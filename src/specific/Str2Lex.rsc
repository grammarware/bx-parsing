@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	This is an idiosyncratic way to obtain Lex from Str directly (sort of).
	We do this by defining a concrete syntax specification as close as possible to
	the desired algebraic data type of Lex, and then calling a Rascal "implode" function
	that attempts to match the grammar with the ADT whenever possible by using heuristics
	and soft matching. As a result, we obtain a Lex entity directly.
	
	Conceptually, this is Str -> For -> Ptr -> Cst -> Ast -> Lex, where
		Str -> For is provided by GLL built-in in Rascal (for free)
		For -> Ptr is guaranteed by writing unambiguous grammar (for free)
		Ptr -> Cst is implicit by Rascal design (for free)
		Cst -> Ast is obtained by the implode method (for free)
		Ast -> Lex is not even needed since by design they are equal.
	
	This example demonstrates how a seemingly longer roundabout way may be easier to implement
	due to certain features of the toolkit being given to a language workshop user for free.
	This scenario does require a separate spec to be written in a very peculiar way.
}
module specific::Str2Lex

import types::Str;
import types::Lex;
import ParseTree;

syntax AltLex
	= lexfundef: TokToken+ left "=" TokToken+ right;
syntax TokToken
	= numeric: LexNumeric n
	| alphanumeric: LexString a
	| ssymbol: LexSymbol s
	;
lexical LexNumeric = [0-9]+ !>> [0-9];
lexical LexString = [a-z]+ !>> [a-z];
lexical LexSymbol = ![0-9a-z\ \t\n\r=]+ !>> ![0-9a-z\ \t\n\r=];
layout L = [\ \t\n\r]*;

test bool xstr2lex1() = implode(#Lex,parse(#AltLex,types::Str::example)) == types::Lex::example;