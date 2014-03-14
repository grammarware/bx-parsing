@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::Ptr

import ParseTree;
import types::Ptr;
import vis::Figure;
import vis::Render;
import List;

import lang::rascal::format::Escape;
import String;


str mapname("Ptr") = "FunDef";
default str mapname(str s) = replaceFirst(s,"Ptr","");

public list[Figure] visParsetree(Tree t)
{
	switch(t)
	{
		case b:appl(Production prod, list[Tree] args):
		{
			Figure curnode;
			if(\lex(name) := prod.def)
				curnode = box(text(mapname(name)),size(5));
			else
				curnode = ellipse(text("<prod.def>"),size(5));
			if(prod.def has string)
				return [box(text("\'<prod.def.string>\'"),size(5))];
			if (iter(\char-class(_)) := prod.def)
				return [box(text("\'<unparse(b)>\'"),size(5))];
			if (\iter-star(\lex("WS")) := prod.def)
			{
				ts = [*visParsetree(c) | appl(Production p2, list[Tree] as2) <- args, c <- as2];
				if (isEmpty(ts))
					return [];
				else
					return [tree(box(text("Layout"),size(5)), ts)];
			}
			if (\iter-seps(_,L) := prod.def)
				return [*visParsetree(c) | c <- args];
			return [tree(curnode, [*visParsetree(c) | c <- args], gap(30))];
		}
		case char(int c):
			return [box(text("\'<escape(stringChar(c))>\'", gap(5), fontColor("blue")))];
	}
}

public void visualise(Ptr p) = render(visualised(p));
public Figure visualised(Ptr p) = space(visParsetree(p)[0], std(gap(10)), std(font("Monaco")), std(resizable(false)));

void visptr1() = visualise(types::Ptr::example);
void visptr2() = visualise(types::Ptr::defexample);
void visptr3() = visualise(types::Ptr::tricky);
void visptr4() = visualise(types::Ptr::multi);
