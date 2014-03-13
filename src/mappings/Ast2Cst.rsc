@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	Unfortunately, Rascal allows us to pattern match with concrete syntax, but not to construct
	concrete parse trees the same way. Hence, the code below relies on a library called
	CstFactory which contains grammar-derived boilerplate code to construct parse tree nodes. 
	This demonstrates that in [at least some] modern language workbenches
	users are not expected to freely manipulate concrete syntax trees.
}
module mappings::Ast2Cst

import types::Ast;
import types::Cst;
import lib::CstFactory;

Cst ast2cst(Ast p)
	= newCst(
		newCstLHS(
			newCstName(p.name),
			newCstNameArgs([newCstName(a) | a <- p.args])),
		newCstRHS(ast2cst(p.body))); 

CstExpr ast2cst(astvariable(AstName name)) = newCstExpr(newCstAtom(newCstName(name))); 
CstExpr ast2cst(astliteral(AstNumber number)) = newCstExpr(newCstAtom(newCstNumber(number)));
CstExpr ast2cst(astbplus(AstExpr left, AstExpr right)) = newCstExpr(ast2cst(left), "+", ast2cst(right));
CstExpr ast2cst(astbmul(AstExpr left, AstExpr right)) = newCstExpr(ast2cst(left), "*", ast2cst(right));

test bool vast2cst1() = ast2cst(types::Ast::example) == types::Cst::example;