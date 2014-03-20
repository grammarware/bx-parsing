@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module lib::LocFactory

import String;

public loc newloc(int offset, int length, int line, int scol)
	= |stdin:///|(offset,length,<line,scol>,<line,scol+length>);

public loc newloc(int length, int line, int scol) = newloc(0,length,line,scol);

public loc newloc(str s, int line, int scol) = newloc(0,size(s),line,scol);
