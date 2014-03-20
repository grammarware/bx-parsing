## [Dra2Gra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Dra2Gra.rsc)

In this mapping we make some assumptions about the structure of the drawing: for example,
we expect parenthesis to match. Parentheses in our “textual picture” correspond to box
containers in pixel visualisations, and the parenthesis matching thus corresponds to checking
whether other elements fit inside the box or are placed outside it.

```
module mappings::Dra2Gra

import visualise::Gra;
import types::Dra;
import types::Gra;
import List;

// For the sake of easy testing
import types::Fig;
import mappings::Fig2Gra;
import mappings::Gra2Dra;

public Gra dra2gra(Dra d) = matchdra(d.es);

Gra matchdra([
        dracurly(str label, _),
        drasymbol("(", _),
        *A,
        drasymbol("→", _),
        *B,
        drasymbol(")", _)
    ]) =
    gramodel(graprefix(grabox(gracurly(),label),graconfix(graround(),grainfix(graarrow(),[matchargs(A), matchbody(B)]))));

GraElement matchargs([drasquare(str label, _)]) = grabox(grasquare(),label);
default GraElement matchargs(list[DraElement] As) = grainfix(graempty(),[*matchargs([a]) | DraElement a <- As]);

GraElement matchbody([drasquare(str label, _)]) = grabox(grasquare(),label);
GraElement matchbody([draround(str label, _)]) = grabox(graround(),label);
default GraElement matchbody(list[DraElement] Es)
{
    if (size(Es)<3) return graempty();
    if (dracurly(str label, _) !:= Es[0]) return graempty();
    border = 1+findsplit(Es[1..]);
    return 
        graprefix(grabox(gracurly(),Es[0].label),grainfix(graempty(),
            [matchbody(Es[1..border]),matchbody(Es[border..])]
        ));
}

int findsplit([drasquare(_,_), *L1]) = 1;
int findsplit([draround(_,_), *L2]) = 1;
int findsplit([dracurly(_,_), *L3]) = 1+findsplit(L3)+findsplit(L3[findsplit(L3)..]); 

// id
Gra ex1gra = fig2gra(figfunctionmodel("f",["x"],figvariable("x")));
test bool vdra2gra1m() = dra2gra(gra2dra(ex1gra)) == ex1gra;

// const
Gra ex2gra = fig2gra(figfunctionmodel("f",["y"],figliteral(42)));
test bool vdra2gra2m() = dra2gra(gra2dra(ex2gra)) == ex2gra;

// add
Gra ex3gra = fig2gra(figfunctionmodel("f",["x","y"],figbinary("+",figvariable("x"),figvariable("y"))));
test bool vdra2gra3m() = dra2gra(gra2dra(ex3gra)) == ex3gra;

// a*a+b
Gra ex4gra = fig2gra(figfunctionmodel("f",["a","b"],figbinary("+", figbinary("*",figvariable("a"),figvariable("a")), figvariable("b"))));
test bool vdra2gra4m() = dra2gra(gra2dra(ex4gra)) == ex4gra;

// (10+a)*a+b
Gra ex5gra = fig2gra(figfunctionmodel("f",["a","b"],figbinary("+", figbinary("*", figbinary("+",figliteral(10),figvariable("a")), figvariable("a")), figvariable("b")) ));
test bool vdra2gra5m() = dra2gra(gra2dra(ex5gra)) == ex5gra;

test bool vdra2gra1() = dra2gra(types::Dra::example) == types::Gra::example;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Dra.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Gra.png)

### See also:
* [types::Dra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Dra.rsc)
* [visualise::Dra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Dra.rsc)
* [types::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
* [visualise::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Gra.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)
