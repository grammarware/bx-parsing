## [Tok2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tok2Lex.rsc)

TBD

```
module mappings::Tok2Lex

import List;
import String;
import types::Tok;
import types::Lex;

// Frankly, this should have been a part of the Rascal library
list[list[str]] split(str sep, list[str] xs)
{
    list[list[str]] res = [[]];
    yy = res[-1];
    for (str x <- xs)
        if (x == sep)
            res += [[]];
        else
            res[size(res)-1] = res[-1] + x;
    return res;
}

public Lex tok2lex(Tok p)
{
    xs = split("=",p);
    assert size(xs) == 2;
    return lexfundef(maptokens(xs[0]),maptokens(xs[1]));
}

list[TokToken] maptokens(list[str] ts) = [maptoken(t) | t <- ts];

TokToken maptoken(str s:/[a-z]+/) = alphanumeric(s);
TokToken maptoken(str n:/[0-9]+/) = numeric(toInt(n));
default TokToken maptoken(str z) = ssymbol(z);

test bool vtok2lex1() = tok2lex(types::Tok::example) == types::Lex::example;
```

### See also:
* [types::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tok.rsc)
* [visualise::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Tok.rsc)
* [specific::Ptr2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc)
* [types::Lex](https://github.com/grammarware/bx-parsing/blob/master/src/types/Lex.rsc)
* [visualise::Lex](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Lex.rsc)
* [specific::Str2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc)
