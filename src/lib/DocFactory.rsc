@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module lib::DocFactory

import lib::PNGFactory;
import IO;
import String;
import List;

tuple[str,str] slicesrc(str s)
{
	list[str] docs = [], code = [];
	bool go = true;
	for (line <- split("\n",s))
	{
		if (startsWith(line,"@contributor")) continue;
		if (go && startsWith(line,"@doc")) continue;
		if (go && trim(line) == "}") {go = false; continue;}
		if (go) docs += trim(line); else code += line;
	}
	return <intercalate("\n",docs), intercalate("\n",code)>;
}

void main()
{
	lib::PNGFactory::renderto(|project://bx-parsing/img/|);
	writeFile(|project://bx-parsing/doc/README.md|,readFile(|project://bx-parsing/README.md|));
	for (loc z <- |project://bx-parsing/src/types/|.ls)
	{
		name = replaceLast(z.file,".rsc","");
		println(z.file);
		<docs,code> = slicesrc(readFile(z));
		writeFile(|project://bx-parsing/doc/<name>.md|,"## <name>
		'
		'<docs>
		'
		'![Example](https://github.com/grammarware/bx-parsing/raw/master/img/<name>.png)
		'
		'```
		'<code>
		'```
		'
		'");	
	}
}