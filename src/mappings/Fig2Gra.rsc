@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	In Fig to Gra mapping, we need to introduce visualisation details: Fig information is too close
	to the domain (it talks about functions, arguments and bodies), while we would like to have a model
	that talks about boxes and arrows.
}
module mappings::Fig2Gra

import List;
import types::Fig;
import types::Gra;

public Gra fig2gra(figfunctionmodel(FigName name, FigArgs args, FigExpr body))
	= gramodel(
		graprefix(grabox(gracurly(),name),
		graconfix(graround(),
		grainfix(graarrow(),
		mapargsandbody(args,body)
	))));

list[GraElement] mapargsandbody(FigArgs args, FigExpr body)
{
	list[GraElement] res = [];
	if (size(args)==1)
		res += grabox(grasquare(),args[0]);
	else
		res += grainfix(graempty(),[grabox(grasquare(),arg) | arg <- args]);
	res += mapexpr(body);
	return res;
}

GraElement mapexpr(figvariable(FigName name)) = grabox(grasquare(),name);
GraElement mapexpr(figliteral(FigNumber number)) = grabox(graround(),"<number>");
GraElement mapexpr(figbinary(FigName op, FigExpr left, FigExpr right))
	= graprefix(grabox(gracurly(),op),grainfix(graempty(),[mapexpr(left),mapexpr(right)]));

test bool vfig2gra1() = fig2gra(types::Fig::example) == types::Gra::example;
