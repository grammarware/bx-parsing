@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Str2Tok

import mappings::Str2Tkl;
import mappings::Tkl2Tok;
import types::Str;
import types::Tok;

public Tok str2tok(Str p) = tkl2tok(str2tkl(p));

test bool vstr2tok1() = str2tok(types::Str::example) == types::Tok::example;
test bool vstr2tok2() = str2tok("f\narg = arg\t+\t1;\r\n") == types::Tok::example;
