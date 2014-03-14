@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Cst

import ParseTree;
import types::Cst;
import vis::Figure;
import vis::Render;

import lang::rascal::format::Escape;
import String;

str mapname("Cst") = "FunDef";
default str mapname(str s) = replaceFirst(s,"Cst","");

public list[Figure] visParsetree(Tree t)
{
	switch(t)
	{
		case b:appl(Production prod, list[Tree] args):
		{
			Figure curnode;
			if(prod.def has string)
				return [box(text("\'<prod.def.string>\'"),size(5))];
			if (iter(\char-class(_)) := prod.def)
				return [box(text("\'<unparse(b)>\'"),size(5))];
			if(\layouts(_) := prod.def)
				return [];
			if (\iter-seps(_,L) := prod.def)
				return [*visParsetree(c) | c <- args];
			if(\lex(name) := prod.def || sort(name) := prod.def)
				curnode = box(text(mapname(name)),size(5));
			else
				curnode = ellipse(text("<prod.def>"),size(5));
			return [tree(curnode, [*visParsetree(c) | c <- args], gap(30))];
		}
		case char(int c):
			return [box(text("\'<escape(stringChar(c))>\'", gap(5), fontColor("blue")))];
	}
}

public void visualise(Cst p) = render(visualised(p));
public Figure visualised(Cst p) = space(visParsetree(p)[0], std(gap(10)), std(font("Monaco")), std(resizable(false)));

void viscst1() = visualise(types::Cst::example);
void viscst2() = visualise(types::Cst::tricky);
