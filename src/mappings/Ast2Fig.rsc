@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Ast2Fig

import types::Ast;
import types::Fig;

public Fig ast2fig(astfundef(AstName name, AstArgs args, AstExpr body))
	= figfunctionmodel(name, args, ast2fig(body));
FigExpr ast2fig(astvariable(AstName name)) = figvariable(name);
FigExpr ast2fig(astliteral(AstNumber number)) = figliteral(number);
FigExpr ast2fig(astbplus(AstExpr left, AstExpr right)) = figbinary("+", ast2fig(left), ast2fig(right));
FigExpr ast2fig(astbmul(AstExpr left, AstExpr right)) = figbinary("*", ast2fig(left), ast2fig(right));

test bool tast2fig1() = ast2fig(types::Ast::example) == types::Fig::example; 
