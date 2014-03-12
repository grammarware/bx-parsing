@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Str

alias Str = str;

Str example = "f arg = arg +1;";
Str defexample = "f arg = arg + 1 ;";

public bool validate(Str s) = true;

test bool vstr1() = validate(example);
