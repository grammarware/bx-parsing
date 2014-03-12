@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	Cst is a concrete syntax tree, which means it unambiguously defines the program
	in a form very close to the syntax used by programmers or any other language users.
	
	In the case study we model Ast by Rascal Concrete Syntax Definition, see
	http://tutor.rascal-mpl.org/Rascal/Expressions/ConcreteSyntax/ConcreteSyntax.html
	This specification utilises many features, including:
		- layout which is automatically "ignored" during pattern matching
		- explicit starting nonterminal which takes care of leading & trailing layout
		- named subexpressions that make writing mappers easier
		- explicit left associativity and production precedence to encode priorities
		- follow restrictions for greedy matching of preterminals
		- deep matching of ambiguities as a validation technique 
}
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
	= CstAtom a
	> left CstExpr l "*" CstExpr r
	> left CstExpr l "+" CstExpr r
	;
syntax CstAtom
	= CstName name
	| CstNumber number
	;
lexical CstName = [a-z]+ !>> [a-z];
lexical CstNumber = [0-9]+ !>> [0-9];

Cst example = parse(#start[Cst],"f arg = arg +1;").top;

public bool validate(Cst p) = /amb(_) !:= p;

public void visualise(Cst p) = renderParsetree(p);

test bool vCst1() = validate(example);

void visCst1() = visualise(parse(#start[Cst],"f arg = arg +1;").top);
void visCst2() = visualise(parse(#start[Cst],"f arg = 1+2*2+1;").top);
