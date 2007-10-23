# $Id$

include ../Makefile.head

SOURCES = \
	gen.ml \
	reduce.ml \
	label.ml \
	algo.ml \
	calipso.ml
	
STAT_SOURCES = \
	gen.ml \
	reduce.ml

OCAML_INC += ../frontc
OCAML_LIB += unix ../frontc/frontc

$(eval $(call ocaml_prog,calipso,$(SOURCES)))

$(eval $(call ocaml_prog,calipso_stat,$(STAT_SOURCES)))

include ../Makefile.tail
