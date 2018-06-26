<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>Markdown Theme Break Examples</title>
<meta name="author" content="Doug Hemken" />

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});
</script>
<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS_CHTML">
</script>
<!--#include virtual="../../../Rmd/headInclKB.html" -->

<link rel="stylesheet" href="../../../Rmd/Rmd.css" type="text/css" />
<style>
table {
    border-collapse: collapse;
}
table, th, td {
   border: 1px solid black;
}
blockquote {
    border-left: solid blue;
	padding-left: 10px;
}
</style>

</head>
<body>

<!--#include virtual="/sscc/pubs/Rmd/topInclKB.html" -->

# Markdown Theme Break Examples (horizontal rules)
## Using *Flexmark* 
### Doug Hemken
### May 2018

A theme break (a horizontal rule) is written as three or more dashes, 
underscores, or asterisks.  These may be preceded by up
to three spaces.  (When rendered with *pegdown* or *pandoc*
they usually must be preceded by a blank line, and followed by a blank line.)

This is a block element that **cannot** contain inline elements.

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

### Theme breaks and headers
A theme break may appear before or after a header with no blank lines.

~~~
#### Header 4
---
#### Another header

Header 2
---
---
Header 2 again
---
~~~
#### Header 4
---
#### Another header

Header 2
---
---
Header 2 again
---

### Theme breaks and paragraphs
Theme breaks do not interrupt paragraphs (dashes may be interpreted
as setext headings).

~~~
Some text.
---
More text.
___

Yet more.
***
~~~
Some text.
---
More text.
___

Yet more.
***

### Theme breaks and code blocks
A theme break may appear immediately before or after a fenced code block
or an indented code block.

~~~~
~~~
generate y = x
~~~
***
~~~
summarize y
~~~

	generate y = x
***
	summarize y
~~~~
~~~
generate y = x
~~~
***
~~~
summarize y
~~~

	generate y = x
***
	summarize y

### Theme breaks and tables
A theme break requires no blank line before a table, but does require one
after (like a paragraph).

~~~
***
column 1 | column 2
---------|---------
value 1  | value 2

---
~~~
***
column 1 | column 2
---------|---------
value 1  | value 2

---

### Theme breaks and block quotes
A theme break may appear before a block quote with no blank line.  After a
block quote a blank line is required (because block quotes have lazy 
continuation).

~~~
> Quoted text.

---
> More quotes.
~~~
> Quoted text.

---
> More quotes.

A theme break may appear within a block quote.

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

### Theme breaks and lists
A theme break may appear before or after a list with no blank lines.

~~~
- list 1
---
- list 2
~~~
- list 1
---
- list 2

A theme break may be contained in a list, if it is composed of characters that
contrast with the list item marker. Notice using the same character as a list item and
as a theme break yields a pure theme break, interrupting the list.

Written:
~~~
- item 1, list 1
- ***
- ---
- ___
- item 2, list 2
* ***
~~~
Rendered:

- item 1, list 1
- ***
- ---
- ___
- item 2, list 2
* ***

<!--#include virtual="/sscc/pubs/Rmd/bottomInclKB.html" -->
</body>
