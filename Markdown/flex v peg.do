cd z:/public_web/stataworkshops/stmd/markdown

markdown dd_include.md, saving(dd_include.html) replace

markdown markdownelements.md, saving(markdownelements1.html) replace
markdown markdownelements-p.md, saving(markdownelements2.html) replace pegdown
local pandoc "c:/program files/rstudio/bin/pandoc/pandoc"
local inchead "../../../Rmd/headInclKB.html"
local incbody "../../../Rmd/topInclKB.html"
local incfoot "../../../Rmd/bottomInclKB.html"
local inccss  "../../../Rmd/Rmd.css"
stpandoc markdownelements-p.md, saving(markdownelements3.html) replace ///
	path(`pandoc') from(markdown) pargs(--mathjax ///
	-H `inchead' -B `incbody' -A `incfoot' -c `inccss')

markdown paragraphs.md, saving(paragraphs1.html) replace
markdown paragraphs-p.md, saving(paragraphs2.html) replace pegdown
local pandoc "c:/program files/rstudio/bin/pandoc/pandoc"
local inchead "../../../Rmd/headInclKB.html"
local incbody "../../../Rmd/topInclKB.html"
local incfoot "../../../Rmd/bottomInclKB.html"
local inccss  "../../../Rmd/Rmd.css"
stpandoc paragraphs-p.md, saving(paragraphs3.html) replace ///
	path(`pandoc') from(markdown) pargs(--mathjax ///
	-H `inchead' -B `incbody' -A `incfoot' -c `inccss')

markdown headers.md, saving(headers1.html) replace
markdown headers-p.md, saving(headers2.html) replace pegdown
local pandoc "c:/program files/rstudio/bin/pandoc/pandoc"
local inchead "../../../Rmd/headInclKB.html"
local incbody "../../../Rmd/topInclKB.html"
local incfoot "../../../Rmd/bottomInclKB.html"
local inccss  "../../../Rmd/Rmd.css"
stpandoc headers-p.md, saving(headers3.html) replace ///
	path(`pandoc') from(markdown) pargs(--mathjax ///
	-H `inchead' -B `incbody' -A `incfoot' -c `inccss')

markdown themebreaks.md, saving(themebreaks1.html) replace
markdown themebreaks-p.md, saving(themebreaks2.html) replace pegdown
local pandoc "c:/program files/rstudio/bin/pandoc/pandoc"
local inchead "../../../Rmd/headInclKB.html"
local incbody "../../../Rmd/topInclKB.html"
local incfoot "../../../Rmd/bottomInclKB.html"
local inccss  "../../../Rmd/Rmd.css"
stpandoc themebreaks-p.md, saving(themebreaks3.html) replace ///
	path(`pandoc') from(markdown) pargs(--mathjax ///
	-H `inchead' -B `incbody' -A `incfoot' -c `inccss')

markdown lists.md, saving(lists1.html) replace

markdown tablebasics.md, saving(tables1.html) replace

markdown tableandblocks.md, saving(tableandblocks1.html) replace
local pandoc "c:/program files/rstudio/bin/pandoc/pandoc"
local inchead "../../../Rmd/headInclKB.html"
local incbody "../../../Rmd/topInclKB.html"
local incfoot "../../../Rmd/bottomInclKB.html"
local inccss  "../../../Rmd/Rmd.css"
stpandoc tableandblocks-p.md, saving(tableandblocks3.html) replace ///
	path(`pandoc') from(markdown) pargs(--mathjax ///
	-H `inchead' -B `incbody' -A `incfoot' -c `inccss')
