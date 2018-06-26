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

# Markdown Header Examples
## Using *Flexmark* in Stata

### Doug Hemken
### May 2018

A header, like a paragraph, is a container block and any inline markdown
may be used within it.

Headers may be written in two different styles, *setext* headers which are
marked up with \"underscores\", and *ATX* headers which are marked up with
hash marks (\"#\").

1. **Setext** headers are denoted with \"underscores\" (actually, at least 3
equal signs or dashes on the next line of text).  The text line of a setext
header must usually
be *preceded* by a blank line, it cannot \"interrupt\" a paragraph.

	Written:
	
	~~~
	Header 1
	========
	Header 2
	---
	~~~

	Rendered:
	
	> Header 1
	> ========
	> Header 2
	> ---
	
	However, no blank line is needed after another header, after a fenced
	code block, or after an indented code block.
	
	A blank line is required after a block quote, a list item, or a 
	table in order to prevent it from
	being interpreted as a lazy header.
	
	~~~~
	~~~
	summarize z
	~~~
	After a code fence
	---
	    generate y = x
	After indented code
	---
	
	-----
	After a theme break
	---
	> Quoted text.
	
	After a block quote
	---
	- item 1
	
	After a list item
	---
	column 1 | column 2
    ---------|---------
    value 1  | value 2
	
    After a table
	---
	~~~~

	~~~
	summarize z
	~~~
	After a code fence
	---
	    generate y = x
	After indented code
	---
	
	-----
	After a theme break
	---
	> Quoted text.
	
	After a block quote
	---
	- item 1
	
	After a list item
	---
	column 1 | column 2
    ---------|---------
    value 1  | value 2
	
    After a table
	---
	
	(Rules for finding the beginning of a setext header differ slightly in
	*pegdown* after a paragraph, and after a theme break in both *pegdown*
	and *pandoc*.)

	In *flexmark*, no preceding blank line is needed at the beginning of 
	a document or the
	beginning of a blockquote.  Oddly, a setext header cannot
	be the first element in a list item, but can appear in a later paragraph
	within the list item.
	
	~~~~
	~~~
	> Within a blockquote
	> ---
	
	- item 1
	
	    Header 2
	    ---
	~~~
	~~~~
	
	> Within a blockquote
	> ---
	
	- item 1
	
	    Header 2
	    ---
	
2. **ATX** headers are denoted with \"hash\" marks (\"#\") and a space, before the
header text.  Up to six levels of headers are supported in HTML.
No preceding or trailing blank line required in this style, with the exception
of block quotes (and headers after list items are 
interpreted *within* the item in *pegdown* and *pandoc*).

	Written:

	~~~
	# Header 1
	## Header 2
	### Header 3
	#### Header 4
	##### Header 5
	###### Header 6
	####### no header 7 in HTML
	~~~
	Rendered:
	
	> # Header 1
	> ## Header 2
	> ### Header 3
	> #### Header 4
	> ##### Header 5
	> ###### Header 6
	> ####### no header 7 in HTML
	
	~~~~
	~~~
	summarize z
	~~~
	#### After a code fence
	    generate y = x
	#### After indented code
	
	-----
	#### After a theme break
	> Quoted text.
	
	#### After a block quote
	- item 1
	#### After a list item
	column 1 | column 2
    ---------|---------
    value 1  | value 2
	#### After a table
	~~~
	~~~~
	~~~
	summarize z
	~~~
	#### After a code fence
	    generate y = x
	#### After indented code
	
	-----
	#### After a theme break
	> Quoted text.
	
	#### After a block quote
	- item 1
	#### After a list item
	column 1 | column 2
    ---------|---------
    value 1  | value 2
	#### After a table
		
3. Inlines within headers

    ~~~~
	*Emphatic* **Strong** ~~Strikethrough~~ `Code`
	---
	#### `Code` ~~Strikethrough~~ **Strong** _Emphasis_
	~~~~

	*Emphatic* **Strong** ~~Strikethrough~~ `Code`
	---
	#### `Code` ~~Strikethrough~~ **Strong** _Emphasis_
	
3. Headers may appear within
	* Blockquotes.
		Written:
		~~~
		> ### Quoted header
		~~~
		Rendered:
		> ### Quoted header
		
	* Lists, written:
		~~~
		* ### Item 1
		* ### Item 2
		~~~
		Rendered:

		* ### Item 1
		* ### Item 2

<!--#include virtual="/sscc/pubs/Rmd/bottomInclKB.html" -->
</body>
