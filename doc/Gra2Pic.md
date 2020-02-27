## [Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)

Instead of going from Gra to Dra and then to Pic, we utilise Rascal pretty-printing
functionality — see
[string comprehensions](http://tutor.rascal-mpl.org/Rascal/Expressions/Values/String/String.html)
— to make a much more reliable and human friendly printer.

All the low level computations on positioning our “boxes” are actually implicitly present
here since this is the semantics of the Rascal `'` modifier in string comprehensions.

```
module specific::Gra2Pic

import types::Gra;
import types::Pic;
import mappings::MultiStep;

import List;
import String;

private str NL = "
'";

public str gra2pic_r(Gra g) = intercalate(NL, [s | str s <- split(NL, gra2pic_r(g.root)), trim(s) != ""]);
// GraElement
str gra2pic_r(graempty()) = "";
str gra2pic_r(graarrow()) = "→";
str gra2pic_r(grabox(grasquare(), GraLabel label)) = "[<label>]";
str gra2pic_r(grabox(graround(), GraLabel label)) = "(<label>)";
str gra2pic_r(grabox(gracurly(), GraLabel label)) = "{<label>}";
str gra2pic_r(graprefix(GraElement e1, GraElement e2)) =
    "<gra2pic_r(e1)>
    '    <gra2pic_r(e2)>";
str gra2pic_r(grapostfix(GraElement e1, GraElement e2)) =
    "    <gra2pic_r(e2)>
    '<gra2pic_r(e1)>";
str gra2pic_r(grainfix(GraElement e1, [])) = "";
str gra2pic_r(grainfix(graempty(), list[GraElement] es2)) =
    "
    '<for(GraElement e2 <- es2){>
    '<gra2pic_r(e2)><}>";
str gra2pic_r(grainfix(GraElement e1, list[GraElement] es2)) =
    "
    '    <gra2pic_r(es2[0])><for(GraElement e2 <- tail(es2)){>
    '<gra2pic_r(e1)>
    '    <gra2pic_r(e2)><}>";
str gra2pic_r(graconfix(GraType t, e:grainfix(_,_))) =
    "
    '<gratype2left(t)>
    '<gra2pic_r(e)>
    '<gratype2right(t)>";
str gra2pic_r(graconfix(GraType t, GraElement e)) =
    "
    '<gratype2left(t)>
    '    <gra2pic_r(e)>
    '<gratype2right(t)>";

str gratype2left(grasquare()) = "[";
str gratype2left(graround()) = "(";
str gratype2left(gracurly()) = "{";
str gratype2right(grasquare()) = "]";
str gratype2right(graround()) = ")";
str gratype2right(gracurly()) = "}";

test bool xgra2pic1() = gra2pic_r(types::Gra::example) == types::Pic::example;
test bool xgra2pic2() = gra2pic_r(types::Gra::example) == gra2pic(types::Gra::example);
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Gra.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Pic.png)

### See also:
* [types::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
* [visualise::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Gra.rsc)
* [types::Pic](https://github.com/grammarware/bx-parsing/blob/master/src/types/Pic.rsc)
* [visualise::Pic](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Pic.rsc)
