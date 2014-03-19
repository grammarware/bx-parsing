## [Gra](https://github.com/grammarware/bx-parsing/blob/master/src/types/Gra.rsc)

Gra is a metamodel-specific model of a picture, usually in the form of a diagram with
entities and relationships, perhaps of different kinds.

In our case study, we have boxes (atomic entities) and complex entities that know their
own notation (prefix, postfix, infix and confix). There is no information about their
positioning, but also no abstract understanding of what these boxes might mean.
For example, a model of a function relies on its prefix notation for the function name,
its confix notation around its definition and its infix notation to separate the signature
and the body.

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Gra.png)

```
module types::Gra

data Gra = gramodel(GraElement root);
data GraElement
    = graempty()
    | graarrow()
    | grabox(GraType t, GraLabel label)
    | graprefix(GraElement e1, GraElement e2)
    | grapostfix(GraElement e1, GraElement e2)
    | grainfix(GraElement e1, list[GraElement] es2)
    | graconfix(GraType t, GraElement e)
    ;
data GraType
    = grasquare()
    | graround()
    | gracurly()
    ;
alias GraLabel = str;

Gra example =
    gramodel(graprefix(grabox(gracurly(),"f"),
        graconfix(graround(),
            grainfix(graarrow(),[
                    grabox(grasquare(),"arg"),
                    graprefix(
                        grabox(gracurly(),"+"),
                        grainfix(graempty(),[grabox(grasquare(),"arg"),grabox(graround(),"1")])
    )]))));

public bool validate(Gra p)
    = /grabox(_,"") !:= p
    && /graprefix(graempty(), _) !:= p
    && /graprefix(_, graempty()) !:= p
    && /grapostfix(graempty(), _)!:= p
    && /grapostfix(_, graempty())!:= p
    && /graconfix(_, graempty()) !:= p
    ;

test bool vgra1() = validate(example);
```

### See also:
* [mappings::Cst2Gra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Cst2Gra.rsc)
* [mappings::Dra2Gra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Dra2Gra.rsc)
* [mappings::Fig2Gra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Fig2Gra.rsc)
* [mappings::Gra2Cst](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Cst.rsc)
* [mappings::Gra2Dra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Dra.rsc)
* [mappings::Gra2Fig](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Gra2Fig.rsc)
* [visualise::Gra](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Gra.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)
