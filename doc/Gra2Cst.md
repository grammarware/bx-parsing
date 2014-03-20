## [Gra2Cst](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Cst.rsc)

This Gra to Cst mapping is a little bit unconventional in the sense that it is not
usually considered due to the lack of tradition in bridging grammarware and modelware.

We have implemented this example in order to demonstrate implicit *lowering* of
[Fig2Ast](https://github.com/grammarware/bx-parsing/blob/master/doc/Fig2Ast.md)
serialisation. We would like to emphasize that the lowering is not explicit — there is
no call to `fig2ast()` here, but that call is a Type IV clone (a semantic equivalent) of
this code. The reason why these mappings often are programmed entirely is that some information
can be saved and propagated directly in the bidirectional case. For example, a graphical
model may visualise some syntactic sugar elements (like optional keywords) differently if that
suits the needs of the users.

```
module mappings::Gra2Cst

import types::Gra;
import types::Cst;
import lib::CstFactory;

public Cst gra2cst(gramodel(graprefix(grabox(gracurly(), GraLabel rootname),
        graconfix(graround(),grainfix(graarrow(),
            [GraElement args, GraElement body])))))
    = newCst(newCstLHS(newCstName("<rootname>"),mapargs(args)), newCstRHS(mapexpr(body)));

CstNameArgs mapargs(grabox(grasquare(), GraLabel label))
    = newCstNameArgs([newCstName("<label>")]);
CstNameArgs mapargs(grainfix(graempty(),list[GraElement] es))
    = newCstNameArgs([newCstName("<label>") | grabox(grasquare(), GraLabel label) <- es]);

CstExpr mapexpr(grabox(grasquare(), GraLabel name)) = newCstExpr(newCstAtom(newCstName("<name>")));
CstExpr mapexpr(grabox(graround(), GraLabel number)) = newCstExpr(newCstAtom(newCstNumber("<number>")));
CstExpr mapexpr(graprefix(grabox(gracurly(), str kind),grainfix(graempty(),[GraElement l, GraElement r])))
    = newCstExpr(mapexpr(l),kind,mapexpr(r));

test bool vgra2cst1() = gra2cst(types::Gra::example) == types::Cst::example;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Gra.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Cst.png)

### See also:
* [types::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
* [visualise::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Gra.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)
* [types::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc)
* [visualise::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Cst.rsc)
