(* Calipso Project -- main algorithm
**
**	Project: 		Calipso
** 	File: 			calipso.ml
** 	Version:		3.0
**	Date:			7.20.99
** 	Author:			Hugues Cassé
*)

open Label

(* switches *)
let regular_switch = ref false
type strategy_kind =
	LEFT			(* sequence built at left *)
	| RIGHT			(* sequence built at right *)
	| WEIGHTED		(* sequence built using weights *)
let strategy = ref LEFT
let use_mask = ref false


(* Statistics data *)
let degenerated_switch = ref 0
let label_total = ref 0
let label_max = ref 0
let label_func = ref 0



(* linearize statement -> statement list
**	Transform embedded sequence statement to the list form.
*)
let rec linearize stat =
	match stat with
	(_, _, SEQUENCE (n1, n2)) ->
		List.append (linearize n1) (linearize n2)
	| (_, _, NOP) -> []
	| (_, _, BLOCK ([], stat')) -> linearize stat'
	| _ -> [stat]


(* cabs2cal Cabstract_statement -> Calipso_statement
**	Convert statements.
*)
let null = BitField.empty 1
let rec cabs2cal (stat : Cabs.statement) : node =
	let rec extract stat =
		match stat with
		Cabs.CASE (cst, stat') ->
			let (csts, stat'') = extract stat' in (cst::csts, stat'')
		| Cabs.DEFAULT stat' ->
			let (csts, stat'') = extract stat' in (Cabs.NOTHING::csts, stat'')
		| _ -> ([], stat) in
	
	let rec cut stats =
		match stats with
		[] -> (Cabs.NOP, [])
		| (Cabs.CASE _)::fol -> (Cabs.NOP, stats)
		| (Cabs.DEFAULT _)::fol -> (Cabs.NOP, stats)
		| stat::fol ->
			let (stat', fol') = cut fol in
			let stat'' = Gen.remove_break stat in
			if stat = Cabs.NOP then (stat', fol')
			else if stat' = Cabs.NOP then (stat'', fol')
			else (Cabs.SEQUENCE (stat'', stat'), fol') in
		
	let rec divide stats : (Cabs.expression list * node) list =
		match stats with
		[] -> []
		| stat::fol ->
			let (csts, stat') = extract stat in
			let (seq, fol') = cut (stat'::fol) in
			((csts, cabs2cal seq) : Cabs.expression list * node)::(divide fol') in

	match stat with
	  Cabs.NOP -> (null, null, NOP)
	| Cabs.COMPUTATION exp -> (null, null, COMPUTATION exp)
	| Cabs.GNU_ASM _ | Cabs.ASM _ -> (null, null, OTHER stat)
	| Cabs.BLOCK (decs, stat') ->
		(null, null, BLOCK (decs, cabs2cal stat'))
	| Cabs.SEQUENCE (stat1, stat2) ->
		(null, null, SEQUENCE (cabs2cal stat1, cabs2cal stat2))
	| Cabs.IF (cnd, Cabs.GOTO lbl, Cabs.NOP) ->
		(null, null, NORMAL_GOTO (cnd, lbl))
	| Cabs.IF (cnd, stat1, stat2) ->
		(null, null, IF (cnd, cabs2cal stat1, cabs2cal stat2))
	| Cabs.WHILE (cnd, stat') ->
		(null, null, WHILE (cnd, cabs2cal stat'))
	| Cabs.DOWHILE (cnd, stat') ->
		(null, null, DOWHILE (cnd, cabs2cal stat'))
	| Cabs.FOR (ini, cnd, nxt, stat') ->
		(null, null, FOR (ini, cnd, nxt, cabs2cal stat'))
	| Cabs.GOTO lbl ->
		(null, null, NORMAL_GOTO (Gen.cnd_true, lbl))
	| Cabs.LABEL (lbl, stat') ->
		(null, null, LABEL (lbl, cabs2cal stat'))
	| Cabs.CASE (cst, stat') ->
		(null, null, CASE (cst, cabs2cal stat'))
	| Cabs.DEFAULT stat' ->
		(null, null, DEFAULT (cabs2cal stat'))
	| Cabs.BREAK -> (null, null, BREAK)
	| Cabs.CONTINUE -> (null, null, CONTINUE)
	| Cabs.RETURN exp -> (null, null, RETURN exp)
	| Cabs.SWITCH (cnd, stat') ->
		if !regular_switch then
			let stats = Gen.linearize stat' in
			let cases = divide stats in
			(null, null, REGULAR_SWITCH (cnd, cases))
		else
			(null, null, SWITCH (cnd, cabs2cal stat'))
	| Cabs.STAT_LINE (stat, file, line) ->
		(null, null, LINE (cabs2cal stat, file, line))


(* cal2cabs Calipso_statement -> Cabstract_statement
**	Convert statement formats.
*)
let rec cal2cabs stat =
	let rec sequentialize stats =
		match stats with
		[] -> Cabs.NOP
		| [stat] -> stat
		| stat::stats -> Cabs.SEQUENCE (stat, sequentialize stats) in

	let rec factorize nds ins =
		match nds with
		[] -> ([], [])
		| (_, _, GUARD (cnd, nd, ins', outs'))::fol ->
			if not (BitField.equal ins ins') then ([], nds)
			else if not (BitField.isEmpty outs') then ([cal2cabs nd], fol)
			else let (thens, fol') = factorize fol ins in
			((cal2cabs nd)::thens, fol')
		| _ -> ([], nds) in
	
	let rec partition nds =
		match nds with
		[] -> []
		| (_, _, GUARD (cnd, nd, ins, outs))::fol ->
			let (thens, fol') = factorize nds ins in
			(Cabs.IF (cnd, sequentialize thens, Cabs.NOP))::(partition fol')
		| nd::fol -> (cal2cabs nd)::(partition fol) in
	
	match stat with
	  (_, _, NOP) -> Cabs.NOP
	| (_, _, COMPUTATION exp) -> Cabs.COMPUTATION exp
	| (_, _, BLOCK (decs, stat')) ->
		let stat'' = cal2cabs stat' in
		if (stat'' = Cabs.NOP) && (decs = []) then Cabs.NOP
		else Cabs.BLOCK (decs, stat'')
	| (_, _, SEQUENCE (stat1, stat2)) ->
		sequentialize (partition (linearize stat))		
	| (_, _, IF (cnd, stat1, stat2)) ->
		Cabs.IF (cnd, cal2cabs stat1, cal2cabs stat2)
	| (_, _, WHILE (cnd, stat')) -> Cabs.WHILE (cnd, cal2cabs stat')
	| (_, _, DOWHILE (cnd, stat')) -> Cabs.DOWHILE (cnd, cal2cabs stat')
	| (_, _, FOR (ini, cnd, nxt, stat')) ->
		Cabs.FOR (ini, cnd, nxt, cal2cabs stat')
	| (_, _, RETURN exp) -> Cabs.RETURN exp
	| (_, _, NORMAL_GOTO (cnd, lbl)) ->
		if cnd = Gen.cnd_true then Cabs.GOTO lbl
		else Cabs.IF (cnd, Cabs.GOTO lbl, Cabs.NOP)
	| (_, _, LABEL (lbl, stat')) -> Cabs.LABEL (lbl, cal2cabs stat')
	| (_, _, GUARD (cnd, stat', _, _)) ->
		Cabs.IF (cnd, cal2cabs stat', Cabs.NOP)
	| (_, _, SWITCH (cnd, stat')) -> Cabs.SWITCH (cnd, cal2cabs stat')
	| (_, _, CASE (cst, stat')) -> Cabs.CASE (cst, cal2cabs stat')
	| (_, _, DEFAULT stat') -> Cabs.DEFAULT (cal2cabs stat')
	| (_, _, BREAK) -> Cabs.BREAK
	| (_, _, CONTINUE) -> Cabs.CONTINUE
	| (_, _, REGULAR_SWITCH (cnd, cases)) ->
		let body = sequentialize (List.map
			(fun (csts, seq) ->
				let seq = Cabs.SEQUENCE(cal2cabs seq, Cabs.BREAK) in
				List.fold_right
					(fun cst stat -> if cst = Cabs.NOTHING
						then Cabs.DEFAULT stat else Cabs.CASE (cst, stat))
					csts
					seq)
			cases) in
		Cabs.SWITCH (cnd, body)
	| (_, _, LINE (node, file, line)) -> 
		Cabs.STAT_LINE (cal2cabs node, file, line)
	| (_, _, OTHER stat) -> stat


(* pass1 nodes labels -> nodes
**		Computes GOTO and LABEL sets.
*)
let pass1 (nd : node) (labs : label_list) : node =
	let empty = BitField.empty (get_count labs) in
	let rec compute nd  =
		match nd with
		(_, _, BLOCK (decs, s)) ->
			let n = compute s in
			let (goto, label, _) = n in
			(goto, label, BLOCK (decs, n))
		| (_, _, SEQUENCE (s1, s2)) ->
			let n1 = compute s1 in
			let n2 = compute s2 in
			let (g1, l1, _) = n1 in
			let (g2, l2, _) = n2 in
			(BitField.union (BitField.diff g1 l2) (BitField.diff g2 l1),
			BitField.union l1 l2,
			SEQUENCE (n1, n2))
		| (_, _, IF (cnd, s1, s2)) ->
			let n1 = compute s1 in
			let n2 = compute s2 in
			let (g1, l1, _) = n1 in
			let (g2, l2, _) = n2 in
			(BitField.union (BitField.diff g1 l1) (BitField.diff g2 l2),
			BitField.union l1 l2,
			IF (cnd, n1, n2))
		| (_, _, WHILE (cnd, s)) ->
			let n = compute s in
			let (goto, label, _) = n in
			(goto, label, WHILE (cnd, n))	
		| (_, _, DOWHILE (cnd, s)) ->
			let n = compute s in
			let (goto, label, _) = n in
			(goto, label, DOWHILE (cnd, n))	
		| (_, _, FOR (ini, cnd, nxt, s)) ->
			let n = compute s in
			let (goto, label, _) = n in
			(goto, label, FOR (ini, cnd, nxt, n))
		| (_, _, NORMAL_GOTO (cnd, lbl)) ->
			(BitField.set empty (get_index labs lbl), empty,
			NORMAL_GOTO (cnd, lbl))
		| (_, _, LABEL (lbl, s)) ->
			let n = compute s in
			let (goto, label, _) = n in
			(goto, BitField.set label (get_index labs lbl), LABEL (lbl, n))
		| (_, _, REGULAR_SWITCH (cnd, cases)) ->
			let (goto, label, cases') =
				List.fold_right
					(fun  (csts, seq) (goto, label, cases) ->
						let seq' = compute seq in
						let (goto', label', _) = seq' in
						(BitField.union goto goto',
						BitField.union label label',
						(csts, seq')::cases))
					cases
					(empty, empty, []) in
			(goto, label, REGULAR_SWITCH (cnd, cases'))
		| (_, _, s) -> (empty, empty, s) in
	compute nd


(* make_cond pos neg  labs -> expression
**		Compute a guarding condition.
*)
let make_cond pos neg labs cond =
	let rec or_list idx set cond : Cabs.expression =
		if idx < 0 then cond
		else 
			let exp : Cabs.expression = or_list (idx - 1) set cond in
			if not (BitField.get set idx) then exp
			else
				let flag = Cabs.VARIABLE (get_label labs idx) in
				if exp = Cabs.NOTHING then flag
				else Cabs.BINARY (Cabs.OR, flag, exp) in
	let pos_exp = if BitField.isEmpty pos then cond
		else or_list ((BitField.size pos) - 1) pos cond in
	if BitField.isEmpty neg
	then pos_exp
	else
		let neg_exp = Cabs.UNARY (
			Cabs.NOT,
			or_list ((BitField.size neg) - 1) neg Cabs.NOTHING) in
		if pos_exp = Cabs.NOTHING then neg_exp
		else Cabs.BINARY (Cabs.AND, neg_exp, pos_exp)


(* apply_weights statement in_labels out_labels -> statement
**		Apply weights strategy.
*)
let apply_weights nd ins outs =
	let add wghts idx vle =
		try Array.set wghts idx ((Array.get wghts idx) + vle)
		with Invalid_argument _ -> () in
	let add_inter wghts i j vle =
		for k = i to j do add wghts k vle done in
		
	let test_edge wghts i (goti, lbli, si) j (gotj, lblj, sj) =
		let cnt = BitField.count (BitField.inter goti lblj) in
		if cnt <> 0 then
			if i <= j then	(* forward branch *)
			begin
				add wghts (i + 1) ((j - i) * cnt);
				add wghts j ((j - i) * cnt)
			end
		else				(* backward branch *)
			add_inter wghts i j (- ((j - i) * cnt)) in
	
	let test_edge_in wghts i (goti, lbli, si) =
		let bra = BitField.inter ins lbli in
		if not (BitField.isEmpty bra) then
			add wghts i ((i + 1) * (BitField.count bra)) in
	let test_edge_out wghts i (goti, lbli, si) =
		let bra = BitField.inter goti outs in
		if not (BitField.isEmpty bra) then
			add wghts (i + 1)
				(((Array.length wghts) - i) * (BitField.count bra)) in
		
	let test_edges stats =
		let lng = List.length stats in
		let wghts = Array.create lng 0 in
		begin
			for i = 0 to (lng - 1) do
				for j = 0 to (lng - 1) do
					test_edge wghts
						i (List.nth stats i)
						j (List.nth stats j)
				done
			done;
			for i = 0 to (lng - 1) do
				test_edge_in wghts i (List.nth stats i);
				test_edge_out wghts i (List.nth stats i)
			done;
			wghts
		end in

	let rec rebuild start stop stats wghts =
		if start = stop then List.nth stats start
		else
			let rec max idx ml =
			if idx > stop then ml
			else if (Array.get wghts ml) > (Array.get wghts idx)
				then max (idx + 1) ml
			else max (idx + 1) idx in
				let idx = max (start + 1) start in
				let idx' = if idx = start then idx + 1 else idx in
				let n1 = rebuild start (idx' - 1) stats wghts in
				let n2 = rebuild idx' stop stats wghts in
				let (g1, l1, s1) = n1 in
				let (g2, l2, s2) = n2 in
				( BitField.union (BitField.diff g1 l2) (BitField.diff g2 l1),
				BitField.union l1 l2,
				SEQUENCE (n1, n2)) in
						
	let nds = linearize nd in
	let wghts = test_edges nds in
	rebuild 0 ((Array.length wghts) - 1) nds wghts


(* apply_right statement -> statement
**	Build a sequence to the right.
*)
let apply_right nd =
	let rec to_right nds =
		match nds with
		[] -> (null, null, NOP)
		| [nd] -> nd
		| nd1::fol ->
			let nd2 = to_right fol in
			let (g1, l1, s1) = nd1 in
			let (g2, l2, s2) = nd2 in
			(BitField.union (BitField.diff g1 l2) (BitField.diff g2 l1),
			BitField.union l1 l2,
			SEQUENCE (nd1, nd2)) in
			
	let nds = linearize nd in
	to_right nds
	

(* degenerate_switch condition (constants * sequence) list -> statement
**	Degenerate a regular switch to embeded-ifs form.
*)
let degenerate_switch cnd cases =
	let tag = Gen.new_tag () in
	let rec is_default csts =
		match csts with
		[] -> false
		| Cabs.NOTHING::fol -> true
		| _::fol -> is_default fol in
	let rec build_cond csts =
		match csts with
		[] -> Gen.cnd_false
		| [cst] -> Cabs.BINARY (Cabs.EQ, Cabs.VARIABLE tag, cst)
		| cst::fol -> Cabs.BINARY (Cabs.OR,
			Cabs.BINARY (Cabs.EQ, Cabs.VARIABLE tag, cst),
			build_cond fol) in
	let rec do_it cases def =
		match cases with
		[] -> def
		| (csts, seq)::fol ->
			if is_default csts then do_it fol seq
			else (null, null, IF (build_cond csts, seq, do_it fol def)) in
	(null, null, BLOCK
		([Gen.dec_var tag Cabs.NO_TYPE cnd],
		do_it cases (null, null, NOP)))

	
(* pass23 declarations statements labs -> declarations * statements
**		Perform pass3.
*)
exception JumpToDefaultInRegularSwitch
let rec pass23 (nd : node) (labs : label_list) : node =
	let count = get_count labs in
	let empty = BitField.empty count in
	let make stat = (empty, empty, stat) in
	let assign name value =
		COMPUTATION (Cabs.BINARY (Cabs.ASSIGN, Cabs.VARIABLE name, value)) in

	let rec get_const csts =
		match csts with
		[] -> raise JumpToDefaultInRegularSwitch
		| Cabs.NOTHING::fol -> get_const fol
		| cst::_ -> cst in
	
	let guard set nd ins outs =
		let cnd = if !use_mask
			then make_full_test empty set Cabs.NOTHING
			else make_cond empty set labs Cabs.NOTHING in
		(empty, empty, GUARD (cnd, nd, ins, outs)) in
	
	let loop pos nd =
		let cnd = if !use_mask
			then make_full_test pos empty Cabs.NOTHING
			else make_cond pos empty labs Cabs.NOTHING in
		(empty, empty, DOWHILE (cnd, nd)) in
	
	let rec transform nd ins outs =
		match nd with
		(goto, label, NORMAL_GOTO (cnd, lbl)) ->
			let goto = if !use_mask
				then  let set = set_label_true labs lbl in
					if cnd = Gen.cnd_true then set
					else IF (cnd, make set, make NOP)
				else assign lbl (Gen.rectify_condition cnd) in
			make goto
			
		| (goto, label, LABEL(lbl, s)) ->
			let l = BitField.inter goto label in
			let label = if !use_mask
				then set_label_false labs lbl
				else assign lbl Gen.cnd_false in
			let t = make (SEQUENCE (make label,
				(transform s
					(BitField.diff (BitField.reset ins (get_index labs lbl)) l)
					(BitField.diff outs l)))) in
			if BitField.isEmpty l then t
			else loop l t

		| (goto, label, BLOCK (decs, s)) ->
			make (BLOCK (decs, transform s ins outs))
			
		| (goto, label, SEQUENCE (s1, s2)) ->
			let rec do_it nd ins outs =
				match nd with
				(goto, label, SEQUENCE (s1, s2)) ->
					let (gotos1, labels1, _) = s1 in
					let (gotos2, labels2, _) = s2 in
					let ins1 = BitField.union
						(BitField.inter ins labels1)
						(BitField.inter gotos2 labels1) in
					let ins2 = BitField.union
						(BitField.inter ins labels2)
						(BitField.inter gotos1 labels2) in
					let outs1 = BitField.union
						(BitField.inter outs gotos1)
						(BitField.inter labels2 gotos1) in
					let outs2 = BitField.union
						(BitField.inter outs gotos2)
						(BitField.inter labels1 gotos2) in
					let n1 = do_it s1 ins1 outs1 in
					let n2 = do_it s2 ins2 outs2 in
					let s_to_s2 = BitField.inter ins ins2 in
					let s1_to_s = BitField.inter outs outs1 in
					let s2_to_s1 = BitField.inter outs2 ins1 in
					let t1 = if BitField.isEmpty s_to_s2
						then n1 else guard s_to_s2 n1 ins1 outs1 in
					let t2 = if BitField.isEmpty s1_to_s 
						then n2 else guard s1_to_s n2 ins2 outs2 in
					let t = (empty, empty, SEQUENCE (t1, t2)) in
						if BitField.isEmpty s2_to_s1 then t
						else loop s2_to_s1 t
				| _ -> transform nd ins outs in
	
			let nd' = (match !strategy with
				WEIGHTED -> apply_weights nd ins outs
				| LEFT -> nd
				| RIGHT -> apply_right nd) in
			do_it nd' ins outs
		
		| (goto, label, IF(cnd, s1, s2)) ->
			let (gotos1, labels1, _) = s1 in
			let (gotos2, labels2, _) = s2 in
			let ins1 = BitField.union
				(BitField.inter ins labels1) (BitField.inter gotos2 labels1) in
			let ins2 = BitField.union
				(BitField.inter ins labels2) (BitField.inter gotos1 labels2) in
			let outs1 = BitField.union
				(BitField.inter outs gotos1) (BitField.inter labels2 gotos1) in
			let outs2 = BitField.union
				(BitField.inter outs gotos2) (BitField.inter labels1 gotos2) in
			let n1 = transform s1 ins1 outs1 in
			let n2 = transform s2 ins2 outs2 in
			let cnd' = if !use_mask
				then make_full_test ins1 ins2 cnd
				else make_cond ins1 ins2 labs cnd in
			let t = make (IF (cnd', n1, n2)) in
			let loop_set = BitField.union
				(BitField.inter ins1 outs2) (BitField.inter ins2 outs1) in
			if BitField.isEmpty loop_set then t
			else loop loop_set t
		
		| (goto, label, WHILE(cnd, s)) ->
			let nd = transform s ins outs in
			let cnd' = if !use_mask
				then make_full_test ins outs cnd
				else make_cond ins outs labs cnd in
			make (WHILE (cnd', nd))
			
		| (goto, label, DOWHILE(cnd, s)) ->
			let nd = transform s ins outs in
			let cnd' = if !use_mask
				then make_full_test empty outs cnd
				else make_cond empty outs labs cnd in
			make (DOWHILE (cnd', nd))
			
		| (goto, label, FOR(ini, cnd, nxt, s)) ->
			let nd = transform s ins outs in
			let cnd' = if !use_mask
				then make_full_test ins outs cnd
				else make_cond ins outs labs cnd in
			let nxt' = if !use_mask
				then make_full_test outs empty nxt
				else make_cond outs empty labs nxt in
			make (FOR (ini, cnd', nxt', nd))
		
		| (goto, label, REGULAR_SWITCH (cnd, cases)) ->
			(try
				let (cases', intos) = List.fold_right
					(fun (csts, seq) (cases, intos) ->
						let (goto', label', _) = seq in
						let ins' = BitField.union
							(BitField.inter ins label')
							(BitField.inter goto label') in
						let outs' = BitField.union
							(BitField.inter outs goto')
							(BitField.inter label goto') in
						let seq' = transform seq ins' outs' in
						((csts, seq')::cases, (csts, ins')::intos))
					cases
					([], []) in
				let (test, tag) = List.fold_right
					(fun (csts, ins) (stat, tag) ->
						if BitField.isEmpty ins then (stat, tag)
						else
							let tval = get_const csts in
							let cnd = if !use_mask
								then make_full_test ins empty Cabs.NOTHING
								else make_cond ins empty labs Cabs.NOTHING in
							let tag' = if tag = "" then Gen.new_tag () else tag in
							(make (IF (cnd, make (assign tag' tval), stat)), tag'))
					intos
					(make NOP, "") in
				let switch =  if tag = "" then make (REGULAR_SWITCH (cnd, cases'))
					else make (BLOCK
						([Gen.dec_var tag Cabs.NO_TYPE cnd],
						make (SEQUENCE (test,
							make (REGULAR_SWITCH (Cabs.VARIABLE tag, cases')))))) in
				let lp = BitField.inter goto label in
				if BitField.isEmpty lp then switch
				else loop lp switch
			with JumpToDefaultInRegularSwitch ->
				let dswitch = degenerate_switch cnd cases in
				let dswitch' = pass1 dswitch labs in
				transform dswitch' ins outs)
		
		(*| (goto, label, SWITCH (cnd, stat')) ->
			let loopm = BitField.inter goto label in
			if BitField.isEmpty loopm then switch
			else loop loopm switch*)
			
		| _ -> nd in
	transform nd empty empty


(* remove body -> body
**	Perform the goto removal using  Calipso algorithm.
*)
let remove (decs, stat) =
	let cal_stat = cabs2cal stat in
	let lab_list = find_labels cal_stat in
	let cnt = List.length lab_list in
	let _ = label_total := !label_total + cnt in
	let _ = if cnt != 0 then incr label_func in
	let _ = if cnt > !label_max then label_max := cnt in
	let labs = make_labs lab_list in
	let cal_stat' = pass1 cal_stat labs in
	let cal_stat'' = pass23 cal_stat' labs in
	let decs' = if lab_list = [] then decs
		else if !use_mask
		then (declare_labels labs)::decs
		else (Gen.dec_flags lab_list)::decs in
	(decs', cal2cabs cal_stat'')

	
