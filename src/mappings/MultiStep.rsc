@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module mappings::MultiStep

import mappings::Str2Tkl;
import mappings::Tkl2Str;
import mappings::Tkl2Tok;
import mappings::Tok2Tkl;
import mappings::Tok2Lex;
import mappings::Lex2Tok;
import mappings::Gra2Dra;
import mappings::Dra2Pic;
import types::Str;
import types::Tkl;
import types::Tok;
import types::Lex;
import types::Pic;
import types::Dra;
import types::Gra;
import types::Fig;

public Tok str2tok(Str p) = tkl2tok(str2tkl(p));
test bool vstr2tok1() = str2tok(types::Str::example) == types::Tok::example;
test bool vstr2tok2() = str2tok("f\narg = arg\t+\t1;\r\n") == types::Tok::example;

public Lex str2lex(Str p) = tok2lex(tkl2tok(str2tkl(p)));
test bool vstr2lex1() = str2lex(types::Str::example) == types::Lex::example;

public Lex tkl2lex(Tkl p) = tok2lex(tkl2tok(p));
test bool vtkl2lex1() = tkl2lex(types::Tkl::example) == types::Lex::example;

public Str tok2str(Tok p) = tkl2str(tok2tkl(p));
test bool vtok2str1() = tok2str(types::Tok::example) == types::Str::defexample;

public Str lex2str(Lex p) = tkl2str(tok2tkl(lex2tok(p)));
test bool vlex2str1() = lex2str(types::Lex::example) == types::Str::defexample;

public Tkl lex2tkl(Lex p) = tok2tkl(lex2tok(p));
test bool vlex2tkl1() = lex2tkl(types::Lex::example) == types::Tkl::defexample;

public Pic gra2pic(Gra p) = dra2pic(gra2dra(p));
test bool vgra2pic1() = gra2pic(types::Gra::example) == types::Pic::example;
