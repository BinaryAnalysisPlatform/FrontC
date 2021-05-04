.PHONY: build install test doc uninstall clean
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

clean:
	dune clean
