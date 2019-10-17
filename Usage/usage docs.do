cd "z:/Stata/stmd/usage"

capture erase Graph.svg

stmd stmdusage.stmd, replace
file_equal stmdusage.html using stmdusage-bm.html, display
assert r(differences)==0

stmd stmdcodeblocks.stmd, replace
file_equal stmdcodeblocks.html using stmdcodeblocks-bm.html, display
assert r(differences)==0

stmd stmdcodeoptions.stmd, replace
file_equal stmdcodeoptions.html using stmdcodeoptions-bm.html, display
assert r(differences)==0

stmd graphing.stmd, replace

do "Subset reports.do"
do "Frame reports.do"
do "Dataset reports.do"
stmd "Repeated Reports.stmd", replace

forvalues i=1/15 {
	erase "Graph`i'.png"
}
forvalues i=1/5 {
	erase "rep78 eq `i'.html"
	erase "rep78_`i'.html"
	erase "rep78_data_`i'.html"
}

copy "Repeated Reports.html" "Z:/PUBLIC_web/Stataworkshops/stmd/Usage/Repeated Reports.html", replace