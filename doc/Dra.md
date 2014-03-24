## [Dra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Dra.rsc)

Dra is a low level drawing specification in terms of displayed entities and their
coordinates. Since in the case study we opted for textual graphics, the coordinates
are modelled by the Rascal
[location](http://tutor.rascal-mpl.org/Rascal/Expressions/Values/Location/Location.html)
type. This type has been designed to model locations in the source code, so we stretch it
only slightly to mdoel locations on our textual canvas.

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Dra.png)

```
module types::Dra

data Dra = drapicture(DraElements es);
alias DraElements = list[DraElement];
data DraElement
    = drasquare(str label, loc where)
    | draround(str label, loc where)
    | dracurly(str label, loc where)
    | drasymbol(str label, loc where)
    ;

Dra example = drapicture
    ([
        dracurly("f",    |stdin:///|(0,3,<1,0>,<1,3>)),
        drasymbol("(",   |stdin:///|(5,1,<2,1>,<2,2>)),
        drasquare("arg", |stdin:///|(9,5,<3,2>,<3,7>)),
        drasymbol("→",   |stdin:///|(16,1,<4,1>,<4,2>)),
        dracurly("+",    |stdin:///|(20,3,<5,2>,<5,5>)),
        drasquare("arg", |stdin:///|(27,5,<6,3>,<6,8>)),
        draround("1",    |stdin:///|(36,3,<7,3>,<7,6>)),
        drasymbol(")",   |stdin:///|(41,1,<8,1>,<8,2>))
    ]);
// Basically everywhere two tabs instead of one
Dra exedited = drapicture
    ([
        dracurly("f",    |stdin:///|(0,3,<1,0>,<1,3>)),
        drasymbol("(",   |stdin:///|(6,1,<2,2>,<2,3>)),
        drasquare("arg", |stdin:///|(12,5,<3,4>,<3,9>)),
        drasymbol("→",   |stdin:///|(20,1,<4,2>,<4,3>)),
        dracurly("+",    |stdin:///|(26,3,<5,4>,<5,7>)),
        drasquare("arg", |stdin:///|(36,5,<6,6>,<6,11>)),
        draround("1",    |stdin:///|(48,3,<7,6>,<7,9>)),
        drasymbol(")",   |stdin:///|(54,1,<8,2>,<8,3>))
    ]);

public bool validate(Dra d) = 
    (true | it && e.where.length == e.where.end.column-e.where.begin.column | DraElement e <- d.es);

public Dra balance(Dra p)
{
    DraElements res = [];
    int cx = 0;
    for (e <- p.es)
    {
        e.where.offset = cx + e.where.begin.column;
        cx += e.where.end.column + 1;
        res += e;
    }
    return drapicture(res);
}

test bool vdra1() = validate(example);
test bool vdra2() = validate(exedited);
```

### See also:
* [mappings::Dra2Gra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Dra2Gra.rsc)
* [mappings::Dra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Dra2Pic.rsc)
* [mappings::Gra2Dra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Dra.rsc)
* [mappings::Pic2Dra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Pic2Dra.rsc)
* [visualise::Dra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Dra.rsc)
