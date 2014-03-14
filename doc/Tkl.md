## [Tkl](https://github.com/grammarware/bx-parsing/blob/master/src/types/Tkl.rsc)

Tkl models a program as a list of its tokens. A definition of a token can vary, in our case
study we consider alphabetical and numerical literals to be treated as separate tokens
(i.e., several consequent letters or several consequent digits form a single token),
same behaviour is used for whitespace, and otherwise token boundaries are switches from
characters of one type (letters, digits, spaces) to characters of another.

One of the consequences is that names like "var1" are disallowed (or rather split up in
several tokens, which can be glued together later on). This may not be universally
desirable for all software languages.

Some language workbenches have one fixed tokeniser, which means that Tkl and Str are
bijectively related and undistinguishable. It also means variations of concrete syntax
are limited.

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Tkl.png)

```
module types::Tkl

alias Tkl = list[str];

Tkl example = ["f"," ","arg"," ","="," ","arg"," ","+","1",";"];
Tkl defexample = ["f"," ","arg"," ","="," ","arg"," ","+"," ","1"," ",";"];

bool isEmpty(str s) = s == ""; 

public bool validate(Tkl ss) = (true | it && !isEmpty(s) | s <- ss);

test bool vtkl1() =  validate(example);
test bool vtkl2() = !validate(["f"," ","arg"," ","="," ","arg"," ","+","","1",";"]);
test bool vtkl3() =  validate(defexample);
```

