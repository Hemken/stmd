# Markdown List Examples
## Using *Flexmark* in Stata

### Doug Hemken
### May 2018

Lists may be ordered (numbered) or not (bulleted).

Unordered or bulleted lists:

* item A
* item Z

Ordered lists:

1. first item
2. second item

Unordered list elements are marked with
asterisks, dashes, or pluses.
No distinction is made between list markers, which may be
intermingled.

* asterisk item
- dash item
+ plus item
* asterisk item
- dash item
+ plus item

Ordered lists are marked by numerals and periods (not with right
parentheses in *flexmark*).  The numbering that you write
is arbitrary - in web
pages the type of numeral used is a *style* element.

1. first item
1. second item

2) not a list item

List items are *lazy*, that is, an item may continue across
more than one line of text.

- List items are *lazy*, that is, an item may continue across
more than one line text.

-----
Lists and paragraphs

A list begins with a list item after a blank line, a blockquote, 
a code block, or a header.

~~~
After a paragraph

- item

Included in paragraph text
- not an item
~~~
After a paragraph

- item

Included in paragraph text
- not an item

-----
Lists and headers

No blank line is needed after a header and before a list.
An ATX header interrups (ends) a list.


~~~
#### Header
1. item
#### Another header
~~~~
#### Header
1. item
#### Another header

Setext headers after list items require a preceding space,
or they become lazy item text plus a theme break.
~~~
Header
---
- item
Not a header
---
~~~
Header
---
- item
Not a header
---

-----
Lists and theme breaks

-----
Lists and code blocks

Lists need no separation from fenced code blocks.

~~~~
~~~
generate y = x
~~~
+ item
~~~
summarize y
~~~
~~~~
~~~
generate y = x
~~~
+ item
~~~
summarize y
~~~

A list may interrupt an indented code block.  However
an indented code block after a list item requires
some element besides a blank line to demarcate the
end of the list - blank lines followed by indented text become
a paragaph included in the item.

~~~
    generate z = y
1. item
    summarize z

2. item

	summarize z
~~~
    generate z = y
1. item
    summarize z

2. item

	summarize z

-----
Lists and block quotes

-----
Lists and tables

-----
The list continues as a series of list items, until it is ended
with a blank line.

Lists may be nested.  Sub-items are indented at least 4 spaces
and any marker may be used.

* item A
    - sub item A-1
    * sub item A-2

* level 1
    - level 2
        * level 3
            + level 4
                * level 5
        * level 3
		
1. item A
    1. sub item A-1
    1. sub item A-2

1. level 1
    - level 2
        1. level 3
            + level 4
                * level 5
        1. level 3

List markers and numerals are set by style, not by markdown.

Lists may be blockquoted.  Lazy blockquotes produce flat lists.
~~~~
~~~
> 1. item A
    1. sub item A-1
    1. sub item A-2
~~~
~~~~
> 1. item A
    1. sub item A-1
    1. sub item A-2

Explicit blockquotes can render sublists.
~~~~
~~~
> 1. item A
>      1. sub item A-1
>      1. sub item A-2
~~~
~~~~
> 1. item A
>      1. sub item A-1
>      1. sub item A-2

