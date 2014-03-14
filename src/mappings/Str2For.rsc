@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	TBD
}
module mappings::Str2For

import ParseTree;
import types::Str;
import types::For;

For str2for(Str p) = parse(#For,p);

test bool vstr2for1() = validate(str2for(types::Str::example));
test bool vstr2for2() = validate(str2for(types::Str::defexample));
