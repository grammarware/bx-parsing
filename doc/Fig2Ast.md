## [Fig2Ast](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Fig2Ast.rsc)

The Fig to Ast mapping is serialisation: in practice it is used for interoperability, when Ast
defines a format that two (or more) tools agree on, and Fig is the format of one concrete visual
modelling tool.

The structures of Fig and Ast in our prototype are strikingly similar, even though one was obtained
by generalising and abstracting parse trees, and the other one by generalising and abstracting
graphical models. Fig is slightly more flexible when it comes to operations (`+` and `*`), so
the only nontrivial thing in this mapping is recognising when to use either of the corresponding
constructors available from the Ast side, and what to do when nothing matches. Our troubleshooting
heuristic is to ignore the right operand if the operation is not supported by Ast.

```
module mappings::Fig2Ast

import types::Fig;
import types::Ast;

public Ast fig2ast(figfunctionmodel(FigName name, FigArgs args, FigExpr body))
    = astfundef(name, args, fig2ast(body));

AstExpr fig2ast(figvariable(FigName name)) = astvariable(name);
AstExpr fig2ast(figliteral(FigNumber number)) = astliteral(number);
AstExpr fig2ast(figbinary("+", FigExpr left, FigExpr right)) = astbplus(fig2ast(left), fig2ast(right));
AstExpr fig2ast(figbinary("*", FigExpr left, FigExpr right)) = astbmul(fig2ast(left), fig2ast(right));
default AstExpr fig2ast(figbinary(str op, FigExpr left, FigExpr right)) = fig2ast(left);

test bool tfig2ast1() = fig2ast(types::Fig::example) == types::Ast::example; 
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Fig.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Ast.png)

### See also:
* [types::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/types/Fig.rsc)
* [visualise::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Fig.rsc)
* [specific::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Fig.rsc)
* [types::Ast](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ast.rsc)
* [visualise::Ast](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Ast.rsc)
