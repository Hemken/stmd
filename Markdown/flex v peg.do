cd z:/public_web/stataworkshops/stmd/markdown

markdown markdownelements.md, saving(markdownelements1.html) replace
markdown markdownelements.md, saving(markdownelements2.html) replace pegdown
local pandoc "c:/program files/rstudio/bin/pandoc/pandoc"
stpandoc markdownelements.md, saving(markdownelements3.html) replace path(`pandoc')

markdown headers.md, saving(headers1.html) replace
markdown headers.md, saving(headers2.html) replace pegdown

markdown themebreaks.md, saving(themebreaks1.html) replace
markdown themebreaks-pegdown.md, saving(themebreaks2.html) replace pegdown

*local pandoc `" "c:/program files/rstudio/bin/pandoc/pandoc" "'
local pandoc "c:/program files/rstudio/bin/pandoc/pandoc"
stpandoc themebreaks.md, saving(themebreaks3.html) replace path(`pandoc')
stpandoc themebreaks-pegdown.md, saving(themebreaks4.html) replace path(`pandoc')
