@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	For is a parse forest or any other ambiguous collection of different representations
	of the same program. Just in the same way that by looking at a flat text of a program
	we cannot immediately tell its meaning, For models the fact that there is more than one
	way to understand a certain program.
	
	In our case study, For is obtained by GLL parsing with an ambiguous grammar.
	The grammar uses Rascal's concrete syntax definition, but does not rely on advanced
	features typically used for disambiguation (filtering, production precedence,
	associativity, follow restrictions, etc).
	
	NB: renderParsetree from vis::ParseTree does not show anything useful here, because it was
	written to ignore lexical structure and thus also lexical ambiguities.
}
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

For example = parse(#For, "f arg = arg +1;", allowAmbiguity=true);
For tricky  = parse(#For,"f arg = 1+2*3+4;", allowAmbiguity=true);

test bool vfor0() = /amb(_) := example;
test bool vfor1() = /amb(_) := parse(#For,"f arg = 1+1+1;", allowAmbiguity=true);
test bool vfor2() = /amb(_) := parse(#For,"f arg = 1+1*1;", allowAmbiguity=true);
test bool vfor3() = /amb(_) := parse(#For,"f arg = 1*1+1;", allowAmbiguity=true);
test bool vfor4() = /amb(_) := parse(#For,"f arg = 1;", allowAmbiguity=true);

void visfor1() = visualise(example);
void visfor2() = visualise(tricky);
void visfor3() = visualise(parse(#For,"f arg = 1;", allowAmbiguity=true));
// Rascal does not draw lexical ambiguities :(
