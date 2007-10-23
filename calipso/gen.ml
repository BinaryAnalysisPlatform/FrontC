(* Calipso Project -- C abstract code manager
**
** 	Project: 		Calipso
** 	File: 			gen.ml
** 	Version:		1.0
** 	Date:			7.7.99
** 	Author:			Hugues Cassé
**
*)

open Cabs


(*********************** CONSTRUCTORS *********************************)


(*
** Condition Constants
*)
let cnd_true = CONSTANT (CONST_INT "1")
let cnd_false = CONSTANT (CONST_INT "0")


(* assign variable_name expression -> statement
**		Vuild an assignement to a variable.
*)
let assign var exp =
	COMPUTATION (BINARY (ASSIGN, VARIABLE var, exp))


(* dec_var variable_name variable_type initialisation_value -> declaration
**		Build a declaration.
*)
let dec_var var typ ini =
	let typ' = if typ = NO_TYPE
		then INT (NO_SIZE, NO_SIGN)
		else typ in
	DECDEF (typ', NO_STORAGE, [var, typ', [], ini])


(* label label_name statement -> statment
**		Build a label.
*)
let label name stat = LABEL (name, stat)


(* goto label_name -> statement
**		Build a goto statement.
*)
let goto name = GOTO name


(* equal variable_name expression
**		Build an equality expression test.
*)
let equal name exp =
	BINARY (EQ, VARIABLE name, exp)



(* positive_flag name condition -> condition
** negative_flag name condition -> condition
**	Apply a positive/negative flag on a condition.
*)
let positive_flag name cnd =
	if cnd = NOTHING then VARIABLE name
	else BINARY (Cabs.OR, VARIABLE name, cnd)
let negative_flag name cnd =
	if cnd = NOTHING then UNARY (NOT, VARIABLE name)
	else BINARY (AND, UNARY (NOT, VARIABLE name), cnd)


(* not_var name -> condition
**	Build a condition of the form: ! name
*)
let not_var name = UNARY (NOT, VARIABLE name)


(* rectify_condition condition -> condition
**	Check condition for validity and correct it if needed.
*)
let rectify_condition cnd =
	if (match cnd with
		BINARY(op, _, _) ->
			(match op with
			AND | OR | EQ | NE | LT | GT | LE | GE -> true
			| _ -> false)
		| _ -> false)
	then cnd
	else BINARY (NE, cnd, CONSTANT (CONST_INT "0"))


(* dec_flags flags -> declaration
**	Build the declaration of the list of given flags.
*)
let dec_flags flags =
	DECDEF (CHAR NO_SIGN, NO_STORAGE,
			List.map
				(fun flag -> (flag, CHAR NO_SIGN, [], cnd_false))
				flags)


(********************* BRANCH AND LABEL MANAGERS *************************)

(* get_pure statement -> statement
**	Find the first embedded pure statement.
**	Non-pure statement are LABEL, CASE and DEFAULT
*)
let rec get_pure stat =
	match stat with
	CASE (_, stat') -> get_pure stat'
	| DEFAULT stat' -> get_pure stat'
	| LABEL (_, stat') -> get_pure stat'
	| _ -> stat


(* set_pure statement -> statement
**	Modify a statement value thru non-pure statements.
*)
let rec set_pure stat fct =
	match stat with
	CASE (cst, stat') -> CASE (cst, set_pure stat' fct)
	| DEFAULT stat' -> DEFAULT (set_pure stat' fct)
	| LABEL (lbl, stat') -> LABEL (lbl, set_pure stat' fct)
	| _ -> fct stat


(* is_branch statement -> bool
**	Test if the given statement is a branch, that is, one of
** {GOTO, BREAK, CONTINUE} or from this point, there's a branch transfer
** of control
*)
let rec is_branch stat =
	match stat with
	GOTO _ | BREAK | CONTINUE | RETURN _ -> true
	| SEQUENCE (_, stat') -> is_branch stat'
	| IF (_, stat1, stat2) -> (is_branch stat1) && (is_branch stat2)
	| LABEL (_, stat') -> is_branch stat'
	| CASE (_, stat') -> is_branch stat'
	| DEFAULT stat' -> is_branch stat'
	| _ -> false


(* remove_case statement -> statement
**		Remove any leading CASE or DEFAULT in the given statement.
*)
let rec remove_case stat =
	match stat with
	CASE (_, stat') -> remove_case stat'
	| DEFAULT stat' -> remove_case stat'
	| LABEL (lbl, stat') -> LABEL (lbl, remove_case stat')
	| _ -> stat


(* remove_break statement -> statement
**	Remove the break from the statement.
*)
let rec remove_break stat =
	match stat with
	BREAK -> NOP
	| CASE (cst, stat') -> CASE (cst, remove_break stat')
	| DEFAULT stat' -> DEFAULT (remove_break stat')
	| LABEL (lbl, stat') -> LABEL (lbl, remove_break stat')
	| BLOCK (decs, stat') -> BLOCK (decs, remove_break stat')
	| SEQUENCE (stat1, stat2) -> SEQUENCE (stat1, remove_break stat2)
	| IF (cnd, stat1, stat2) -> IF (cnd, remove_break stat1, remove_break stat2)
	| _ -> stat


(********************** STATEMENT SEQUENCE MANAGERS ************************)

(* sequence statement_1 statement_2 -> statement
**		Build a sequence. Remove one of the statement if they are equal to NOP
*)
let sequence s1 s2 =
	if (get_pure s1) = NOP then (set_pure s1 (fun _ -> s2))
	else if s2 = NOP then s1
	else SEQUENCE (s1, s2)


(* sequentialize statement_list -> statement
**		Build a sequence structure from the given statement list.
*)
let rec sequentialize stats =
	match stats with
	[] -> NOP
	| [stat] -> stat
	| stat::fol ->
		sequence stat (sequentialize fol)
	

(* linearize statement -> statement_list
**	Tranform a sequence statement into a statement list.
*)
let rec linearize stat =
	match stat with
	SEQUENCE (stat1, stat2) -> List.append (linearize stat1) (linearize stat2)
	| BLOCK ([], stat') -> linearize stat'
	| NOP -> []
	| _ -> [stat]


(*************************** TEMPORARY AND TAG MANAGER *********************)

(* new_tmp _ -> new_label
**		Create a new temporary name.
*)
let tmp_cnt = ref (-1)
let tag_cnt = ref (-1)
let new_tmp _ =
	incr tmp_cnt;
	"__tmp_" ^ (string_of_int !tmp_cnt) ^ "__"
let new_tag _ =
	incr tag_cnt;
	"__tag_" ^ (string_of_int !tag_cnt) ^ "__"
let reset _ =
	tmp_cnt := -1;
	tag_cnt := -1
