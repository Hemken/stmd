---
title: "Inline Elements"
author: "Doug Hemken"
date: "April 27, 2018"
output: html_document
---

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