@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	This module is nothing more than a list of wrappers that collects all straightforward
	combinations of existing one-step mappings.
}
module mappings::MultiStep

import mappings::Ast2Cst;
import mappings::Ast2Fig;
import mappings::Ast2Lex;
import mappings::Cst2Ast;
import mappings::Cst2Gra;
import mappings::Cst2Ptr;
import mappings::Cst2Tok;
import mappings::Dra2Pic;
import mappings::Fig2Ast;
import mappings::Fig2Gra;
import mappings::For2Ptr;
import mappings::For2Str;
import mappings::Gra2Cst;
import mappings::Gra2Dra;
import mappings::Lex2Ast;
import mappings::Lex2Tok;
import mappings::Ptr2Cst;
import mappings::Ptr2Tkl;
import mappings::Str2For;
import mappings::Str2Tkl;
import mappings::Tkl2Str;
import mappings::Tkl2Tok;
import mappings::Tok2Lex;
import mappings::Tok2Tkl;
import mappings::Dra2Gra;
import mappings::Gra2Fig;
import types::Str;
import types::Tkl;
import types::Tok;
import types::Lex;
import types::Pic;
import types::Dra;
import types::Gra;
import types::Fig;
import types::For;
import types::Ptr;
import types::Cst;
import types::Ast;

// Left column
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

// Central column
public Ptr ast2ptr(Ast p) = cst2ptr(ast2cst(p));
test bool vast2ptr1() = ast2ptr(types::Ast::example) == types::Ptr::defexample;

public Ast ptr2ast(Ptr p) = cst2ast(ptr2cst(p));
test bool vptr2ast1() = ptr2ast(types::Ptr::example) == types::Ast::example;

public Cst for2cst(For p) = ptr2cst(for2ptr(p));
test bool vfor2cst1() = for2cst(types::For::example) == types::Cst::example;

public Ast for2ast(For p) = cst2ast(ptr2cst(for2ptr(p)));
test bool vfor2ast1() = for2ast(types::For::example) == types::Ast::example;

// Right column
public Pic gra2pic(Gra p) = dra2pic(gra2dra(p));
test bool vgra2pic1() = gra2pic(types::Gra::example) == types::Pic::example;

public Pic fig2pic(Fig p) = dra2pic(gra2dra(fig2gra(p)));
test bool vfig2pic1() = fig2pic(types::Fig::example) == types::Pic::example;

public Dra fig2dra(Fig p) = gra2dra(fig2gra(p));
test bool vfig2dra1() = dra2pic(fig2dra(types::Fig::example)) == dra2pic(types::Dra::example);

public Fig dra2fig(Dra p) = gra2fig(dra2gra(p));
test bool vdra2fig1() = dra2fig(types::Dra::example) == types::Fig::example;

//def f(x,y,z): print 'public %s %s2%s(%s p) = %s2%s(%s2%s(p));\ntest bool v%s2%s1() = %s2%s(types::%s::example) == types::%s::example;' % (z, x.lower(),z.lower(),x, y.lower(),z.lower(),x.lower(),y.lower(), x.lower(),z.lower(), x.lower(),z.lower(), x,z)
