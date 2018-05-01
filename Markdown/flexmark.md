---
title: "Stata Markdown - the Flexmark Specification"
author: "Doug Hemken"
date: "April 2018"
output: 
  html_document:
    includes:
      in_header: ../../../Rmd/headKBprod3.html
      before_body: ../../../Rmd/topKBprod.html
      after_body: ../../../Rmd/bottomKBprod.html
  css: ../../../Rmd/Rmd.css
  self_contained: no
  theme: null
  highlight: null
  toc: yes
---

There are many different flavors of the Markdown specification for
writing documents.  They all agree on the basic elements, so for really
straightforward Markdown documents - where each Markdown element is
used in isolation from other elements - any Markdown rendering software will
produce the same results.  

Things start to become more complicated
when you start using *extensions* of the core specification, like
tables or strikethrough fonts.  A further complication is when you
begin using the basic elements in combination, like using header elements
within block quotes, or even using paragraphs within list items.

Stata (as of version 15) has two different Markdown specifications built
into it\'s `markdown` command (and therefore, also into `dyndoc` 
and `dyntext`).  The default specification is ***flexmark***, and you
also have the option (currently undocumented) to use ***pegdown***.
These differ slightly from each other, meaning the same Markdown
document might come out looking different from each other.  They also
differ slightly from the ***pandoc*** default specification, which is
used in German Rodriguez\'s `markstat` command or when working in
Rstudio.

(Technical aside:  both *flexmark* and *pandoc* are configurable to emulate
other Markdown parser/renderers.  While the behavior of *pandoc* can be
changed through the use of command line options, changing the *flexmark*
emulation would require you to dig into the Java code.)

As a writer, you will probably want to pick one specification and stick
with that.  However, a downside to all three of these specifications
is that they are not particularly well documented in the details.  In what
follows, I try to fill in some of those details.

Although most descriptions of Markdown syntax point to Gruber\`s original
specification, two of the most thoroughly specified and described flavors
of Markdown are ***commonmark*** and ***gfm*** (Github-flavored Markdown, 
which aims to be a strict extension of commonmark).  Especially 
because *flexmark*
aims/claims to be a *commonmark* emulation by default, it is useful to
work through these specifications, in order to reveal
where they agree and/or disagree.

***

- [Gruber\'s description](https://daringfireball.net/projects/markdown/syntax)
- [Flexmark documentation](https://github.com/vsch/flexmark-java)
- [Commonmark specification](http://spec.commonmark.org/0.28/)
- [gfm specification](https://github.github.com/gfm/)
- [Pandoc specification](https://pandoc.org/MANUAL.html#pandocs-markdown)

***

## Basic Markdown Elements
These examples are rendered with *flexmark*, using Stata\'s `markdown`
command.

- [The basics, by example](markdownelements1.html)
  - [Emphasis](emphasis1.html)
  - [Code spans]()
  - [Inlines combined](inlinescombined1.html)
- [Paragraphs](paragraphs1.html)
- [Headers](headers1.html)
- [Theme Breaks](themebreaks1.html)
- [Block Quotes]()
- [Lists](lists.html)
- [Tables](tables1.html)