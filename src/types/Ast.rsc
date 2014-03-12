@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Ast

import types::Tkl;

data Ast = astfundef(AstName name, AstArgs args, AstExpr body);
alias AstName = str;
alias AstArgs = list[AstArg];
alias AstArg = str;
data AstExpr
	= astvariable(AstName name)
	| astliteral(AstNumber number)
	| astbplus(AstExpr left, AstExpr right)
	| astbmul(AstExpr left, AstExpr right)
	;
alias AstNumber = int;

public bool validate(Ast a)
	= (true | it && !isEmpty(n) && (n in a.args) | /astvariable(AstName n) <- a)
	;

test bool vast1() = validate(astfundef("f",["arg"],
							astbplus(astvariable("arg"),astliteral(1))));
test bool vast2() = !validate(astfundef("f",["arg"],
							astbplus(astvariable("x"),astliteral(1))));
