FrontC v4.0
----------

FrontC is C language front-end. It provides the program in "C Abstract Form", a tree representation of the original C source. It may be used for many source works including:
   - compilation,
   - source pre-processing,
   - source beautification,
   - source analysis,
   - and so on.

It provides also an XML back-end making easier to transform the C program using XML tools like XSLT (it was my first goal when I perform this task).

ctoxml
======

The `ctoxml` package provides a

calipso
=======

The `calipso` package provides a program analysis tool that removes non-structural control-flow from C programs. See https://dblp.org/rec/journals/tsi/CasseFRS02 for more details. The tool provides two binaries, `calipso` and `calipso_stat`

FrontC v3.0 (stable)
-----------

The [stable][1] branch supports only ANSI C (C89) with partial support for some GNU extensions. This branch is using ocamlyacc as a parser generator and doesn't accept new features, only occasional bug fixes.


[1]: https://github.com/BinaryAnalysisPlatform/FrontC/tree/stable
