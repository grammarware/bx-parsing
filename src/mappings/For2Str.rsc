@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	TBD
}
module mappings::For2Str

import ParseTree;
import types::For;
import types::Str;

public Str for2str(For p) = unparse(p);

test bool vfor2str1() = for2str(types::For::example) == types::Str::example;
 