@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	The "Foster BX" (well-behaved lens) variant of Ptr-Dra bridge.
	L = Ptr (parse tree with textual layout info); R = Dra (drawing with graphical layout info)
}
module bridges::ptrdra::Foster

import types::Ptr;
import types::Dra;
import types::Ast;
import types::Fig;
import mappings::Dra2Pic;
import mappings::Ast2Fig;
import mappings::Fig2Ast;
import mappings::MultiStep;
import lib::PtrFactory;

import IO;
import List;
import ParseTree;

import Exception;
data RuntimeException = GetException() | PutBackException();

// L = Ptr; R = Dra
Dra get(Ptr L) throws UpdateException
{
	Ast ast = ptr2ast(L);
	if (!validate(ast)) throw GetException();
	Fig fig = ast2fig(ast);
	if (!validate(fig)) throw GetException();
	Dra dra = fig2dra(fig);
	if (!validate(dra)) throw GetException(); 
	return dra;
}

Ptr putback(Dra R, Ptr L) throws PutBackException
{
	Fig fig = dra2fig(R);
	if (!validate(fig)) throw PutBackException();
	Ast ast = fig2ast(fig);
	if (!validate(ast)) throw PutBackException();
	Ptr ptr = ast2ptr(ast);
	if (!validate(ptr)) throw PutBackException(); 
	return putbacktt(L,ptr);
}

Ptr putbacktt(
	(Ptr main)`<PtrLHS lhs1><WS* ws1>=<WS* ws2><PtrRHS rhs1><WS* ws3>;`,
	(Ptr updd)`<PtrLHS lhs2><WS*   _>=<WS*   _><PtrRHS rhs2><WS*   _>;`
) = newPtr(putbacktt(lhs1,lhs2), unparse(ws1), unparse(ws2), newPtrRHS(putbacktt(rhs1.rhs,rhs2.rhs)), unparse(ws3));

PtrLHS putbacktt(
	(PtrLHS main)`<PtrName _><WS* ws><PtrNameArgs args1>`,
	(PtrLHS updd)`<PtrName f><WS*  _><PtrNameArgs args2>`
) = newPtrLHS(f, unparse(ws), putbacktt(args1,args2));

PtrNameArgs putbacktt(PtrNameArgs main, PtrNameArgs updd)
{
	list[PtrName] names = [n | /PtrName n := updd.ns];
	list[str] wss = [unparse(ws) | /WS ws := main.ns];
	while(size(wss)<size(names)) wss += " ";
	return newPtrNameArgs([<names[i],wss[i]> | i <- [0..size(names)]]);
}

PtrExpr putbacktt(main:(PtrExpr)`<PtrAtom _>`, updd:(PtrExpr)`<PtrAtom _>`) = updd;
PtrExpr putbacktt(
	(PtrExpr)`<PtrExpr l1><WS* ws1>*<WS* ws2><PtrExpr r1>`,
	(PtrExpr)`<PtrExpr l2><WS*   _>*<WS*   _><PtrExpr r2>`)
	= newPtrExpr(putbacktt(l1,l2), unparse(ws1), "*", unparse(ws2), putbacktt(r1,r2));
PtrExpr putbacktt(
	(PtrExpr)`<PtrExpr l1><WS* ws1>+<WS* ws2><PtrExpr r1>`,
	(PtrExpr)`<PtrExpr l2><WS*   _>+<WS*   _><PtrExpr r2>`)
	= newPtrExpr(putbacktt(l1,l2), unparse(ws1), "+", unparse(ws2), putbacktt(r1,r2));
PtrExpr putbacktt(
	(PtrExpr)`<PtrExpr l1><WS* ws1>*<WS* ws2><PtrExpr r1>`,
	(PtrExpr)`<PtrExpr l2><WS*   _>+<WS*   _><PtrExpr r2>`)
	= newPtrExpr(putbacktt(l1,l2), unparse(ws1), "+", unparse(ws2), putbacktt(r1,r2));
PtrExpr putbacktt(
	(PtrExpr)`<PtrExpr l1><WS* ws1>+<WS* ws2><PtrExpr r1>`,
	(PtrExpr)`<PtrExpr l2><WS*   _>*<WS*   _><PtrExpr r2>`)
	= newPtrExpr(putbacktt(l1,l2), unparse(ws1), "*", unparse(ws2), putbacktt(r1,r2));
default PtrExpr putbacktt(PtrExpr main, PtrExpr updd) = updd;
// NB: we don't try too hard, no oversophisticated matching going on here

// get works well
test bool vfoster1() = get(types::Ptr::example) == types::Dra::example;
// putback works just as well
test bool vfoster2() = putback(types::Dra::example,types::Ptr::example) == types::Ptr::example;
// putback can do the same trick with default indentation
test bool vfoster3() = putback(types::Dra::example,types::Ptr::defexample) == types::Ptr::defexample;
// some more fancy stuff putback can do
test bool vfoster4() = putback(types::Dra::example,parse(#Ptr,"f arg = 42 +arg   *\t\t9000;")) == types::Ptr::example;
// yet putback disregards visual repositioning (breaks the PutGet law)
test bool vfoster5() = get(putback(types::Dra::exedited,types::Ptr::example)) == types::Dra::example;
