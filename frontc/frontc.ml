(* 
 *	$Id$
 *	Copyright (c) 2003, Hugues Cassé <hugues.casse@laposte.net>
 *
 *	Library entry point..
 *)

(* Old history.
 *
 *	1.0	2.18.99	Hugues Cassé	First release.
 *	2.0	3.22.99	Hugues Cassé	Full ANSI C and GCC attributes supported.
 *								Cprint improved.
 *  2.1 2.18.04 Hugues Cassé	A lot of improvement: improved parse
 *								arguments allowing preprocessing and any
 *								channel, converison to XML, support for
 *								unknown types in typedef.
 *)


let version = "FrontC 2.1 2.18.04 Hugues Cassé"
open Cabs


(**
 * FrontC is an OCAML library providing facilities for parsing source file
 * in C language.
 *
 * Although it is designed for parsing ANSI C, it provides also support for
 * old K&R C style and for some GCC extensions.
 *
 * It provides also a limited degraded mode allowing to parse file although
 * all type information is not available and preprocessor directives are still
 * in the source.
 *
 * @author Hugues Cassé <hugues.casse\@laposte.net>
 *)

(* !!TODO!!
	Add option support:
		- Support unknown types.
		- Support for GC specifics (attributes, __builtin_va_list).
		- Replace the input handler by a structure.
 *)


(**
 * Parameters for building the reader handler.
 *)
type parsing_arg =
	  FROM_STDIN					(** Parse the standard input. *) 
	| FROM_CHANNEL of in_channel	(** Parse the given channel. *)
	| FROM_FILE of string			(** Parse the given file. *)
	| USE_CPP						(** Use the C preprocessor. *)
	| PREPROC of string				(** Path to the preprocessor. *)
	| DEF of string					(** Pass this definition to CPP. *)
	| UNDEF of string				(** Undefine the given symbol for CPP. *)
	| INCLUDE of string				(** Include the given file by the CPP. *)
	| INCLUDE_DIR of string			(** Use the given directory for retrieving includes. *)
	| OPTION of string				(** Pass the given option directl to the CPP. *)
	| ERROR of out_channel			(** Use the given channel for outputting errors. *)
	| INTERACTIVE of bool			(** Is this session interactive (from console). *)
	| GCC_SUPPORT of bool			(** Support some extensions of the GCC compiler (default to true). *)
	| LINE_RECORD of bool			(** Record line numbers in the C abstract trees (default to false). *)


(**
 * Result of a parsing.
 *)
type parsing_result =
	PARSING_ERROR	(** Parsing failure. Error outputted. *)
	| PARSING_OK of Cabs.definition list (** Success. Return list of read definitions. *)


(**
 * Transform an old K&R C function definition into a new ANSI one.
 * @param def	Old function definition.
 * @return		New function definition.
 * @raise UnconsistentDef	Raised when an undeclared parameter is found
 * in the function definition.
 *)
let trans_old_fun_def (def: single_name * name_group list * body) =
	let int_type = INT (NO_SIZE, NO_SIGN) in
	let ((_type, store, name), par_types, body) = def in
	let (ident, full_type, attrs, exp) = name in 
	
	let (rtype, par_names, vararg) =
		match full_type with
		  OLD_PROTO proto -> proto
		| _ ->
			raise UnconsistentDef in
	
	let process_group (rtype, store, names) =
		List.map
			(fun (name, _type, _, _) ->
				(name, (rtype, store, _type)))
			names in

	let par_defs = List.flatten (List.map process_group par_types) in
	
	let process_name name =
		let (rtype, store, ftype) =
			try
				List.assoc name par_defs
			with Not_found ->
				(int_type, NO_STORAGE, int_type) in
		(rtype, store, (name, ftype, [], NOTHING)) in

	let rec normalize_type _type =
		match _type with
		  NO_TYPE -> int_type
		| CONST _type -> CONST (normalize_type _type)
		| VOLATILE _type -> VOLATILE (normalize_type _type)
		| GNU_TYPE (attrs, _type) -> GNU_TYPE (attrs, normalize_type _type)
		| PTR _type -> PTR (normalize_type _type)
		| RESTRICT_PTR _type -> RESTRICT_PTR (normalize_type _type)
		| ARRAY(_type, size) -> ARRAY (normalize_type _type, size)
		| _ -> _type in
		
	let fpars = List.map process_name par_names in
	let proto = PROTO (normalize_type rtype, fpars, vararg) in
	FUNDEF ((normalize_type _type, store, (ident, proto, attrs, exp)), body)


(**
 * Transform all old function definition into new ones.
 * @param defs	Defs to transform.
 * @return		Definitions with all old function definitions transformed.
 * @raise UnconsistentDef Raised if some old function definition does not
 * define the type of a parameter.
 *)
let rec trans_old_fun_defs defs =
	match defs with
	  [] ->
	  	[]
	| (OLDFUNDEF (dec, pars, body)) :: defs ->
	  	(trans_old_fun_def (dec, pars, body)) :: (trans_old_fun_defs defs)
	| def :: defs ->
		def :: (trans_old_fun_defs defs)


(**
 * Convert the given C file abstract repersentation into XML.
 * @param file	C file to convert.
 * @return		XML document result of conversion.
 * @raise UnconsistentDef	Raised if the file contains some old function
 * definition whose one parameter is not defined.
 *)
let convert_to_xml file =
	let safe_file = trans_old_fun_defs file in
	let children = List.flatten (List.map Ctoxml.convert_def safe_file) in
	let elt = Cxml.new_elt "file" [] children in
	Cxml.new_simple_doc elt


let parse args =
	let error = ref stderr in
	let input = ref stdin in
	let cpp_cmd = ref "cpp" in
	let cpp_opts = ref "" in
	let cpp_use = ref false in
	let file = ref "" in
	let interactive = ref false in
	let gcc = ref true in
	let linerec = ref false in
	
	(* Scan the arguments *)
	let rec scan args =
		match args with
		  [] -> ()
		| FROM_STDIN :: tl ->
			input := stdin; scan tl
		| (FROM_FILE path) :: tl ->
			file := path; scan tl
		| (FROM_CHANNEL chan) :: tl ->
			input := chan; scan tl
		| USE_CPP :: tl ->
			cpp_use := true; scan tl
		| (PREPROC cmd) :: tl ->
			cpp_cmd := cmd; scan tl
		| (DEF def) :: tl ->
			cpp_opts := !cpp_opts ^ " -D" ^ def; scan tl
		| (UNDEF undef) :: tl ->
			cpp_opts := !cpp_opts ^ " -U" ^ undef; scan tl
		| (INCLUDE file) :: tl ->
			cpp_opts := !cpp_opts ^ " -i" ^ file; scan tl
		| (INCLUDE_DIR dir) :: tl ->
			cpp_opts := !cpp_opts ^ " -I" ^ dir; scan tl
		| (OPTION opt) :: tl ->
			cpp_opts := !cpp_opts ^ " " ^ opt; scan tl
		| (ERROR chan) :: tl ->
			error := chan; scan tl
		| (INTERACTIVE inter) :: tl ->
			interactive := inter; scan tl
		| (GCC_SUPPORT v) :: tl ->
			gcc := v; scan tl
		| (LINE_RECORD v) :: tl ->
			linerec := v; scan tl in
	let _ = scan args in
	
	(* Build the input *)
	let (real_input, close) =
		if not !cpp_use then
			if !file = "" then (!input, false)
			else (open_in !file, true)
		else
			let cmd = !cpp_cmd ^ " " ^ !cpp_opts ^ " " ^ !file in
			(Unix.open_process_in cmd, true) in
	
	(* Perform the  parse *)
	let result =
		try 
			Clexer.init {
				Clexer.h_interactive = !interactive;
				Clexer.h_in_channel = real_input;
				Clexer.h_line = "";
				Clexer.h_buffer = "";
				Clexer.h_pos = 0;
				Clexer.h_lineno = 0;
				Clexer.h_out_channel = !error;
				Clexer.h_file_name = !file;
				Clexer.h_gcc = !gcc;
				Clexer.h_linerec = !linerec;
			};
			PARSING_OK (Cparser.file
				Clexer.initial
				(Lexing.from_function (Clexer.get_buffer Clexer.current_handle)))
		with
		  Parsing.Parse_error ->
		  	PARSING_ERROR
		| Cabs.BadType ->
			Clexer.display_semantic_error "mal-formed type" ;
			PARSING_ERROR 
		| Cabs.BadModifier ->
			Clexer.display_semantic_error "mal-formed modifier";
			PARSING_ERROR in
	
	(* Cleanup *)
	if close then close_in real_input;
	result


(**
 * Parse the input channel in interactive way, that is, as coming from the
 * console. Error are displayed in a specific way.
 * @param inp	Input to read the C source from.
 * @param out	For outputting errors.
 * @return		Read C definitions.
 *)
let parse_interactive  (inp : in_channel) (out : out_channel) : parsing_result =
	parse [FROM_CHANNEL inp; ERROR out; INTERACTIVE true]


(**
 * Parse the C source from the console. It exactly equals to
 * "parse_interactive stdin stderr".
 * @return Read C definitions.
 *)
let parse_console _ : parsing_result =
	parse_interactive stdin stderr


(**
 * Parse the C source from a non-interactive channel. It may be useful when
 * the source come from a piped channel from the C preprocessor, for example.*
 * @param input	Input channel to read the source from.
 * @param out	Output channel to display errors.
 * @return		Read C definitions.
 *)	
let parse_channel (input: in_channel) (out: out_channel) : parsing_result =
	parse [FROM_CHANNEL input; ERROR out]


(**
 * Parse a C source passed as a file path.
 * @param file_name	Path of the file to read.
 * @param out		Channel used for displaying errors.
 * @return			Read C definitions.
 *
 * NOTE: an error during the read of the file returned as a parse failure.
 *)	
let parse_file (file_name : string) (out : out_channel) : parsing_result =
	try
		parse [FROM_FILE file_name; ERROR out]
	with (Sys_error msg) ->
		output_string out
			("Error while opening " ^ file_name
			^ ": " ^ msg ^ "\n");
		PARSING_ERROR
