@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Tkl

alias Tkl = list[str];

bool isEmpty(str s) = s == ""; 

public bool validate(Tkl ss) = (true | it && !isEmpty(s) | s <- ss);

test bool vtkl1() =  validate(["f"," ","arg"," ","="," ","arg"," ","+","1",";"]);
test bool vtkl2() = !validate(["f"," ","arg"," ","="," ","arg"," ","+","","1",";"]);
