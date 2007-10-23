(* Calipso Project -- management of labels for Calipso
**
**	Project: 		Calipso
** 	File: 			calipso.ml
** 	Version:		3.0
** 	Date:			7.20.99
** 	Author:			Hugues Cassé
*)

(*
** Bitfield definition
*)
module BitField =
struct
	type t = bool array
	
	let empty (sz : int) : t = Array.create sz false
	
	(*** accessors **)
	let size (bf : t) : int = Array.length bf
	let get (bf : t) (idx : int) : bool = Array.get bf idx

	let isEmpty (bf : t) : bool =
		let rec test i =
			if i < 0 then true
			else if (Array.get bf i) then false
			else test (i - 1) in
		test ((Array.length bf) - 1)

	let equal (bf1 : t) (bf2 : t) : bool =
		let rec test i =
			if i < 0 then true
			else if (Array.get bf1 i) <> (Array.get bf2 i) then false
			else test (i - 1) in
		test ((Array.length bf1) - 1)

	let count (bf : t) : int =
		let rec cnt idx =
			if idx < 0 then 0
			else (if (Array.get bf idx) then 1 else 0) + (cnt (idx - 1)) in
		cnt ((Array.length bf) - 1)
	
	(*** constructors ***)
	let set (bf : t) (idx : int) : t =
		let nbf = Array.copy bf in
		(Array.set nbf idx true; nbf)
	let reset (bf : t) (idx : int) : t =
		let nbf = Array.copy bf in
		(Array.set nbf idx false; nbf)
		
	let union (bf1 : t) (bf2 : t) : t =
		let sz = Array.length bf1 in
		let bf = empty sz in
		(for i = 0 to (sz - 1) do
			Array.set bf i ((Array.get bf1 i) || (Array.get bf2 i))
		done;
		bf)
		
	let inter (bf1 : t) (bf2 : t) : t =
		let sz = Array.length bf1 in
		let bf = empty sz in
		(for i = 0 to (sz - 1) do
			Array.set bf i ((Array.get bf1 i) && (Array.get bf2 i))
		done;
		bf)
		
	let diff (bf1 : t) (bf2 : t) : t =
		let sz = Array.length bf1 in
		let bf = empty sz in
		(for i = 0 to (sz - 1) do
			let bit1 = Array.get bf1 i in
			let bit2 = Array.get bf2 i in
			Array.set bf i (if bit1 && bit2 then false else bit1)
		done;
		bf)
end


(*
** Program representation
*)
type node = BitField.t * BitField.t * statement
and statement =
	  NOP
	| COMPUTATION of Cabs.expression
	| BLOCK of Cabs.definition list * node
	| SEQUENCE of node * node
	| IF of Cabs.expression * node * node
	| WHILE of Cabs.expression * node
	| DOWHILE of Cabs.expression * node
	| FOR of Cabs.expression * Cabs.expression * Cabs.expression * node
	| RETURN of Cabs.expression
	| NORMAL_GOTO of Cabs.expression * string
	| LABEL of string * node
	| GUARD of Cabs.expression * node * BitField.t * BitField.t
	| SWITCH of Cabs.expression * node
	| CASE of Cabs.expression * node
	| DEFAULT of node
	| BREAK
	| CONTINUE
	| REGULAR_SWITCH of Cabs.expression * (Cabs.expression list * node) list
	| OTHER of Cabs.statement
	| LINE of node * string * int


(*
** Label list management
*)
type label_list = int * (string * int) list

(* make_labs string  list -> labs
**		Compute label list from a string list.
*)
let rec make_labs (lst : string list) : label_list =
	let (cnt, labs) = List.fold_right
		(fun lbl (cnt, labs) -> (cnt + 1, (lbl, cnt)::labs))
		lst
		(0, []) in
	(cnt, List.rev labs) 


(* get_index labs label -> index
**		Find index of the given label.
**		Raise Not_found if label can't be found in the label list.
*)
let get_index ((_, labs) : label_list) (lbl : string) : int =
	try List.assoc lbl labs
	with Not_found -> (prerr_endline lbl; raise Not_found)


(* get_count labs -> size
**		Find count of label in the label list.
*)
let get_count ((cnt, _) : label_list) : int = cnt


(* get_label labs index -> label
**		Find label associated with given index.
*)
let get_label ((cnt, lbls) : label_list) (idx : int) : string =
	let (lbl, _) = List.nth lbls idx in lbl


(* find_labels statement -> label_list
**	Find the labels in the given statement.
*)
let rec find_labels stat =
	match stat with
	(_, _, BLOCK (_, stat')) -> find_labels stat'
	| (_, _, SEQUENCE (stat1, stat2)) ->
		List.append (find_labels stat1) (find_labels stat2)
	| (_, _, IF (_, stat1, stat2)) ->
		List.append (find_labels stat1) (find_labels stat2)
	| (_, _, WHILE (_, stat')) -> find_labels stat'
	| (_, _, DOWHILE (_, stat')) -> find_labels stat'
	| (_, _, FOR (_, _, _, stat')) -> find_labels stat'
	| (_, _, LABEL (lbl, stat')) -> lbl::(find_labels stat')
	| (_, _, GUARD (_, stat', _, _)) -> find_labels stat'
	| (_, _, SWITCH (_, stat')) -> find_labels stat'
	| (_, _, CASE (_, stat')) -> find_labels stat'
	| (_, _, DEFAULT stat') -> find_labels stat'
	| (_, _, REGULAR_SWITCH (_, cases)) ->
		List.fold_right
			(fun (csts, seq) labs -> List.append (find_labels seq) labs)
			cases
			[]
	| _ -> []
	

(*
** BitField test
**
**	Labels 0-31 are stored in __goto_0__, labels 32-63 are stored in __goto_1__
**	and so on.
*)

(* Must be changed according to the target architecture *)
let int_size = 32
let null_hex = "0x" ^ (String.make (int_size / 4) '0')


(* Conversion arrays *)
let bit2hex = [| "1"; "2"; "4"; "8" |]
let invbit2hex = [| "E"; "D"; "B"; "7" |]
let int2hex = [| "0"; "1"; "2"; "3"; "4"; "5"; "6"; "7";
				 "8"; "9"; "A"; "B"; "C"; "D"; "E"; "F" |]


(* Internal primitives *)
let make_flag idx = "__goto__" ^ (string_of_int idx) ^ "__"


(* declare_labels label_list -> label flag declaration list.
**		Produce code for label flag declaration.
*)
let declare_labels labs =
	(*let _ = prerr_string "declare_labels\n" in*)
	let cnt = get_count labs in
	let rec add idx =
		if (idx * int_size) >= cnt then []
		else
			(make_flag idx,
			Cabs.INT (Cabs.NO_SIZE, Cabs.UNSIGNED),
			[],
			Cabs.CONSTANT (Cabs.CONST_INT "0"))
			::(add (idx + 1)) in
	Cabs.DECDEF (Cabs.INT (Cabs.NO_SIZE, Cabs.UNSIGNED), Cabs.NO_STORAGE, add 0)


(* set_label_true label_list label -> instruction
**		Build a label flag set at true condition.
*)
let set_label_true labs lab =
	(*let _ = prerr_string "set_label_true\n" in*)
	let lidx = get_index labs lab in
	let fidx = lidx / int_size in
	let bit = lidx mod int_size in
	let suff = String.make (bit / 4) '0' in
	let pref = String.make ((int_size / 4) - (bit / 4) - 1) '0' in
	let mask = "0x" ^ pref ^ (Array.get bit2hex (bit mod 4)) ^ suff in
	COMPUTATION (Cabs.BINARY (
		Cabs.BOR_ASSIGN,
		Cabs.VARIABLE (make_flag fidx),
		Cabs.CONSTANT (Cabs.CONST_INT mask)))


(* set_label_false label_list label -> instruction
**		Build a label flag set at false condition.
*)
let set_label_false labs lab =
	(*let _ = prerr_string "set_label_false\n" in*)
	let lidx = get_index labs lab in
	let fidx = lidx / int_size in
	let bit = lidx mod int_size in
	let suff = String.make (bit / 4) 'F' in
	let pref = String.make ((int_size / 4) - (bit / 4) - 1) 'F' in
	let mask = "0x" ^ pref ^ (Array.get invbit2hex (bit mod 4)) ^ suff in
	COMPUTATION (Cabs.BINARY (
		Cabs.BAND_ASSIGN,
		Cabs.VARIABLE (make_flag fidx),
		Cabs.CONSTANT (Cabs.CONST_INT mask)))


(* make_test bitfield base_expression -> expression
**		Build an expression for testing a bitfield.
*)
let make_test bf expr =
	(*let _ = prerr_string "make_test\n" in*)
	let cnt = BitField.size bf in
	let make_hex low up =
		let rec doit pow low =
			if low > up then 0
			else (if BitField.get bf low then pow else 0)
				+ (doit (pow * 2) (low + 1)) in
		Array.get int2hex (doit 1 low) in
	let make_mask low up =
		(*let _ = prerr_string ((string_of_int up) ^ "\n") in*)
		let rec doit low =
			if low > up then ""
			else (doit (low + 4)) ^ (make_hex low (min (low + 3) up)) in
		"0x"
		^ (String.make ((int_size / 4) - ((up mod int_size) / 4 ) - 1) '0')
		^ (doit low) in
	let rec doit expr idx =
		if idx >= cnt then expr
		else 
			let mask = make_mask idx (min (idx + int_size - 1) (cnt - 1)) in
			if mask = null_hex then doit expr (idx + int_size)
			else
				let test = Cabs.BINARY
					(Cabs.BAND,
					Cabs.VARIABLE (make_flag (idx / int_size)),
					Cabs.CONSTANT (Cabs.CONST_INT mask)) in
				doit
					(if expr = Cabs.NOTHING
						then test
						else Cabs.BINARY (Cabs.OR, test, expr))
					(idx + int_size) in
	doit expr 0


(* make_full_test true_bitfied false_bitfield base_test -> expression
**		Build a full test.
*)
let make_full_test true_bf false_bf base_test =
	(*let _ = prerr_string "make_full_test\n" in*)
	let true_test = make_test true_bf base_test in
	let false_test = make_test false_bf Cabs.NOTHING in
	if false_test = Cabs.NOTHING
	then true_test
	else
		if true_test = Cabs.NOTHING
		then Cabs.UNARY (Cabs.NOT, false_test)
		else Cabs.BINARY
			(Cabs.AND,
			Cabs.UNARY (Cabs.NOT, false_test),
			true_test)
