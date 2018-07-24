cd z:/public_web/stataworkshops/stmd/
do "update stmd install.do "

cd z:/public_web/stataworkshops/stmd/Examples/

capture erase graph.svg
cscript
//Basic, with code, inline, graphs
stmd example0.stmd, replace
file_equal example0.html using example0-bm.html, display

capture erase graph1.svg
capture erase graph2.svg
cscript
//Basic, with code, inline, graphs
stmd example-stmd.stmd, replace
file_equal example-stmd.html using example-stmd-bm.html, display

cscript
//Basic, language specifications
stmd example-language.stmd, replace
file_equal example-language.html using example-language-bm.html, display

cscript
//Basic, inline language calls
stmd example-inline.stmd, replace
file_equal example-inline.html using example-inline-bm.html, display

capture erase graph3.svg
capture erase graph4.svg
cscript
//Various options for returning code and results
stmd example-codeopts.stmd, replace
file_equal example-codeopts.html using example-codeopts-bm.html, display

capture erase graph.svg
cscript
//A `markstat` document - `graph export` and markdown image links
//   need to be revised
stmd example-markstat.stmd, replace
file_equal example-markstat.html using example-markstat-bm.html, display

cscript
// A longer example, with eval==FALSE
sysuse auto
stmd lesson1.stmd, replace
file_equal lesson1.html using lesson1-bm.html, display


cd z:/public_web/stataworkshops/stmd/examples

cscript
stmd quietly.stmd, replace
file_equal quietly.html using quietly-bm.html, display

cscript
stmd "stacked codefences.stmd", replace
file_equal "stacked codefences.html" using "stacked codefences-bm.html", display

