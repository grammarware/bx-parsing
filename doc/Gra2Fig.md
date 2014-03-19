## [Gra2Fig](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Fig.rsc)

module mappings::Gra2Fig

import types::Gra;
import types::Fig;
import String;

Fig gra2fig(gramodel(graprefix(grabox(gracurly(),str fname),
graconfix(graround(), grainfix(graarrow(),[ GraElement args, GraElement body ])))))
= figfunctionmodel(fname,mapargs(args),mapexpr(body));

FigArgs mapargs(grabox(grasquare(), str arg)) = [arg];
FigArgs mapargs(grainfix(graempty(), args)) = [arg | grabox(grasquare(), str arg) <- args];

FigExpr mapexpr(grabox(grasquare(), GraLabel label)) = figvariable(label);
FigExpr mapexpr(grabox(graround(), GraLabel label)) = figliteral(toInt(label));
FigExpr mapexpr(graprefix( grabox(gracurly(), str op), grainfix(graempty(),[GraElement e1, GraElement e2]) ))
= figbinary(op, mapexpr(e1), mapexpr(e2));

test bool vgra2fig1() = gra2fig(types::Gra::example) == types::Fig::example;

```

```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Gra.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Fig.png)

### See also:
* [types::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
* [visualise::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Gra.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)
* [types::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/types/Fig.rsc)
* [visualise::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Fig.rsc)
* [specific::Fig](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Fig.rsc)
