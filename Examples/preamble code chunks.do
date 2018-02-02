* Preamble
* Use this at the start of any standalone dyndoc
<<dd_do: quietly>>
tempname pwd ls
local `pwd' = c(pwd)
local `ls' = c(linesize)
set graphics off
preserve
<</dd_do>>

* Epilogue
* Use this at the end of any standalone dyndoc that has a Preamble
<<dd_do: quietly>>
cd `"``pwd''"'
set linesize ``ls''
set graphics on
restore
<</dd_do>>

* Graphics Preamble
* Set up for detecting change in Graph window
<<dd_do: quietly>>
capture graph describe Graph
tempname gdate
local `gdate' = "`r(command_date)' `r(command_time)'"
<</dd_do>>
