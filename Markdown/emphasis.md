## Emphasis and strong emphasis

John Gruber's original [Markdown syntax
description](http://daringfireball.net/projects/markdown/syntax#em) says:

> Markdown treats asterisks (`*`) and underscores (`_`) as indicators of
> emphasis. Text wrapped with one `*` or `_` will be wrapped with an HTML
> `<em>` tag; double `*`'s or `_`'s will be wrapped with an HTML `<strong>`
> tag.

This is enough for most users, but these rules leave much undecided,
especially when it comes to nested emphasis.  The original
`Markdown.pl` test suite makes it clear that triple `***` and
`___` delimiters can be used for strong emphasis, and most
implementations have also allowed the following patterns 
(pegdown does not recognize ***strong** in emph*):
~~~~
```
***strong emph***  
***strong** in emph*  
***emph* in strong**  
**in strong *emph***  
*in emph **strong***
```
~~~~
***strong emph***  
***strong** in emph*  
***emph* in strong**  
**in strong *emph***  
*in emph **strong***

The following patterns are less widely supported, but the intent
is clear and they are useful (especially in contexts like bibliography
entries)(flexmark and pegdown see these are straight emphasis and strong):
~~~~
```
*emph *with emph* in it*  
**strong **with strong** in it**
```
~~~~
*emph *with emph* in it*  
**strong **with strong** in it**

Many implementations have also restricted intraword emphasis to
the `*` forms, to avoid unwanted emphasis in words containing
internal underscores.  (It is best practice to put these in code
spans, but users often do not.) (Flexmark recognizes internal emphasis,
pegdown does not.)
~~~~
```
internal emphasis: foo*bar*baz
no emphasis: foo_bar_baz
```
~~~~
internal emphasis: foo*bar*baz  
no emphasis: foo_bar_baz

The rules given below capture all of these patterns, while allowing
for efficient parsing strategies that do not backtrack.

First, some definitions.  A [delimiter run](@) is either
a sequence of one or more `*` characters that is not preceded or
followed by a non-backslash-escaped `*` character, or a sequence
of one or more `_` characters that is not preceded or followed by
a non-backslash-escaped `_` character.

A [left-flanking delimiter run](@) is
a [delimiter run] that is (a) not followed by [Unicode whitespace],
and (b) not followed by a [punctuation character], or
preceded by [Unicode whitespace] or a [punctuation character].
For purposes of this definition, the beginning and the end of
the line count as Unicode whitespace.

A [right-flanking delimiter run](@) is
a [delimiter run] that is (a) not preceded by [Unicode whitespace],
and (b) not preceded by a [punctuation character], or
followed by [Unicode whitespace] or a [punctuation character].
For purposes of this definition, the beginning and the end of
the line count as Unicode whitespace.

Here are some examples of delimiter runs.

  - left-flanking but not right-flanking:

    ```
    ***abc
      _abc
    **"abc"
     _"abc"
    ```

  - right-flanking but not left-flanking:

    ```
     abc***
     abc_
    "abc"**
    "abc"_
    ```

  - Both left and right-flanking:

    ```
     abc***def
    "abc"_"def"
    ```

  - Neither left nor right-flanking:

    ```
    abc *** def
    a _ b
    ```

(The idea of distinguishing left-flanking and right-flanking
delimiter runs based on the character before and the character
after comes from Roopesh Chander's
[vfmd](http://www.vfmd.org/vfmd-spec/specification/#procedure-for-identifying-emphasis-tags).
vfmd uses the terminology "emphasis indicator string" instead of "delimiter
run," and its rules for distinguishing left- and right-flanking runs
are a bit more complex than the ones given here.)

The following rules define emphasis and strong emphasis:

1.  A single `*` character [can open emphasis](@)
    iff (if and only if) it is part of a [left-flanking delimiter run].

2.  A single `_` character [can open emphasis] iff
    it is part of a [left-flanking delimiter run]
    and either (a) not part of a [right-flanking delimiter run]
    or (b) part of a [right-flanking delimiter run]
    preceded by punctuation.

3.  A single `*` character [can close emphasis](@)
    iff it is part of a [right-flanking delimiter run].

4.  A single `_` character [can close emphasis] iff
    it is part of a [right-flanking delimiter run]
    and either (a) not part of a [left-flanking delimiter run]
    or (b) part of a [left-flanking delimiter run]
    followed by punctuation.

5.  A double `**` [can open strong emphasis](@)
    iff it is part of a [left-flanking delimiter run].

6.  A double `__` [can open strong emphasis] iff
    it is part of a [left-flanking delimiter run]
    and either (a) not part of a [right-flanking delimiter run]
    or (b) part of a [right-flanking delimiter run]
    preceded by punctuation.

7.  A double `**` [can close strong emphasis](@)
    iff it is part of a [right-flanking delimiter run].

8.  A double `__` [can close strong emphasis] iff
    it is part of a [right-flanking delimiter run]
    and either (a) not part of a [left-flanking delimiter run]
    or (b) part of a [left-flanking delimiter run]
    followed by punctuation.

9.  Emphasis begins with a delimiter that [can open emphasis] and ends
    with a delimiter that [can close emphasis], and that uses the same
    character (`_` or `*`) as the opening delimiter.  The
    opening and closing delimiters must belong to separate
    [delimiter runs].  If one of the delimiters can both
    open and close emphasis, then the sum of the lengths of the
    delimiter runs containing the opening and closing delimiters
    must not be a multiple of 3.

10. Strong emphasis begins with a delimiter that
    [can open strong emphasis] and ends with a delimiter that
    [can close strong emphasis], and that uses the same character
    (`_` or `*`) as the opening delimiter.  The
    opening and closing delimiters must belong to separate
    [delimiter runs].  If one of the delimiters can both open
    and close strong emphasis, then the sum of the lengths of
    the delimiter runs containing the opening and closing
    delimiters must not be a multiple of 3.

11. A literal `*` character cannot occur at the beginning or end of
    `*`-delimited emphasis or `**`-delimited strong emphasis, unless it
    is backslash-escaped.

12. A literal `_` character cannot occur at the beginning or end of
    `_`-delimited emphasis or `__`-delimited strong emphasis, unless it
    is backslash-escaped.

Where rules 1--12 above are compatible with multiple parsings,
the following principles resolve ambiguity:

13. The number of nestings should be minimized. Thus, for example,
    an interpretation `<strong>...</strong>` is always preferred to
    `<em><em>...</em></em>`.

14. An interpretation `<em><strong>...</strong></em>` is always
    preferred to `<strong><em>...</em></strong>`.

15. When two potential emphasis or strong emphasis spans overlap,
    so that the second begins before the first ends and ends after
    the first ends, the first takes precedence. Thus, for example,
    `*foo _bar* baz_` is parsed as `<em>foo _bar</em> baz_` rather
    than `*foo <em>bar* baz</em>`.

16. When there are two potential emphasis or strong emphasis spans
    with the same closing delimiter, the shorter one (the one that
    opens later) takes precedence. Thus, for example,
    `**foo **bar baz**` is parsed as `**foo <strong>bar baz</strong>`
    rather than `<strong>foo **bar baz</strong>`.

17. Inline code spans, links, images, and HTML tags group more tightly
    than emphasis.  So, when there is a choice between an interpretation
    that contains one of these elements and one that does not, the
    former always wins.  Thus, for example, `*[foo*](bar)` is
    parsed as `*<a href="bar">foo*</a>` rather than as
    `<em>[foo</em>](bar)`.

These rules can be illustrated through a series of examples.

Rule 1:
~~~~
```
*foo bar*
```
~~~~
*foo bar*


This is not emphasis, because the opening `*` is followed by
whitespace, and hence not part of a [left-flanking delimiter run]:
~~~~
```
a * foo bar*
```
~~~~
a * foo bar*


This is not emphasis, because the opening `*` is preceded
by an alphanumeric and followed by punctuation, and hence
not part of a [left-flanking delimiter run]:

~~~~
```
a*"foo"*
```
~~~~
a*"foo"*


Unicode nonbreaking spaces count as whitespace, too:

~~~~
```
* a *
```
~~~~
* a *


Intraword emphasis with `*` is permitted (flexmark, not pegdown):

~~~~
```
foo*bar*
```
~~~~
foo*bar*


~~~~
```
5*6*78
```
~~~~
5*6*78


Rule 2:
~~~~
```
_foo bar_
```
~~~~
_foo bar_


This is not emphasis, because the opening `_` is followed by
whitespace:

~~~~
```
_ foo bar_
```
~~~~
_ foo bar_


This is not emphasis, because the opening `_` is preceded
by an alphanumeric and followed by punctuation:

~~~~
```
a_"foo"_
```
~~~~
a_"foo"_


Emphasis with `_` is not allowed inside words:

~~~~
```
foo_bar_
```
~~~~
foo_bar_


~~~~
```
5_6_78
```
~~~~
5_6_78


~~~~
```
пристаням_стремятся_
```
~~~~
пристаням_стремятся_


Here `_` does not generate emphasis, because the first delimiter run
is right-flanking and the second left-flanking:

~~~~
```
aa_"bb"_cc
```
~~~~
aa_"bb"_cc


This is emphasis, even though the opening delimiter is
both left- and right-flanking, because it is preceded by
punctuation (flexmark, not pegdown):

~~~~
```
foo-_(bar)_
```
~~~~
foo-_(bar)_


Rule 3:

This is not emphasis, because the closing delimiter does
not match the opening delimiter:

~~~~
```
_foo*
```
~~~~
_foo*


This is not emphasis, because the closing `*` is preceded by
whitespace:

~~~~
```
*foo bar *
```
~~~~
*foo bar *


A newline also counts as whitespace:

~~~~
```
*foo bar
*
```
~~~~
*foo bar
*


This is not emphasis, because the second `*` is
preceded by punctuation and followed by an alphanumeric
(hence it is not part of a [right-flanking delimiter run]:

~~~~
```
*(*foo)
```
~~~~
*(*foo)


The point of this restriction is more easily appreciated
with this example (flexmark, not pegdown):

~~~~
```
*(*foo*)*
```
~~~~
*(*foo*)*


Intraword emphasis with `*` is allowed in flexmark, not pegdown:

~~~~
```
*foo*bar
```
~~~~
*foo*bar



Rule 4:

This is not emphasis, because the closing `_` is preceded by
whitespace:

~~~~```
_foo bar _
.
<p>_foo bar _</p>
```~~~~


This is not emphasis, because the second `_` is
preceded by punctuation and followed by an alphanumeric:

~~~~```
_(_foo)
.
<p>_(_foo)</p>
```~~~~


This is emphasis within emphasis:

~~~~```
_(_foo_)_
.
<p><em>(<em>foo</em>)</em></p>
```~~~~


Intraword emphasis is disallowed for `_`:

~~~~```
_foo_bar
.
<p>_foo_bar</p>
```~~~~


~~~~```
_пристаням_стремятся
.
<p>_пристаням_стремятся</p>
```~~~~


~~~~```
_foo_bar_baz_
.
<p><em>foo_bar_baz</em></p>
```~~~~


This is emphasis, even though the closing delimiter is
both left- and right-flanking, because it is followed by
punctuation:

~~~~```
_(bar)_.
.
<p><em>(bar)</em>.</p>
```~~~~


Rule 5:

~~~~```
**foo bar**
.
<p><strong>foo bar</strong></p>
```~~~~


This is not strong emphasis, because the opening delimiter is
followed by whitespace:

~~~~```
** foo bar**
.
<p>** foo bar**</p>
```~~~~


This is not strong emphasis, because the opening `**` is preceded
by an alphanumeric and followed by punctuation, and hence
not part of a [left-flanking delimiter run]:

~~~~```
a**"foo"**
.
<p>a**&quot;foo&quot;**</p>
```~~~~


Intraword strong emphasis with `**` is permitted:

~~~~```
foo**bar**
.
<p>foo<strong>bar</strong></p>
```~~~~


Rule 6:

~~~~```
__foo bar__
.
<p><strong>foo bar</strong></p>
```~~~~


This is not strong emphasis, because the opening delimiter is
followed by whitespace:

~~~~```
__ foo bar__
.
<p>__ foo bar__</p>
```~~~~


A newline counts as whitespace:
~~~~```
__
foo bar__
.
<p>__
foo bar__</p>
```~~~~


This is not strong emphasis, because the opening `__` is preceded
by an alphanumeric and followed by punctuation:

~~~~```
a__"foo"__
.
<p>a__&quot;foo&quot;__</p>
```~~~~


Intraword strong emphasis is forbidden with `__`:

~~~~```
foo__bar__
.
<p>foo__bar__</p>
```~~~~


~~~~```
5__6__78
.
<p>5__6__78</p>
```~~~~


~~~~```
пристаням__стремятся__
.
<p>пристаням__стремятся__</p>
```~~~~


~~~~```
__foo, __bar__, baz__
.
<p><strong>foo, <strong>bar</strong>, baz</strong></p>
```~~~~


This is strong emphasis, even though the opening delimiter is
both left- and right-flanking, because it is preceded by
punctuation:

~~~~```
foo-__(bar)__
.
<p>foo-<strong>(bar)</strong></p>
```~~~~



Rule 7:

This is not strong emphasis, because the closing delimiter is preceded
by whitespace:

~~~~```
**foo bar **
.
<p>**foo bar **</p>
```~~~~


(Nor can it be interpreted as an emphasized `*foo bar *`, because of
Rule 11.)

This is not strong emphasis, because the second `**` is
preceded by punctuation and followed by an alphanumeric:

~~~~```
**(**foo)
.
<p>**(**foo)</p>
```~~~~


The point of this restriction is more easily appreciated
with these examples:

~~~~```
*(**foo**)*
.
<p><em>(<strong>foo</strong>)</em></p>
```~~~~


~~~~```
**Gomphocarpus (*Gomphocarpus physocarpus*, syn.
*Asclepias physocarpa*)**
.
<p><strong>Gomphocarpus (<em>Gomphocarpus physocarpus</em>, syn.
<em>Asclepias physocarpa</em>)</strong></p>
```~~~~


~~~~```
**foo "*bar*" foo**
.
<p><strong>foo &quot;<em>bar</em>&quot; foo</strong></p>
```~~~~


Intraword emphasis:

~~~~```
**foo**bar
.
<p><strong>foo</strong>bar</p>
```~~~~


Rule 8:

This is not strong emphasis, because the closing delimiter is
preceded by whitespace:

~~~~```
__foo bar __
.
<p>__foo bar __</p>
```~~~~


This is not strong emphasis, because the second `__` is
preceded by punctuation and followed by an alphanumeric:

~~~~```
__(__foo)
.
<p>__(__foo)</p>
```~~~~


The point of this restriction is more easily appreciated
with this example:

~~~~```
_(__foo__)_
.
<p><em>(<strong>foo</strong>)</em></p>
```~~~~


Intraword strong emphasis is forbidden with `__`:

~~~~```
__foo__bar
.
<p>__foo__bar</p>
```~~~~


~~~~```
__пристаням__стремятся
.
<p>__пристаням__стремятся</p>
```~~~~


~~~~```
__foo__bar__baz__
.
<p><strong>foo__bar__baz</strong></p>
```~~~~


This is strong emphasis, even though the closing delimiter is
both left- and right-flanking, because it is followed by
punctuation:

~~~~```
__(bar)__.
.
<p><strong>(bar)</strong>.</p>
```~~~~


Rule 9:

Any nonempty sequence of inline elements can be the contents of an
emphasized span.

~~~~```
*foo [bar](/url)*
.
<p><em>foo <a href="/url">bar</a></em></p>
```~~~~


~~~~```
*foo
bar*
.
<p><em>foo
bar</em></p>
```~~~~


In particular, emphasis and strong emphasis can be nested
inside emphasis:

~~~~```
_foo __bar__ baz_
.
<p><em>foo <strong>bar</strong> baz</em></p>
```~~~~


~~~~```
_foo _bar_ baz_
.
<p><em>foo <em>bar</em> baz</em></p>
```~~~~


~~~~```
__foo_ bar_
.
<p><em><em>foo</em> bar</em></p>
```~~~~


~~~~```
*foo *bar**
.
<p><em>foo <em>bar</em></em></p>
```~~~~


~~~~```
*foo **bar** baz*
.
<p><em>foo <strong>bar</strong> baz</em></p>
```~~~~

~~~~```
*foo**bar**baz*
.
<p><em>foo<strong>bar</strong>baz</em></p>
```~~~~

Note that in the preceding case, the interpretation

``` markdown
<p><em>foo</em><em>bar<em></em>baz</em></p>
```


is precluded by the condition that a delimiter that
can both open and close (like the `*` after `foo`)
cannot form emphasis if the sum of the lengths of
the delimiter runs containing the opening and
closing delimiters is a multiple of 3.

The same condition ensures that the following
cases are all strong emphasis nested inside
emphasis, even when the interior spaces are
omitted:


~~~~```
***foo** bar*
.
<p><em><strong>foo</strong> bar</em></p>
```~~~~


~~~~```
*foo **bar***
.
<p><em>foo <strong>bar</strong></em></p>
```~~~~


~~~~```
*foo**bar***
.
<p><em>foo<strong>bar</strong></em></p>
```~~~~


Indefinite levels of nesting are possible:

~~~~```
*foo **bar *baz* bim** bop*
.
<p><em>foo <strong>bar <em>baz</em> bim</strong> bop</em></p>
```~~~~


~~~~```
*foo [*bar*](/url)*
.
<p><em>foo <a href="/url"><em>bar</em></a></em></p>
```~~~~


There can be no empty emphasis or strong emphasis:

~~~~```
** is not an empty emphasis
.
<p>** is not an empty emphasis</p>
```~~~~


~~~~```
**** is not an empty strong emphasis
.
<p>**** is not an empty strong emphasis</p>
```~~~~



Rule 10:

Any nonempty sequence of inline elements can be the contents of an
strongly emphasized span.

~~~~```
**foo [bar](/url)**
.
<p><strong>foo <a href="/url">bar</a></strong></p>
```~~~~


~~~~```
**foo
bar**
.
<p><strong>foo
bar</strong></p>
```~~~~


In particular, emphasis and strong emphasis can be nested
inside strong emphasis:

~~~~```
__foo _bar_ baz__
.
<p><strong>foo <em>bar</em> baz</strong></p>
```~~~~


~~~~```
__foo __bar__ baz__
.
<p><strong>foo <strong>bar</strong> baz</strong></p>
```~~~~


~~~~```
____foo__ bar__
.
<p><strong><strong>foo</strong> bar</strong></p>
```~~~~


~~~~```
**foo **bar****
.
<p><strong>foo <strong>bar</strong></strong></p>
```~~~~


~~~~```
**foo *bar* baz**
.
<p><strong>foo <em>bar</em> baz</strong></p>
```~~~~


~~~~```
**foo*bar*baz**
.
<p><strong>foo<em>bar</em>baz</strong></p>
```~~~~


~~~~```
***foo* bar**
.
<p><strong><em>foo</em> bar</strong></p>
```~~~~


~~~~```
**foo *bar***
.
<p><strong>foo <em>bar</em></strong></p>
```~~~~


Indefinite levels of nesting are possible:

~~~~```
**foo *bar **baz**
bim* bop**
.
<p><strong>foo <em>bar <strong>baz</strong>
bim</em> bop</strong></p>
```~~~~


~~~~```
**foo [*bar*](/url)**
.
<p><strong>foo <a href="/url"><em>bar</em></a></strong></p>
```~~~~


There can be no empty emphasis or strong emphasis:

~~~~```
__ is not an empty emphasis
.
<p>__ is not an empty emphasis</p>
```~~~~


~~~~```
____ is not an empty strong emphasis
.
<p>____ is not an empty strong emphasis</p>
```~~~~



Rule 11:

~~~~```
foo ***
.
<p>foo ***</p>
```~~~~


~~~~```
foo *\**
.
<p>foo <em>*</em></p>
```~~~~


~~~~```
foo *_*
.
<p>foo <em>_</em></p>
```~~~~


~~~~```
foo *****
.
<p>foo *****</p>
```~~~~


~~~~```
foo **\***
.
<p>foo <strong>*</strong></p>
```~~~~


~~~~```
foo **_**
.
<p>foo <strong>_</strong></p>
```~~~~


Note that when delimiters do not match evenly, Rule 11 determines
that the excess literal `*` characters will appear outside of the
emphasis, rather than inside it:

~~~~```
**foo*
.
<p>*<em>foo</em></p>
```~~~~


~~~~```
*foo**
.
<p><em>foo</em>*</p>
```~~~~


~~~~```
***foo**
.
<p>*<strong>foo</strong></p>
```~~~~


~~~~```
****foo*
.
<p>***<em>foo</em></p>
```~~~~


~~~~```
**foo***
.
<p><strong>foo</strong>*</p>
```~~~~


~~~~```
*foo****
.
<p><em>foo</em>***</p>
```~~~~



Rule 12:

~~~~```
foo ___
.
<p>foo ___</p>
```~~~~


~~~~```
foo _\__
.
<p>foo <em>_</em></p>
```~~~~


~~~~```
foo _*_
.
<p>foo <em>*</em></p>
```~~~~


~~~~```
foo _____
.
<p>foo _____</p>
```~~~~


~~~~```
foo __\___
.
<p>foo <strong>_</strong></p>
```~~~~


~~~~```
foo __*__
.
<p>foo <strong>*</strong></p>
```~~~~


~~~~```
__foo_
.
<p>_<em>foo</em></p>
```~~~~


Note that when delimiters do not match evenly, Rule 12 determines
that the excess literal `_` characters will appear outside of the
emphasis, rather than inside it:

~~~~```
_foo__
.
<p><em>foo</em>_</p>
```~~~~


~~~~```
___foo__
.
<p>_<strong>foo</strong></p>
```~~~~


~~~~```
____foo_
.
<p>___<em>foo</em></p>
```~~~~


~~~~```
__foo___
.
<p><strong>foo</strong>_</p>
```~~~~


~~~~```
_foo____
.
<p><em>foo</em>___</p>
```~~~~


Rule 13 implies that if you want emphasis nested directly inside
emphasis, you must use different delimiters:

~~~~```
**foo**
.
<p><strong>foo</strong></p>
```~~~~


~~~~```
*_foo_*
.
<p><em><em>foo</em></em></p>
```~~~~


~~~~```
__foo__
.
<p><strong>foo</strong></p>
```~~~~


~~~~```
_*foo*_
.
<p><em><em>foo</em></em></p>
```~~~~


However, strong emphasis within strong emphasis is possible without
switching delimiters:

~~~~```
****foo****
.
<p><strong><strong>foo</strong></strong></p>
```~~~~


~~~~```
____foo____
.
<p><strong><strong>foo</strong></strong></p>
```~~~~



Rule 13 can be applied to arbitrarily long sequences of
delimiters:

~~~~```
******foo******
.
<p><strong><strong><strong>foo</strong></strong></strong></p>
```~~~~


Rule 14:

~~~~```
***foo***
.
<p><em><strong>foo</strong></em></p>
```~~~~


~~~~```
_____foo_____
.
<p><em><strong><strong>foo</strong></strong></em></p>
```~~~~


Rule 15:

~~~~```
*foo _bar* baz_
.
<p><em>foo _bar</em> baz_</p>
```~~~~


~~~~```
*foo __bar *baz bim__ bam*
.
<p><em>foo <strong>bar *baz bim</strong> bam</em></p>
```~~~~


Rule 16:

~~~~```
**foo **bar baz**
.
<p>**foo <strong>bar baz</strong></p>
```~~~~


~~~~```
*foo *bar baz*
.
<p>*foo <em>bar baz</em></p>
```~~~~


Rule 17:

~~~~```
*[bar*](/url)
.
<p>*<a href="/url">bar*</a></p>
```~~~~


~~~~```
_foo [bar_](/url)
.
<p>_foo <a href="/url">bar_</a></p>
```~~~~


~~~~```
*<img src="foo" title="*"/>
.
<p>*<img src="foo" title="*"/></p>
```~~~~


~~~~```
**<a href="**">
.
<p>**<a href="**"></p>
```~~~~


~~~~```
__<a href="__">
.
<p>__<a href="__"></p>
```~~~~


~~~~```
*a `*`*
.
<p><em>a <code>*</code></em></p>
```~~~~


~~~~```
_a `_`_
.
<p><em>a <code>_</code></em></p>
```~~~~


~~~~```
**a<http://foo.bar/?q=**>
.
<p>**a<a href="http://foo.bar/?q=**">http://foo.bar/?q=**</a></p>
```~~~~


~~~~```
__a<http://foo.bar/?q=__>
.
<p>__a<a href="http://foo.bar/?q=__">http://foo.bar/?q=__</a></p>
```~~~~


