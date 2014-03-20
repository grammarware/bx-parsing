@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	Losing structural information is easy.
	Here we flatten the primitive tree and deliver tokens in less structured fashion.
	Note how we do this without ever using any information about the internal structure of Lex.
	To avoid even the pattern matching of `tokenlex2tok()`, we need Lex to expose a function like
	`toToken()` to us.
}
module mappings::Lex2Tok

import types::Tok;
import types::Lex;

public Tok lex2tok(Lex p) = [tokenlex2tok(t) | /TokToken t <- p];

str tokenlex2tok(numeric(int n)) = "<n>";
str tokenlex2tok(alphanumeric(str a)) = "<a>";
str tokenlex2tok(ssymbol(str s)) = "<s>";

test bool vlex2tok1() = lex2tok(types::Lex::example) == types::Tok::example;
