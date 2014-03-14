## [Str](https://github.com/grammarware/bx-parsing/blob/master/src/types/Str.rsc)

Str is a string, the simplest possible representation of a textual program.

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Str.png)

```
module types::Str

alias Str = str;

Str example = "f arg = arg +1;";
Str defexample = "f arg = arg + 1 ;";

public bool validate(Str s) = true;

test bool vstr1() = validate(example);
test bool vstr2() = validate(defexample);
```

### See also:
* [mappings::For2Str](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/For2Str.rsc)
* [mappings::Str2For](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Str2For.rsc)
* [mappings::Str2Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Str2Tkl.rsc)
* [mappings::Tkl2Str](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tkl2Str.rsc)
* [visualise::Str](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Str.rsc)
* [specific::Str2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc)
