@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	Concatenation of a list of strings to a string is a library function, see
	[intercalate()](http://tutor.rascal-mpl.org/Rascal/Libraries/Prelude/List/intercalate/intercalate.html).
}
module mappings::Tkl2Str

import List;
import types::Tkl;
import types::Str;

public Str tkl2str(Tkl p) = intercalate("",p);

test bool vtkl2str1() = tkl2str(types::Tkl::example) == types::Str::example;
