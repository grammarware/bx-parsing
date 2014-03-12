@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::Tkl2Tok

import String;
import types::Tok;
import types::Tkl;

@doc{
	We implicitly reuse the Rascal definition of whitespace by using the library function
	trim()
	http://tutor.rascal-mpl.org/Rascal/Libraries/Prelude/String/trim/trim.html
}
public Tok tkl2tok(Tkl p) = [t | str t <- p, trim(t) != ""];

test bool vtkl2tok1() = tkl2tok(types::Tkl::example) == types::Tok::example;
test bool vtkl2tok2() = tkl2tok(["f","\n","xxx"," ","=","\t\r\n\t","100",";"]) == ["f","xxx","=","100",";"];
