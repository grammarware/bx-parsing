@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Dra

import types::Dra;
import vis::Figure;
import vis::Render;

Figure visualised(Dra p) = tree(box(text("Drawing")),[mapdrael(e) | e <- p.es], resizable(false), std(font("Monaco")), std(gap(5)), gap(20) );

Figure mapdrael(drasquare(str label, loc where)) = makesubtree("[...]", label, where);
Figure mapdrael( draround(str label, loc where)) = makesubtree("(...)", label, where);
Figure mapdrael( dracurly(str label, loc where)) = makesubtree("{...}", label, where);
Figure mapdrael(drasymbol(str label, loc where)) = makesubtree("", label, where);

Figure makesubtree(str top, str label, loc where)
	= tree(
		(top=="")?ellipse(size(5)):box(text(top)),
		[
			box(text("\'<label>\'")),
			box(text("<where.begin.line>:<where.begin.column>..<where.end.column>"))
		],gap(20)
	);

public void visualise(Dra p) = render(visualised(p));

void visdra1() = visualise(types::Dra::example);


