@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Cst2Tok

import ParseTree;
import types::Cst;
import types::Tok;

public Tok cst2tok(Cst p)
{
	Tok ts = [];
	// Find layout
	set[Symbol] black = {guilty | /prod(layouts(_),[\iter-star(Symbol guilty)],_) := p};
	top-down visit(p)
	{
		case t:appl(prod(Symbol name,_,_), _) :
			if ((lex(_) := name || lit(_) := name) && name notin black)
				ts += unparse(t);
	}
	return ts;
}

test bool vcst2tok1() = cst2tok(types::Cst::example) == types::Tok::example;
