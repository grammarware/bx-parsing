@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Tkl

import types::Tkl;
import vis::Figure;
import vis::Render;
import String;

str maybequote(str s) = trim(s) == "" ? "\'<s>\'" : s ;

public void visualise(Tkl p) = render(visualised(p));
public Figure visualised(Tkl p)
	= hcat(
	[box(text(maybequote(s)), gap(5), resizable(false)) | str s <- p],
	gap(10), std(font("Monaco")), resizable(false));

void vistkl1() = visualise(types::Tkl::example);
void vistkl2() = visualise(types::Tkl::defexample);
