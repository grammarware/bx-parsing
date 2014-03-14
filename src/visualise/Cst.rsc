@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Cst

import types::Cst;
import vis::ParseTree;

public void visualise(Cst p) = renderParsetree(p);

test bool vCst1() = validate(example);

void viscst1() = visualise(types::Cst::example);
void viscst2() = visualise(types::Cst::tricky);
