cd z:/public_web/stataworkshops/md2dyn
*run markstat2dyntest.ado 

md2dyn using review-markstat.stmd
dyndoc review-markstat.smd, replace

md2dyn using example-md2dyn.stmd
dyndoc example-md2dyn.smd, replace
