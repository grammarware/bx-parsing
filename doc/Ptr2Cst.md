## [Ptr2Cst](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Ptr2Cst.rsc)

Unfortunately, Rascal allows us to pattern match with concrete syntax, but not to construct
concrete parse trees the same way. Hence, the code below relies on a library called
CstFactory which contains grammar-derived boilerplate code to construct parse tree nodes.
This demonstrates that in [at least some] modern language workbenches
users are not expected to freely manipulate concrete syntax trees.
One of the reasons is the obliviousness Rascal provides for its users who do not want
to distinguish between Ptr and Cst at all.

```
module mappings::Ptr2Cst

import types::Ptr;
import types::Cst;
import lib::CstFactory;

Cst ptr2cst(Ptr p) = newCst(ptr2cst(p.lhs), ptr2cst(p.rhs));

CstLHS ptr2cst(PtrLHS p) = newCstLHS(ptr2cst(p.f), ptr2cst(p.args));

CstRHS ptr2cst(PtrRHS p) = newCstRHS(ptr2cst(p.rhs)); 

CstNameArgs ptr2cst(PtrNameArgs p) = newCstNameArgs( [ptr2cst(n) | PtrName n <- p.ns] );

CstExpr ptr2cst((PtrExpr)`<PtrAtom a>`) = newCstExpr(ptr2cst(a)); 
CstExpr ptr2cst((PtrExpr)`<PtrExpr l><WS* _>*<WS* _><PtrExpr r>`) = newCstExpr(ptr2cst(l), "*", ptr2cst(r));
CstExpr ptr2cst((PtrExpr)`<PtrExpr l><WS* _>+<WS* _><PtrExpr r>`) = newCstExpr(ptr2cst(l), "+", ptr2cst(r));

CstAtom ptr2cst((PtrAtom)`<PtrName n>`) = newCstAtom(ptr2cst(n));
CstAtom ptr2cst((PtrAtom)`<PtrNumber n>`) = newCstAtom(ptr2cst(n));

CstName ptr2cst(PtrName n) = newCstName("<n>"); 
CstNumber ptr2cst(PtrNumber n) = newCstNumber("<n>");

test bool vptr2cst1() = ptr2cst(types::Ptr::example) == types::Cst::example;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Ptr.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Cst.png)

### See also:
* [types::Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/types/Ptr.rsc)
* [visualise::Ptr](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Ptr.rsc)
* [specific::Ptr2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc)
* [types::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc)
* [visualise::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Cst.rsc)
