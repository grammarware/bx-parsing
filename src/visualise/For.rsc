@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::For

import ParseTree;
import types::For;
import vis::Figure;
import vis::Render;

import lang::rascal::format::Escape;
import String;

str mapname("For") = "FunDef";
default str mapname(str s) = replaceFirst(s,"For","");

public list[Figure] visParsetree(Tree t)
{
	switch(t)
	{
		case b:appl(Production prod, list[Tree] args):
		{
			Figure curnode;
			if(\layouts(_) := prod.def)
				return [];
			if(prod.def has string)
				return [box(text("\'<prod.def.string>\'"),size(5))];
			if (iter(\char-class(_)) := prod.def)
				return [box(text("\'<unparse(b)>\'"),size(5))];
			if (\iter-star-seps(\lex("WS"),_) := prod.def)
				return [tree(box(text("Layout"),size(5)), [*visParsetree(c) | appl(Production p2, list[Tree] as2) <- args, c <- as2])];
			if (\iter-seps(_,L) := prod.def)
				return [*visParsetree(c) | c <- args];
			if (\iter-star(\lex("WS")) := prod.def)
				return [tree(box(text("Layout"),size(5)), [])];;
			if(\lex(name) := prod.def || sort(name) := prod.def)
				curnode = box(text(mapname(name)),size(5));
			else
				curnode = ellipse(text("<prod.def>"),size(5));
			return [tree(curnode, [*visParsetree(c) | c <- args], gap(30))];
		}
		case char(int c):
			return [box(text("\'<escape(stringChar(c))>\'", gap(5), fontColor("blue")))];
		case amb(set[Tree] alternatives):
			return [tree(ellipse(size(10), fillColor("red")),
						[tree(ellipse(size(10), fillColor("blue")), visParsetree(c)) | c <- alternatives])];
	}
}

public void visualise(For p) = render(visualised(p));
public Figure visualised(For p) = space(visParsetree(p)[0], std(gap(10)), std(font("Monaco")), std(resizable(false)));

void visfor1() = visualise(types::For::example);
void visfor2() = visualise(types::For::tricky);
