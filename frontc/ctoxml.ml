(* 
 *	$Id$
 *	Copyright (c) 2003, Hugues Cassé <hugues.casse@laposte.net>
 *
 *	Pretty printer of XML document.
 *)

(** Transform a C abstract syntax into XML document.
 *)

open Cabs


let rec convert_storage store def =
	match store with
	  NO_STORAGE -> convert_storage def AUTO
	| AUTO -> "auto"
	| STATIC -> "static"
	| EXTERN ->"extern"
	| REGISTER -> "register"


let convert_un op =
	match op with
	  MINUS -> "neg"
	| PLUS -> "pos"
	| NOT -> "not"
	| BNOT -> "bnot"
	| MEMOF -> "memof"
	| ADDROF -> "addrof"
	| PREINCR -> "preinc"
	| PREDECR -> "predecr"
	| POSINCR -> "postinc"
	| POSDECR -> "postdec"


let convert_bin op =
	match op with
	  ADD -> "add"
	| SUB -> "sub"
	| MUL -> "mul"
	| DIV -> "div"
	| MOD -> "mod"
	| AND -> "and"
	| OR -> "or"
	| BAND -> "band"
	| BOR -> "bor"
	| XOR -> "xor"
	| SHL -> "shl"
	| SHR -> "shr"
	| EQ -> "eq"
	| NE -> "ne"
	| LT -> "lt"
	| GT -> "gt"
	| LE -> "le"
	| GE -> "ge"
	| ASSIGN -> "set"
	| ADD_ASSIGN -> "set_add"
	| SUB_ASSIGN -> "set_sub"
	| MUL_ASSIGN -> "set_mul"
	| DIV_ASSIGN -> "set_div"
	| MOD_ASSIGN -> "set_mod"
	| BAND_ASSIGN -> "set_band"
	| BOR_ASSIGN -> "set_bor"
	| XOR_ASSIGN -> "set_xor"
	| SHL_ASSIGN -> "set_shl"
	| SHR_ASSIGN -> "set_shr"


let rec convert_const c =
	match c with
	  CONST_INT v ->
	  	Cxml.new_elt "int" [] [Cxml.new_text v]
	| CONST_FLOAT v ->
	  	Cxml.new_elt "float" [] [Cxml.new_text v]
	| CONST_CHAR v ->
	  	Cxml.new_elt "char" [] [Cxml.new_text v]
	| CONST_STRING v ->
	  	Cxml.new_elt "string" [] [Cxml.new_text v]
	| CONST_COMPOUND exps ->
		Cxml.new_elt "compound" [] (List.map convert_exp exps)


and convert_exp exp =
	match exp with
	  NOTHING ->
	  	Cxml.new_elt "nothing" [] []
	| UNARY (op, e) ->
		Cxml.new_elt (convert_un op) [] [convert_exp e]
	| BINARY (op, e1, e2) ->
		Cxml.new_elt (convert_bin op) [] [convert_exp e1; convert_exp e2]
	| QUESTION (c, t, e) ->
		Cxml.new_elt "quest" []
			[convert_exp c; convert_exp t; convert_exp e]
	| CAST (t, e) ->
		Cxml.new_elt "cast" [] [convert_type t; convert_exp e]
	| CALL (f, args) ->
		Cxml.new_elt "call" []
			((convert_exp f) :: (List.map convert_exp args))
	| COMMA exps ->
		Cxml.new_elt "comma" [] (List.map convert_exp exps)
	| CONSTANT c ->
		convert_const c
	| VARIABLE n ->
		Cxml.new_elt "get" [("ref", n)] []
	| EXPR_SIZEOF e ->
		Cxml.new_elt "sizeof" [] [convert_exp e]
	| TYPE_SIZEOF t ->
		Cxml.new_elt "sizeof" [] [convert_type t]
	| INDEX (b, i) ->
		Cxml.new_elt "index" [] [convert_exp b; convert_exp i]
	| MEMBEROF (b, n) ->
		Cxml.new_elt "memberof" [("field", n)] [convert_exp b]
	| MEMBEROFPTR (b, n) ->
		Cxml.new_elt "memberofptr" [("field", n)] [convert_exp b]
	| GNU_BODY (d, s) ->
		Cxml.new_elt "body" [] (convert_block (d, s))
	| EXPR_LINE (expr, file, line) ->
		Cxml.new_elt "expr_line"
			[("file", file); ("line", string_of_int line)]
			[convert_exp expr]


and convert_stat stat =
	match stat with
	  NOP
	  	-> Cxml.new_elt "nop" [] []
	| COMPUTATION e
		-> convert_exp e
	| BLOCK (defs, stat)
		-> Cxml.new_elt "block" [] (convert_block (defs, stat))
	| SEQUENCE _
		-> Cxml.new_elt "block" [] (convert_block ([], stat))
	| IF (c, t, e)
		-> Cxml.new_elt "if" []
			[convert_exp c; convert_stat t; convert_stat e]
	| WHILE (c, b)
		-> Cxml.new_elt "while" [] [convert_exp c; convert_stat b]
	| DOWHILE (c, b)
		-> Cxml.new_elt "dowhile" [] [convert_exp c; convert_stat b]
	| FOR (i, c, n, b)
		-> Cxml.new_elt "for" []
			[convert_exp i; convert_exp c; convert_exp n; convert_stat b]
	| BREAK
		-> Cxml.new_elt "break" [] []
	| CONTINUE
		-> Cxml.new_elt "continue" [] []
	| RETURN e
		-> Cxml.new_elt "return" [] [convert_exp e]
	| SWITCH (e, s)
		-> Cxml.new_elt "switch" [] [convert_exp e; convert_stat s]
	| CASE (e, s)
		-> Cxml.new_elt "case" [] [convert_exp e; convert_stat s]
	| DEFAULT s
		-> Cxml.new_elt "default" [] [convert_stat s]
	| LABEL (l, s)
		-> Cxml.new_elt "label" [("id", l)] [convert_stat s]
	| GOTO l
		-> Cxml.new_elt "goto" [("ref", l)] []
	| ASM text
		-> Cxml.new_elt "asm" [] [Cxml.new_text text]
	| GNU_ASM (text, outs, ins, clobbers)
		-> Cxml.new_elt "gnu_asm" []
			((Cxml.new_elt "text" [] [Cxml.new_text text])
			::(convert_gnu_asm outs ins clobbers))
	| STAT_LINE (stat, file, line)
		-> Cxml.new_elt "stat_line"
			[("file", file); ("line", (string_of_int line))]
			[convert_stat stat]

and convert_gnu_asm outs ins clobbers =
	let process tag id reg exp =
		let attrs = if id = "" then [] else [("id", id)] in
		let attrs = ("reg", reg)::attrs in
		Cxml.new_elt tag attrs [convert_exp exp] in
	List.append
		(List.map (fun (id, reg, exp) -> process "out" id reg exp) outs)
		(List.append
			(List.map (fun (id, reg, exp) -> process "in" id reg exp) ins)
			(List.map (fun reg -> (Cxml.new_elt "clobber" [("reg", reg)] [])) clobbers)
		)

and convert_seq stat =
	match stat with
	  SEQUENCE (s1, s2) -> List.append (convert_seq s1) (convert_seq s2)
	| _ -> [convert_stat stat]


and convert_block (defs, stat) =
	let defs = List.flatten (List.map convert_def defs) in
	let seq = convert_seq stat in
	List.append defs seq


and convert_fields fields =
	let convert_names (_, _, names) =
		let convert_name (name, _type, _, _) =
			Cxml.new_elt "field" [("name", name)] [convert_type _type] in
		List.map convert_name names in
	List.flatten (List.map convert_names fields)
	

and convert_values values =
	let convert_value (name, exp) =
		Cxml.new_elt "value" [("name", name)] [convert_exp exp] in
	List.map convert_value values


and convert_proto _type =

	let (rtype, args, vararg) =
		match _type with
		  PROTO (_type, args, vararg) -> (_type, args, vararg)
		| _ -> raise UnconsistentDef in
	let relt = Cxml.new_elt "type" [] [convert_type rtype] in
	
	let convert_arg (_, store, (name, _type, _, _)) args =
		if _type = VOID then args else
		let elt = Cxml.new_elt "param"
			[("name", name); ("store", convert_storage store AUTO)]
			[convert_type _type] in
		elt :: args in
	let aelts = List.fold_right convert_arg args [] in

	let elts =
		if not vararg then aelts
		else List.append aelts [Cxml.new_elt "vararg" [] []] in
		
	relt :: elts


and convert_type _type =
	let base_type name = Cxml.new_elt name [] [] in
	match _type with
	  NO_TYPE -> convert_type (INT (NO_SIZE, NO_SIGN))
	| VOID -> base_type "void"
	| CHAR NO_SIGN
	| CHAR SIGNED -> base_type "char"
	| CHAR UNSIGNED -> base_type "uchar"
	| INT (SHORT, NO_SIGN)
	| INT (SHORT, SIGNED) -> base_type "short"
	| INT (SHORT, UNSIGNED) -> base_type "ushort"
	| INT (NO_SIZE, NO_SIGN)
	| INT (LONG, NO_SIGN)
	| INT (NO_SIZE, SIGNED)
	| INT (LONG, SIGNED) -> base_type "long"
	| INT (NO_SIZE, UNSIGNED)
	| INT (LONG, UNSIGNED) -> base_type "ulong"
	| INT (LONG_LONG, NO_SIGN)
	| INT (LONG_LONG, SIGNED) -> base_type "llong"
	| INT (LONG_LONG, UNSIGNED) -> base_type "ulong"
	| BITFIELD (NO_SIGN, exp) -> Cxml.new_elt "bits" [] [convert_exp exp]
	| BITFIELD (SIGNED, exp) -> Cxml.new_elt "bits" [] [convert_exp exp]
	| BITFIELD (UNSIGNED, exp) -> Cxml.new_elt "ubits" [] [convert_exp exp]
	| FLOAT false -> base_type "float"
	| FLOAT true
	| DOUBLE false -> base_type "double"
	| DOUBLE true -> base_type "ldouble"

	| PTR _type -> Cxml.new_elt "ptr" [] [convert_type _type]
	| CONST _type -> Cxml.new_elt "const" [] [convert_type _type]
	| VOLATILE _type -> Cxml.new_elt "volatile" [] [convert_type _type]
	| NAMED_TYPE name -> Cxml.new_elt "type" [("ref", name)] []
	| RESTRICT_PTR _type -> Cxml.new_elt "restrict" [] [convert_type _type]
	
	| ARRAY  (_type, size) ->
		Cxml.new_elt "array" [] [
			convert_type _type;
			Cxml.new_elt "size" [] [convert_exp size]
		]

	| STRUCT (name, fields) ->
		let id = if fields = [] then "ref" else "id" in
		Cxml.new_elt "struct"
			(if name <> "" then [(id, "struct:" ^ name)] else [])
			(convert_fields fields)
		
	| UNION (name, fields) ->
		let id = if fields = [] then "ref" else "id" in
		Cxml.new_elt "union"
			(if name <> "" then [(id, "union:" ^ name)] else [])
			(convert_fields fields)
	
	| ENUM (name, values) ->
		let id = if values = [] then "ref" else "id" in
		Cxml.new_elt "enum"
			(if name <> "" then [(id, "enum:" ^ name)] else [])
			(convert_values values)
	
	| PROTO (_, _, _) ->
		Cxml.new_elt "fun" [] (convert_proto _type)
	
	| OLD_PROTO (_, _, _) ->
		Cxml.new_elt "fun" [] [Cxml.new_elt "vararg" [] []]
	
	| GNU_TYPE (attrs, _type) ->
		Cxml.add_children (convert_type _type) (List.map convert_gnu_attr attrs)

	| TYPE_LINE (file, line, t) ->
		Cxml.new_elt "type_line"
			[ ("file", file); ("line", string_of_int line) ]
			[convert_type _type]

and convert_gnu_attr attr =
	match attr with
	  GNU_NONE
	  	-> Cxml.new_elt "none" [] []
	| GNU_ID id
		-> Cxml.new_elt "id" [("value", id)] []
	| GNU_CST cst
		-> convert_const cst
	| GNU_EXTENSION
		-> Cxml.new_elt "extension" [] []
	| GNU_INLINE
		-> Cxml.new_elt "inline" [] []
	| GNU_CALL (id, attrs)
		-> Cxml.new_elt "call" [("id", id)] (List.map convert_gnu_attr attrs)

and convert_fundef _type store name vars body =

	let proto_elts = convert_proto _type in
	let body_elt = Cxml.new_elt "body" [] (convert_block (vars, body)) in
	
	Cxml.new_elt "fundef"
		[
			("id", name);
			("store", convert_storage store AUTO)
		]
		(List.append proto_elts [body_elt])


and convert_name store (name, _type, _, exp) =
	let attrs = [("id", name); ("store", (convert_storage store AUTO))] in
	match _type with
	  PROTO _ ->
	  	Cxml.new_elt "fundec" attrs (convert_proto _type)
	| _ ->
		let type_elt = convert_type _type in
		let elts =
			if exp = NOTHING then [type_elt]
			else type_elt :: [convert_exp exp] in
		Cxml.new_elt "var" attrs elts


and convert_typedef store (name, _type, _, _) =
	Cxml.new_elt "type"
		[("id", name); ("store", (convert_storage store AUTO))]
		[convert_type _type]


and convert_onlytypedef _type =
	convert_type _type


and convert_def def =
	match def with
	  FUNDEF ((_, store, (name, _type, _, _)), (vars, body)) ->
	  	[convert_fundef _type store name vars body]
	| OLDFUNDEF (_, _, _) ->
		raise UnconsistentDef
	| DECDEF (_, store, names) ->
		List.map (convert_name store) names
	| TYPEDEF ((_, store, names), _) ->
		List.map (fun name -> convert_typedef store name) names
	| ONLYTYPEDEF (_type, _, _) ->
		[convert_onlytypedef _type]


