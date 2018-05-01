<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>Markdown Inlines Combined</title>
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

#Markdown Inlines Combined

Combining inline Markdown elements:

With asterisks:

*Emphasis*\
**Strong**\
***Emphatic strong***\
*** not Emphatic strong (leading space)*** \
***Emphatic strong (trailing space) *** \
* **spaced markers** * (a leading space)\
** *spaced markers* ** 

With underscores:

_Emphasis_ \
__Strong__ \
___Emphatic strong___ 

Mixed underscores and asterisks - must
be properly nested:

*__Emphatic strong__* \
_**Emphatic strong**_ 

Overlapping (not nested) demarcation:

_**emphatic strong_** \
__*strong emphasis__* \
*~~emphatic strikethrough*~~ \
~~**striken strong~~** 


With tildes:

~~Strikethrough~~\
*~~Emphatic strikethrough~~*\
~~*Stricken emphasis*~~\
**~~*Strong stricken emphasis*~~**

[url text](@)\
*[url text](@)* emphasized\
[*url text*](@) embedded\
**[url text](@)** strong\
*[**url text**](@)* emphasized, strong embedded\
~~[url text](@)~~ stricken

Code spans may be embedded in other inlines, but
not vice versa.

*`code span`* emphatic\
**`code span`** strong\
~~`code span`~~ stricken\
[`url text`](@) embedded code in url

But not

`*code span*` emphatic\
`**code span**` strong\
`~~code span~~` stricken\
`[url text](@)` embedded code in url

Math (where enabled) ignores emphasis:

$y=x_1+x_2$ \
*$y=x_1+x_2$* emphatic\
~~$y=x_1+x_2$~~ striken\
[$y=x_1+x_2$](@) as url text

Code spans and math can't mix.

<!--#include virtual="/sscc/pubs/Rmd/bottomInclKB.html" -->
</body>
