## [Tok](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tok.rsc)

Tok models a program as a list of its tokens, disregarding layout information (whitespace,
indentation, comments, line numbers, etc). A definition of a token can vary, in our case
study we let Tok to rely on the same token definition as Tkl, but with more limitations
(e.g., cannot be empty modulo layout data).

Preserving layout information — in particular, comments — is crucial in some software
language manipulation methods. For them Tok representation is not useful.

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Tok.png)

```
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
```

