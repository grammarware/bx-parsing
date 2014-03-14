## Dra

Dra is a low level drawing specification in terms of displayed entities and their
coordinates. Since in the case study we opted for "textual graphics", the coordinates
are modelled by the Rascal location type, see
http://tutor.rascal-mpl.org/Rascal/Expressions/Values/Location/Location.html
This type has been designed to model locations in the source code, so we stretch it
only slightly to mdoel locations on our textual "canvas".

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Dra.png)

```
module types::Dra

data Dra = drapicture(list[DraElement] es);
data DraElement
	= drasquare(str label, loc where)
	| draround(str label, loc where)
	| dracurly(str label, loc where)
	| drasymbol(str label, loc where)
	;

Dra example = drapicture([
							dracurly("f",    |stdin:///|(0,3,<1,0>,<1,3>)),
							drasymbol("(",   |stdin:///|(5,1,<2,1>,<2,2>)),
							drasquare("arg", |stdin:///|(9,5,<3,2>,<3,7>)),
							drasymbol("→",   |stdin:///|(16,1,<4,1>,<4,2>)),
							dracurly("+",    |stdin:///|(20,3,<5,2>,<5,5>)),
							drasquare("arg", |stdin:///|(27,5,<6,3>,<6,8>)),
							draround("1",    |stdin:///|(36,3,<7,3>,<7,6>)),
							drasymbol(")",   |stdin:///|(41,1,<8,1>,<8,2>))
						]);

public bool validate(Dra d) = 
	(true | it && e.where.length == e.where.end.column-e.where.begin.column | DraElement e <- d.es);

test bool vdra1() = validate(example);
```

