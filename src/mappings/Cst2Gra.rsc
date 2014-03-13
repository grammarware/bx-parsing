@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Cst2Gra

import List;
import types::Cst;
import types::Gra;

public Gra cst2gra(Cst p)
	= gramodel(graprefix(grabox(gracurly(),"<p.lhs.f>"),
		graconfix(graround(),grainfix(graarrow(),[
			maybewrap([grabox(grasquare(),"<n>") | /CstName n <- p.rhs.args]),
			mapexpr(p.rhs.rhs)]))));

GraElement maybewrap([GraElement n]) = n;
GraElement maybewrap(list[GraElement] ns) = grainfix(graempty(),es); 

GraElement mapexpr((CstExpr)`<CstAtom a>`) = mapatom(a);
GraElement mapexpr((CstExpr)`<CstExpr l>*<CstExpr r>`)
	= graprefix(grabox(gracurly(),"*"),grainfix(graempty(),[mapexpr(l),mapexpr(r)]));
GraElement mapexpr((CstExpr)`<CstExpr l>+<CstExpr r>`)
	= graprefix(grabox(gracurly(),"+"),grainfix(graempty(),[mapexpr(l),mapexpr(r)]));
GraElement mapatom((CstAtom)`<CstName name>`) = grabox(grasquare(),"<name>");
GraElement mapatom((CstAtom)`<CstNumber number>`) = grabox(graround(),"<number>");
		
test bool vcst2gra1() = cst2gra(types::Cst::example) == types::Gra::example;
