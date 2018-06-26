<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>Markdown Paragraph Examples</title>
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

# Markdown Paragraph Examples
## Using *Flexmark* in Stata

### Doug Hemken
### May 2018

A paragraph is a basic block element.  It
is composed of consecutive lines of text.  These lines may be indented
up to three spaces (four spaces marks a *code block*).  By default
lines of text flow into each other.  Lines should
end with at most one space - two spaces or a backslash mark a hard line break.

Any of the inline (span) elements may be used within a paragraph.

A blank line always ends a paragraph.  In ***flexmark*** a paragraph 
may also be interrupted
(ended) by a block quote, a fenced code block, or an ATX header.
A paragraph not followed by a blank line subsumes any *following* paragraph,
theme break, indented code block, list item, or table - these elements 
usually become ordinary text.  A setext header subsumes the *preceding*
paragraph.

In ***pegdown***
and in ***pandoc***, the precedence of paragraphs over some containers 
are handled differently, as noted below.

-----
~~~~
~~~
This is
a paragraph.
~~~
~~~~
This is
a paragraph.

~~~~
~~~
This sentence is followed by a hard line break (two spaces).  
A sentence on a new line.
~~~
~~~~
This sentence is followed by a hard line break (two spaces).  
A sentence on a new line.

~~~~
~~~
   This paragraph text is indented 
     three spaces on the first line,
	 and more on subsequent lines.
~~~
~~~~
   This paragraph text is indented 
     three spaces on the first line,
	 and more on subsequent lines.

-----
A paragraph may follow a header, and it may be
interrupted by a ATX header - no blank line is needed to end the
paragraph in *flexmark* (a blank line is required in *pandoc*).

In *flexmark*, setext header text may be *lazy* - it may be broken over
several contiguous lines.  So in *flexmark* a blank line is required to
separate a paragraph and a following setext header (In *pegdown* setext
headers are not lazy, and no blank line is required.  In *pandoc* this
just wraps into a paragraph.)

~~~~
~~~
#### ATX header text
Paragraph after a header.
#### Another ATX header.
~~~
~~~~
#### ATX header text
Paragraph after a header.
#### Another ATX header.

~~~~
~~~
Setext header text
==================
Paragraph after a header.

A lazy setext
header
======
~~~
~~~~
Setext header text
==================
Paragraph after a header.

A lazy setext
header
======

-----
In *flexmark* and *pandoc* a paragraph may follow a theme break
with no intervening blank line. (In *pegdown*, theme breaks
need blank lines after them.) Theme breaks do not interrupt
paragraphs. (Also note that dashes can also denote a setext header, so a \"theme break\"
without a preceding blank could alter text before or after.) 

~~~~
~~~
* * *
Paragraph after a theme break.
* * *
~~~
~~~~
* * *
Paragraph after a theme break.
* * *


~~~~
~~~
Paragraph
---
with an included \"theme break\"
~~~
~~~~
Paragraph
---
with an included \"theme break\"

-----
In *flexmark* a paragraph needs no blank lines either
after or before a fenced code block (as with a header).

~~~~~
~~~~
~~~
generate x = y
~~~
After a code block.
~~~
replace y = x
~~~
~~~~
~~~~~

~~~
generate x = y
~~~
After a code block.
~~~
replace y = x
~~~

However, indented code blocks are run into paragraphs
that precede them without a blank line (like theme
breaks and other elements).

~~~~
~~~
    generate x = y
After an indented code block.
    replace y = x
~~~
~~~~

    generate x = y
After an indented code block.
    replace y = x

-----
A table after a paragraph requires a line break.  However, a paragraph
interrupts a table.

~~~~
~~~
Some text.

column 1 | column 2
---------|---------
value 1  | value 2
More text.
column A | column B
---------|---------
value a  | value b
~~~
~~~~
Some text.

column 1 | column 2
---------|---------
value 1  | value 2
More text.
column A | column B
---------|---------
value a  | value b

-----
A paragraph after a list item requires an intervening blank line, but not before!
(The opposite of theme breaks and indented code blocks.)

~~~~
~~~
- item 1

After a list item.
- not item 2

- item 1
Not after a list item.
- item 2
~~~
~~~~

- item 1

After a list item.
- not item 2

- item 1
Not after a list item.
- item 2

In the preceding example, the paragraph separates two lists.

A list item may contain multiple paragraphs, if they are indented four
spaces(and include
a preceding blank line).

~~~~
~~~
- item A

    An included new paragraph.
- item B
~~~
~~~~

- item A

    An included new paragraph.
- item B

-----
A paragraph after a block quotes requires an intervening blank line (like
list items, block quotes
allow lazy wrapping).  However, a block quote interrupts a paragraph.

~~~~
~~~
> Quoted text.

After a blockquote requires a blank line.
> More quoted text.
~~~
~~~~

> Quoted text.

After a blockquote requires a blank line.
> More quoted text.

Paragraphs may be contained within a blockquote (like lists) - the
end of the first paragraph is marked with a quoted blank line.

~~~~
~~~
> First this.
>
> Then that.
~~~
~~~~
> First this.
>
> Then that.

<!--#include virtual="/sscc/pubs/Rmd/bottomInclKB.html" -->
</body>
