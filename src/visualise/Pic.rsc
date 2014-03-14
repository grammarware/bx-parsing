@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Pic

import types::Pic;
import vis::Figure;
import vis::Render;

public Figure visualised(Pic p) = vcat([box(text("Picture")),box(text(p), gap(5), resizable(false))], resizable(false), std(font("Monaco")));
public void visualise(Pic p) = render(visualised(p));

void vispic1() = visualise(types::Pic::example);

