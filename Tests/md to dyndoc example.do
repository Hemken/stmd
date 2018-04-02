cd z:/public_web/stataworkshops/stmd/
do "update stmd2dyn.do "

cd z:/public_web/stataworkshops/stmd/Examples/

capture erase graph1.svg
capture erase graph2.svg
cscript
//Basic, with code, inline, graph
stmd2dyn example-stmd.stmd, replace
dyndoc example-stmd.dyn, replace
file_equal example-stmd.html using example-stmd-bm.html, display

cscript
//Basic, language specifications
stmd2dyn example-language.stmd, replace
dyndoc example-language.dyn, replace
file_equal example-language.html using example-language-bm.html, display

cscript
//Basic, inline language calls
stmd2dyn example-inline.stmd, replace
dyndoc example-inline.dyn, replace
file_equal example-inline.html using example-inline-bm.html, display

capture erase graph3.svg
capture erase graph4.svg
cscript
//Various options for returning code and results
stmd2dyn example-codeopts.stmd, replace
dyndoc example-codeopts.dyn, replace
file_equal example-codeopts.html using example-codeopts-bm.html, display

capture erase graph.svg
cscript
//md2dyn using review-markstat.stmd
md2dyn review-markstat.stmd, replace
dyndoc review-markstat.smd, replace
file_equal review-markstat.html using review-markstat-bm.html, display



cscript
sysuse auto
md2dyn lesson1.smd, saving(lesson1_dd.smd) replace
dyndoc lesson1_dd.smd, replace
