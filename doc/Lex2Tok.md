## [Lex2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Lex2Tok.rsc)

Losing structural information is easy.
Here we flatten the primitive tree and deliver tokens in less structured fashion.
Note how we do this without ever using any information about the internal structure of Lex.
To avoid even the pattern matching of `tokenlex2tok()`, we need Lex to expose a function like
`toToken()` to us.

```
module mappings::Lex2Tok

import types::Tok;
import types::Lex;

public Tok lex2tok(Lex p) = [tokenlex2tok(t) | /TokToken t <- p];

str tokenlex2tok(numeric(int n)) = "<n>";
str tokenlex2tok(alphanumeric(str a)) = "<a>";
str tokenlex2tok(ssymbol(str s)) = "<s>";

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
