@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Tok

import types::Tok;
import vis::Figure;
import vis::Render;

public void visualise(Tok p)
	= render(hcat(
	[box(text(s), gap(5), resizable(false)) | str s <- p],
	gap(10), resizable(false)));

void vistok1() = visualise(types::Tok::example);
void vistok2() = visualise(types::Tok::defexample);
