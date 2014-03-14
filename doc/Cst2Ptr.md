## [Cst2Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Ptr.rsc)

Cst to Ptr mapping is a formatting issue: we add layout information here, which (in the unidirectional setup)
is added in standard quantities (usually to achieve minimal readability and parsability).
Just as with all “...to Cst” mappings, this one uses a separate library which rebuilds a tree for Ptr,
since Rascal currently does not provide this functionality from the box, and we would like to abstract
from the boilerplate.

```
module mappings::Cst2Ptr

import List;
import types::Cst;
import types::Ptr;
import lib::PtrFactory;

public Ptr cst2ptr(Cst p) = newPtr( cst2ptr(p.lhs), " ", " ", cst2ptr(p.rhs), " ");

PtrLHS cst2ptr(CstLHS p)
{
    list[tuple[PtrName,str]] argswithlayout = [<newPtrName("<a>")," "> | /CstName a := p.args];
    argswithlayout[size(argswithlayout)-1][1] = ""; // no trailing whitespace
    return newPtrLHS(newPtrName("<p.f>"), " ", newPtrNameArgs(argswithlayout) );
}

PtrRHS cst2ptr(CstRHS p) = newPtrRHS(cst2ptr(p.rhs));

PtrExpr cst2ptr((CstExpr)`<CstAtom a>`) = newPtrExpr(cst2ptr(a));
PtrExpr cst2ptr((CstExpr)`<CstExpr l>*<CstExpr r>`) = newPtrExpr(cst2ptr(l)," ","*"," ",cst2ptr(r));
PtrExpr cst2ptr((CstExpr)`<CstExpr l>+<CstExpr r>`) = newPtrExpr(cst2ptr(l)," ","+"," ",cst2ptr(r));

PtrAtom cst2ptr((CstAtom)`<CstName name>`) = newPtrAtom(newPtrName("<name>"));
PtrAtom cst2ptr((CstAtom)`<CstNumber number>`) = newPtrAtom(newPtrNumber("<number>"));

test bool vcst2ptr1() = cst2ptr(types::Cst::example) == types::Ptr::defexample;
```

### See also:
* [types::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc)
* [visualise::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Cst.rsc)
* [types::Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ptr.rsc)
* [visualise::Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Ptr.rsc)
* [specific::Ptr2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc)
