@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
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
