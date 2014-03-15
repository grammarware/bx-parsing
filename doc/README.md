BX Parsing
==========

<img align="right" src="http://grammarware.github.io/logos/bx.200.png"/>
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

There are approximately **2500** lines of code and comments committed to this repository. To run all this code, you will need the [Rascal](http://www.rascal-mpl.org/start/) language workbench. The repository contains specifications of twelve kinds of software artefacts related to (un)parsing and many mappings between them:

 | Textual | | Structured | | Graphical
|:----- |:-----:|:-----:|:-----:|:-----:|:-----:|
**Abstract** | [Lex](https://github.com/grammarware/bx-parsing/blob/master/doc/Lex.rsc) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Ast2Lex.rsc) [→](https://github.com/grammarware/bx-parsing/blob/master/doc/Lex2Ast.rsc) | [Ast](https://github.com/grammarware/bx-parsing/blob/master/doc/Ast.rsc) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Fig2Ast.rsc) [→](https://github.com/grammarware/bx-parsing/blob/master/doc/Ast2Fig.rsc) | [Fig](https://github.com/grammarware/bx-parsing/blob/master/doc/Fig.rsc)
 | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Lex2Tok.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Tok2Lex.rsc) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Ast2Cst.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst2Ast.rsc) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Fig2Gra.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Gra2Fig.rsc)
**Layoutless** | [Tok](https://github.com/grammarware/bx-parsing/blob/master/doc/Tok.rsc) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst2Tok.rsc) | [Cst](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst.rsc) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Gra2Cst.rsc) [→](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst2Gra.rsc) | [Gra](https://github.com/grammarware/bx-parsing/blob/master/doc/Gra.rsc)
 | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Tok2Tkl.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Tkl2Tok.rsc) | [↖](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc) | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst2Ptr.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Ptr2Cst.rsc) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Gra2Dra.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Dra2Gra.rsc)
**Layout** | [Tkl](https://github.com/grammarware/bx-parsing/blob/master/doc/Tkl.rsc) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Ptr2Tkl.rsc) | [Ptr](https://github.com/grammarware/bx-parsing/blob/master/doc/Ptr.rsc) | | [Dra](https://github.com/grammarware/bx-parsing/blob/master/doc/Dra.rsc)
 | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Tkl2Str.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Str2Tkl.rsc) | | [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/For2Ptr.rsc)  | | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Dra2Pic.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Pic2Dra.rsc)
**Raw** | [Str](https://github.com/grammarware/bx-parsing/blob/master/doc/Str.rsc) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/For2Str.rsc) [→](https://github.com/grammarware/bx-parsing/blob/master/doc/Str2For.rsc) | [For](https://github.com/grammarware/bx-parsing/blob/master/doc/For.rsc) | | [Pic](https://github.com/grammarware/bx-parsing/blob/master/doc/Pic.rsc)

![Megamodel](https://github.com/grammarware/bx-parsing/raw/master/megamodel.png)

...as well as alternative [Gra→Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc), [Ptr→Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc) and [Str→Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc) mappings and several versions of *bidirectional* mappings between **Ptr** and **Dra**: [Foster BX](https://github.com/grammarware/bx-parsing/blob/master/src/bridges/ptrdra/Foster.rsc) and [Meertens BX](https://github.com/grammarware/bx-parsing/blob/master/src/bridges/ptrdra/Meertens.rsc).

---
Yours,
* [Vadim Zaytsev](http://grammarware.net)
* [Anya Helene Bagge](http://www.ii.uib.no/~anya/)
