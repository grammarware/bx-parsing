## [Pic2Dra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Pic2Dra.rsc)

In general, Pic2Dra uses image recognition techniques to “parse” a rasterised picture.
For out prototype, this means searching for elements in the textual picture, correctly
identifying them and assigning them proper coordinates.

```
module mappings::Pic2Dra

import types::Pic;
import types::Dra;
import String;

Dra pic2dra(Pic p)
{
    list[DraElement] es = [];
    int i = 1, cx = 0;
    for (str e <- split("\n",p))
    {
        es += mapline(e, i, cx);
        cx += es[i-1].where.end.column +1;
        i += 1;
    }
    return drapicture(es);
}

DraElement mapline(str e:/\{<w:.+>\}/, int no, int cx)
    = dracurly(w, |stdin:///|(cx+findFirst(e,"{"),size(w)+2,<no,findFirst(e,"{")>,<no,findLast(e,"}")+1>));
DraElement mapline(str e:/\[<w:.+>\]/, int no, int cx)
    = drasquare(w, |stdin:///|(cx+findFirst(e,"["),size(w)+2,<no,findFirst(e,"[")>,<no,findLast(e,"]")+1>));
DraElement mapline(str e:/\(<w:.+>\)/, int no, int cx)
    = draround(w, |stdin:///|(cx+findFirst(e,"("),size(w)+2,<no,findFirst(e,"(")>,<no,findLast(e,")")+1>));
default DraElement mapline(str e:/<w:\S+>/, int no, int cx)
    = drasymbol(w, |stdin:///|(cx+findFirst(e,w),size(w),<no,findFirst(e,w)>,<no,findFirst(e,w)+size(w)>));

test bool vpic2dra1() = pic2dra(types::Pic::example) == types::Dra::example;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Pic.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Dra.png)

### See also:
* [types::Pic](https://github.com/grammarware/bx-parsing/blob/master/src/types/Pic.rsc)
* [visualise::Pic](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Pic.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)
* [types::Dra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Dra.rsc)
* [visualise::Dra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Dra.rsc)
