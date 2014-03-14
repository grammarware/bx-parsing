## [Tok2Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tok2Tkl.rsc)

For the Tok to Tkl mapping we add exactly one space between all tokens.
This is very primitive pretty-printing.

```
module mappings::Tok2Tkl

import List;
import types::Tok;
import types::Tkl;

public Tkl tok2tkl([]) = [];
public Tkl tok2tkl(Tok p)
    = p[0]
    + [*[" ",t] | str t <- tail(p)];

test bool vtok2tkl1() = tok2tkl(types::Tok::example) != types::Tkl::example;
test bool vtok2tkl2() = tok2tkl(types::Tok::example) == types::Tkl::defexample;
```

### See also:
* [types::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tok.rsc)
* [visualise::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Tok.rsc)
* [specific::Ptr2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc)
* [types::Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tkl.rsc)
* [visualise::Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Tkl.rsc)
