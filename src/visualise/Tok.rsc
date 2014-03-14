@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Tok

import types::Tok;
import vis::Figure;
import vis::Render;
import String;
import List;

public void visualise(Tok p)
	= render(graph(
	[box(text(p[i-1]), id("token<i>"), gap(5)) | int i <- [size(p)..0]],
	[], hint("layered"), gap(10)));

void vistok1() = visualise(types::Tok::example);
void vistok2() = visualise(types::Tok::defexample);
