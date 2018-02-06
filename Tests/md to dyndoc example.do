cd z:/public_web/stataworkshops/md2dyn/examples
*run md2dyn.ado 
net from https://www.ssc.wisc.edu/~hemken/Stataworkshops/
net install md2dyn, replace
capture erase graph.svg
cscript
//md2dyn using review-markstat.stmd
md2dyn review-markstat.stmd, replace
dyndoc review-markstat.smd, replace
file_equal review-markstat.html using review-markstat-bm.html, display

capture erase graph1.svg
capture erase graph2.svg
cscript
//md2dyn using example-md2dyn.stmd
md2dyn example-md2dyn.stmd, replace
dyndoc example-md2dyn.smd, replace
file_equal example-md2dyn.html using example-md2dyn-bm.html, display

capture erase graph3.svg
capture erase graph4.svg
cscript
//md2dyn using example-codeopts.stmd
md2dyn example-codeopts.stmd, replace
dyndoc example-codeopts.smd, replace
file_equal example-codeopts.html using example-codeopts-bm.html, display

cscript
sysuse auto
md2dyn lesson1.smd, saving(lesson1_dd.smd) replace
dyndoc lesson1_dd.smd, replace
