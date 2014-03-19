## [For2Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/For2Ptr.rsc)

Moving up from a forest to a single tree is a research topic on its own.
The state of the art is to rely on heuristics, filtering functions, diagnose tools,
semi-automation, additional specs, etc.
Also, we cannot match the parse trees as we usually do in Rascal since the concrete patterns
themselves are ambiguous. In the case study, we implement the mapping by first nondeterministically
choosing one of the alternatives for each ambiguity, and then manually traversing the parse tree
with ugly low level constructs.
The lack of beauty and the abundance of boilerplate in the code below reflects the lack of
tool support for explicit programming of the disambiguation process.
If we look beyond that, we can see that the mapping heavily utilises the language specification.

```
module mappings::For2Ptr

import ParseTree;
import types::For;
import types::Ptr;
import lib::PtrFactory;
import String;
import Set;

// NB: a workaround via Str since manual low-level disambiguation is too ugly in Rascal
public Ptr for2ptr(For p) = mapfor(nondeterministicdisambiguation(p));

For nondeterministicdisambiguation(For p) = innermost visit(p)
    {case amb(set[Tree] alternatives) => getOneFrom(alternatives)};

Ptr mapfor(appl(prod(sort("For"),_,_),[
        e1:appl(prod(sort("ForLHS"),_,_),_),
        _, // standard layout
        ws1, // WS
        _, // standard layout
        appl(prod(lit("="),_,_),_),
        _, // standard layout
        ws2, // WS
        _, // standard layout
        e2:appl(prod(sort("ForRHS"),_,_),_),
        _, // standard layout
        ws3, // WS
        _, // standard layout
        appl(prod(lit(";"),_,_),_)
    ]))
    = newPtr( mapforlhs(e1), unparse(ws1), unparse(ws2), mapforrhs(e2), unparse(ws3) );

PtrLHS mapforlhs(appl(prod(sort("ForLHS"),_,_),[
    e1:appl(prod(lex("ForName"),_,_),_),
    _, // standard layout
    ws1, // WS
    _, // standard layout
    appl(prod(lex("ForNameArgs"),_,_),[e2])
]))
    = newPtrLHS(mapforname(e1), unparse(ws1), mapfornameargs(e2));

PtrNameArgs mapfornameargs(
    appl(
        regular(\iter-seps(
        lex("ForName"),
        [\iter-star(lex("WS"))])),
        list[Tree] L
    ))
{
    lrel[PtrName,str] args = [];
    int i = 0;
    while (i<size(L))
    {
        args += <mapforname(L[i]), (i+1>=size(L))?"":unparse(L[i+1])>;
        i += 2;
    }
    return newPtrNameArgs(args);
}
    
PtrRHS mapforrhs(appl(prod(sort("ForRHS"),_,_),[Tree rhs]))
    = newPtrRHS(mapforexpr(rhs)); 

PtrExpr mapforexpr(appl(prod(sort("ForExpr"),_,_),[e:appl(prod(sort("ForAtom"),_,_),[_])]))
    = newPtrExpr(mapforatom(e));
PtrExpr mapforexpr(appl(prod(sort("ForExpr"),_,_),
    [
        e1:appl(prod(sort("ForExpr"),_,_),_),
        _, // standard layout
        ws1, // WS
        _, // standard layout
        appl(prod(lit(str op),_,_),_),
        _, // standard layout
        ws2, // WS
        _, // standard layout
        e2:appl(prod(sort("ForExpr"),_,_),_)
    ]))
    = newPtrExpr(mapforexpr(e1),unparse(ws1),op,unparse(ws2),mapforexpr(e2));

PtrAtom mapforatom(appl(prod(sort("ForAtom"),_,_),[Tree e]))
{
    if (appl(prod(lex("ForName"),_,_),[appl(_,L)]) := e)
        return newPtrAtom(mapforname(e));
    if (appl(prod(lex("ForNumber"),_,_),[appl(_,L)]) := e)
        return newPtrAtom(mapfornumber(e));
}

PtrName mapforname(appl(prod(lex("ForName"),_,_),[appl(_,L)]))
    = newPtrName(stringChars([x | char(x) <- L]));
PtrNumber mapfornumber(appl(prod(lex("ForNumber"),_,_),[appl(_,L)]))
    = newPtrNumber(stringChars([x | char(x) <- L]));

test bool vfor2ptr1() = for2ptr(types::For::example) == types::Ptr::example;
test bool vfor2ptr2() = for2ptr(types::For::tricky) == types::Ptr::tricky;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/For.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Ptr.png)

### See also:
* [types::For](https://github.com/grammarware/bx-parsing/blob/master/src/types/For.rsc)
* [visualise::For](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/For.rsc)
* [types::Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ptr.rsc)
* [visualise::Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Ptr.rsc)
* [specific::Ptr2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc)
