## Str

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

