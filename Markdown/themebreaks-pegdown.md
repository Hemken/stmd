# Theme Breaks (horizontal rules)

A theme break (a horizontal rule) is written as three or more dashes, 
underscores, or asterisks.  These may be preceded by up
to three spaces.  When rendered with *pegdown* or *pandoc* (default)
they usually must be preceded by a blank line, and followed by a blank line.

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

Rendered:

- - -

_ _ _

* * *

A theme break may appear in a block quote.

Written:

~~~
> ***
>
> quoted
>
> ***
>
> text
~~~

Rendered:

> ***
>
> quoted
>
> ***
>
> text

Can a theme break be contained in a list? Not in *pegdown* where it appears theme breaks
interrupt a list. However, *pandoc* appears the same as *flexmark*.

Notice using the same character as a list and
as a theme break yields a pure theme break (it is interpreted as a theme break
containing spaces).

Written:

~~~
- item 1
- 
    ***

- ---

- 
  ___

- item 2

* ***
~~~

Rendered:

- item 1
- 
    ***

- ---

- 
  ___

- item 2

* ***
