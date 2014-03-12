@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Cst2Ast

import String;
import types::Cst;
import types::Ast;

@doc{
	Notice how much more readable and concise this code is compared to the Ptr to Cst mapping.
	The reason is that this mapping (implosion) is expected to be done by a human, so
	the language workbench provides as much support as possible.
	On the other hand, cleaning up a parse tree of layout info and ambiguities is better done
	automatically, so manual ways are unhandy.
}
Ast cst2ast((Cst)`<CstLHS lhs>=<CstRHS rhs>;`)
	= astfundef("<lhs.f>", cst2ast(lhs.args), cst2ast(rhs.rhs));

AstArgs cst2ast((CstNameArgs)`<{CstName WS*}+ ns>`) = ["<a>" | /CstName a <- ns];

AstExpr cst2ast((CstExpr)`<CstAtom a>`)
{
	if ((CstAtom)`<CstName name>` := a) return astvariable("<name>");
	if ((CstAtom)`<CstNumber number>` := a) return astliteral(toInt("<number>"));
	return astvariable("ERROR");
}

AstExpr cst2ast((CstExpr)`<CstExpr l> * <CstExpr r>`)
	= astbmul(cst2ast(l), cst2ast(r));
AstExpr cst2ast((CstExpr)`<CstExpr l> + <CstExpr r>`)
	= astbplus(cst2ast(l), cst2ast(r));

test bool vcst2ast1() = cst2ast(types::Cst::example) == types::Ast::example;
