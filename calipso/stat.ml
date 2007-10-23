(* stat -- compute statistics about goto and labels.
**
** Project: 		Calipso
** File: 			calipso.ml
** Version:			1.0
** Date:			9.22.99
** Author:			Hugues Cassé
**
*)

open Cabs
exception ParsingError


(* statistics building *)
let goto_total = ref 0
let goto_funcs = ref 0
let goto_max = ref 0

let label_total = ref 0
let label_funcs = ref 0
let label_max = ref 0

let goto_one = ref false
let goto_cnt = ref 0
let label_one = ref false
let label_cnt = ref 0

let rec build_stat stat = 
	match stat with
	BLOCK (_, sstat) -> build_stat sstat
	| SEQUENCE (stat1, stat2) -> build_stat stat1; build_stat stat2
	| IF (_, stat1, stat2) -> build_stat stat1; build_stat stat2
	| WHILE (_, sstat) -> build_stat sstat
	| DOWHILE (_, sstat) -> build_stat sstat
	| FOR (_, _, _, sstat) -> build_stat sstat
	| SWITCH (_, sstat) -> build_stat sstat
	| CASE (_, sstat) -> build_stat sstat
	| DEFAULT sstat -> build_stat sstat
	| LABEL (_, sstat) -> incr label_cnt; label_one := true; build_stat sstat
	| GOTO _ -> incr goto_cnt; goto_one := true
	| _ -> ()

let process_func typ body  =
	let (decs, stats) = Reduce.reduce body typ in
	begin
		goto_one := false;
		label_one := false;
		goto_cnt := 0;
		label_cnt := 0;
		build_stat stats;
		goto_total := !goto_total + !goto_cnt;
		label_total := !label_total + !label_cnt;
		if !goto_cnt > !goto_max then goto_max := !goto_cnt;
		if !label_cnt > !label_max then label_max := !label_cnt;
		if !goto_one then incr goto_funcs;
		if !label_one then incr label_funcs
	end

let display_stats _ =
	print_string ("goto total = " ^ (string_of_int !goto_total) ^ "\n");
	print_string ("goto average = " ^ (if !goto_funcs = 0 then "-" else
		(string_of_int (!goto_total / !goto_funcs))) ^ "\n");
	print_string ("goto maximum = " ^ (string_of_int !goto_max) ^ "\n");
	print_string ("goto functions = " ^ (string_of_int !goto_funcs) ^ "\n");
	print_string ("label total = " ^ (string_of_int !label_total) ^ "\n");
	print_string ("label average = " ^ (if !label_funcs = 0 then "-" else
		(string_of_int (!label_total / !label_funcs))) ^ "\n");
	print_string ("label maximum = " ^ (string_of_int !label_max) ^ "\n");
	print_string ("label functions = " ^ (string_of_int !label_funcs) ^ "\n")
	


(* Useful Data *)
let version = "stat V1.0 = 9.22.99 Hugues Cassé"
let help = version ^ "\n" ^ "stat [-hPtVv] [-r[bcfgkrs]] [-p preprocessor] <file list>"
exception InternalError

(* File Management *)
let files = ref []

let add_file filename =
	files := List.append !files [filename]


(*
** Argument definition
*)
let remove_goto = ref false
let preproc = ref ""
let verbose_mode = ref false
let standard_remove _ =
	Reduce.remove_break := true;
	Reduce.remove_continue := true;
	Reduce.remove_return := true;
	Reduce.remove_switch := Reduce.REDUCE;
	remove_goto := true
let subtle_remove _ =
	Reduce.remove_break := true;
	Reduce.remove_continue := true;
	Reduce.remove_return := true;
	Reduce.remove_switch := Reduce.KEEP;
	remove_goto := true
let arg_def =
[
	"-V", Arg.Unit (fun _ -> print_endline help), "Informations";
	"-v", Arg.Set verbose_mode, "Verbose mode";
	"-p", Arg.String (fun id -> preproc := id), "Preprocessor command.";
	"-P", Arg.Unit (fun _ -> preproc := "gcc -E %i -o %o"), "Use \"gcc -E %i -o %o\" as preprocessor.";
	"-rg", Arg.Set remove_goto, "Remove the goto statements.";
	"-rb", Arg.Set Reduce.remove_break, "Remove the break statements.";
	"-rc", Arg.Set Reduce.remove_continue, "Remove the continue statements.";
	"-rr", Arg.Set Reduce.remove_return, "Remove the return statements.";
	"-rs", Arg.Unit (fun _ -> Reduce.remove_switch := Reduce.RAW), "Reduce rawly the switch statements.";
	"-rk", Arg.Unit (fun _ -> Reduce.remove_switch := Reduce.KEEP), "Reduce the switch statements but keep the regular ones.";
	"-rf", Arg.Unit (fun _ -> Reduce.remove_switch := Reduce.REDUCE), "Reduce the switch statements but use a faster method for regular ones.";
	"-r", Arg.Unit standard_remove, "Set -rg, -rb, -rc, -rr, -rf options.";
	"-t", Arg.Unit subtle_remove, "Set -rg, -rb, -rc, -rr, -rk options."
]


(*** preprocessing ***)
exception PreprocessingError
let preprocess inname outname =
	let rec replace str =
		try let idx = String.index str '%' in
			(if idx > 0 then String.sub str 0 idx else "")
			^ (match String.get str (idx + 1) with
				'i' -> inname
				| 'o' -> outname
				| '%' -> "%"
				| _ -> "")
			^ (if (idx + 2) >= (String.length str)
				then ""
				else replace
					(String.sub str (idx + 2) ((String.length str) - idx - 2))) 
		with Not_found -> str in
	let com = replace !preproc in
	let _ = if !verbose_mode
		then prerr_string ("Executing \"" ^ com ^ "\"\n")
		else () in
	if (Sys.command com) = 0 
		then ()
		else raise PreprocessingError


(* process_defs definition list -> definition list
**		Remove "goto" and statement alike in the definition list.
*)
let rec process_defs (defs : Cabs.definition list) =
	match defs with
	[] -> ()
	| (Cabs.FUNDEF ((base, sto, (id, proto, [], exp)), body))::fol ->
		let _ = if !verbose_mode then prerr_string (id ^ "()\n") in
		let _ =  match proto with
			Cabs.PROTO (typ, pars, ell) -> process_func typ body
			| _ -> raise InternalError in
		process_defs fol
	| (Cabs.OLDFUNDEF ((base, sto, (id, proto, [], exp)), decs, body))::fol ->
		let _ = if !verbose_mode then prerr_string (id ^ "()\n") in
		let _ = match proto with
			Cabs.OLD_PROTO (typ, pars, ell) -> process_func typ body
			| _ -> raise InternalError in
		process_defs fol
	| def::fol -> process_defs fol


(* Starter *)
let process filename =
	let parse file =
		let _ = if !verbose_mode then prerr_string "Parsing...\n" else () in
		Frontc.parse_file file stderr in
	match (
		if !preproc = ""
		then parse filename
		else
			let tmp = Filename.temp_file "rewrite" ".i" in
			try
				preprocess filename tmp;
				let res = parse tmp in
				Sys.remove tmp;
				res
			with PreprocessingError ->
				begin
					prerr_string
						("Error while preprocessing " ^ filename ^ "\n");
					Frontc.PARSING_ERROR
				end) with
	Frontc.PARSING_ERROR -> ()
	| Frontc.PARSING_OK defs ->
			process_defs defs
	
let rec process_files files =
	match files with
	[] -> ()
	| filename::fol -> (process filename; process_files fol)

let _ =
	Arg.parse arg_def add_file help;
	process_files !files;
	display_stats ()
