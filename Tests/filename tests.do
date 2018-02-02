* md2dyn filename tests
cd z:/public_web/stataworkshops/md2dyn/examples
capture md2dyn garbage.smd // file not found
assert _rc == 601

capture md2dyn review-markstat.stmd // output file already exists, need -replace-
assert _rc == 602

capture md2dyn review-markstat.smd // output file already exists, same extension
assert _rc == 602

md2dyn "review-markstat.stmd", replace

md2dyn "z:/public_web/stataworkshops/md2dyn/examples/review-markstat.stmd", replace
