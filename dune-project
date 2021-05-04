(lang dune 2.7)
(using menhir 2.0)
(cram enable)
(version 4.0.0)
(name FrontC)

(license LGPL-2.0-only)
(authors "Hugues Cassé <casse@irit.fr> et al")
(maintainers "Ivan Gotovchits <ivg@ieee.org>")
(source (github BinaryAnalysisPlatform/FrontC))
(homepage "https://github.com/BinaryAnalysisPlatform/FrontC")
(bug_reports "https://github.com/BinaryAnalysisPlatform/FrontC/issues")


(package
 (name FrontC)
 (synopsis "Parses C programs to an abstract syntax tree")
 (description "FrontC provides a C parser and an OCaml definition \
               of an abstract syntax treee for the C language. It also \
               includes AST pretty-printers in plain and XML formats.")
 (deprecated_package_names Frontc)
 (depends (dune (and (>= 2.7) :build)) menhir)
 (tags (FrontC C parser XML)))

(package
 (name calipso)
 (synopsis "Rewrites C programs to remove non-structured control-flow")
 (description "Calipso analyzes programs in order to replace all \
               nonstructured instructions (i.e., break, return, switch...) \
               by branches and, then, remove all branches. \
               See https://dblp.org/rec/journals/tsi/CasseFRS02 for more details" )
 (depends (FrontC (>= 4.0.0)))
 (tags (FrontC C analysis)))

(package
 (name ctoxml)
 (synopsis "Parses a C program into Cabs AST and dumps as an XML document")
 (depends (FrontC (>= 4.0.0)))
 (tags (FrontC C parser XML)))

(generate_opam_files true)
