# Some Examples of Headers

Headers may be written in two different styles, *setext* headers which are
marked up with \"underscores\", and *ATX* headers which are marked up with
hash marks (\"#\").

1. **Setext** headers are denoted with \"underscores\" (actually, at least 3
equal signs or dashes on the next line of text).  The text line of a setext
header must usually
be preceded by a blank line, it cannot \"interrupt\" another container.

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
	
	~~~
	summarize
	~~~
	After a code fence
	---
	---
	After a theme break
	---

	(Rules for finding the beginning of a setext header differ slightly between
	*flexmark*, *pegdown*, and *pandoc*.)

	In flexmark, no preceding blank line is needed at the beginning of 
	a document or the
	beginning of a blockquote.  Likewise, no preceding blank line is needed 
	where the preceding container has closed after a code fence or
	after a theme break).  Oddly, a setext header cannot
	be the first element in a list item, but can appear in a later paragraph
	within the list item.
	
	- item 1
	
	    Header 2
	    ---
	
2. **ATX** headers are denoted with \"hash\" marks (\"#\") and a space, before the
header text.  Up to six levels of headers are supported in HTML.
No preceding blank line required in this style.

	Written:

	~~~
	# Header 1
	## Header 2
	### Header 3
	#### Header 4
	##### Header 5
	###### Header 6
	####### not header 7
	~~~
	Rendered:
	
	> # Header 1
	> ## Header 2
	> ### Header 3
	> #### Header 4
	> ##### Header 5
	> ###### Header 6
	> ####### not header 7
	
3. Inlines within headers

	*Emphatic* **Strong** ~~Strikethrough~~ `Code`
	---
	
	## `Code` ~~Strikethrough~~ **Strong** _Emphasis_
	
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
