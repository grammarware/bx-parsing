## [Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc)

Cst is a concrete syntax tree, which means it unambiguously defines the program
in a form very close to the syntax used by programmers or any other language users.

In the case study we model Ast by Rascal Concrete Syntax Definition, see
http://tutor.rascal-mpl.org/Rascal/Expressions/ConcreteSyntax/ConcreteSyntax.html
This specification utilises many features, including:
- layout which is automatically "ignored" during pattern matching
- explicit starting nonterminal which takes care of leading & trailing layout
- named subexpressions that make writing mappers easier
- explicit left associativity and production precedence to encode priorities
- follow restrictions for greedy matching of preterminals
- deep matching of ambiguities as a validation technique

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Cst.png)

```
module types::Cst

extend lang::std::Layout;
import ParseTree;

start syntax Cst = CstLHS lhs "=" CstRHS rhs ";";
syntax CstLHS = CstName f CstNameArgs args;
syntax CstRHS = CstExpr rhs;
syntax CstNameArgs = CstName+;
syntax CstExpr
    = CstAtom a
    > left CstExpr l "*" CstExpr r
    > left CstExpr l "+" CstExpr r
    ;
syntax CstAtom
    = CstName name
    | CstNumber number
    ;
lexical CstName = [a-z]+ !>> [a-z];
lexical CstNumber = [0-9]+ !>> [0-9];

Cst example = parse(#start[Cst],"f arg = arg +1;", allowAmbiguity=true).top;
Cst tricky = parse(#start[Cst],"f arg = 1+2*2+1;", allowAmbiguity=true).top;

public bool validate(Cst p) = /amb(_) !:= p;

test bool vCst1() = validate(example);
test bool vCst2() = validate(tricky);
```

### See also:
* [mappings::Ast2Cst](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ast2Cst.rsc)
* [mappings::Cst2Ast](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Ast.rsc)
* [mappings::Cst2Gra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Gra.rsc)
* [mappings::Cst2Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Ptr.rsc)
* [mappings::Cst2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Tok.rsc)
* [mappings::Gra2Cst](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Cst.rsc)
* [mappings::Ptr2Cst](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ptr2Cst.rsc)
* [visualise::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Cst.rsc)
