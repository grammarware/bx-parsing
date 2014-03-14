@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Tkl

import types::Tkl;
import vis::Figure;
import vis::Render;
import String;
import List;

str maybequote(str s) = trim(s) == "" ? "\'<s>\'" : s ;

public void visualise(Tkl p)
	= render(graph(
	[box(text(maybequote(p[i-1])), id("token<i>"), gap(5)) | int i <- [size(p)..0]],
	[], hint("layered"), gap(10)));

void vistkl1() = visualise(types::Tkl::example);
void vistkl2() = visualise(types::Tkl::defexample);
