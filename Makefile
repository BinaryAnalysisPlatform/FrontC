# $Id$
include Makefile.head

PROJECT=Frontc
VERSION=3.3
RELEASE=3
SUBDIRS = frontc ctoxml printc
DIST+=AUTHORS ChangeLog COPYING INSTALL NEWS README

include Makefile.tail

doc:
	test -d autodoc || mkdir autodoc
	cd frontc; $(MAKE) doc
