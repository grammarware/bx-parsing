@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	The "Meertens BX" (symmetric maintainer) variant of Ptr-Dra bridge.
	L = Ptr (parse tree with textual layout info); R = Dra (drawing with graphical layout info)
}
module bridges::ptrdra::Meertens

import types::Ptr;
import types::Dra;
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
	newR = fig2dra(ast2fig(ptr2ast(L)));
	if (!validate(newR)) throw MaintainException(); 
	newnewR = syncR(R,newR);
	if (!validate(newnewR)) throw MaintainException(); 
	return newnewR;
}

Ptr maintainL(Ptr L, Dra R) throws MaintainException
{
	newL = ast2ptr(fig2ast(dra2fig(R)));
	if (!validate(newL)) throw MaintainException(); 
	newnewL = syncL(L,newL);
	if (!validate(newnewL)) throw MaintainException();
	return newnewL;
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

test bool vmeertens1() = dra2pic(maintainR(types::Ptr::example, types::Dra::example)) == dra2pic(types::Dra::example);
test bool pmeertens1()
{
	println(types::Dra::example);
	println(maintainR(types::Ptr::example, types::Dra::example));
	return true;
}

test bool vmeertens2() = maintainL(types::Ptr::example,types::Dra::example) == types::Ptr::example;
test bool pmeertens2()
{
	println(types::Ptr::example);
	println(maintainL(types::Ptr::example,types::Dra::example));
	return true;
}

test bool vmeertens3() = maintainL(parse(#Ptr,"f arg = 42 +arg   *\t\t9000;"),types::Dra::example) == types::Ptr::example;
test bool pmeertens3()
{
	println(types::Ptr::example);
	println(maintainL(parse(#Ptr,"f arg = 42 +arg   *\t\t9000;"),types::Dra::example));
	return true;
}

// L = Ptr; R = Dra
test bool vmeertens4() = dra2pic(maintainR(parse(#Ptr,"f arg = arg   +\t\t1;"),types::Dra::example)) == dra2pic(types::Dra::example);
test bool pmeertens4()
{
	println(types::Dra::example);
	println(maintainR(parse(#Ptr,"f arg = arg   +\t\t1;"),types::Dra::example));
	return true;
}
