## [Lex](https://github.com/grammarware/bx-parsing/blob/master/src/types/Lex.rsc)

Lex is the highest level model of a program that is obtained without examining its entire
structure. Usually methods that rely on Lex, are more tolerant to deviations in their input,
but also more prone to delivering wrong results due to their excessive robustness.

In our case study, we model Lex as Rascal Algebraic Data Type, see
http://tutor.rascal-mpl.org/Rascal/Declarations/AlgebraicDataType/AlgebraicDataType.html
We only separated left hand side (function signature) from the right hand side (its body)
and classify tokens into three groups (numeric, alphabetic and special symbols).
Some prior research on structured lexical models of software also utilise more deeply nested
tree-like structures or loosely constructed trees with unparsed chunks.

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Lex.png)

```
module types::Lex

import List;

data TokToken
    = numeric(int n)
    | alphanumeric(str a)
    | ssymbol(str s)
    ;
alias TokTokens = list[TokToken];
data Lex = lexfundef(TokTokens left, TokToken sep, TokTokens right, TokToken end);

Lex example = lexfundef(
                [alphanumeric("f"),alphanumeric("arg")],
                ssymbol("="),
                [alphanumeric("arg"),ssymbol("+"),numeric(1)],
                ssymbol(";"));

bool isTokToken(numeric(int n)) = true;
bool isTokToken(alphanumeric(str a)) = /[a-z0-9]+/ := a;
bool isTokToken(ssymbol(str s)) = /[a-z0-9]+/ !:= s;
default bool isTokToken(TokToken t) = false;

bool isTokTokens(TokTokens ts) = (true | it && isTokToken(t) | t <- ts); 

public bool validate(Lex ls)
    = isTokTokens(ls.left)
    && size(ls.left) == 2
    && isTokTokens(ls.right)
    ;

test bool vlex1() = validate(example);
test bool vlex2() = !validate(lexfundef(
                        [alphanumeric("f")],ssymbol("="),
                        [alphanumeric("arg"),ssymbol("+"),numeric(1)],ssymbol(";")));
test bool vlex3() = !validate(lexfundef(
                        [alphanumeric("f"),alphanumeric("!")],ssymbol("="),
                        [alphanumeric("arg"),ssymbol("+"),numeric(1)],ssymbol(";")));
test bool vlex4() = !validate(lexfundef(
                        [alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
                        [alphanumeric("arg"),ssymbol("plus"),numeric(1)],ssymbol(";")));
```

### See also:
* [mappings::Ast2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ast2Lex.rsc)
* [mappings::Lex2Ast](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Lex2Ast.rsc)
* [mappings::Lex2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Lex2Tok.rsc)
* [mappings::Tok2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tok2Lex.rsc)
* [visualise::Lex](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Lex.rsc)
* [specific::Str2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc)
