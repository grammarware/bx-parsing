@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module types::Gra

import List;
import String;
import types::Pic;

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

str gra2pic(Gra g) = intercalate("\n",[s | str s <- split("\n",gra2pic(g.root)), trim(s) != ""]);
// GraElement
str gra2pic(graempty()) = "";
str gra2pic(graarrow()) = "→";
str gra2pic(grabox(grasquare(), GraLabel label)) = "[<label>]";
str gra2pic(grabox(graround(), GraLabel label)) = "(<label>)";
str gra2pic(grabox(gracurly(), GraLabel label)) = "{<label>}";
str gra2pic(graprefix(GraElement e1, GraElement e2)) =
	"<gra2pic(e1)>
	'	<gra2pic(e2)>";
str gra2pic(grapostfix(GraElement e1, GraElement e2)) =
	"	<gra2pic(e2)>
	'<gra2pic(e1)>";
str gra2pic(grainfix(GraElement e1, [])) = "";
str gra2pic(grainfix(graempty(), list[GraElement] es2)) =
	"
	'<for(GraElement e2 <- es2){>
	'<gra2pic(e2)><}>";
str gra2pic(grainfix(GraElement e1, list[GraElement] es2)) =
	"
	'	<gra2pic(es2[0])><for(GraElement e2 <- tail(es2)){>
	'<gra2pic(e1)>
	'	<gra2pic(e2)><}>";
str gra2pic(graconfix(GraType t, e:grainfix(_,_))) =
	"
	'<gratype2left(t)>
	'<gra2pic(e)>
	'<gratype2right(t)>";
str gra2pic(graconfix(GraType t, GraElement e)) =
	"
	'<gratype2left(t)>
	'	<gra2pic(e)>
	'<gratype2right(t)>";

str gratype2left(grasquare()) = "[";
str gratype2left(graround()) = "(";
str gratype2left(gracurly()) = "{";
str gratype2right(grasquare()) = "]";
str gratype2right(graround()) = ")";
str gratype2right(gracurly()) = "}";

test bool vgra1() = gra2pic(example) == types::Pic::example;
