## [Pic](https://github.com/grammarware/bx-parsing/blob/master/src/types/Pic.rsc)

In order to use Rascal facilities, we represent graphical models as text with indentations
and fancy formatting, it is fairly easy to write a mapping between this form and a graphical
model of nicer looks. The "textual graphics" is enough as a proof of concept for our case
study.

![Example](https://github.com/grammarware/bx-parsing/raw/master/img/Pic.png)

```
module types::Pic

alias Pic = str;

Pic example =     "{f}
                '    (
                '        [arg]
                '    →
                '        {+}
                '            [arg]
                '            (1)
                '    )";
```

### See also:
* [mappings::Dra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Dra2Pic.rsc)
* [mappings::Pic2Dra](https://github.com/grammarware/bx-parsing/blob/master/src/mappings/Pic2Dra.rsc)
* [visualise::Pic](https://github.com/grammarware/bx-parsing/blob/master/src/visualise/Pic.rsc)
* [specific::Gra2Pic](https://github.com/grammarware/bx-parsing/blob/master/src/specific/Gra2Pic.rsc)
