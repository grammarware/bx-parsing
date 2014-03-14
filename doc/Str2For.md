## [Str2For](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Str2For.rsc)

TBD

```
module mappings::Str2For

import ParseTree;
import types::Str;
import types::For;

For str2for(Str p) = parse(#For,p);

test bool vstr2for1() = validate(str2for(types::Str::example));
test bool vstr2for2() = validate(str2for(types::Str::defexample));
```

### See also:
* [types::Str](https://github.com/grammarware/bx-parsing/blob/master/src/types/Str.rsc)
* [visualise::Str](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Str.rsc)
* [specific::Str2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc)
* [types::For](https://github.com/grammarware/bx-parsing/blob/master/src/types/For.rsc)
* [visualise::For](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/For.rsc)
