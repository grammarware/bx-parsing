@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Str

alias Str = str;

public bool validate(Str s) = true;

test bool vstr1() = validate("f arg = arg +1;");
