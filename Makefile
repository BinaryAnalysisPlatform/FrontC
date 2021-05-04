.PHONY: build install test doc
build:
	dune build

install:
	dune install

test:
	dune test

doc:
	dune build @doc
