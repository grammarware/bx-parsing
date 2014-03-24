@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	The "Final BX" (sustainer) variant of Ptr-Dra bridge.
	L = Ptr (parse tree with textual layout info); R = Dra (drawing with graphical layout info)
}
module bridges::ptrdra::Final

import types::Ptr;
import types::Dra;
import types::Ast;
import types::Fig;
import mappings::Dra2Pic;
import mappings::Ast2Fig;
import mappings::Fig2Ast;
import mappings::MultiStep;
import lib::PtrFactory;
import lib::LocFactory;

import IO;
import List;
import ParseTree;

import Exception;
data RuntimeException = SustainException();

alias LR = tuple[Ptr,Dra];

Ptr fixptr(Ptr L)
{
	// Add undeclared variables
	args = [unparse(n) | /PtrNameArgs nas := L.rhs, /PtrName ud := nas];
	args += [unparse(ud) | /PtrName ud := L.rhs, unparse(ud) notin args];
	lrel[PtrName,str] awl = [<newPtrName(a)," "> | a <- args];
	awl[size(awl)-1][1] = "";
	//newL.args = newPtrNameArgs(awl);
	if ((Ptr)`<PtrName f><WS* ws1><PtrNameArgs args><WS* ws2>=<WS* ws3><PtrRHS rhs><WS* ws4>;` := L)
		return newPtr(newPtrLHS(f, unparse(ws1), newPtrNameArgs(awl) ), unparse(ws2), unparse(ws3), rhs, unparse(ws4));
	else
		return L;
}

// L = Ptr; R = Dra
LR maintainR(Ptr L, Dra R) throws SustainException
{
	Ptr newL = fixptr(L);
	if (!validate(newL)) throw SustainException();
	Ast ast = ptr2ast(newL);
	if (!validate(ast)) throw SustainException();
	Fig fig = ast2fig(ast);
	if (!validate(fig)) throw SustainException();
	Dra dra = fig2dra(fig);
	if (!validate(dra)) throw SustainException();
	Dra fix = fixdra(dra);
	if (!validate(fix)) throw SustainException();
	Dra newR = syncR(R,fix); 
	if (!validate(newR)) throw SustainException();
	return <newL,newR>;
}

Dra fixdra(Dra R)
{
	if (   dracurly(_,_) := R.es[0]
		&& drasymbol("(",_) := R.es[1]
		&& drasymbol(")",_) !:= R.es[-1]
		)
		R = drapicture(R.es+[drasymbol(")", newloc(1, R.es[-1].where.end.line+1, R.es[1].where.begin.column))]);
	return balance(R);
}

LR maintainL(Ptr L, Dra R) throws SustainException
{
	Dra newR = fixdra(R);
	if (!validate(newR)) throw SustainException();
	Fig fig = dra2fig(newR);
	if (!validate(fig)) throw SustainException();
	Ast ast = fig2ast(fig);
	if (!validate(ast)) throw SustainException();
	Ptr ptr = ast2ptr(ast);
	if (!validate(ptr)) throw SustainException();
	Ptr fix = fixptr(ptr);
	if (!validate(fix)) throw SustainException();
	Ptr newL =  syncL(L,fix);
	if (!validate(newL)) throw SustainException();
	return <newL,newR>;
}

// Maintaining the "right" part of the relation (Dra, a drawing of a model)
Dra syncR(Dra main, Dra updd) throws SustainException
{
	list[DraElement] res = [];
	if (size(main.es) != size(updd.es))
	{
		println(main.es);
		println(updd.es);
		throw SustainException;
	}
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

// right sustainer works
test bool vfinal1() = maintainR(types::Ptr::example, types::Dra::example)
					== <types::Ptr::example, types::Dra::example>;
// right sustainer works on default formatting
test bool vfinal2() = maintainR(types::Ptr::defexample, types::Dra::example)
					== <types::Ptr::defexample, types::Dra::example>;
// right sustainer works on repositioned model
test bool vfinal3() = maintainR(types::Ptr::example, types::Dra::exedited)
					== <types::Ptr::example, types::Dra::exedited>;
// left sustainer works
test bool vfinal4() = maintainL(types::Ptr::example,types::Dra::example)
					== <types::Ptr::example, types::Dra::example>;
// left sustainer works on default formatting
test bool vfinal5() = maintainL(types::Ptr::defexample,types::Dra::example)
					== <types::Ptr::defexample, types::Dra::example>;
// left sustainer works on repositioned model
test bool vfinal6() = maintainL(types::Ptr::example,types::Dra::exedited)
					== <types::Ptr::example, types::Dra::exedited>;
// left maintainer can do more fancy stuff
test bool vfinal7() = maintainL(parse(#Ptr,"f arg = 42 +arg   *\t\t9000;"),types::Dra::example)
					== <types::Ptr::example, types::Dra::example>;
// right maintainer doesn’t want to lose
Ptr ptrtab = parse(#Ptr,"f arg = arg   +\t\t1;");
test bool vfinal8() = maintainR(ptrtab,types::Dra::example)
					== <ptrtab, types::Dra::example>;
// left maintainer goes beyond Meertens BX
test bool vfinalA() = maintainL(types::Ptr::example,drapicture(types::Dra::example.es[..-1]))
					== <types::Ptr::example, types::Dra::example>;
// right maintainer goes beyond Meertens BX
Ptr ptradd1 = parse(#Ptr,"add x = x+y;");
Ptr ptradd2 = parse(#Ptr,"add y = x+y;");
Ptr ptradd3 = parse(#Ptr,"add x y = x+y;");
Ptr ptradd4 = parse(#Ptr,"add y = x + y;");
Ptr ptradd5 = parse(#Ptr,"add x y = x + y;");
Dra draadd = drapicture([
	dracurly("add",|stdin:///|(0,5,<1,0>,<1,5>)),
	drasymbol("(",|stdin:///|(7,1,<2,1>,<2,2>)),
	drasquare("x",|stdin:///|(11,3,<3,2>,<3,5>)),
	drasquare("y",|stdin:///|(17,3,<4,2>,<4,5>)),
	drasymbol("→",|stdin:///|(22,1,<5,1>,<5,2>)),
	dracurly("+",|stdin:///|(26,3,<6,2>,<6,5>)),
	drasquare("x",|stdin:///|(33,3,<7,3>,<7,6>)),
	drasquare("y",|stdin:///|(40,3,<8,3>,<8,6>)),
	drasymbol(")",|stdin:///|(45,1,<9,1>,<9,2>))
]);
test bool vfinalB() = maintainR(ptradd1,draadd)
					== <ptradd3, draadd>;
test bool vfinalC() = maintainR(ptradd2,draadd)
					== <ptradd3, draadd>;
test bool vfinalD() = maintainR(ptradd3,draadd)
					== <ptradd3, draadd>;
test bool vfinalE() = maintainR(ptradd4,draadd)
					== <ptradd5, draadd>;
