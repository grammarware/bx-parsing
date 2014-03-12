@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Dra

import IO;
import List;
import String;
import types::Pic;

data Dra = drapicture(list[DraElement] es);
data DraElement
	= drasquare(str label, loc where)
	| draround(str label, loc where)
	| dracurly(str label, loc where)
	| drasymbol(str label, loc where)
	;

Dra example = drapicture([
							dracurly("f",    |stdin:///|(0,3,<1,0>,<1,3>)),
							drasymbol("(",   |stdin:///|(5,1,<2,1>,<2,2>)),
							drasquare("arg", |stdin:///|(9,5,<3,2>,<3,7>)),
							drasymbol("→",   |stdin:///|(16,1,<4,1>,<4,2>)),
							dracurly("+",    |stdin:///|(20,3,<5,2>,<5,5>)),
							drasquare("arg", |stdin:///|(27,5,<6,3>,<6,8>)),
							draround("1",    |stdin:///|(36,3,<7,3>,<7,6>)),
							drasymbol(")",   |stdin:///|(41,1,<8,1>,<8,2>))
						]);

str dra2pic(Dra d)
{
	list[str] res = [];
	for (DraElement e <- d.es)
	{
		assert e.where.begin.line == e.where.end.line;
		if (drasymbol(_,_) !:= e)
			assert e.where.length == size(e.label)+2;
		else
			assert e.where.length == size(e.label);
		while (e.where.begin.line >= size(res)) res += [""];
		while (e.where.begin.column > size(res[e.where.begin.line])) res[e.where.begin.line] += "\t";
		res[e.where.begin.line][e.where.begin.column..e.where.end.column] = bracketit(e);
	}
	return intercalate("\n",tail(res));
}

str bracketit(drasquare(str label, loc _)) = "[<label>]";
str bracketit( draround(str label, loc _)) = "(<label>)";
str bracketit( dracurly(str label, loc _)) = "{<label>}";
str bracketit(drasymbol(str label, loc _)) = label;
default str bracketit(DraElement e) = "ERROR";

test bool vdra1() = dra2pic(example) == types::Pic::example;
