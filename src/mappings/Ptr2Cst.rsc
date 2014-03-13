@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Ptr2Cst

import ParseTree;
import types::Ptr;
import types::Cst;

@doc{
	Unfortunately, Rascal allows us to pattern match with concrete syntax, but not to construct
	concrete parse trees the same way. Hence, the code below contains lots of boilerplate.
	This is left as it is to demonstrate that in [at least some] modern language workbenches
	users are not expected to freely manipulate concrete syntax trees.
	One of the reasons is the obliviousness Rascal provides for its users who do not want
	to distinguish between Ptr and Cst.
}
Cst ptr2cst(Ptr p)
{
	Cst res = (Cst)`g x=x;`;
	res.lhs = ptr2cst(p.lhs);
	res.rhs = ptr2cst(p.rhs);
	return res;
}

CstLHS ptr2cst(PtrLHS p)
{
	CstLHS res = (CstLHS)`g x`;
	res.f = ptr2cst(p.f);
	res.args = ptr2cst(p.args);
	return res;
}

CstRHS ptr2cst(PtrRHS p)
{
	CstRHS res = (CstRHS)`z`;
	res.rhs = ptr2cst(p.rhs);
	return res;
}

CstNameArgs ptr2cst(PtrNameArgs p)
{
	//CstNameArgs res = (CstNameArgs)`z`;
	// cheating
	return parse(#CstNameArgs,"<p>");
}

CstExpr ptr2cst((PtrExpr)`<PtrAtom a>`)
{
	CstExpr res = (CstExpr)`1`;
	res.a = ptr2cst(a);
	return res;
}

CstExpr ptr2cst((PtrExpr)`<PtrExpr l><WS* _>*<WS* _><PtrExpr r>`)
{
	CstExpr res = (CstExpr)`1*1`;
	res.l = ptr2cst(p.l);
	res.r = ptr2cst(p.r);
	return res;
}

CstExpr ptr2cst((PtrExpr)`<PtrExpr l><WS* _>+<WS* _><PtrExpr r>`)
{
	CstExpr res = (CstExpr)`1+1`;
	res.l = ptr2cst(l);
	res.r = ptr2cst(r);
	return res;
}

CstAtom ptr2cst((PtrAtom)`<PtrName n>`)
{
	CstAtom res = (CstAtom)`x`;
	res.name = ptr2cst(n);
	return res;
}

CstAtom ptr2cst((PtrAtom)`<PtrNumber n>`)
{
	CstAtom res = (CstAtom)`1`;
	res.number = ptr2cst(n);
	return res;
}

// cheating, but not really
CstName ptr2cst(PtrName n) = parse(#CstName,"<n>");
CstNumber ptr2cst(PtrNumber n) = parse(#CstNumber,"<n>");

test bool vptr2cst1() = ptr2cst(types::Ptr::example) == types::Cst::example;
