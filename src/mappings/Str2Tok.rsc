@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Str2Tok

import String;
import mappings::Str2Tkl;
import types::Str;
import types::Tok;
import types::Tkl;

public Tok str2tok(Str p)
{
	Tkl ts = str2tkl(p);
	return [t | str t <- str2tkl(p), trim(t) != ""]; 
}

test bool vstr2tok1() = str2tok(types::Str::example) == types::Tok::example;
test bool vstr2tok2() = str2tok("f\narg = arg\t+\t1;\r\n") == types::Tok::example;
