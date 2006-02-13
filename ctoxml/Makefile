# $Id$
include ../Makefile.head

SOURCES = \
	ctoxml_bin.ml

OCAML_INC += ../frontc
OCAML_LIB += unix ../frontc/frontc

$(eval $(call ocaml_prog,ctoxml,$(SOURCES)))

include ../Makefile.tail
