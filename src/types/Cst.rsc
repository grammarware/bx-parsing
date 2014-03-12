@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Cst

import ParseTree;
import vis::ParseTree;

layout L = WS*;
lexical WS = [\ \t\n\r];
start syntax Cst = CstLHS lhs "=" CstRHS rhs ";";
syntax CstLHS = CstName f CstNameArgs args;
syntax CstRHS = CstExpr rhs;
syntax CstNameArgs = {CstName WS*}+;
syntax CstExpr
	= CstAtom
	> left CstExpr "*" CstExpr
	> left CstExpr "+" CstExpr
	;
syntax CstAtom
	= CstName
	| CstNumber
	;
lexical CstName = [a-z]+ !>> [a-z];
lexical CstNumber = [0-9]+ !>> [0-9];

public bool validate(Cst p) = /amb(_) !:= p;

public void visualise(Cst p) = renderParsetree(p);

test bool vCst1() = parse(#start[Cst],"f arg = arg +1;");

void visCst1() = visualise(parse(#start[Cst],"f arg = arg +1;").top);
void visCst2() = visualise(parse(#start[Cst],"f arg = 1+2*2+1;").top);