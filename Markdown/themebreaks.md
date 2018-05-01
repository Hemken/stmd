# Theme Breaks (horizontal rules)

A theme break (a horizontal rule) is written as three or more dashes, 
underscores, or asterisks.  These may be preceded by up
to three spaces.  (When rendered with *pegdown* or *pandoc* (default)
they usually must be preceded by a blank line, and followed by a blank line.)

Written as:

    ---
	___
	***
Rendered as:

---
___
***

Too few marks do not work:

--

__

**

The marks may be interspersed with spaces, but not any other characters.

Written:
~~~
- - -
_ _ _
* * *
~~~

- - -
_ _ _
* * *

Theme breaks do not interrupt paragraphs (the marks may be interpreted
as emphasis or setext headings).

A theme break may appear in a block quote.

Written:
~~~
> ***
> quoted
>
> ***
> text
~~~
Rendered:
> ***
> quoted
>
> ***
> text

A theme break may be contained in a list, if it is composed of characters that
contrast with the list item marker. Notice using the same character as a list item and
as a theme break yields a pure theme break, interrupting the list.

Written:
~~~
- item 1
- ***
- ---
- ___
- item 2
* ***
~~~
Rendered:

- item 1
- ***
- ---
- ___
- item 2
* ***
