cd z:/public_web/stataworkshops/md2dyn/examples

ado uninstall md2dyn
net from https://www.ssc.wisc.edu/~hemken/Stataworkshops/
net install md2dyn, replace

//md2html using review-markstat.stmd
cscript
capture erase graph.svg
md2html review-markstat.stmd, replace
file_equal review-markstat.html using review-markstat-bm.html, display

//md2html using example-md2dyn.stmd
cscript
capture erase graph1.svg
capture erase graph2.svg
md2html example-md2dyn.stmd, replace
file_equal example-md2dyn.html using example-md2dyn-bm.html, display

//md2html using example-codeopts.stmd
cscript
capture erase graph3.svg
capture erase graph4.svg
md2html example-codeopts.stmd, replace
file_equal example-codeopts.html using example-codeopts-bm.html, display

cscript
sysuse auto
md2dyn lesson1.smd, saving(lesson1_dd.smd) replace
dyndoc lesson1_dd.smd, replace
