@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module specific::Fig

import types::Fig;
import vis::Figure;
import vis::Render;

Figure diagonal(Figure topleft, Figure rightbottom)
	= 
		overlay(
			[
					space(topleft, left(), top(), resizable(false), shrink(0.3)),
					space(rightbottom, right(), bottom(),resizable(false), shrink(0.9))
			],
			resizable(false)
		
	);

Figure diagonal2(Figure topleft, Figure rightbottom)
	= grid([
		[
			space(topleft, left(), top()),
			space()
		],
		[
			space(),
			space(rightbottom, right(), bottom())
		]
		],
		std(gap(5)), resizable(false)
		);

Figure visFig(Fig p)
	= diagonal(
		box(text(p.name, fontColor("white")), fillColor("DimGray"), gap(5)),
		vcat([
				box(vcat([box(text(a), resizable(false)) | a <- p.args]), gap(3)),
				box(mapfigexpr(p.body), resizable(false))
			], gap(0), std(gap(5)), resizable(true), std(font("Monaco")))
	);

Figure mapfigexpr(figvariable(FigName name)) = box(text(name), resizable(false));
Figure mapfigexpr(figliteral(FigNumber number)) = ellipse(text("<number>"), resizable(false));
Figure mapfigexpr(figbinary(FigName op, FigExpr left, FigExpr right))
	= diagonal(
		box(text(op, fontColor("white")), fillColor("DimGray")),
		vcat([
			mapfigexpr(left),
			mapfigexpr(right)
		])
	);

default Figure mapfigexpr(_) = box(text("body"), resizable(false));

Figure visFig2(Fig p)
{
	return grid([
		[
			box(text(p.name, fontColor("white")), fillColor("DimGray"), left(), top()),
			space()
		],
		[
			space(),
			vcat([
				box(vcat([box(text(a)) | a <- p.args]), gap(3)),
				box(text("body"), resizable(false))
			], gap(0), right(), bottom(), resizable(true))
		]
		],
		std(gap(5)), resizable(false)
		);
}

public void visualise(Fig p) = render(visualised(p));
public Figure visualised(Fig p) = visFig(p);

void visfig1() = visualise(types::Fig::example);
