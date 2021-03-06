@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	Fig is the highest level model in the graphical representation world. It abstracts away from
	details like position, colour and form, and focuses on the concepts.
	In our case study, Fig is an algebraic data type that distinguishes between variables and
	literals, and has binary expressions.
}
module types::Fig

data Fig = figfunctionmodel(FigName name, FigArgs args, FigExpr body);
alias FigName = str;
alias FigArgs = list[FigArg];
alias FigArg = str;
data FigExpr
	= figvariable(FigName name)
	| figliteral(FigNumber number)
	| figbinary(FigName op, FigExpr left, FigExpr right)
	;
alias FigNumber = int;

Fig example = figfunctionmodel("f",["arg"],figbinary("+",figvariable("arg"),figliteral(1)));

public bool validate(Fig f) = /figvariable("") !:= f;

test bool tfig1() = validate(example);