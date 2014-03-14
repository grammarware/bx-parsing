@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Lex

import types::Lex;
import vis::Figure;
import vis::Render;
import List;

Figure vistoken(numeric(int n), int n) = ellipse(text("<n>"), gap(5), id("token<n>"));
Figure vistoken(alphanumeric(str a), int n) = box(text(a), gap(5), id("token<n>"));
Figure vistoken(ssymbol(str s), int n) = box(text("\'s\'", fontColor("white")), gap(5), fillColor("DimGray"), id("token<n>"));

public void visualise(Lex p) = render(visualised(p));
public Figure visualised(Lex p) 
	= tree(
		box(text("lexfundef"), id("lexfundef"), gap(5)),
	[
		box(hcat([vistoken(p.left[i], i) | int i <- [0..size(p.left)]], gap(10), resizable(false)), id("left"), gap(10)),
		box(hcat([vistoken(p.right[i], size(p.left)+i) | int i <- [0..size(p.right)]], gap(10), resizable(false)), id("right"), gap(10))
	],
	gap(40), std(font("Monaco")));

void vislex1() = visualise(types::Lex::example);