(* Calipso Project -- break / continue / return / switch remover
**
** Project: 		Calipso
** File: 			reduce.ml
** Version:			1.0
** Date:			7.7.99
** Author:			Hugues Cassé
**
*)

open Cabs
open Gen


(*
** Configuration switches
*)

(* true -> remove continue statements *)
let remove_continue = ref false

(* true -> remove break statements *)
let remove_break = ref false

(* true -> remove non-ending returns *)
let remove_return = ref false

(* switch action *)
type switch_action =
	NO			(* don't reduce them *)		
	| RAW		(* remove all switches *)
	| REDUCE	(* remove them but scan for optimized regular ones *)
	| KEEP		(* don't reduce which are regulars *)
let remove_switch = ref NO


(* statements counters *)
let break_count = ref 0
let continue_count = ref 0
let goto_count = ref 0
let label_count = ref 0
let switch_count = ref 0
let return_count = ref 0
let case_count = ref 0
let raw_switch = ref 0
let fast_switch = ref 0
let kept_switch = ref 0


(*
** Definitions
*)
let return = "__return__"


(*
** Handle Definition
*)

type handle =
	(string * expression) list		(* switch label list *)
	* string						(* break label, "~" don't tranform *)
	* string						(* continue label *)
	* string						(* return label *)




(* raw_switch_trans condition statement handle -> statement * handle
**		Perform a raw switch transformation.
*)
let raw_switch_trans cnd stat hdl : statement * handle =
	incr raw_switch;
	let (cases, brk, _, _) = hdl in
	let tag = new_tag () in
	
	let rec remove_break stat brk =
		match stat with
		BREAK ->
			let brk' = if brk = "" then new_tmp () else brk in
			(GOTO brk', brk')
		| LABEL (lbl, ss) ->
			let (ss', brk') = remove_break ss brk in (LABEL (lbl, ss'), brk')
		| CASE  (cst, ss) ->
			let (ss', brk') = remove_break ss brk in (CASE (cst, ss'), brk')
		| DEFAULT ss ->
			let (ss', brk') = remove_break ss brk in (DEFAULT ss', brk')
		| IF (cnd, ss1, ss2) ->
			let (ss1', brk1) = remove_break ss1 brk in
			let (ss2', brk2) = remove_break ss2 brk1 in
			(IF (cnd, ss1', ss2'), brk2)
		| SEQUENCE (ss1, ss2) ->
			let (ss1', brk1) = remove_break ss1 brk in
			let (ss2', brk2) = remove_break ss2 brk1 in
			(SEQUENCE (ss1', ss2'), brk2)
		| BLOCK (decs, ss) ->
			let (ss', brk') = remove_break ss brk in (BLOCK (decs, ss'), brk')
		| _ -> (stat, brk) in
	
	let rec make_switch cases dflt =
		match cases with
		[] ->
			if dflt = "" then NOP else GOTO dflt
		| (lbl, exp)::fol when exp = NOTHING ->
			make_switch fol lbl
		| (lbl, exp)::fol ->
			IF (
				BINARY (EQ, VARIABLE tag, exp),
				GOTO lbl,
				make_switch fol dflt) in
	
	let (stat', brk') = remove_break stat brk in
	let stat'' = sequence
		(make_switch (List.rev cases) "")
		(IF (cnd_false, stat', NOP)) in
	let stat3 = if brk' = "" then stat'' else sequence stat'' (label brk' NOP) in
	(BLOCK ([dec_var tag NO_TYPE cnd], stat3), hdl)


(* separated_switch_check switch_body -> part_list
**		Check if the given switch body is sapratable.
**		Return parts in reverse order and statements in parts in reverse order.
**
** DEF: the statement s is separatable
**	if it is a CASE (_, s') and s' is separatable,
**	if it is a DEFAULT s and s' is separatable,
**	if s doesn't contain any one of CASE or DEFAULT.
*)
exception NotSeparatable
let separated_switch_check stat =
	let rec is_unreachable stat =
		match stat with
		CASE _
		| DEFAULT _ -> false
		| BLOCK (_, s') -> is_unreachable s'
		| SEQUENCE (s1, s2) -> (is_unreachable s1) && (is_unreachable s2)
		| IF (_, s1, s2) -> (is_unreachable s1) && (is_unreachable s2)
		| WHILE (_, s') -> is_unreachable s'
		| DOWHILE (_, s') -> is_unreachable s'
		| FOR (_, _, _, s') -> is_unreachable s'
		| LABEL (_, s') -> is_unreachable s'
		| SWITCH _
		| _ -> true in

	let rec separate stat parts =
		match stat with
		CASE _
		| DEFAULT _ ->
			if is_unreachable (get_pure stat) then [stat]::parts
			else raise NotSeparatable
		| SEQUENCE (s1, s2) -> separate s2 (separate s1 parts)
		| _ ->
			if not (is_unreachable (get_pure stat))
			then raise NotSeparatable
			else match parts with
				[] -> raise NotSeparatable
				| part::fol -> (stat::part)::fol in
				
	match stat with
	BLOCK ([], stat') -> separate stat' []
	| BLOCK _ -> raise NotSeparatable
	| _ -> separate stat []


(* separated_switch_keep condition parts handle -> (statement, handle)
**		Rebuild the parts of the body of a separated switch.
**		Parts must be in good order but statement in parts in the
**		reverse order.
*)
let separated_switch_keep cnd parts hdl =
	incr kept_switch;
	let rec count_case stat =
		match stat with
		CASE (_, stat') -> incr case_count
		| DEFAULT stat' -> incr case_count
		| _ -> () in
	let scan_tail part eol =
		match part with
		[] -> ([], "")
		| lst::blk ->
			if (is_branch lst) || eol then (part, "")
			else let lbl = new_tmp () in ((GOTO lbl)::part, lbl) in
	
	let scan_head part lbl =
		count_case (List.hd part); 
		if lbl = "" then part
		else
			match part with
			[] -> [label lbl NOP]
			| fst::blk -> (set_pure fst (fun stat -> label lbl stat))::blk in
	
	let rec process_part parts lbl hdl =
		match parts with
		[] -> (NOP, hdl)
		| part::fol ->
			let (part', lbl') = scan_tail part (fol = []) in
			let part'' = scan_head (List.rev part') lbl in
			let part3 = sequentialize part'' in
			let (stat, hdl') = process_part fol lbl' hdl in
			(sequence part3 stat, hdl') in
	
	let (body, hdl') = process_part parts "" hdl in
	(SWITCH (cnd, body), hdl')
 

(* separated_switch_remove condition parts handle -> (statement, handle)
**		Rebuild the parts of the body of a separated switch by removing the
**		switch.
**		Parts must be in good order but statement in parts in the
**		reverse order.
*)
let separated_switch_remove cnd parts hdl =
	let tag = new_tag () in

	let process_tail part hdl last =
		match part with
		[] -> ([], "", hdl)
		| lst::blk ->
			let lst' = set_pure lst
				(fun stat -> if stat = BREAK then NOP else stat) in
			if last || (is_branch lst) then (lst'::blk, "", hdl)
			else
				let (cases, brk, cnt, rtn) = hdl in
				let lbl = new_tmp () in
				((GOTO lbl)::part, lbl, (cases, brk, cnt, rtn)) in
	
	let default = VARIABLE "" in
	let rec make_cond stat cnd =
		match stat with
		CASE (cst, stat') ->
			incr case_count;
			let eq = equal tag cst in
			make_cond stat'
				(if cnd = NOTHING then eq else BINARY (OR, cnd, eq))
		| DEFAULT stat' -> incr case_count; default
		| _ -> cnd in
	
	let process_head part lbl =
		let rec extract stat =
			match stat with
			DEFAULT stat' -> extract stat'
			| CASE (_, stat') -> extract stat'
			| _ -> stat in
		match part with
		[] -> ((if lbl = "" then [] else [label lbl NOP]), NOTHING)
		| fst::blk ->
			let cnd = make_cond fst NOTHING in
			if lbl = "" then ((extract fst)::blk, cnd)
			else ((label lbl (remove_case fst))::blk, cnd) in
	
	let rec process_part parts (lbl, hdl, def) =
		match parts with
		[] -> (def, hdl)
		| part::fol ->
			let (part', lbl', hdl') = process_tail part hdl (fol = []) in
			let (part'', cnd) = process_head (List.rev part') lbl in
			let part3 = sequentialize part'' in
			let def' = if cnd = default then part3 else def in
			let (stat, hdl'') = process_part fol (lbl', hdl', def') in
				if cnd = default then (stat, hdl'')
				else (IF (cnd, part3, stat), hdl'') in
	
	let (stat, hdl') = process_part parts ("", hdl, NOP) in
	let (cases', brk', cnt', rtn') = hdl' in
	let stat' = if (brk' = "") || (brk' = "!") then stat
		else sequence stat (label brk' NOP) in
	(BLOCK ([dec_var tag NO_TYPE cnd], stat'), hdl')
 

(* transform statement handle -> statement * handle
**		Perform some transformations.
*)
let rec transform (stat : statement) (hdl : handle) : statement * handle =

	let transform_parts parts hdl : statement list list * handle =
		let rec process_stat stat hdl =
			match stat with
			CASE (cst, stat') ->
				let (stat'', hdl') = process_stat stat' hdl in
				(CASE (cst, stat''), hdl')
			| DEFAULT stat' ->
				let (stat'', hdl') = process_stat stat' hdl in
				(DEFAULT stat'', hdl')
			| _ -> transform stat hdl in
		let process_part part hdl =
			let (cases, brk, cnt, rtn) = hdl in
			let (last, head) = if (get_pure (List.hd part)) = BREAK
				then (List.hd part, List.tl part)
				else (NOP, part) in
			let (head', hdl') = List.fold_right
				(fun stat (stats, hdl) ->
					let (stat', hdl') = process_stat stat hdl in
					(stat'::stats, hdl'))
				head
				([], ([], "", cnt, rtn)) in
			let (_, brk', cnt', rtn') = hdl' in
			let last' = (set_pure last (fun stat -> if brk' = ""
				then stat else label brk' stat)) in
			((if last' = NOP then head' else last'::head'),
			([], "", cnt', rtn')) in
		List.fold_left
			(fun (parts, hdl) part ->
				let (part', hdl') = process_part part hdl in
				(part'::parts, hdl'))
			([], hdl)
			parts in

	match stat with
	
	NOP | GNU_ASM _ | ASM _ -> (stat, hdl)
		
	| COMPUTATION exp -> (COMPUTATION exp, hdl)
	
	| STAT_LINE (stat, file, line) ->
		let (stat', hdl') = transform stat hdl in
		(STAT_LINE (stat', file, line), hdl') 
		
	| BLOCK (decs, stat) ->
		let (stat', hdl') = transform stat hdl in
		(BLOCK (decs, stat'), hdl')
		
	| SEQUENCE (s1, s2) ->
		let (s1', hdl') = transform s1 hdl in
		let (s2', hdl'') = transform s2 hdl' in
		(SEQUENCE (s1', s2'), hdl'')
		
	| IF(cnd, s1, s2) ->
		let (s1', hdl') = transform s1 hdl in
		let (s2', hdl'') = transform s2 hdl' in
		(IF (cnd, s1', s2'), hdl'')
		
	| WHILE (cnd, stat) ->
		let (cases, brk, cnt, rtn) = hdl in
		let (stat1, (cases', brk', cnt', rtn')) =
			transform stat (cases, "", "", rtn) in
		let stat2 =
			if cnt' <> "" then sequence stat1 (label cnt' NOP) else stat1 in
		let stat3 =  WHILE (cnd, stat2) in
		let stat4 =
			if brk' <> "" then sequence stat3 (label brk' NOP) else stat3 in
		(stat4, (cases', brk, cnt, rtn'))
	
	| DOWHILE (cnd, stat) ->
		let (cases, brk, cnt, rtn) = hdl in
		let (stat1, (cases', brk', cnt', rtn')) =
			transform stat (cases, "", "", rtn) in
		let stat2 =
			if cnt' <> "" then sequence stat1 (label cnt' NOP) else stat1 in
		let stat3 = DOWHILE (cnd, stat2) in
		let stat4 = 
			if brk' <> "" then sequence stat3 (label brk' NOP) else stat3 in
		(stat4, (cases', brk, cnt, rtn'))
	
	| FOR(ini, cnd, nxt, stat) ->
		let (cases, brk, cnt, rtn) = hdl in
		let (stat1, (cases', brk', cnt', rtn')) =
			transform stat (cases, "", "", rtn) in
		let stat2 =
			if cnt' <> "" then sequence stat1 (label cnt' NOP) else stat1 in
		let stat3 = FOR (ini, cnd, nxt, stat2) in
		let stat4 = 
			if brk' <> "" then sequence stat3 (label brk' NOP) else stat3 in
		(stat4, (cases', brk, cnt, rtn'))
	
	| BREAK ->
		incr break_count;
		if not !remove_break then (stat, hdl)
		else
			let (cases, brk, cnt, rtn) = hdl in
				let brk' = if brk = "" then new_tmp () else brk in
				(GOTO brk', (cases, brk', cnt, rtn))
	
	| CONTINUE ->
		incr continue_count;
		if not !remove_continue then (stat, hdl)
		else
			let (cases, brk, cnt, rtn) = hdl in
			let cnt' = if cnt = "" then new_tmp () else cnt in
			(GOTO cnt', (cases, brk, cnt', rtn))
	
	| RETURN exp ->
		incr return_count;
		if not !remove_return then (stat, hdl)
		else
			let (cases, brk, cnt, rtn) = hdl in
			let rtn' = if rtn = "" then new_tmp () else rtn in
			let goto = GOTO rtn' in
			let ret =
				if exp = NOTHING then goto
				else sequence (assign return exp) goto in
			(ret, (cases, brk, cnt, rtn'))
	
	| CASE (exp, stat) ->
		incr case_count;
		let (stat', hdl') = transform stat hdl in
		(match !remove_switch with
		NO -> (CASE (exp, stat'), hdl')
		| _ ->
			let (cases, brk, cnt, rtn) = hdl' in
			let lbl = new_tmp () in
			(label lbl stat', ((lbl, exp)::cases, brk, cnt, rtn)))
	
	| DEFAULT stat ->
		incr case_count;
		let (stat', hdl') = transform stat hdl in
		(match !remove_switch with
		NO -> (DEFAULT stat', hdl')
		| _ ->
			let (cases, brk, cnt, rtn) = hdl' in
			let lbl = new_tmp () in
			(label lbl stat', ((lbl, NOTHING)::cases, brk, cnt, rtn)))
	
	| LABEL (lbl, stat) ->
		incr label_count;
		let (stat', hdl') = transform stat hdl in
		(label lbl stat', hdl')
	
	| GOTO lbl -> incr goto_count; (stat, hdl)
	
	| SWITCH (cnd, stat) ->
		incr switch_count;
		let (cases, brk, cnt, rtn) = hdl in
		try
			match !remove_switch with
			NO ->
				let (stat', (cases', _, cnt', rtn')) =
					transform stat ([], "~", cnt, rtn) in
				(SWITCH (cnd, stat'), (cases, brk, cnt', rtn'))
			| RAW ->
				let (stat', hdl') = transform stat ([], "", cnt, rtn) in
				let (stat'', (_, _, cnt', rtn')) =
					raw_switch_trans cnd stat' hdl' in
				(stat'', (cases, brk, cnt', rtn'))
			| REDUCE ->
				let parts  = separated_switch_check stat in
				let (parts', hdl') =
					transform_parts parts ([], "!", cnt, rtn) in
				let (stat', (_, _, cnt', rtn')) =
					separated_switch_remove cnd parts' hdl' in
				begin
					incr fast_switch;
					(stat', (cases, brk, cnt', rtn'))
				end
			| KEEP ->
				let parts  = separated_switch_check stat in
				let (parts', hdl') =
					transform_parts parts ([], "", cnt, rtn) in
				let (stat', (_, _, cnt', rtn')) = 
					separated_switch_keep cnd parts' hdl' in
				(stat', (cases, brk, cnt', rtn'))
		with NotSeparatable ->
			(*let _ = prerr_string "Unseparatable !\n" in *)
			let (stat', hdl') = transform stat ([], "", cnt, rtn) in
			let (stat'', (_, _, cnt', rtn')) =
				raw_switch_trans cnd stat' hdl' in
			(stat'', (cases, brk, cnt', rtn'))
			


(* reduce body return_type -> body
**		Perform the removal of break / continue / switch on the given
**		procedure body.
*)
let reduce ((decs, stat) : body) (typ : base_type) : body =

	(* without return removal *)
	if not !remove_return then
		let (stat', _) = transform stat ([], "", "", "") in
		(decs, stat')
		
	(* with return removal *)
	else
		let rec remove_last_return stat = 
			match stat with
			RETURN exp -> (NOP, exp)
			| SEQUENCE (stat', RETURN exp) -> (stat', exp)
			| SEQUENCE (s1, s2) ->
				let (stat', rtn_val) = remove_last_return s2 in
				(SEQUENCE (s1, stat'), rtn_val)
			| LABEL (lbl, stat') -> 
				let (stat'', rtn_val) = remove_last_return stat' in
				(LABEL (lbl, stat''), rtn_val)
			| _ -> (stat, NOTHING) in
		
		let (stat', rtn_val) = remove_last_return stat in
		let (stat'', (_, _, _, rtn_lbl)) =
			transform stat' ([], "", "", "") in
		let ret_ins =
			if typ = VOID then NOP
			else if rtn_lbl <> "" then RETURN (VARIABLE return)
			else if rtn_val = NOTHING then NOP
			else RETURN rtn_val in
		let lab_ins =
			if rtn_lbl = "" then ret_ins
			else LABEL (rtn_lbl, ret_ins) in
		let last_ins =
			if (rtn_lbl = "") || (rtn_val = NOTHING) then lab_ins
			else SEQUENCE (assign return rtn_val, lab_ins) in
		(
			(if (rtn_lbl = "") || (typ = VOID)
				then decs
				else (dec_var return typ NOTHING)::decs),
			sequence stat'' last_ins
		)
