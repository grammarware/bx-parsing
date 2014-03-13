@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Ptr2Cst

import ParseTree;
import types::Ptr;
import types::Cst;
import lib::CstFactory;

@doc{
	Unfortunately, Rascal allows us to pattern match with concrete syntax, but not to construct
	concrete parse trees the same way. Hence, the code below contains lots of boilerplate.
	This is left as it is to demonstrate that in [at least some] modern language workbenches
	users are not expected to freely manipulate concrete syntax trees.
	One of the reasons is the obliviousness Rascal provides for its users who do not want
	to distinguish between Ptr and Cst.
}
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
