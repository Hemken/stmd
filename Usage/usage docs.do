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
