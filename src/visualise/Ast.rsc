@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Ast

import types::Ast;
import vis::Figure;
import vis::Render;

import String;

Figure visAst(Ast p)
	= tree(
		box(text("FunDef")),
		[
			visName(p.name),
			*[visArg(a) | AstArg a <- p.args],
			visExpr(p.body)
		],
		std(gap(5)), gap(30), std(font("Monaco")));

Figure visName(AstName name)
	= tree(
		box(text("Name")),
		[
			box(text("\'<name>\'"))
		], gap(30));

Figure visArg(AstArg arg)
	= tree(
		box(text("Arg")),
		[
			box(text("\'<arg>\'"))
		], gap(30));

Figure visExpr(astvariable(AstName name))
	= tree(
		box(text("Variable")),
		[
			box(text("\'<name>\'"))
		], gap(30));
Figure visExpr(astliteral(AstNumber number))
	= tree(
		box(text("Literal")),
		[
			box(text("<number>"))
		], gap(30));
Figure visExpr(astbplus(AstExpr left, AstExpr right))
	= tree(
		box(text("BinaryPlus")),
		[
			visExpr(left),
			visExpr(right)
		], gap(30));
Figure visExpr(astbmul(AstExpr left, AstExpr right))
	= tree(
		box(text("BinaryMul")),
		[
			visExpr(left),
			visExpr(right)
		], gap(30));

public void visualise(Ast p) = render(visualised(p));
public Figure visualised(Ast p) = visAst(p);

void visast1() = visualise(types::Ast::example);
void visast2() = visualise(types::Ast::tricky);
