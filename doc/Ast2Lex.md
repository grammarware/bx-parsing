## [Ast2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ast2Lex.rsc)

This mapping is much more simple than Lex2Ast: it is always easier to lose information
about structure than to obtain it, even though the information per se is out there.
Notice how this mapping is also free from almost any commitment to a language definition.

```
module mappings::Ast2Lex

import IO;
import types::Lex;
import types::Ast;

public Lex ast2lex(Ast p)
    = lexfundef(
        [alphanumeric(p.name)] + [alphanumeric(a) | a <- p.args],
        ssymbol("="),
        mapexpr(p.body),
        ssymbol(";")); 

list[TokToken] mapexpr(astvariable(AstName name)) = [alphanumeric(name)];
list[TokToken] mapexpr(astliteral(AstNumber number)) = [numeric(number)];
list[TokToken] mapexpr(astbplus(AstExpr left, AstExpr right))
    = mapexpr(left) + [ssymbol("+")] + mapexpr(right);
list[TokToken] mapexpr(astbmul(AstExpr left, AstExpr right))
    = mapexpr(left) + [ssymbol("*")] + mapexpr(right);

// NB: the actual mapping is much more intricate than the running example,
// so we need more test cases.
test bool vast2lex1() = ast2lex(types::Ast::example) == types::Lex::example;
test bool vast2lex2() = ast2lex(astfundef("f",["arg"], astbplus(astliteral(1),astliteral(2))))
    == lexfundef([alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
                [numeric(1),ssymbol("+"),numeric(2)],ssymbol(";"));
test bool vast2lex3() = ast2lex(astfundef("f",["arg"], astbmul(astliteral(1),astliteral(2))))
    == lexfundef([alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
                [numeric(1),ssymbol("*"),numeric(2)],ssymbol(";"));
test bool vast2lex4() = ast2lex(astfundef("f",["arg"], astbplus(astliteral(1),astbmul(astliteral(2),astliteral(3)))))
    == lexfundef([alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
                [numeric(1),ssymbol("+"),numeric(2),ssymbol("*"),numeric(3)],ssymbol(";"));
test bool vast2lex5() = ast2lex(astfundef("f",["arg"], astbplus(astbmul(astliteral(1),astliteral(2)),astliteral(3))))
    == lexfundef([alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
                [numeric(1),ssymbol("*"),numeric(2),ssymbol("+"),numeric(3)],ssymbol(";"));
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Ast.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Lex.png)

### See also:
* [types::Ast](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ast.rsc)
* [visualise::Ast](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Ast.rsc)
* [types::Lex](https://github.com/grammarware/bx-parsing/blob/master/src/types/Lex.rsc)
* [visualise::Lex](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Lex.rsc)
* [specific::Str2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc)
