# Paragraph examples

A paragraph is a basic block element.  It
is composed of consecutive non-blank lines
that are not headers, blockquotes, code blocks, or lists.

A paragraph begins where a header, or code block ends, 
or after a blank line.

---
### Header text
After a header.

~~~
generate x = y
~~~
After a code block.

---
After lists or blockquotes requires an intervening blank line.

~~~~
~~~
- item 1

After a list item.
~~~
~~~~

- item 1

After a list item.
~~~~
~~~
> Quoted text.

After a blockquote requires a blank line.
~~~
~~~~

> Quoted text.

After a blockquote requires a blank line.

---
A paragraph *within* a blockquote.

~~~~
~~~
> First this.

> Then that.
~~~
~~~~
> First this.

> Then that.

A paragraph *within* a list item.

~~~~
~~~
1. item 1

    second paragraph
2. item 2
~~~
~~~~

1. item 1

    second paragraph
2. item 2

---

A paragraph may begin with up to three spaces in the first line.
Subsequent lines may have any number of spaces

---
Written:
~~~
   Begin a
      paragraph.
~~~

Rendered as:

   Begin a
      paragraph.

---
Too many leading spaces renders as code:
~~~
     Too many
	   spaces.
~~~

Renders as:

     Too many
	   spaces.
