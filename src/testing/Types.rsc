@contributor{Vadim Zaytsev - vadim@grammarware.net}
module testing::Types

import ParseTree;

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

test bool vast1() = types::Ast::validate(types::Ast::example);
test bool vast2() = !types::Ast::validate(astfundef("f",["arg"],astbplus(astvariable(""),astliteral(1))));
test bool vast3() = !types::Ast::validate(astfundef("f",["arg"],astbplus(astvariable("x"),astliteral(1))));

test bool vCst1() = types::Cst::validate(types::Cst::example);
test bool vCst2() = types::Cst::validate(types::Cst::tricky);

test bool vdra1() = types::Dra::validate(types::Dra::example);
test bool vdra2() = types::Dra::validate(types::Dra::exedited);

test bool tfig1() = types::Fig::validate(types::Fig::example);

test bool vfor0() = /amb(_) := types::For::example;
test bool vfor1() = /amb(_) := parse(#For,"f arg = 1+1+1;", allowAmbiguity=true);
test bool vfor2() = /amb(_) := parse(#For,"f arg = 1+1*1;", allowAmbiguity=true);
test bool vfor3() = /amb(_) := parse(#For,"f arg = 1*1+1;", allowAmbiguity=true);
test bool vfor4() = /amb(_) := parse(#For,"f arg = 1;", allowAmbiguity=true);

test bool vgra1() = types::Gra::validate(types::Gra::example);

test bool vlex1() = types::Lex::validate(types::Lex::example);
test bool vlex2() = !types::Lex::validate(lexfundef(
						[alphanumeric("f")],ssymbol("="),
						[alphanumeric("arg"),ssymbol("+"),numeric(1)],ssymbol(";")));
test bool vlex3() = !types::Lex::validate(lexfundef(
						[alphanumeric("f"),alphanumeric("!")],ssymbol("="),
						[alphanumeric("arg"),ssymbol("+"),numeric(1)],ssymbol(";")));
test bool vlex4() = !types::Lex::validate(lexfundef(
						[alphanumeric("f"),alphanumeric("arg")],ssymbol("="),
						[alphanumeric("arg"),ssymbol("plus"),numeric(1)],ssymbol(";")));

// NB: no tests in types::Pic

test bool vptr1() = types::Ptr::validate(types::Ptr::example);
test bool vptr2() = types::Ptr::validate(types::Ptr::defexample);
test bool vptr3() = types::Ptr::validate(types::Ptr::tricky);

test bool vstr1() = types::Str::validate(types::Str::example);
test bool vstr2() = types::Str::validate(types::Str::defexample);

test bool vtkl1() =  types::Tkl::validate(types::Tkl::example);
test bool vtkl2() = !types::Tkl::validate(["f"," ","arg"," ","="," ","arg"," ","+","","1",";"]);
test bool vtkl3() =  types::Tkl::validate(types::Tkl::defexample);

test bool vtok1() =  types::Tok::validate(types::Tok::example);
test bool vtok2() = !types::Tok::validate(["f"," ","arg"," ","="," ","arg"," ","+","1",";"]);
test bool vtok3() = !types::Tok::validate(["f"," ","arg"," ","="," ","arg"," ","+","","1",";"]);
