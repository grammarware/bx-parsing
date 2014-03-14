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
		if (go) docs += trim(line); else code += replaceAll(line,"\t","    ");
	}
	return <intercalate("\n",docs), intercalate("\n",code)>;
}

str basic(str title, str doc, str pic, str code, list[str] end) = "## <title>
		'
		'<doc>
		'
		'<pic>
		'```
		'<code>
		'```
		'
		'### See also:
		'<for(str s<-end){>* <s>
		'<}>";

str norsc(loc z) = replaceLast(z.file,".rsc","");
void main()
{
	lib::PNGFactory::renderto(|project://bx-parsing/img/|);
	writeFile(|project://bx-parsing/doc/README.md|,readFile(|project://bx-parsing/README.md|));
	for (loc z <- |project://bx-parsing/src/types/|.ls)
	{
		name = norsc(z);
		println(z.file);
		<docs,code> = slicesrc(readFile(z));
		seealso
			= ["[mappings::<norsc(m)>](https://github.com/grammarware/bx-parsing/blob/master<m.path>)" | loc m <- |project://bx-parsing/src/mappings/|.ls, contains(m.path,name)]
			+ ["[visualise::<norsc(m)>](https://github.com/grammarware/bx-parsing/blob/master<m.path>)" | loc m <- |project://bx-parsing/src/visualise/|.ls, contains(m.path,name)]
			+ ["[specific::<norsc(m)>](https://github.com/grammarware/bx-parsing/blob/master<m.path>)" | loc m <- |project://bx-parsing/src/specific/|.ls, contains(m.path,name)];
		writeFile(|project://bx-parsing/doc/<name>.md|,basic(
			"[<name>](https://github.com/grammarware/bx-parsing/blob/master/src/types/<name>.rsc)",
			docs,
			"![Example](https://github.com/grammarware/bx-parsing/raw/master/img/<name>.png)\n",
			code,
			seealso));	
	}
}