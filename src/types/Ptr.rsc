@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	Ptr is a parse tree: a graph-like hierarchical representation of a program designed
	to preserve all information that programmers entered. This means including layout,
	comments, indentation, annotations, etc. In Rascal Ptr and Cst are interchangeable
	because there is evidence that this makes language engineers more efficient.
	However, in order to demonstrate Ptr in our case study, we used purely lexical definitions
	(so called "character level grammars"), which are otherwise uncommon in Rascal.
	Layout is explicitly defined empty, because otherwise Rascal parser generator will
	fall back to default layout definition.
	
	NB: renderParsetree from vis::ParseTree does not show anything here, because it was
	written to ignore lexical structure.
}
module types::Ptr

import ParseTree;
import vis::ParseTree;
import IO;

layout L = ();
lexical WS = [\ \t\n\r];
lexical Ptr = PtrLHS lhs WS* "=" WS* PtrRHS rhs WS* ";";
lexical PtrLHS = PtrName f WS* PtrNameArgs args;
lexical PtrRHS = PtrExpr rhs;
lexical PtrNameArgs = {PtrName WS*}+;
lexical PtrExpr
	= PtrAtom a
	> left PtrExpr l WS* "*" WS* PtrExpr r
	> left PtrExpr l WS* "+" WS* PtrExpr r
	;
lexical PtrAtom
	= PtrName name
	| PtrNumber number
	;
lexical PtrName = [a-z]+ !>> [a-z];
lexical PtrNumber = [0-9]+ !>> [0-9];

public bool validate(Ptr p) = /amb(_) !:= p;

public void visualise(Ptr p) = renderParsetree(p);

Ptr example = parse(#Ptr,"f arg = arg +1;");

test bool vptr1() = validate(example);

void visptr1() = visualise(example);
void pptr1() {iprintln(example);}
void visptr2() = visualise(parse(#Ptr,"f arg = 1+2*2+1;"));
