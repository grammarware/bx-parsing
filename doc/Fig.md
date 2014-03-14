## [Fig](https://github.com/grammarware/bx-parsing/blob/master/src/types/Fig.rsc)

Fig is the highest level model in the graphical representation world. It abstracts away from
details like position, colour and form, and focuses on the concepts.
In our case study, Fig is an algebraic data type that distinguishes between variables and
literals, and has binary expressions.

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Fig.png)

```
module types::Fig

data Fig = figfunctionmodel(FigName name, FigArgs args, FigExpr body);
alias FigName = str;
alias FigArgs = list[FigArg];
alias FigArg = str;
data FigExpr
    = figvariable(FigName name)
    | figliteral(FigNumber number)
    | figbinary(FigName op, FigExpr left, FigExpr right)
    ;
alias FigNumber = int;

Fig example = figfunctionmodel("f",["arg"],figbinary("+",figvariable("arg"),figliteral(1)));

public bool validate(Fig f) = /figvariable("") !:= f;

test bool tfig1() = validate(example);
```

### See also:
* [mappings::Ast2Fig](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ast2Fig.rsc)
* [mappings::Fig2Ast](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Fig2Ast.rsc)
* [mappings::Fig2Gra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Fig2Gra.rsc)
* [visualise::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Fig.rsc)
* [specific::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Fig.rsc)
