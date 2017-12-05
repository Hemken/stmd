cd z:/public_web/stataworkshops/md2dyn
*run markstat2dyntest.ado 
capture erase graph.svg
cscript
md2dyn using review-markstat.stmd
dyndoc review-markstat.smd, replace
file_equal review-markstat.html using review-markstat-bm.html, display

capture erase graph1.svg
capture erase graph2.svg
cscript
md2dyn using example-md2dyn.stmd
dyndoc example-md2dyn.smd, replace
file_equal example-md2dyn.html using example-md2dyn-bm.html, display

capture erase graph3.svg
capture erase graph4.svg
cscript
md2dyn using example-codeopts.stmd
dyndoc example-codeopts.smd, replace
file_equal example-codeopts.html using example-codeopts-bm.html, display
