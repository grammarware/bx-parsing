@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Tok

import String;
import types::Tkl;

alias Tok = list[str];

Tok example = ["f","arg","=","arg","+","1",";"];

bool isToken(str s) = !types::Tkl::isEmpty(trim(s)); 

public bool validate(Tok ss) = (true | it && isToken(s) | s <- ss);

test bool vtok1() = validate(example);
test bool vtok2() = !validate(["f"," ","arg"," ","="," ","arg"," ","+","1",";"]);
test bool vtok3() = !validate(["f"," ","arg"," ","="," ","arg"," ","+","","1",";"]);
