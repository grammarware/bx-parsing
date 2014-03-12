@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
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

Gra example = gramodel(graprefix(grabox(gracurly(),"f"),
					graconfix(graround(),
						grainfix(graarrow(),
							[
								grabox(grasquare(),"arg"),
								graprefix(
									grabox(gracurly(),"+"),
										grainfix(graempty(),[grabox(grasquare(),"arg"),grabox(graround(),"1")])
								)
							]
						)
					)
				));

public bool validate(Gra p)
	= /grabox(_,"") !:= p
	&& /graprefix(graempty(), _) !:= p
	&& /graprefix(_, graempty()) !:= p
	;

test bool vgra1() = validate(example);
