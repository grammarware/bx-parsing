## [Gra2Cst](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Cst.rsc)

TBD

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

### See also:
* [types::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
* [visualise::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Gra.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)
* [types::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc)
* [visualise::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Cst.rsc)
