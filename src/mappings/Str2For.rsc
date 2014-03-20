@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	Str to For is Rascal parsing, see
	[parse()](http://tutor.rascal-mpl.org/Rascal/Libraries/Prelude/ParseTree/parse/parse.html).
}
module mappings::Str2For

import ParseTree;
import types::Str;
import types::For;

For str2for(Str p) = parse(#For,p);

test bool vstr2for1() = validate(str2for(types::Str::example));
test bool vstr2for2() = validate(str2for(types::Str::defexample));
