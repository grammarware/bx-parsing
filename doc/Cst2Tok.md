## [Cst2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Tok.rsc)

The Cst to Tok mapping is a form of limited unparsing: we retain the information about tokens, but drop
the hierarchical details and disregard layout info.
This is done independently of a language definition: we just produce one token for each preterminal
(a nonterminal defined with a lexical production rule, in Rascal terms).
Due to Rascal trying to always make the language workbench user unaware of the Cst/Ptr distinction,
we need to make an extra step there: the layout information is actually still in the tree, but we can
easily identify it as such and disregard when traversing tree nodes with a low level visitor.

```
module mappings::Cst2Tok

import ParseTree;
import types::Cst;
import types::Tok;

public Tok cst2tok(Cst p)
{
    Tok ts = [];
    // Find layout
    set[Symbol] black = {guilty | /prod(layouts(_),[\iter-star(Symbol guilty)],_) := p};
    top-down visit(p)
    {
        case t:appl(prod(Symbol name,_,_), _) :
            if ((lex(_) := name || lit(_) := name) && name notin black)
                ts += unparse(t);
    }
    return ts;
}

test bool vcst2tok1() = cst2tok(types::Cst::example) == types::Tok::example;
```

### See also:
* [types::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc)
* [visualise::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Cst.rsc)
* [types::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tok.rsc)
* [visualise::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Tok.rsc)
* [specific::Ptr2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc)
