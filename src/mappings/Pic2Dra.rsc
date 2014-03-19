@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	In general, Pic2Dra uses image recognition techniques to “parse” a rasterised picture.
	For out prototype, this means searching for elements in the textual picture, correctly
	identifying them and assigning them proper coordinates.
}
module mappings::Pic2Dra

import types::Pic;
import types::Dra;
import String;

Dra pic2dra(Pic p)
{
	list[DraElement] es = [];
	int i = 1, cx = 0;
	for (str e <- split("\n",p))
	{
		es += mapline(e, i, cx);
		cx += es[i-1].where.end.column +1;
		i += 1;
	}
	return drapicture(es);
}

DraElement mapline(str e:/\{<w:.+>\}/, int no, int cx)
	= dracurly(w, |stdin:///|(cx+findFirst(e,"{"),size(w)+2,<no,findFirst(e,"{")>,<no,findLast(e,"}")+1>));
DraElement mapline(str e:/\[<w:.+>\]/, int no, int cx)
	= drasquare(w, |stdin:///|(cx+findFirst(e,"["),size(w)+2,<no,findFirst(e,"[")>,<no,findLast(e,"]")+1>));
DraElement mapline(str e:/\(<w:.+>\)/, int no, int cx)
	= draround(w, |stdin:///|(cx+findFirst(e,"("),size(w)+2,<no,findFirst(e,"(")>,<no,findLast(e,")")+1>));
default DraElement mapline(str e:/<w:\S+>/, int no, int cx)
	= drasymbol(w, |stdin:///|(cx+findFirst(e,w),size(w),<no,findFirst(e,w)>,<no,findFirst(e,w)+size(w)>));

test bool vpic2dra1() = pic2dra(types::Pic::example) == types::Dra::example;
