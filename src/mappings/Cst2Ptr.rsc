@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
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
