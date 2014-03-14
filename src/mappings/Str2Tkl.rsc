@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
 DFA (deterministic final automaton) is used to tokenise the example.
 The knowledge about structure is hard-coded to it.
 For example, it puts subsequent letters and subsequent digits into one token,
 but makes a token boundary when letters change to digits and vice versa.
 It also treats nonalphanumeric symbols individually, which is unacceptable for language
 with tokens like == or ->
}
module mappings::Str2Tkl

import String;
import types::Str;
import types::Tkl;

public Tkl str2tkl(Str p)
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
		if (state == 1 && curchar == 1) curtoken += stringChar(c);
		elseif (state == 2 && curchar == 2) curtoken += stringChar(c);
		elseif (state == 3 && curchar == 3) curtoken += stringChar(c);
		else {if (curtoken!="") tokens += curtoken; curtoken = stringChar(c);}
		state = curchar;
	}
	if (curtoken!="") tokens += curtoken;
	return tokens;
}

test bool vstr2tkl1() = str2tkl(types::Str::example) == types::Tkl::example;
test bool vstr2tkl2() = str2tkl("f xxx = 100;") == ["f"," ","xxx"," ","="," ","100",";"];
