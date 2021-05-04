.PHONY: build install test doc uninstall
build:
	dune build

install:
	dune install

test:
	dune test

doc:
	dune build @doc

uninstall:
	dune uninstall
