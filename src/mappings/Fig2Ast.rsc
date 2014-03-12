@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Fig2Ast

import types::Fig;
import types::Ast;

public Ast fig2ast(figfunctionmodel(FigName name, FigArgs args, FigExpr body))
	= astfundef(name, args, fig2ast(body));

AstExpr fig2ast(figvariable(FigName name)) = astvariable(name);
AstExpr fig2ast(figliteral(FigNumber number)) = astliteral(number);
AstExpr fig2ast(figbinary("+", FigExpr left, FigExpr right)) = astbplus(fig2ast(left), fig2ast(right));
AstExpr fig2ast(figbinary("*", FigExpr left, FigExpr right)) = astbmul(fig2ast(left), fig2ast(right));
// Troubleshooting heuristic: ignore right operand if the operation is not supported by the AST
default AstExpr fig2ast(figbinary(str op, FigExpr left, FigExpr right)) = fig2ast(left);

test bool tfig2ast1() = fig2ast(types::Fig::example) == types::Ast::example; 
