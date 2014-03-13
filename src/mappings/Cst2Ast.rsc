@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	This code is readable and concise even without using a separate library
	(compared to the Ptr to Cst mapping). The reason is that this mapping (implosion)
	is expected to be done by a human, so the language workbench provides as much support
	as possible.
	On the other hand, cleaning up a parse tree of layout info and ambiguities is better done
	automatically, so manual ways are unhandy.
}
module mappings::Cst2Ast

import String;
import types::Cst;
import types::Ast;

Ast cst2ast((Cst)`<CstLHS lhs>=<CstRHS rhs>;`)
	= astfundef("<lhs.f>", cst2ast(lhs.args), cst2ast(rhs.rhs));

AstArgs cst2ast((CstNameArgs)`<CstName+ ns>`) = ["<a>" | /CstName a <- ns];

AstExpr cst2ast((CstExpr)`<CstAtom a>`) = cst2ast(a); 
AstExpr cst2ast((CstExpr)`<CstExpr l> * <CstExpr r>`)
	= astbmul(cst2ast(l), cst2ast(r));
AstExpr cst2ast((CstExpr)`<CstExpr l> + <CstExpr r>`)
	= astbplus(cst2ast(l), cst2ast(r));

AstExpr cst2ast((CstAtom)`<CstName name>`) = astvariable("<name>");
AstExpr cst2ast((CstAtom)`<CstNumber number>`) = astliteral(toInt("<number>"));

test bool vcst2ast1() = cst2ast(types::Cst::example) == types::Ast::example;
