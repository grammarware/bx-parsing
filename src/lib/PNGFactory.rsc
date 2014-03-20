@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module lib::PNGFactory

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

import visualise::For;
import visualise::Ptr;
import visualise::Cst;
import visualise::Ast;

import visualise::Pic;
import visualise::Dra;
import visualise::Gra;
import visualise::Fig;

import vis::Render;
import vis::Figure;
import IO;

Figure forcegrow(Figure f) = visit(f) { case _text(a,p) => _text(a,p+[fontSize(32)]) };

void renderto(loc base)
{
	renderSave(forcegrow(visualised(types::Str::example)), base+"Str.png");
	renderSave(forcegrow(visualised(types::Tkl::example)), base+"Tkl.png");
	renderSave(forcegrow(visualised(types::Tok::example)), base+"Tok.png");
	renderSave(forcegrow(visualised(types::Lex::example)), base+"Lex.png");
	
	renderSave(forcegrow(visualised(types::For::example)), base+"For.png");
	//render(visualised(types::For::tricky));//, base+"For2.png");
	renderSave(forcegrow(visualised(types::Ptr::example)), base+"Ptr.png");
	renderSave(forcegrow(visualised(types::Cst::example)), base+"Cst.png");
	renderSave(forcegrow(visualised(types::Ast::example)), base+"Ast.png");
	
	renderSave(forcegrow(visualised(types::Pic::example)), base+"Pic.png");
	renderSave(forcegrow(visualised(types::Dra::example)), base+"Dra.png");
	renderSave(forcegrow(visualised(types::Gra::example)), base+"Gra.png");
	renderSave(forcegrow(visualised(types::Fig::example)), base+"Fig.png");
}

void main()
{
	renderto(|home:///projects/acceptware/parsing/generated/|);
}