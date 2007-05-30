(* 
 *	$Id$
 *	Copyright (c) 2003, Hugues Cassé <hugues.casse@laposte.net>
 *
 *	Pretty printer of XML document.
 *)

open Frontc


(* Options *)
let banner =
	"ctoxml V1.0 (02/14/04)\n" ^
	"Copyright (c) 2004, Hugues Cassé <hugues.casse@laposte.net>\n\n" ^
	"SYNTAX:\tctoxml [options] files...\n" ^
	"\tctoxml [options] --\n"
let args: parsing_arg list ref = ref []
let files: string list ref = ref []
let out_file = ref ""
let from_stdin = ref false


(* Options scanning *)
let opts = [
	("-o", Arg.Set_string out_file,
		"Output to the given file.");
	("-pp", Arg.Unit (fun _ -> args := USE_CPP :: !args),
		"Preprocess the input files.");
	("-nogcc", Arg.Unit (fun _ -> args := (GCC_SUPPORT false) :: !args),
		"Do not use the GCC extensions.");
	("-proc", Arg.String (fun cpp -> args := (PREPROC cpp) :: !args),
		"Use the given preprocessor");
	("-i", Arg.String (fun file -> args := (INCLUDE file) :: !args),
		"Include the given file.");
	("-I", Arg.String (fun dir -> args := (INCLUDE_DIR dir) :: !args),
		"Include retrieval directory");
	("-D", Arg.String (fun def -> args := (DEF def) :: !args),
		"Pass this definition to the preprocessor.");
	("-U", Arg.String (fun undef -> args := (UNDEF undef) :: !args),
		"Pass this undefinition to the preprocessor.");
	("--", Arg.Set from_stdin,
		"Takes input from standard input.");
]


(* Main Program *)
let _ =

	(* Parse arguments *)
	Arg.parse opts (fun file -> files := file :: !files) banner;

	(* Get the output *)
	let (output, close) =
		if !out_file = "" then (stdout,false)
		else ((open_out !out_file), true) in
	

	(* Process the input *)
	let process opts =
		match Frontc.parse opts with
		  PARSING_ERROR ->  ()
		| PARSING_OK file ->
			let doc = Frontc.convert_to_xml file in
			Cxml.output_doc output doc in

	(* Process the inputs *)
	let _ =
		if !from_stdin || !files = []
		then process !args
		else
			List.iter (fun file -> process ((FROM_FILE file) :: !args)) !files in

	(* Close the output if needed *)
	if close then close_out output

	
