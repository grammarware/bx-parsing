## [Dra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Dra2Pic.rsc)

TBD

```
module mappings::Dra2Pic

import types::Dra;
import types::Pic;

import List;
import String;

public Pic dra2pic(Dra d)
{
    list[str] res = [];
    for (DraElement e <- d.es)
    {
        assert e.where.begin.line == e.where.end.line;
        if (drasymbol(_,_) !:= e)
            assert e.where.length == size(e.label)+2;
        else
            assert e.where.length == size(e.label);
        while (e.where.begin.line >= size(res)) res += [""];
        while (e.where.begin.column > size(res[e.where.begin.line])) res[e.where.begin.line] += "\t";
        res[e.where.begin.line][e.where.begin.column..e.where.end.column] = bracketit(e);
    }
    return intercalate("\n",tail(res));
}

str bracketit(drasquare(str label, loc _)) = "[<label>]";
str bracketit( draround(str label, loc _)) = "(<label>)";
str bracketit( dracurly(str label, loc _)) = "{<label>}";
str bracketit(drasymbol(str label, loc _)) = label;
default str bracketit(DraElement e) = "ERROR";

test bool vdra2pic1() = dra2pic(types::Dra::example) == types::Pic::example;
```

### See also:
* [types::Dra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Dra.rsc)
* [visualise::Dra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Dra.rsc)
* [types::Pic](https://github.com/grammarware/bx-parsing/blob/master/src/types/Pic.rsc)
* [visualise::Pic](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Pic.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)