@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	TBD
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
