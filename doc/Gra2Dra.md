## [Gra2Dra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Dra.rsc)

The Gra to Dra mapping assigns coordinates to all elements it can find in the model.
To optimise and simplify the code, we do it in stages: first position them, and then recalculate
character offsets from the beginning of the canvas.

```
module mappings::Gra2Dra

import IO;
import String;
import types::Gra;
import types::Dra;
import lib::LocFactory;

Dra gra2dra(gramodel(GraElement root)) = balance(drapicture(grarender(root,1,0)));
list[DraElement] grarender(graempty(), int line, int col) = [];
list[DraElement] grarender(grabox(GraType t, GraLabel label), int line, int col)
{
    loc where = newloc(size(label) + 2, line, col);
    switch(t)
    {
        case grasquare(): return [drasquare(label,where)];
        case graround(): return [draround(label,where)];
        case gracurly(): return [dracurly(label,where)];
    }
}

list[DraElement] grarender(graprefix(GraElement e1, GraElement e2), int line, int col)
{
    list[DraElement] res = grarender(e1,line,col);
    res += grarender(e2, res[-1].where.end.line+1, col+1);
    return res;
}
list[DraElement] grarender(grapostfix(GraElement e1, GraElement e2), int line, int col)
{
    list[DraElement] res = grarender(e2,cx+1,line,col+1);
    res += grarender(e1, res[-1].where.end.line+1, col);
    return res;
}
// empty separator => no extra indentation
list[DraElement] grarender(grainfix(graempty(), list[GraElement] es2), int line, int col)
{
    list[DraElement] res = [];
    for (GraElement e <- es2)
    {
        res += grarender(e,line,col);
        line = res[-1].where.end.line+1;
    }
    return res;
}
list[DraElement] grarender(grainfix(GraElement e1, []), _, _) = [];
list[DraElement] grarender(grainfix(GraElement e1, list[GraElement] es2), int line, int col)
{
    list[DraElement] res = grarender(es2[0],line,col+1);
    for (GraElement e <- es2[1..])
    {
        line = res[-1].where.end.line+1;
        res += grarender(e1,line,col);
        line = res[-1].where.end.line+1;
        res += grarender(e,res[-1].where.end.line+1,col+1);
    }
    return res;
}

list[DraElement] grarender(graconfix(GraType t, GraElement e), int line, int col)
{
    int ofst = (grainfix(_,_):=e)?0:1;
    list[DraElement] res = [gratype2left(t,line,col)];
    res += grarender(e,line+1,col+ofst);
    line = res[-1].where.end.line+1;
    res += gratype2right(t,line,col);
    return res;
}

DraElement onesymb(str s, int line, int col) = drasymbol(s, newloc(1, line, col));
DraElement gratype2left(grasquare(), int line, int col) = onesymb("[",line,col);
DraElement gratype2left(graround(), int line, int col)  = onesymb("(",line,col);
DraElement gratype2left(gracurly(), int line, int col)  = onesymb("{",line,col);
DraElement gratype2right(grasquare(), int line, int col)= onesymb("]",line,col);
DraElement gratype2right(graround(), int line, int col) = onesymb(")",line,col);
DraElement gratype2right(gracurly(), int line, int col) = onesymb("}",line,col);

list[DraElement] grarender(graarrow(), int line, int col) = [onesymb("→",line,col)];

default list[DraElement] grarender(GraElement e, int line, int col)
{
    println("Cannot render <e>");
}

test bool vgra2dra1() = gra2dra(types::Gra::example) == types::Dra::example;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Gra.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Dra.png)

### See also:
* [types::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
* [visualise::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Gra.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)
* [types::Dra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Dra.rsc)
* [visualise::Dra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Dra.rsc)
