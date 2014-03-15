@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Gra2Fig

import types::Gra;
import types::Fig;
import String;

Fig gra2fig(gramodel(graprefix(grabox(gracurly(),str fname),
	graconfix(graround(), grainfix(graarrow(),[ GraElement args, GraElement body ])))))
	= figfunctionmodel(fname,mapargs(args),mapexpr(body));

FigArgs mapargs(grabox(grasquare(), str arg)) = [arg];
FigArgs mapargs(grainfix(graempty(), args)) = [arg | grabox(grasquare(), str arg) <- args];

FigExpr mapexpr(grabox(grasquare(), GraLabel label)) = figvariable(label);
FigExpr mapexpr(grabox(graround(), GraLabel label)) = figliteral(toInt(label));
FigExpr mapexpr(graprefix( grabox(gracurly(), str op), grainfix(graempty(),[GraElement e1, GraElement e2]) ))
	= figbinary(op, mapexpr(e1), mapexpr(e2));

test bool vgra2fig1() = gra2fig(types::Gra::example) == types::Fig::example;
