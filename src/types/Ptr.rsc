@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
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
