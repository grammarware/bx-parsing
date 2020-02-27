@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	We use the idea of hierarchical lexical analysis to make Lex even more structured,
	which carries it closer and closer to Ast. It is rather straightforward to implement it
	in Rascal due to a built-in
	[Visitor](http://tutor.rascal-mpl.org/Rascal/Concepts/Visiting/Visiting.html)
	language feature, see
	[visit(){}](http://tutor.rascal-mpl.org/Rascal/Expressions/Visit/Visit.html)
	construction.
	
	We also use an intermediate representation to store the structure which is being processed
	(some parts are unmatched). If at the end of our algorithm some tokens still have not been processed,
	then this Lex instance is incompatible to be converted to Ast.
}
module mappings::Lex2Ast

import IO;
import List;

import types::Lex;
import types::Ast;

data IRLexAst
	= lexvariable(str a)
	| lexliteral(int n)
	| lexplus(IRLexAst left, IRLexAst right)
	| lexmul(IRLexAst left, IRLexAst right)
	| lexunprocessed(str s)
	| lexlist(list[IRLexAst] ts)
	;

IRLexAst lex2ir(TokTokens ts) = lexlist([lex2ir(t) | TokToken t <- ts]);
IRLexAst lex2ir(numeric(int n)) = lexliteral(n);
IRLexAst lex2ir(alphanumeric(str a)) = lexvariable(a);
IRLexAst lex2ir(ssymbol(str s)) = lexunprocessed(s);

AstExpr ir2ast(lexlist([IRLexAst e])) = ir2ast(e);
AstExpr ir2ast(lexvariable(str a)) = astvariable(a);
AstExpr ir2ast(lexliteral(int n)) = astliteral(n);
AstExpr ir2ast(lexplus(IRLexAst left, IRLexAst right)) = astbplus(ir2ast(left), ir2ast(right));
AstExpr ir2ast(lexmul(IRLexAst left, IRLexAst right)) = astbmul(ir2ast(left), ir2ast(right));
default AstExpr ir2ast(IRLexAst e)
{
	println("Leftover: <e>");
	return astvariable("ERROR");
}

public Ast lex2ast(Lex p)
	= astfundef(p.left[0].a, [a | alphanumeric(str a) <- tail(p.left)], mapexpr(p.right));

AstExpr mapexpr(list[TokToken] ts)
{
	IRLexAst ir = lex2ir(ts);
	ir = innermost visit (ir)
	{
		case [*L1, IRLexAst e1, lexunprocessed("*"), IRLexAst e2, *L2]
			=> [*L1, lexmul(e1, e2), *L2]
	};
	ir = innermost visit (ir)
	{
		case [*L1, IRLexAst e1, lexunprocessed("+"), IRLexAst e2, *L2]
			=> [*L1, lexplus(e1, e2), *L2]
	};
	assert lexunprocessed(_) !:= ir; 
	return ir2ast(ir);
}

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
