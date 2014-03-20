@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	The "Meertens BX" (symmetric maintainer) variant of Ptr-Dra bridge.
	L = Ptr (parse tree with textual layout info); R = Dra (drawing with graphical layout info)
}
module bridges::ptrdra::Meertens

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
data RuntimeException = MaintainException();

// L = Ptr; R = Dra
Dra maintainR(Ptr L, Dra R) throws MaintainException
{
	Ast ast = ptr2ast(L);
	if (!validate(ast)) throw MaintainException();
	Fig fig = ast2fig(ast);
	if (!validate(fig)) throw MaintainException();
	Dra dra = fig2dra(fig);
	if (!validate(dra)) throw MaintainException();
	Dra res = syncR(R,dra); 
	if (!validate(res)) throw MaintainException();
	return res;
}

Ptr maintainL(Ptr L, Dra R) throws MaintainException
{
	Fig fig = dra2fig(R);
	if (!validate(fig)) throw MaintainException();
	Ast ast = fig2ast(fig);
	if (!validate(ast)) throw MaintainException();
	Ptr ptr = ast2ptr(ast);
	if (!validate(ptr)) throw MaintainException();
	Ptr res =  syncL(L,ptr);
	if (!validate(res)) throw MaintainException();
	return res;
}

// Maintaining the "right" part of the relation (Dra, a drawing of a model)
Dra syncR(Dra main, Dra updd) throws MaintainException
{
	list[DraElement] res = [];
	if (size(main.es) != size(updd.es))
		throw MaintainException;
	for (i <- [0..size(main.es)])
		if(main.es[i].where == updd.es[i].where)
			res += replaceLabel(main.es[i], updd.es[i].label);
		else
			res += main.es[i];
	return drapicture(res);
}

DraElement replaceLabel(drasquare(str _, loc where), str label) = drasquare(label, where);
DraElement replaceLabel(draround(str _, loc where), str label) = draround(label, where);
DraElement replaceLabel(dracurly(str _, loc where), str label) = dracurly(label, where);
DraElement replaceLabel(drasymbol(str _, loc where), str label) = drasymbol(label, where); 

// Maintaining the "left" part of the relation (Ptr, a parse tree): same as in the Foster BX
Ptr syncL(
	(Ptr main)`<PtrLHS lhs1><WS* ws1>=<WS* ws2><PtrRHS rhs1><WS* ws3>;`,
	(Ptr updd)`<PtrLHS lhs2><WS*   _>=<WS*   _><PtrRHS rhs2><WS*   _>;`
	)
	= newPtr(syncL(lhs1,lhs2), unparse(ws1), unparse(ws2), newPtrRHS(syncL(rhs1.rhs,rhs2.rhs)), unparse(ws3));

PtrLHS syncL(
	(PtrLHS main)`<PtrName _><WS* ws><PtrNameArgs args1>`,
	(PtrLHS updd)`<PtrName f><WS*  _><PtrNameArgs args2>`
	)
	= newPtrLHS(f, unparse(ws), syncL(args1,args2));

PtrNameArgs syncL(PtrNameArgs main, PtrNameArgs updd) throws PutBackException
{
	list[PtrName] names = [n | /PtrName n := updd.ns];
	list[str] wss = [unparse(ws) | /WS ws := main.ns];
	while(size(wss)<size(names)) wss += " ";
	return newPtrNameArgs([<names[i],wss[i]> | i <- [0..size(names)]]);
}

PtrExpr syncL(main:(PtrExpr)`<PtrAtom _>`, updd:(PtrExpr)`<PtrAtom _>`) = updd;
PtrExpr syncL(
	(PtrExpr)`<PtrExpr l1><WS* ws1>*<WS* ws2><PtrExpr r1>`,
	(PtrExpr)`<PtrExpr l2><WS*   _>*<WS*   _><PtrExpr r2>`)
	= newPtrExpr(syncL(l1,l2), unparse(ws1), "*", unparse(ws2), syncL(r1,r2));
PtrExpr syncL(
	(PtrExpr)`<PtrExpr l1><WS* ws1>+<WS* ws2><PtrExpr r1>`,
	(PtrExpr)`<PtrExpr l2><WS*   _>+<WS*   _><PtrExpr r2>`)
	= newPtrExpr(syncL(l1,l2), unparse(ws1), "+", unparse(ws2), syncL(r1,r2));
PtrExpr syncL(
	(PtrExpr)`<PtrExpr l1><WS* ws1>*<WS* ws2><PtrExpr r1>`,
	(PtrExpr)`<PtrExpr l2><WS*   _>+<WS*   _><PtrExpr r2>`)
	= newPtrExpr(syncL(l1,l2), unparse(ws1), "+", unparse(ws2), syncL(r1,r2));
PtrExpr syncL(
	(PtrExpr)`<PtrExpr l1><WS* ws1>+<WS* ws2><PtrExpr r1>`,
	(PtrExpr)`<PtrExpr l2><WS*   _>*<WS*   _><PtrExpr r2>`)
	= newPtrExpr(syncL(l1,l2), unparse(ws1), "*", unparse(ws2), syncL(r1,r2));
default PtrExpr syncL(PtrExpr main, PtrExpr updd) = updd;
// NB: we don't try too hard, no oversophisticated matching going on here

// right semi-maintainer works
test bool vmeertens1() = maintainR(types::Ptr::example, types::Dra::example) == types::Dra::example;
// right semi-maintainer works on default formatting
test bool vmeertens2() = maintainR(types::Ptr::defexample, types::Dra::example) == types::Dra::example;
// right semi-maintainer works on repositioned model
test bool vmeertens3() = maintainR(types::Ptr::example, types::Dra::exedited) == types::Dra::exedited;
// left semi-maintainer works
test bool vmeertens4() = maintainL(types::Ptr::example,types::Dra::example) == types::Ptr::example;
// left semi-maintainer works on default formatting
test bool vmeertens5() = maintainL(types::Ptr::defexample,types::Dra::example) == types::Ptr::defexample;
// left semi-maintainer works on repositioned model
test bool vmeertens6() = maintainL(types::Ptr::example,types::Dra::exedited) == types::Ptr::example;
// left maintainer can do more fancy stuff
test bool vmeertens7() = maintainL(parse(#Ptr,"f arg = 42 +arg   *\t\t9000;"),types::Dra::example) == types::Ptr::example;
// right maintainer doesn’t want to lose
test bool vmeertens8() = maintainR(parse(#Ptr,"f arg = arg   +\t\t1;"),types::Dra::example) == types::Dra::example;
