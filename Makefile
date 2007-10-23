# $Id$
include Makefile.head

PROJECT=Frontc
VERSION=3.4
RELEASE=
SUBDIRS = frontc ctoxml printc calipso
DIST+=AUTHORS ChangeLog COPYING INSTALL NEWS README

include Makefile.tail

doc:
	test -d autodoc || mkdir autodoc
	cd frontc; $(MAKE) doc
