## [Tkl2Str](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tkl2Str.rsc)

Concatenation of a list of strings to a string is a library function.

```
module mappings::Tkl2Str

import List;
import types::Tkl;
import types::Str;

public Str tkl2str(Tkl p) = intercalate("",p);

test bool vtkl2str1() = tkl2str(types::Tkl::example) == types::Str::example;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Tkl.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Str.png)

### See also:
* [types::Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tkl.rsc)
* [visualise::Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Tkl.rsc)
* [types::Str](https://github.com/grammarware/bx-parsing/blob/master/src/types/Str.rsc)
* [visualise::Str](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Str.rsc)
* [specific::Str2Lex](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Str2Lex.rsc)
