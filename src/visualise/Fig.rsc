@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Fig

import types::Fig;
import vis::Figure;
import vis::Render;

Figure visualised(Fig p) = tree(box(text("Figure")),[tree(box(text("Function")),[mapname(p.name), *[maparg(a)|a<-p.args], mapexpr(p.body)], gap(20))], resizable(false), std(font("Monaco")), std(gap(5)), gap(20) );

Figure mapname(FigName name) = tree(box(text("Name")),[box(text("\'<name>\'"))],gap(20));
Figure mapnum(FigNumber number) = tree(box(text("Number")),[box(text("<number>"))],gap(20));
Figure mapop(FigName name) = tree(box(text("Op")),[box(text("\'<name>\'"))],gap(20));
Figure maparg(FigArg name) = tree(box(text("Arg")),[box(text("\'<name>\'"))],gap(20));

Figure mapexpr(figvariable(FigName name)) = tree(box(text("Variable")),[mapname(name)],gap(20));
Figure mapexpr(figliteral(FigNumber number)) = tree(box(text("Literal")),[mapnum(number)],gap(20));
Figure mapexpr(figbinary(FigName op, FigExpr left, FigExpr right))
	= tree(box(text("Binary")),[mapop(op),mapexpr(left),mapexpr(right)],gap(20));

public void visualise(Fig p) = render(visualised(p));

void visfig1() = visualise(types::Fig::example);
