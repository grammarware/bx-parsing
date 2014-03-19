## [Tkl2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Tkl2Tok.rsc)

We implicitly reuse the Rascal definition of whitespace by using the library function
[trim()](http://tutor.rascal-mpl.org/Rascal/Libraries/Prelude/String/trim/trim.html).

```
module mappings::Tkl2Tok

import String;
import types::Tok;
import types::Tkl;

public Tok tkl2tok(Tkl p) = [t | str t <- p, trim(t) != ""];

test bool vtkl2tok1() = tkl2tok(types::Tkl::example) == types::Tok::example;
test bool vtkl2tok2() = tkl2tok(["f","\n","xxx"," ","=","\t\r\n\t","100",";"]) == ["f","xxx","=","100",";"];
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Tkl.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Tok.png)

### See also:
* [types::Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tkl.rsc)
* [visualise::Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Tkl.rsc)
* [types::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tok.rsc)
* [visualise::Tok](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Tok.rsc)
* [specific::Ptr2Tok](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Ptr2Tok.rsc)
