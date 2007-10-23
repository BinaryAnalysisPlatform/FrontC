(* TCL -- Calipso command file.
**
** Project: 		Calipso
** File: 			calipso.ml
** Version:			3.0
** Date:			7.20.99
** Author:			Hugues Cassé
**
*)

exception ParsingError


(* Useful Data *)
let version = "Calipso V3.0 7.20.99 Hugues Cassé"
let help = version ^ "\n" ^ "calipso [-hmPtsVv] [-r[bcfgkrs]] [-s[lrw]] [-p preprocessor] <file list> [-o <output file>]"
exception InternalError

(* Output management *)
let out = ref stdout
let close_me = ref false

let close_output _ =
	flush !out;
	if !close_me then close_out !out else ();
	close_me := false
let set_output filename =
	close_output ();
	(try out := open_out filename
	with (Sys_error msg) ->
		output_string stderr ("Error while opening output: " ^ msg); exit 1);
	close_me := true
	

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
let stat_display = ref false
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
	remove_goto := true;
	Algo.regular_switch := true
let arg_def =
[
	"-V", Arg.Unit (fun _ -> print_endline help), "Informations";
	"-v", Arg.Set verbose_mode, "Verbose mode";
	"-o", Arg.String (fun filename -> set_output filename), "Output file";
	"-m", Arg.Set Algo.use_mask, "Use bitfield masks to handle labels.";
	"-p", Arg.String (fun id -> preproc := id), "Preprocessor command.";
	"-s", Arg.Set stat_display, "Display statistics on control flow structures.";
	"-P", Arg.Unit (fun _ -> preproc := "gcc -E %i -o %o"), "Use \"gcc -E %i -o %o\" as preprocessor.";
	"-rg", Arg.Set remove_goto, "Remove the goto statements.";
	"-rb", Arg.Set Reduce.remove_break, "Remove the break statements.";
	"-rc", Arg.Set Reduce.remove_continue, "Remove the continue statements.";
	"-rr", Arg.Set Reduce.remove_return, "Remove the return statements.";
	"-rs", Arg.Unit (fun _ -> Reduce.remove_switch := Reduce.RAW), "Reduce rawly the switch statements.";
	"-rk", Arg.Unit (fun _ -> Reduce.remove_switch := Reduce.KEEP; Algo.regular_switch := true), "Reduce the switch statements but keep the regular ones.";
	"-rf", Arg.Unit (fun _ -> Reduce.remove_switch := Reduce.REDUCE), "Reduce the switch statements but use a faster method for regular ones.";
	"-r", Arg.Unit standard_remove, "Set -rg, -rb, -rc, -rr, -rf options.";
	"-t", Arg.Unit subtle_remove, "Set -rg, -rb, -rc, -rr, -rk options.";
	"-sl", Arg.Unit (fun _ -> Algo.strategy := Algo.LEFT), "Organize sequences to the left";
	"-sr", Arg.Unit (fun _ -> Algo.strategy := Algo.RIGHT), "Organize sequences to the right";
	"-sw", Arg.Unit (fun _ -> Algo.strategy := Algo.WEIGHTED), "Organize sequences using the weight system"

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
	let process_func typ name body =
		Gen.reset ();
		let body' = Reduce.reduce body typ in
		if !remove_goto then Algo.remove body' else body' in
	match defs with
	[] -> []
	| (Cabs.FUNDEF ((base, sto, (id, proto, [], exp)), body))::fol ->
		let _ = if !verbose_mode then prerr_string (id ^ "()\n") in
		(match proto with
		Cabs.PROTO (typ, pars, ell) ->
			(Cabs.FUNDEF (
				(base, sto, (id, proto, [], exp)),
				process_func typ id body))
			::(process_defs fol)
		| _ -> raise InternalError)
	| (Cabs.OLDFUNDEF ((base, sto, (id, proto, [], exp)), decs, body))::fol ->
		let _ = if !verbose_mode then prerr_string (id ^ "()\n") in
		(match proto with
		Cabs.OLD_PROTO (typ, pars, ell) ->
			(Cabs.OLDFUNDEF (
				(base, sto, (id, proto, [], exp)),
				decs,
				process_func typ id body))
		::(process_defs fol)
		| _ -> raise InternalError)
	| def::fol -> def::(process_defs fol)


(* display_stats _ -> _
**	Display statistics about the number of statements.
*)
let display_stats _ =
	prerr_string ("  switch count = " ^ (string_of_int !Reduce.switch_count) ^ "\n");
	prerr_string ("    raw switch = " ^ (string_of_int !Reduce.raw_switch) ^ "\n");
	prerr_string ("   fast switch = " ^ (string_of_int !Reduce.fast_switch) ^ "\n");
	prerr_string ("   kept switch = " ^ (string_of_int !Reduce.kept_switch) ^ "\n");
	prerr_string ("   degenerated = " ^ (string_of_int !Algo.degenerated_switch) ^ "\n");
	prerr_string ("    case count = " ^ (string_of_int !Reduce.case_count) ^ "\n");
	prerr_string ("   break count = " ^ (string_of_int !Reduce.break_count) ^ "\n");
	prerr_string ("continue count = " ^ (string_of_int !Reduce.continue_count) ^ "\n");
	prerr_string ("  return count = " ^ (string_of_int !Reduce.return_count) ^ "\n");
	prerr_string ("    goto count = " ^ (string_of_int !Reduce.goto_count) ^ "\n");
	prerr_string ("   label count = " ^ (string_of_int !Reduce.label_count) ^ "\n");
	if !Algo.label_total = 0 then
		prerr_string "No label !\n"
	else begin
		prerr_string
			("   max labels per function = "
			^ (string_of_int !Algo.label_max) ^ "\n");
		prerr_string
			("               label total = "
			^ (string_of_int !Algo.label_total) ^ "\n");
		prerr_string
			("function containing labels = "
			^ (string_of_int !Algo.label_func) ^ "\n")
	end
	

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
		begin
			Cprint.print
				!out
				(process_defs defs);
			if !stat_display then display_stats ()
		end
	
let rec process_files files =
	match files with
	[] -> ()
	| filename::fol -> (process filename; process_files fol)

let _ =
	Arg.parse arg_def add_file help;
	process_files !files;
	close_output ()
