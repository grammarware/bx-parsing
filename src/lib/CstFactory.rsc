@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}

@doc{
	For now this library is implemented in an inefficient and somewhat cheating way:
	it constructs the trees by parsing a concatenation of unparsed components,
	but we want to encapsulate this implementation separately in order to circumvent
	the fact that this functionality is not provided by Rascal.
	
	TODO: rewrite this to use appl(...) directly to construct valid trees.
}
module lib::CstFactory

import types::Cst;
import ParseTree;
import String;

public CstNumber newCstNumber(str s) = parse(#CstNumber,s);
public CstNumber newCstNumber(int n) = parse(#CstNumber,"<n>");

public CstName newCstName(str s) = parse(#CstName,s);

public CstAtom newCstAtom(CstName name) = parse(#CstAtom,"<name>");
public CstAtom newCstAtom(CstNumber number) = parse(#CstAtom,"<number>");

public CstExpr newCstExpr(CstAtom a) = parse(#CstExpr,"<a>");
public CstExpr newCstExpr(CstExpr l, "*", CstExpr r) = parse(#CstExpr,"<l>*<r>");
public CstExpr newCstExpr(CstExpr l, "+", CstExpr r) = parse(#CstExpr,"<l>+<r>");

public CstNameArgs newCstNameArgs(list[CstName] ns) = parse(#CstNameArgs, intercalate(" ",["<n>" | CstName n <- ns]));

public CstRHS newCstRHS(CstExpr rhs) = parse(#CstRHS,"<rhs>");

public CstLHS newCstLHS(CstName f, CstNameArgs args) = parse(#CstLHS,"<f> <args>");

public Cst newCst(CstLHS lhs, CstRHS rhs) = parse(#Cst, "<lhs>=<rhs>;");