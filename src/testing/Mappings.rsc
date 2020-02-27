module testing::Mappings

import types::Ast;
import types::Cst;
import types::Dra;
import types::Fig;
import types::For;
import types::Gra;
import types::Lex;
import types::Pic;
import types::Ptr;
import types::Str;
import types::Tkl;
import types::Tok;
import mappings::Ast2Cst;
import mappings::Ast2Fig;
import mappings::Ast2Lex;
import mappings::Cst2Ast;
import mappings::Cst2Gra;
import mappings::Cst2Ptr;
import mappings::Cst2Tok;
import mappings::Dra2Gra;
import mappings::Dra2Pic;
import mappings::Fig2Ast;
import mappings::Fig2Gra;
import mappings::For2Ptr;
import mappings::For2Str;
import mappings::Gra2Cst;
import mappings::Gra2Dra;
import mappings::Gra2Fig;
import mappings::Lex2Ast;
import mappings::Lex2Tok;
import mappings::Pic2Dra;
import mappings::Ptr2Cst;
import mappings::Ptr2Tkl;
import mappings::Str2For;
import mappings::Str2Tkl;
import mappings::Tkl2Str;
import mappings::Tkl2Tok;
import mappings::Tok2Lex;
import mappings::Tok2Tkl;
import specific::Gra2Pic;
import specific::Ptr2Tok;
import specific::Str2Lex;
import mappings::MultiStep;

test bool vast2cst1() = ast2cst(types::Ast::example) == types::Cst::example;

test bool tast2fig1() = ast2fig(types::Ast::example) == types::Fig::example; 

test bool vast2lex1() = ast2lex(types::Ast::example) == types::Lex::example;
test bool vast2lex2() = ast2lex(astfundef("f",["arg"], astbplus(astliteral(1),astliteral(2))))
	== lexfundef([alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
				[numeric(1),ssymbol("+"),numeric(2)],ssymbol(";"));
test bool vast2lex3() = ast2lex(astfundef("f",["arg"], astbmul(astliteral(1),astliteral(2))))
	== lexfundef([alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
				[numeric(1),ssymbol("*"),numeric(2)],ssymbol(";"));
test bool vast2lex4() = ast2lex(astfundef("f",["arg"], astbplus(astliteral(1),astbmul(astliteral(2),astliteral(3)))))
	== lexfundef([alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
				[numeric(1),ssymbol("+"),numeric(2),ssymbol("*"),numeric(3)],ssymbol(";"));
test bool vast2lex5() = ast2lex(astfundef("f",["arg"], astbplus(astbmul(astliteral(1),astliteral(2)),astliteral(3))))
	== lexfundef([alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
				[numeric(1),ssymbol("*"),numeric(2),ssymbol("+"),numeric(3)],ssymbol(";"));

test bool vcst2ast1() = cst2ast(types::Cst::example) == types::Ast::example;

test bool vcst2gra1() = cst2gra(types::Cst::example) == types::Gra::example;

test bool vcst2ptr1() = cst2ptr(types::Cst::example) == types::Ptr::defexample;

test bool vcst2tok1() = cst2tok(types::Cst::example) == types::Tok::example;

// id
Gra ex1gra = fig2gra(figfunctionmodel("f",["x"],figvariable("x")));
test bool vdra2gra1m() = dra2gra(gra2dra(ex1gra)) == ex1gra;

// const
Gra ex2gra = fig2gra(figfunctionmodel("f",["y"],figliteral(42)));
test bool vdra2gra2m() = dra2gra(gra2dra(ex2gra)) == ex2gra;

// add
Gra ex3gra = fig2gra(figfunctionmodel("f",["x","y"],figbinary("+",figvariable("x"),figvariable("y"))));
test bool vdra2gra3m() = dra2gra(gra2dra(ex3gra)) == ex3gra;

// a*a+b
Gra ex4gra = fig2gra(figfunctionmodel("f",["a","b"],figbinary("+", figbinary("*",figvariable("a"),figvariable("a")), figvariable("b"))));
test bool vdra2gra4m() = dra2gra(gra2dra(ex4gra)) == ex4gra;

// (10+a)*a+b
Gra ex5gra = fig2gra(figfunctionmodel("f",["a","b"],figbinary("+", figbinary("*", figbinary("+",figliteral(10),figvariable("a")), figvariable("a")), figvariable("b")) ));
test bool vdra2gra5m() = dra2gra(gra2dra(ex5gra)) == ex5gra;

test bool vdra2gra1() = dra2gra(types::Dra::example) == types::Gra::example;

test bool vdra2pic1() = dra2pic(types::Dra::example) == types::Pic::example;

test bool tfig2ast1() = fig2ast(types::Fig::example) == types::Ast::example; 

test bool vfig2gra1() = fig2gra(types::Fig::example) == types::Gra::example;

test bool vfor2ptr1() = for2ptr(types::For::example) == types::Ptr::example;
test bool vfor2ptr2() = for2ptr(types::For::tricky) == types::Ptr::tricky;

test bool vfor2str1() = for2str(types::For::example) == types::Str::example;

test bool vgra2cst1() = gra2cst(types::Gra::example) == types::Cst::example;

test bool vgra2dra1() = gra2dra(types::Gra::example) == types::Dra::example;

test bool vgra2fig1() = gra2fig(types::Gra::example) == types::Fig::example;

// NB: the actual mapping is much more intricate than the running example,
// so we need more test cases.
test bool vlex2ast1() = lex2ast(types::Lex::example) == types::Ast::example;
test bool vlex2ast2() = lex2ast(lexfundef(
				[alphanumeric("f"),alphanumeric("arg")],
				ssymbol("="),
				[numeric(1),ssymbol("+"),numeric(2)],
				ssymbol(";")))
	== astfundef("f",["arg"], astbplus(astliteral(1),astliteral(2)));
test bool vlex2ast3() = lex2ast(lexfundef(
				[alphanumeric("f"),alphanumeric("arg")],
				ssymbol("="),
				[numeric(1),ssymbol("*"),numeric(2)],
				ssymbol(";")))
	== astfundef("f",["arg"], astbmul(astliteral(1),astliteral(2)));
test bool vlex2ast4() = lex2ast(lexfundef(
				[alphanumeric("f"),alphanumeric("arg")],
				ssymbol("="),
				[numeric(1),ssymbol("+"),numeric(2),ssymbol("*"),numeric(3)],
				ssymbol(";")))
	== astfundef("f",["arg"], astbplus(astliteral(1),astbmul(astliteral(2),astliteral(3))) );
test bool vlex2ast5() = lex2ast(lexfundef(
				[alphanumeric("f"),alphanumeric("arg")],
				ssymbol("="),
				[numeric(1),ssymbol("*"),numeric(2),ssymbol("+"),numeric(3)],
				ssymbol(";")))
	== astfundef("f",["arg"], astbplus(astbmul(astliteral(1),astliteral(2)),astliteral(3)));

test bool vlex2tok1() = lex2tok(types::Lex::example) == types::Tok::example;

test bool vpic2dra1() = pic2dra(types::Pic::example) == types::Dra::example;

test bool vptr2cst1() = ptr2cst(types::Ptr::example) == types::Cst::example;

test bool vptr2tkl1() = ptr2tkl(types::Ptr::example) == types::Tkl::example;

test bool vstr2for1() = validate(str2for(types::Str::example));
test bool vstr2for2() = validate(str2for(types::Str::defexample));

test bool vstr2tkl1() = str2tkl(types::Str::example) == types::Tkl::example;
test bool vstr2tkl2() = str2tkl("f xxx = 100;") == ["f"," ","xxx"," ","="," ","100",";"];

test bool vtkl2str1() = tkl2str(types::Tkl::example) == types::Str::example;

test bool vtkl2tok1() = tkl2tok(types::Tkl::example) == types::Tok::example;
test bool vtkl2tok2() = tkl2tok(["f","\n","xxx"," ","=","\t\r\n\t","100",";"]) == ["f","xxx","=","100",";"];

test bool vtok2lex1() = tok2lex(types::Tok::example) == types::Lex::example;

test bool vtok2tkl1() = tok2tkl(types::Tok::example) != types::Tkl::example;
test bool vtok2tkl2() = tok2tkl(types::Tok::example) == types::Tkl::defexample;

test bool xgra2pic1() = gra2pic_r(types::Gra::example) == types::Pic::example;
test bool xgra2pic2() = gra2pic_r(types::Gra::example) == gra2pic(types::Gra::example);

test bool vptr2tok1() = ptr2tok(types::Ptr::example) == types::Tok::example;

test bool xstr2lex1() = altstr2lex(types::Str::example) == types::Lex::example;

test bool vstr2tok1() = str2tok(types::Str::example) == types::Tok::example;

test bool vstr2tok2() = str2tok("f\narg = arg\t+\t1;\r\n") == types::Tok::example;

test bool vstr2lex1() = str2lex(types::Str::example) == types::Lex::example;

test bool vtkl2lex1() = tkl2lex(types::Tkl::example) == types::Lex::example;

test bool vtok2str1() = tok2str(types::Tok::example) == types::Str::defexample;

test bool vlex2str1() = lex2str(types::Lex::example) == types::Str::defexample;

test bool vlex2tkl1() = lex2tkl(types::Lex::example) == types::Tkl::defexample;

test bool vast2ptr1() = ast2ptr(types::Ast::example) == types::Ptr::defexample;

test bool vptr2ast1() = ptr2ast(types::Ptr::example) == types::Ast::example;

test bool vfor2cst1() = for2cst(types::For::example) == types::Cst::example;

test bool vfor2ast1() = for2ast(types::For::example) == types::Ast::example;

test bool vgra2pic1() = gra2pic(types::Gra::example) == types::Pic::example;

test bool vfig2pic1() = fig2pic(types::Fig::example) == types::Pic::example;

test bool vfig2dra1() = fig2dra(types::Fig::example) == types::Dra::example;

test bool vdra2fig1() = dra2fig(types::Dra::example) == types::Fig::example;

test bool vpic2gra1() = pic2gra(types::Pic::example) == types::Gra::example;

test bool vpic2fig1() = pic2fig(types::Pic::example) == types::Fig::example;
