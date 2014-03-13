@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	For now this library is implemented in an inefficient and somewhat cheating way:
	it constructs the trees by parsing a concatenation of unparsed components,
	but we want to encapsulate this implementation separately in order to circumvent
	the fact that this functionality is not provided by Rascal.
	
	TODO: rewrite this to use appl(...) directly to construct valid trees
}
module lib::PtrFactory

import types::Ptr;
import ParseTree;
import String;
import List;

public PtrNumber newPtrNumber(str s) = parse(#PtrNumber,s);
public PtrNumber newPtrNumber(int n) = parse(#PtrNumber,"<n>");

public PtrName newPtrName(str s) = parse(#PtrName,s);

public PtrAtom newPtrAtom(PtrName name) = parse(#PtrAtom,"<name>");
public PtrAtom newPtrAtom(PtrNumber number) = parse(#PtrAtom,"<number>");

public PtrExpr newPtrExpr(PtrAtom a) = parse(#PtrExpr,"<a>");
public PtrExpr newPtrExpr(PtrExpr l, str ws1, "*", str ws2, PtrExpr r) = parse(#PtrExpr,"<l><ws1>*<ws2><r>");
public PtrExpr newPtrExpr(PtrExpr l, str ws1, "+", str ws2, PtrExpr r) = parse(#PtrExpr,"<l><ws1>+<ws2><r>");

public PtrNameArgs newPtrNameArgs(list[tuple[PtrName,str]] ns) = parse(#PtrNameArgs, trim(intercalate("",["<n><ws>" | <PtrName n, str ws> <- ns])));

public PtrRHS newPtrRHS(PtrExpr rhs) = parse(#PtrRHS,"<rhs>");

public PtrLHS newPtrLHS(PtrName f, str ws, PtrNameArgs args) = parse(#PtrLHS,"<f><ws><args>");

public Ptr newPtr(PtrLHS lhs, str ws1, str ws2, PtrRHS rhs, str ws3)
	= parse(#Ptr, "<lhs><ws1>=<ws2><rhs><ws3>;");