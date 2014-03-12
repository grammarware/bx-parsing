@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Tok2Tkl

import List;
import types::Tok;
import types::Tkl;

@doc{
	We add exactly one space between all tokens.
	This is very primitive pretty-printing.
}
public Tkl tok2tkl([]) = [];
public Tkl tok2tkl(Tok p)
	= p[0]
	+ [*[" ",t] | str t <- tail(p)];

test bool vtok2tkl1() = tok2tkl(types::Tok::example) != types::Tkl::example;
test bool vtok2tkl2()
	= tok2tkl(types::Tok::example)
	== ["f"," ","arg"," ","="," ","arg"," ","+"," ","1"," ",";"];
//                                              ^^^     ^^^
