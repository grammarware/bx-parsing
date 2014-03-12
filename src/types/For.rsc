@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::For

import ParseTree;
import vis::ParseTree;

lexical WS = [\ \t\n\r];
syntax For = ForLHS lhs WS* "=" WS* ForRHS rhs WS* ";";
syntax ForLHS = ForName f WS* ForNameArgs args;
syntax ForRHS = ForExpr rhs;
lexical ForNameArgs = {ForName WS*}+;
syntax ForExpr
	= ForAtom
	| ForExpr WS* "*" WS* ForExpr
	| ForExpr WS* "+" WS* ForExpr
	;
syntax ForAtom
	= ForName
	| ForNumber
	;
lexical ForName = [a-z]+;
lexical ForNumber = [0-9]+;

public bool validate(For p) = true;

public void visualise(For p) = renderParsetree(p);

For example = parse(#For,"f arg = arg +1;");

test bool vfor0() = /amb(_) := example;
test bool vfor1() = /amb(_) := parse(#For,"f arg = 1+1+1;");
test bool vfor2() = /amb(_) := parse(#For,"f arg = 1+1*1;");
test bool vfor3() = /amb(_) := parse(#For,"f arg = 1*1+1;");
test bool vfor4() = /amb(_) := parse(#For,"f arg = 1;");

void visfor1() = visualise(parse(#For,"f arg = arg +1;"));
void visfor2() = visualise(parse(#For,"f arg = 1+2*2+1;"));
void visfor3() = visualise(parse(#For,"f arg = 1;")); // Rascal does not draw lexical ambiguities :(
