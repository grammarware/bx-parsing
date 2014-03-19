## [Ptr2Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ptr2Tkl.rsc)

The Ptr to Tkl mapping is a form of limited unparsing: we retain the information about tokens and whitespace,
but drop the hierarchical details.
This is done independently of a language definition: we just produce one token for each preterminal
(a nonterminal defined with a lexical production rule, in Rascal terms).

```
module mappings::Ptr2Tkl

import ParseTree;
import types::Ptr;
import types::Tkl;

public Tkl ptr2tkl(Ptr p)
{
    Tkl ts = [];
    top-down visit(p)
    {
        case t:appl(prod(Symbol name,[Symbol x],_), _) :
            if (\char-class(_) := x || conditional(iter(\char-class(_)),_) := x)
                ts += unparse(t);
    }
    return ts;
}

test bool vptr2tkl1() = ptr2tkl(types::Ptr::example) == types::Tkl::example;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Ptr.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Tkl.png)

### See also:
* [types::Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ptr.rsc)
* [visualise::Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Ptr.rsc)
* [specific::Ptr2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc)
* [types::Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tkl.rsc)
* [visualise::Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Tkl.rsc)
