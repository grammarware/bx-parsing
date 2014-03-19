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

str basic(str title, str dir, str doc, str pic, str code, str from, str to, list[str] end) =
		//"## <title>
		"## [<title>](https://github.com/grammarware/bx-parsing/blob/master/src/<dir>/<title>.rsc)
		'
		'<doc>
		'
		'<if(pic!=""){><pic>
		'
		'<}>```
		'<code>
		'```
		'
		'### <if(from+to!=""){>Input
		'
		'![Input](https://github.com/grammarware/bx-parsing/raw/master/img/<from>.png)
		'
		'### Output
		'
		'![Output](https://github.com/grammarware/bx-parsing/raw/master/img/<to>.png)
		'
		'### <}>See also:
		'<for(str s<-end){>* <s>
		'<}>";

str norsc(loc z) = replaceLast(z.file,".rsc","");
list[str] getlinks(str name, loc not, str dir) = ["[<dir>::<norsc(m)>](https://github.com/grammarware/bx-parsing/blob/master<m.path>)" | loc m <- |project://bx-parsing/src/<dir>/|.ls, contains(m.path,name), m != not];
list[str] seealso1(str name, loc not) = getlinks(name,not,"mappings") + getlinks(name,not,"visualise") + getlinks(name,not,"specific");
list[str] seealso2(str name, loc not) = getlinks(name,not,"types") + getlinks(name,not,"visualise") + getlinks(name,not,"specific");

void main()
{
	println("Generating figures...");
	lib::PNGFactory::renderto(|project://bx-parsing/img/|);
	println("Generating documentation for types...");
	writeFile(|project://bx-parsing/doc/README.md|,readFile(|project://bx-parsing/README.md|));
	for (loc z <- |project://bx-parsing/src/types/|.ls)
	{
		name = norsc(z);
		<docs,code> = slicesrc(readFile(z));
		writeFile(|project://bx-parsing/doc/<name>.md|,basic(
			name,
			"types",
			docs,
			"![Example](https://github.com/grammarware/bx-parsing/raw/master/img/<name>.png)",
			code,
			"",
			"",
			seealso1(name,z)));	
	}
	println("Generating documentation for mappings...");
	for (loc z <- |project://bx-parsing/src/mappings/|.ls, z.file!="MultiStep.rsc")
	{
		name = norsc(z);
		<docs,code> = slicesrc(readFile(z));
		parts = split("2",name);
		writeFile(|project://bx-parsing/doc/<name>.md|,basic(
			name,
			"mappings",
			docs,
			"",
			code,
			parts[0],
			parts[1],
			[*seealso2(nm,z) | nm <- parts]));	
	}
	println("Generating documentation for specific mappings...");
	for (loc z <- |project://bx-parsing/src/specific/|.ls, contains(z.file,"2"))
	{
		name = norsc(z);
		<docs,code> = slicesrc(readFile(z));
		parts = split("2",name);
		writeFile(|project://bx-parsing/doc/<name>.md|,basic(
			name,
			"specific",
			docs,
			"",
			code,
			parts[0],
			parts[1],
			[*seealso2(nm,z) | nm <- parts]));	
	}
}