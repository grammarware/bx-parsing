@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{
	In order to use Rascal facilities, we represent graphical models as text with indentations
	and fancy formatting, it is fairly easy to write a mapping between this form and a graphical
	model of nicer looks. The “textual graphics” is enough as a proof of concept for our case
	study.
}
module types::Pic

alias Pic = str;

Pic example = 	"{f}
				'	(
				'		[arg]
				'	→
				'		{+}
				'			[arg]
				'			(1)
				'	)";