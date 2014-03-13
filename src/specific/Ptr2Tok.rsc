@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	The Ptr to Tok mapping is a form of limited unparsing related to Ptr to Tkl, just showing that
	layout-related tokens can also be filtered out at the stage of traversal, not later on.
	Conceptually, this is a variation on Ptr -> Tkl -> Tok.
}
module specific::Ptr2Tok

import ParseTree;
import types::Ptr;
import types::Tok;

Symbol disregardthis = \char-class([range(9,10),range(13,13),range(32,32)]) ;

public Tok ptr2tok(Ptr p)
{
	Tok ts = [];
	top-down visit(p)
	{
		case t:appl(prod(Symbol name,[Symbol x],_), _) :
			if ((\char-class(_) := x || conditional(iter(\char-class(_)),_) := x) && x != disregardthis)
				ts += unparse(t);
	}
	return ts;
}

test bool vptr2tok1() = ptr2tok(types::Ptr::example) == types::Tok::example;
