## [For2Str](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/For2Str.rsc)

TBD

```
module mappings::For2Str

import ParseTree;
import types::For;
import types::Str;

public Str for2str(For p) = unparse(p);

test bool vfor2str1() = for2str(types::For::example) == types::Str::example;
 
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/For.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Str.png)

### See also:
* [types::For](https://github.com/grammarware/bx-parsing/blob/master/src/types/For.rsc)
* [visualise::For](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/For.rsc)
* [types::Str](https://github.com/grammarware/bx-parsing/blob/master/src/types/Str.rsc)
* [visualise::Str](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Str.rsc)
* [specific::Str2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc)
