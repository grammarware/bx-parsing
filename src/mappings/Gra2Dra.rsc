@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	TBD
}
module mappings::Gra2Dra

import IO;
import List;
import String;
import types::Gra;
import types::Dra;

Dra gra2dra(gramodel(GraElement root)) = drapicture(grarender(root,0,1,0));
list[DraElement] grarender(graempty(), int cx, int line, int col) = [];
list[DraElement] grarender(grabox(GraType t, GraLabel label), int cx, int line, int col)
{
	loc where = makeloc(cx, size(label) + 2, line, col);
	switch(t)
	{
		case grasquare(): return [drasquare(label,where)];
		case graround(): return [draround(label,where)];
		case gracurly(): return [dracurly(label,where)];
	}
}

loc makeloc(int offset, int length, int line, int scol)
{
	return |stdin:///|(offset,length,<line,scol>,<line,scol+length>);
	loc where = |stdin:///|(0,0,<1,0>,<1,0>);
	where.offset = offset;
	where.length = length;
	//println("Line be <line> in <where>");
	where.begin = <line, scol>;
	where.end = <line, scol + length>;
}

list[DraElement] grarender(graprefix(GraElement e1, GraElement e2), int cx, int line, int col)
{
	list[DraElement] res = grarender(e1,cx,line,col);
	res += grarender(e2,
		// +2 for a newline and an indent; TODO: take current indent into account
		res[-1].where.offset + res[-1].where.length + 2,
		res[-1].where.end.line+1,
		col+1);
	return res;
}
list[DraElement] grarender(grapostfix(GraElement e1, GraElement e2), int cx, int line, int col)
{
	list[DraElement] res = grarender(e2,cx+1,line,col+1);
	res += grarender(e1,
		// +1 for a newline; TODO: take current indent into account
		res[-1].where.offset + res[-1].length + 1,
		res[-1].where.end.line+1,
		col);
	return res;
}
// empty separator => no extra indentation
list[DraElement] grarender(grainfix(graempty(), list[GraElement] es2), int cx, int line, int col)
{
	list[DraElement] res = [];
	for (GraElement e <- es2)
	{
		res += grarender(e,cx,line,col);
		// TODO: take current indent into account
		cx = res[-1].where.offset + res[-1].where.length + 1;
		line = res[-1].where.end.line+1;
	}
	return res;
}
list[DraElement] grarender(grainfix(GraElement e1, [])) = [];
list[DraElement] grarender(grainfix(GraElement e1, list[GraElement] es2), int cx, int line, int col)
{
	list[DraElement] res = grarender(es2[0],cx,line,col+1);
	for (GraElement e <- tail(es2))
	{
		// TODO: take current indent into account
		cx = res[-1].where.offset + res[-1].where.length + 1;
		line = res[-1].where.end.line+1;
		res += grarender(e1,cx,line,col);
		cx = res[-1].where.offset + res[-1].where.length + 1;
		line = res[-1].where.end.line+1;
		res += grarender(e,cx,res[-1].where.end.line+1,col+1);
	}
	return res;
}
list[DraElement] grarender(graconfix(GraType t, GraElement e), int cx, int line, int col)
{
	int ofst = (grainfix(_,_):=e)?0:1;
	list[DraElement] res = [gratype2left(t,cx,line,col)];
	// +1 for newline
	res += grarender(e,cx+1+ofst,line+1,col+ofst);
	cx = res[-1].where.offset + res[-1].where.length + 1;
	line = res[-1].where.end.line+1;
	res += gratype2right(t,cx,line,col);
	return res;
}

DraElement onesymb(str s, int cx, int line, int col) = drasymbol(s, makeloc(cx, 1, line, col));
DraElement gratype2left(grasquare(), int cx, int line, int col) = onesymb("[",cx,line,col);
DraElement gratype2left(graround(), int cx, int line, int col)  = onesymb("(",cx,line,col);
DraElement gratype2left(gracurly(), int cx, int line, int col)  = onesymb("{",cx,line,col);
DraElement gratype2right(grasquare(), int cx, int line, int col)= onesymb("]",cx,line,col);
DraElement gratype2right(graround(), int cx, int line, int col) = onesymb(")",cx,line,col);
DraElement gratype2right(gracurly(), int cx, int line, int col) = onesymb("}",cx,line,col);

list[DraElement] grarender(graarrow(), int cx, int line, int col) = [onesymb("→",cx,line,col)];

default list[DraElement] grarender(GraElement e, int cx, int line, int col)
{
	println("Cannot render <e>");
}


test bool vgra2dra1(Gra p) = gra2dra(types::Gra::example) == types::Dra::example;

void qq()
{
	println(types::Dra::dra2pic(types::Dra::example));
	println(types::Dra::dra2pic(gra2dra(types::Gra::example)));
	println(types::Dra::dra2pic(types::Dra::example)==types::Dra::dra2pic(gra2dra(types::Gra::example)));
	for(DraElement e <- gra2dra(types::Gra::example).es)
		println(e);
}