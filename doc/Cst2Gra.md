## [Cst2Gra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Gra.rsc)

Although this mapping rarely occurs in practice, it is easily implementable, as demonstrated in the
mapping below. The whole “layer” of Tok - Cst - Gra exists because it is a “sweet spot” between being
too abstract to retain technically important low level information (and thus have multiple implementation
strategies, see the note on Ast to Fig code) and being too concrete (and thus too committed to a physical
representation, as it is impossible to map Str to Pic without recognising some of it structure).

Hence, mapping a hierarchical tree-like model of a text to a hierarchical tree-like model of an diagram
is easy.

```
module mappings::Cst2Gra

import List;
import types::Cst;
import types::Gra;

public Gra cst2gra(Cst p)
    = gramodel(graprefix(grabox(gracurly(),"<p.lhs.f>"),
        graconfix(graround(),grainfix(graarrow(),[
            maybewrap([grabox(grasquare(),"<n>") | /CstName n <- p.rhs.args]),
            mapexpr(p.rhs.rhs)]))));

GraElement maybewrap([GraElement n]) = n;
GraElement maybewrap(list[GraElement] ns) = grainfix(graempty(),es); 

GraElement mapexpr((CstExpr)`<CstAtom a>`) = mapatom(a);
GraElement mapexpr((CstExpr)`<CstExpr l>*<CstExpr r>`)
    = graprefix(grabox(gracurly(),"*"),grainfix(graempty(),[mapexpr(l),mapexpr(r)]));
GraElement mapexpr((CstExpr)`<CstExpr l>+<CstExpr r>`)
    = graprefix(grabox(gracurly(),"+"),grainfix(graempty(),[mapexpr(l),mapexpr(r)]));

GraElement mapatom((CstAtom)`<CstName name>`) = grabox(grasquare(),"<name>");
GraElement mapatom((CstAtom)`<CstNumber number>`) = grabox(graround(),"<number>");
        
test bool vcst2gra1() = cst2gra(types::Cst::example) == types::Gra::example;
```

### Input

![Input](https://github.com/grammarware/bx-parsing/raw/master/img/Cst.png)

### Output

![Output](https://github.com/grammarware/bx-parsing/raw/master/img/Gra.png)

### See also:
* [types::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/types/Cst.rsc)
* [visualise::Cst](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Cst.rsc)
* [types::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)
* [visualise::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Gra.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)
