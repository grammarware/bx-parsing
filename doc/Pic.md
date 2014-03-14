## Pic

In order to use Rascal facilities, we represent graphical models as text with indentations
and fancy formatting, it is fairly easy to write a mapping between this form and a graphical
model of nicer looks. The "textual graphics" is enough as a proof of concept for our case
study.

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Pic.png)

```
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
```

