BX Parsing
==========

This repository contains the source code of the case study demonstrating our bidirectional megamodel of:
* parsing
* tokenising
* stripping
* concatenating
* imploding
* exploding
* unparsing
* printing
* pretty-printing
* formatting
* visualising
* rendering
* recognising
* ...

To run all this code, you will need [Rascal](http://www.rascal-mpl.org/start/) workbench. The repository contains specifications of:

 | Textual | Structured | Graphical
|:-----:|:-----:|:-----:|:-----:|
**Abstract** | [Lex](https://github.com/grammarware/bx-parsing/blob/master/src/types/Lex.rsc) | [Ast](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ast.rsc) | [Fig](https://github.com/grammarware/bx-parsing/blob/master/src/types/Fig.rsc)
**Layoutless** | [Tok](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tok.rsc) | [Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc) | [Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
**Layout** | [Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tkl.rsc) | [Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ptr.rsc) | [Dra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Dra.rsc)
**Raw** | [Str](https://github.com/grammarware/bx-parsing/blob/master/src/types/Str.rsc) | [For](https://github.com/grammarware/bx-parsing/blob/master/src/types/For.rsc) | [Pic](https://github.com/grammarware/bx-parsing/blob/master/src/types/Pic.rsc)
![Megamodel](https://github.com/grammarware/bx-parsing/raw/master/megamodel.png)

...and many mappings between them!

Yours,
* [Vadim Zaytsev](http://grammarware.net)
* [Anya Helene Bagge](http://www.ii.uib.no/~anya/)