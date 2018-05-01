# Lists

Lists may be ordered (numbered) or not (bulleted).

Bulleted:

* item A
* item Z

Ordered:

1. first item
2. second item

No distinction is made between list markers, which may be
asterisks, dashes, or pluses.

* asterisk item
- dash item
+ plus item
* asterisk item
- dash item
+ plus item

Ordered lists are marked by numerals and periods (not right
parentheses).

1. first item, `1.`
1. second item, `1.`

2) not a list item

Begin after a blank line, a blockquote, or a code block, or a header.
(A blank is required after an ordinary paragraph.)

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

