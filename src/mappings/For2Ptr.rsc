@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::For2Ptr

import ParseTree;
import types::For;
import types::Ptr;

// NB: a workaround via Str since manual low-level disambiguation is too ugly in Rascal
public Ptr for2ptr(For p) = parse(#Ptr,"<p>");

test bool vfor2ptr1() = for2ptr(types::For::example) == types::Ptr::example;
