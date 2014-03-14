@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Gra

import types::Gra;
import vis::Figure;
import vis::Render;

//data Gra = gramodel(GraElement root);
//data GraElement
//	= graempty()
//	| graarrow()
//	| grabox(GraType t, GraLabel label)
//	| graprefix(GraElement e1, GraElement e2)
//	| grapostfix(GraElement e1, GraElement e2)
//	| grainfix(GraElement e1, list[GraElement] es2)
//	| graconfix(GraType t, GraElement e)
//	;
//data GraType
//	= grasquare()
//	| graround()
//	| gracurly()
//	;
//alias GraLabel = str;

Figure visualised(Gra p) = tree(box(text("GraphModel")),[mapgrael(p.root)], resizable(false), std(font("Monaco")), std(gap(5)), gap(20) );

Figure mapgrael(graempty()) = ellipse(size(5));
Figure mapgrael(graarrow()) = box(text("arrow"));
Figure mapgrael(grabox(GraType t, GraLabel label)) = tree(box(text("box")),[mapgratype(t),box(text("\'<label>\'"))],gap(20));
Figure mapgrael(graprefix(GraElement e1, GraElement e2)) = tree(box(text("prefix")),[mapgrael(e1),mapgrael(e2)],gap(20));
Figure mapgrael(grapostfix(GraElement e1, GraElement e2)) = tree(box(text("postfix")),[mapgrael(e1),mapgrael(e2)],gap(20));
Figure mapgrael(grainfix(GraElement e1, list[GraElement] es2)) = tree(box(text("infix")),[mapgrael(e1),tree(ellipse(),[mapgrael(e) | e <- es2],gap(20))],gap(20));
Figure mapgrael(graconfix(GraType t, GraElement e)) = tree(box(text("confix")),[mapgratype(t),mapgrael(e)],gap(20));

Figure mapgratype(grasquare()) = ellipse(text("[]"), fillColor("yellow"));
Figure mapgratype(graround()) = ellipse(text("()"), fillColor("yellow"));
Figure mapgratype(gracurly()) = ellipse(text("{}"), fillColor("yellow"));

public void visualise(Gra p) = render(visualised(p));

void visgra1() = visualise(types::Gra::example);


