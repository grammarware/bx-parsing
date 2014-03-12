@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Str2Tok

import String;
import types::Str;
import types::Tok;

public Tok str2tok(Str p)
{
	 //1 - alpha, 2 - num, 3 - whitespace, 4 - smth
	int state = 0, curchar;
	str curtoken = "";
	list[str] tokens = [];
	for (int c <- chars(p))
	{
		if (/[a-z]/ := stringChar(c)) curchar = 1;
		elseif (/[0-9]/ := stringChar(c)) curchar = 2;
		elseif (/[\ \t\n\r]/ := stringChar(c)) curchar = 3;
		else curchar = 4;
		if (curchar == 3)
		{
			if (curtoken!="") tokens += curtoken;
			curtoken = "";
			continue;
		}
		if (state == 1 && curchar == 1) curtoken += stringChar(c);
		elseif (state == 2 && curchar == 2) curtoken += stringChar(c);
		else {if (curtoken!="") tokens += curtoken; curtoken = stringChar(c);}
		state = curchar;
	}
	if (curtoken!="") tokens += curtoken;
	return tokens;
}

test bool vstr2tok1() = str2tok(types::Str::example) == types::Tok::example;
test bool vstr2tok2() = str2tok("f\narg = arg\t+\t1;\r\n") == types::Tok::example;
