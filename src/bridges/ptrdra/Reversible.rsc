@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	The reversible function variant of Ptr-Dra bridge.
	L = Ptr (parse tree with textual layout info); R = Dra (drawing with graphical layout info)
}
module bridges::ptrdra::Reversible

import types::Ptr;
import types::Fig;
import types::Ast;
import types::Dra;
import mappings::Dra2Pic;
import mappings::Ast2Fig;
import mappings::Fig2Ast;
import mappings::MultiStep;

import Exception;
data RuntimeException = UpdateException();

// L = Ptr; R = Dra
Dra ptr2dra(Ptr L) throws UpdateException
{
	Ast ast = ptr2ast(L);
	if (!validate(ast)) throw UpdateException();
	Fig fig = ast2fig(ast);
	if (!validate(fig)) throw UpdateException();
	Dra dra = fig2dra(fig);
	if (!validate(dra)) throw UpdateException(); 
	return dra;
}

Ptr dra2ptr(Dra R) throws UpdateException
{
	Fig fig = dra2fig(R);
	if (!validate(fig)) throw UpdateException();
	Ast ast = fig2ast(fig);
	if (!validate(ast)) throw UpdateException();
	ptr = ast2ptr(ast);
	if (!validate(ptr)) throw UpdateException(); 
	return ptr;
}

test bool vrev1() = dra2ptr(types::Dra::example) == types::Ptr::defexample;
test bool vrev2() = ptr2dra(types::Ptr::example) == types::Dra::example;
