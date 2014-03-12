@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Lex2Tok

import List;
import String;
import types::Tok;
import types::Lex;

@doc{
	Losing structural information is easy.
	Here we flatten the primitive tree and add one token that was sacrifised during extraction.
}
public Tok lex2tok(lexfundef(list[TokToken] left, list[TokToken] right))
	= [lex2tok(t) | TokToken t <- left]
	+ ["="]
	+ [lex2tok(t) | TokToken t <- right];

str lex2tok(numeric(int n)) = "<n>";
str lex2tok(alphanumeric(str a)) = "<a>";
str lex2tok(ssymbol(str s)) = "<s>";

test bool vlex2tok1() = lex2tok(types::Lex::example) == types::Tok::example;
