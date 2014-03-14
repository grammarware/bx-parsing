@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Str

import types::Str;
import vis::Figure;
import vis::Render;
import String;

public Figure visualised(Str p) = box(text(p), gap(5), std(font("Monaco")), resizable(false));
public void visualise(Str p) = render(visualised(p));

void visstr1() = visualise(types::Str::example);
void visstr2() = visualise(types::Str::defexample);
