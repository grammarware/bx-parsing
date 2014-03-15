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
**Abstract** | [Lex](https://github.com/grammarware/bx-parsing/blob/master/doc/Lex.md) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Ast2Lex.md) [→](https://github.com/grammarware/bx-parsing/blob/master/doc/Lex2Ast.md) | [Ast](https://github.com/grammarware/bx-parsing/blob/master/doc/Ast.md) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Fig2Ast.md) [→](https://github.com/grammarware/bx-parsing/blob/master/doc/Ast2Fig.md) | [Fig](https://github.com/grammarware/bx-parsing/blob/master/doc/Fig.md)
 | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Lex2Tok.md) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Tok2Lex.md) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Ast2Cst.md) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst2Ast.md) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Fig2Gra.md) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Gra2Fig.md)
**Layoutless** | [Tok](https://github.com/grammarware/bx-parsing/blob/master/doc/Tok.md) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst2Tok.md) | [Cst](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst.md) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Gra2Cst.md) [→](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst2Gra.md) | [Gra](https://github.com/grammarware/bx-parsing/blob/master/doc/Gra.md)
 | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Tok2Tkl.md) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Tkl2Tok.md) | [↖](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.md) | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Cst2Ptr.md) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Ptr2Cst.md) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Gra2Dra.md) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Dra2Gra.md)
**Layout** | [Tkl](https://github.com/grammarware/bx-parsing/blob/master/doc/Tkl.md) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/Ptr2Tkl.md) | [Ptr](https://github.com/grammarware/bx-parsing/blob/master/doc/Ptr.md) | | [Dra](https://github.com/grammarware/bx-parsing/blob/master/doc/Dra.md)
 | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Tkl2Str.md) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Str2Tkl.md) | | [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/For2Ptr.md)  | | [↓](https://github.com/grammarware/bx-parsing/blob/master/doc/Dra2Pic.md) [↑](https://github.com/grammarware/bx-parsing/blob/master/doc/Pic2Dra.md)
**Raw** | [Str](https://github.com/grammarware/bx-parsing/blob/master/doc/Str.md) | [←](https://github.com/grammarware/bx-parsing/blob/master/doc/For2Str.md) [→](https://github.com/grammarware/bx-parsing/blob/master/doc/Str2For.md) | [For](https://github.com/grammarware/bx-parsing/blob/master/doc/For.md) | | [Pic](https://github.com/grammarware/bx-parsing/blob/master/doc/Pic.md)

![Megamodel](https://github.com/grammarware/bx-parsing/raw/master/megamodel.png)

...as well as alternative [Gra→Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc), [Ptr→Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc) and [Str→Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc) mappings and several versions of *bidirectional* mappings between **Ptr** and **Dra**: [Foster BX](https://github.com/grammarware/bx-parsing/blob/master/src/bridges/ptrdra/Foster.rsc) and [Meertens BX](https://github.com/grammarware/bx-parsing/blob/master/src/bridges/ptrdra/Meertens.rsc).

---
Yours,
* [Vadim Zaytsev](http://grammarware.net)
* [Anya Helene Bagge](http://www.ii.uib.no/~anya/)
