## Ast

We consider Ast to be on the highest level of the structured data.
Usually at this level one finds abstract syntax definitions, language syntaxes
with fixed concrete representations, data models without graphical syntax,
algebraic data types, etc.

In the case study we model Ast by Rascal Algebraic Data Type, see
http://tutor.rascal-mpl.org/Rascal/Declarations/AlgebraicDataType/AlgebraicDataType.html

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Ast.png)

```
module types::Ast

import types::Tkl;

data Ast = astfundef(AstName name, AstArgs args, AstExpr body);
alias AstName = str;
alias AstArgs = list[AstArg];
alias AstArg = str;
data AstExpr
	= astvariable(AstName name)
	| astliteral(AstNumber number)
	| astbplus(AstExpr left, AstExpr right)
	| astbmul(AstExpr left, AstExpr right)
	;
alias AstNumber = int;

Ast example = astfundef("f",["arg"], astbplus(astvariable("arg"),astliteral(1)));
Ast tricky = astfundef("f",["x","y"], 
astbplus(
	astbmul(astvariable("x"),astvariable("y")),
	astbplus(
		astvariable("x"),
		astbmul(astvariable("y"), astliteral(5))
		))
);

@doc{Minimal static checking: all used variables must be listed among arguments. Also, variable names cannot be empty.}
public bool validate(Ast a)
	= (true | it && !isEmpty(n) && (n in a.args) | /astvariable(AstName n) <- a)
	;

test bool vast1() = validate(example);
test bool vast2() = !validate(astfundef("f",["arg"],astbplus(astvariable(""),astliteral(1))));
test bool vast3() = !validate(astfundef("f",["arg"],astbplus(astvariable("x"),astliteral(1))));
```

