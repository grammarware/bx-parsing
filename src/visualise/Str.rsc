@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Str

import types::Str;
import vis::Figure;
import vis::Render;
import String;

public void visualise(Str p) = render(graph([box(text(p), id("Str"), gap(5))], [], hint("layered"), gap(100)));

void visstr1() = visualise(types::Str::example);
void visstr2() = visualise(types::Str::defexample);
