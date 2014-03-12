@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Ptr

import ParseTree;
import vis::ParseTree;

lexical WS = [\ \t\n\r];
syntax Ptr = PtrLHS lhs WS* "=" WS* PtrRHS rhs WS* ";";
syntax PtrLHS = PtrName f WS* PtrNameArgs args;
syntax PtrRHS = PtrExpr rhs;
syntax PtrNameArgs = {PtrName WS*}+;
syntax PtrExpr
	= PtrAtom
	| PtrBinary
	;
syntax PtrAtom
	= PtrName
	| PtrNumber
	;
syntax PtrBinary
	= left PtrExpr WS* "*" WS* PtrExpr
	> left PtrExpr WS* "+" WS* PtrExpr
	;
lexical PtrName = [a-z]+ !>> [a-z];
lexical PtrNumber = [0-9]+ !>> [0-9];

bool validate(Ptr p) = /amb(_) !:= p;

bool vptr1() = parse(#Ptr,"f arg = arg +1;");

void visptr1() = renderParsetree(parse(#Ptr,"f arg = arg +1;"));
