
<head>
<title>Basic Markdown Elements</title>
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

<!--#include virtual="/sscc/pubs/Rmd/topInclKB.html" -->

# Markdown Elements


The formatting elements specified by Markdown come in two basic types:  there
are *block* elements and *inline* elements.

**Block** elements include such things as *paragraphs* of text, *code blocks*, 
*block quotes*, *lists*, and *tables*.  *Headings*  and *theme breaks* (horizontal
rules) are also thought of as block elements

**Inline** elements includes things like *emphasis* (italics) and *strong
emphasis* (bold), *links* (URLs), *images* (image links), and *code spans*
(inline code).

One way to keep this straight is that *block* elements may contain *inline*
elements, but not the other way around.

## Inline Examples

Some simple examples:

| Markdown                                       | Output               |
|:----------------------------------------------:|:--------------------:|
| `*Emphasis*`                                   | *Emphasis*           |
| `**Strong** emphasis`                          | **Strong** emphasis  |
| \``Code`\`` span`                              | `Code` span          |
| `~~Strikethrough~~`                            | ~~Strikethrough~~    |
| `[URL](https://www.ssc.wisc.edu/~hemken)`      | [URL](https://www.ssc.wisc.edu/~hemken) |
| `Autolinks <https://www.ssc.wisc.edu/~hemken>` | Autolinks <https://www.ssc.wisc.edu/~hemken> |
| `Image ![](Graph.svg)`                         | Image ![](Graph.svg) |

Pandoc examples that do not work in flexmark or pegdown:

| Markdown          | Output            |
|:-----------------:|:-----------------:|
| Some~subscript~   | Some~subscript~   |
| Some^superscript^ | Some^superscript^ |
| Math $y=x_1+x_2$  | Math $y=x_1+x_2$  |

## Block Elements
The various block elements - paragraphs, headings, lists, etc. - may be
subdivided into two broad categories:  atomic blocks, often called "*leaf*
blocks", and *container* blocks, which can have other block elements 
nested within them.

Most block elements can include inline elements:  the exceptions are
theme breaks and code blocks.

***
A *paragraph* is a continous block of text.  It begins after another block
element ends, or after a blank line (a blank line is often what marks the
end of a block element).  A paragraph often ends with a blank line, but
may be interrupted by some other block elements.  
This is a paragraph.

***
A *header* is a distinct block of text.  These are marked either with
hash marks ("\#" and a space) or with dashes on the following line (either
"-" or "=").  There are six levels of hashed headers ("ATX" headers)
or two levels of underscore headers ("Setext" headers).  Setext
headers must be preceded by a blank line, ATX headers may interrupt
a paragraph (i.e. need not follow a blank line).

Markdown:

```
Header 2
--------
### Header 3
```

Output:

Header 2
--------
### Header 3

***
A *theme break* consists of three or more asterisks, underscores, or dashes,
on a line by themselves.  They may be interspersed with spaces.  They
usually require a preceding blank line, or they may be interpreted as
header indicators or as emphasis.

Markdown:

```
***
```

***
A *code block* is a continuous block of text that is formated as `<code>`.
Code blocks may be marked in two ways:  by indenting the text four 
spaces, and with code fences.  Code fences may include an information
tag (often used to process the code) or not.

Markdown:

~~~~
    indented code block
```
fenced code block
```
~~~~

Output:

    indented code block
```
fenced code block
```

***
A *table* (a "piped table") is marked with vertical bars between the cells,
rows on separate lines, and a required header line (similar to
underscore headers).  While not a part of strict Markdown, they are
available in all the Markdown flavors we use with Stata.

Markdown:

```
column 1 | column 2
---------|---------
value 1  | value 2
```

Output:

column 1 | column 2
---------|---------
value 1  | value 2

***
Block quotes and lists are container blocks, which may contain other block
elements.

Block quotes are marked with a preceding right angle, ">" and a space.
```
> A block quote with a
> ##### header 4
> and a table
>
> column 1 | column 2
> ---------|---------
> value 1  | value 2
```

> A block quote with a
> ##### header 4
> and a table
>
> column 1 | column 2
> ---------|---------
> value 1  | value 2

***
Lists may be either unordered or ordered.  Unordered lists are marked
with a dash, and asterisk, or a plus followed by a space
before each list item.  Ordered
lists begin each element with a numeral and a period, followed by a space.

List items can contain other blocks (not illustrated here).

Markdown:
```
- item 1
- item 2

1. item 1
2. item 2
```

Output:

- item 1
- item 2

1. item 1
2. item 2

<!--#include virtual="/sscc/pubs/Rmd/bottomInclKB.html" -->
