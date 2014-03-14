@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	TBD
}
module mappings::Tok2Lex

import List;
import String;
import types::Tok;
import types::Lex;

// Frankly, this should have been a part of the Rascal library
list[list[str]] split(str sep, list[str] xs)
{
	list[list[str]] res = [[]];
	yy = res[-1];
	for (str x <- xs)
		if (x == sep)
			res += [[]];
		else
			res[size(res)-1] = res[-1] + x;
	return res;
}

public Lex tok2lex(Tok p)
{
	xs = split("=",p);
	assert size(xs) == 2;
	return lexfundef(maptokens(xs[0]),maptokens(xs[1]));
}

list[TokToken] maptokens(list[str] ts) = [maptoken(t) | t <- ts];

TokToken maptoken(str s:/[a-z]+/) = alphanumeric(s);
TokToken maptoken(str n:/[0-9]+/) = numeric(toInt(n));
default TokToken maptoken(str z) = ssymbol(z);

test bool vtok2lex1() = tok2lex(types::Tok::example) == types::Lex::example;
