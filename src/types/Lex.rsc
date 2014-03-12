@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Lex

import List;

data TokToken
	= numeric(int n)
	| alphanumeric(str a)
	| ssymbol(str s)
	;
data Lex = lexfundef(list[TokToken] left, list[TokToken] right);

bool isTokToken(numeric(int n)) = true;
bool isTokToken(alphanumeric(str a)) = /[a-z0-9]+/ := a;
bool isTokToken(ssymbol(str s)) = /[a-z0-9]+/ !:= s;
default bool isTokToken(TokToken t) = false;

bool isTokTokens(list[TokToken] ts) = (true | it && isTokToken(t) | t <- ts); 

public bool validate(Lex ls)
	= isTokTokens(ls.left)
	&& size(ls.left) == 2
	&& isTokTokens(ls.right)
	;

test bool vlex1() = validate(lexfundef(
						[alphanumeric("f"),alphanumeric("arg")],
						[alphanumeric("arg"),ssymbol("+"),numeric("1"),ssymbol(";")]));
test bool vlex2() = !validate(lexfundef(
						[alphanumeric("f")],
						[alphanumeric("arg"),ssymbol("+"),numeric("1"),ssymbol(";")]));
test bool vlex3() = !validate(lexfundef(
						[alphanumeric("f"),alphanumeric("!")],
						[alphanumeric("arg"),ssymbol("+"),numeric("1"),ssymbol(";")]));
test bool vlex4() = !validate(lexfundef(
						[alphanumeric("f"),alphanumeric("arg")],
						[alphanumeric("arg"),ssymbol("plus"),numeric("1"),ssymbol(";")]));
