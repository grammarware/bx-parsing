@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module visualise::ProduceFigures

import types::Str;
import types::Tkl;
import types::Tok;
import types::Lex;

import types::For;
import types::Ptr;
import types::Cst;
import types::Ast;

import types::Pic;
import types::Dra;
import types::Gra;
import types::Fig;

import visualise::Str;
import visualise::Tkl;
import visualise::Tok;
import visualise::Lex;

import visualise::Ptr;

import vis::Render;
import vis::Figure;
import IO;

Figure forcegrow(Figure f) = visit(f) { case _text(a,p) => _text(a,p+[fontSize(32)]) };

void main()
{
	renderSave(forcegrow(visualised(types::Str::example)), |home:///projects/acceptware/parsing/generated/Str.png|);
	renderSave(forcegrow(visualised(types::Tkl::example)), |home:///projects/acceptware/parsing/generated/Tkl.png|);
	renderSave(forcegrow(visualised(types::Tok::example)), |home:///projects/acceptware/parsing/generated/Tok.png|);
	renderSave(forcegrow(visualised(types::Lex::example)), |home:///projects/acceptware/parsing/generated/Lex.png|);
	
	//renderSave(forcegrow(visualised(types::Str::example)), |home:///projects/acceptware/parsing/generated/str.png|);
	renderSave(forcegrow(visualised(types::Ptr::example)), |home:///projects/acceptware/parsing/generated/Ptr.png|);
	//renderSave(forcegrow(visualised(types::Str::example)), |home:///projects/acceptware/parsing/generated/str.png|);
	//renderSave(forcegrow(visualised(types::Str::example)), |home:///projects/acceptware/parsing/generated/str.png|);
}