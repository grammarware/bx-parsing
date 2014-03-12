@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Ptr2Tkl

import ParseTree;
import types::Ptr;
import types::Tkl;

public Tkl ptr2tkl(Ptr p)
{
	Tkl ts = [];
	top-down visit(p)
	{
		case t:appl(prod(Symbol name,[Symbol x],_), _) :
			if (\char-class(_) := x || conditional(iter(\char-class(_)),_) := x)
				ts += unparse(t);
	}
	return ts;
}

test bool vptr2tkl1() = ptr2tkl(types::Ptr::example) == types::Tkl::example;
