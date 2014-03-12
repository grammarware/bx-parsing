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
|:----- |:-----:|:-----:|:-----:|
**Abstract** | [Lex](https://github.com/grammarware/bx-parsing/blob/master/src/types/Lex.rsc) | [Ast](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ast.rsc) | [Fig](https://github.com/grammarware/bx-parsing/blob/master/src/types/Fig.rsc)
**Layoutless** | [Tok](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tok.rsc) | [Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc) | [Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
**Layout** | [Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tkl.rsc) | [Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ptr.rsc) | [Dra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Dra.rsc)
**Raw** | [Str](https://github.com/grammarware/bx-parsing/blob/master/src/types/Str.rsc) | [For](https://github.com/grammarware/bx-parsing/blob/master/src/types/For.rsc) | [Pic](https://github.com/grammarware/bx-parsing/blob/master/src/types/Pic.rsc)

...and many mappings between them:
![Megamodel](https://github.com/grammarware/bx-parsing/raw/master/megamodel.png)

 | Textual | | Structured | | Graphical
|:----- |:-----:|:-----:|:-----:|:-----:|:-----:|
**Abstract** | [Lex](https://github.com/grammarware/bx-parsing/blob/master/src/types/Lex.rsc) | | [Ast](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ast.rsc) | [←](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Fig2Ast.rsc) [→](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ast2Fig.rsc) | [Fig](https://github.com/grammarware/bx-parsing/blob/master/src/types/Fig.rsc)
 | [↓](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Lex2Tok.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tok2Lex.rsc) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ast2Cst.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Ast.rsc) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Fig2Gra.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Fig.rsc)
**Layoutless** | [Tok](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tok.rsc) | | [Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc) | | [Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
 | [↓](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tok2Tkl.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tkl2Tok.rsc) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Ptr.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ptr2Cst.rsc) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Dra.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Dra2Gra.rsc)
**Layout** | [Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tkl.rsc) | | [Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ptr.rsc) | | [Dra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Dra.rsc)
 | [↓](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tkl2Str.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Str2Tkl.rsc) | | [↓](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ptr2For.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/For2Ptr.rsc)  | | [↓](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Dra2Pic.rsc) [↑](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Pic2Dra.rsc)
**Raw** | [Str](https://github.com/grammarware/bx-parsing/blob/master/src/types/Str.rsc) | [←](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/For2Str.rsc) [→](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Str2For.rsc) | [For](https://github.com/grammarware/bx-parsing/blob/master/src/types/For.rsc) | | [Pic](https://github.com/grammarware/bx-parsing/blob/master/src/types/Pic.rsc)

...as well as alternative [Gra→Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc) and [Str→Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc).

Yours,
* [Vadim Zaytsev](http://grammarware.net)
* [Anya Helene Bagge](http://www.ii.uib.no/~anya/)