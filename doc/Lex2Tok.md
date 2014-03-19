## [Lex2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Lex2Tok.rsc)

TBD

```
module mappings::Lex2Tok

import List;
import String;
import types::Tok;
import types::Lex;

@doc{
    Losing structural information is easy.
    Here we flatten the primitive tree and add one token that was sacrifised during extraction.
}
public Tok lex2tok(lexfundef(list[TokToken] left, list[TokToken] right))
    = [lex2tok(t) | TokToken t <- left]
    + ["="]
    + [lex2tok(t) | TokToken t <- right];

str lex2tok(numeric(int n)) = "<n>";
str lex2tok(alphanumeric(str a)) = "<a>";
str lex2tok(ssymbol(str s)) = "<s>";

test bool vlex2tok1() = lex2tok(types::Lex::example) == types::Tok::example;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Lex.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Tok.png)

### See also:
* [types::Lex](https://github.com/grammarware/bx-parsing/blob/master/src/types/Lex.rsc)
* [visualise::Lex](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Lex.rsc)
* [specific::Str2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc)
* [types::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tok.rsc)
* [visualise::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Tok.rsc)
* [specific::Ptr2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc)
