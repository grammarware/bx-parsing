## [Ast2Fig](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ast2Fig.rsc)

Ast to Fig is a visualisation mapping. It is very straightforward because there is virtually no
boilerplate: the mapper traverses one data type and produces another one conceptually similar to it.
Obviously, visualisation strategies in general can get much more complex, but in our case study we
intentionally keep it simple.

```
module mappings::Ast2Fig

import types::Ast;
import types::Fig;

public Fig ast2fig(astfundef(AstName name, AstArgs args, AstExpr body))
    = figfunctionmodel(name, args, ast2fig(body));
FigExpr ast2fig(astvariable(AstName name)) = figvariable(name);
FigExpr ast2fig(astliteral(AstNumber number)) = figliteral(number);
FigExpr ast2fig(astbplus(AstExpr left, AstExpr right)) = figbinary("+", ast2fig(left), ast2fig(right));
FigExpr ast2fig(astbmul(AstExpr left, AstExpr right)) = figbinary("*", ast2fig(left), ast2fig(right));

test bool tast2fig1() = ast2fig(types::Ast::example) == types::Fig::example; 
```

### See also:
* [types::Ast](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ast.rsc)
* [visualise::Ast](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Ast.rsc)
* [types::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/types/Fig.rsc)
* [visualise::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Fig.rsc)
* [specific::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Fig.rsc)
