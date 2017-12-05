cd "z:/public_web/stataworkshops/md2dyn"
clear
*preserve

local linelength = 256
local using = "example-codeopts.stmd"
local saving = "example-codeopts.smd"

* Read in file
	quietly infix str doc_line 1-`linelength' using "`using'"
	quietly compress doc_line
	
* Then identify code blocks
	generate linenum = _n
	*generate codebegin = inlist(usubstr(doc_line, 1, 7), ///
	*		"```s", "```s/", "```{s}", "```{s/}")
	generate codebegin = ustrregexm(doc_line, "^```\{?s(tata)?\/?")
	generate codeopts = ustrregexm(doc_line, ",") if codebegin
	generate noecho = ustrregexm(doc_line, "echo=FALSE") if codebegin & codeopts
	replace noecho = ustrregexm(doc_line, "\/") if codebegin & codeopts
	generate noresults = ustrregexm(doc_line, "results=FALSE") if codebegin & codeopts
	generate noprompt = ustrregexm(doc_line, "noprompt=TRUE") if codebegin & codeopts
	
	generate codefence = usubstr(doc_line, 1, 3) == "```" if ~codebegin
	levelsof linenum if codebegin, local(cb)
	foreach block of local cb {
		di "begin at `block'"
		levelsof linenum if codefence & linenum > `block', local(cbe)
		local cbe : word 1 of `cbe'
		di "end at `cbe'"
		replace codebegin = -1 in `cbe'
	}
	* Replace code ```{s}
	expand 2 if codebegin ~= 0, generate(dup)
	sort linenum dup
	replace doc_line = "```" if codebegin==1 & dup==0
	replace doc_line = "<<dd_do>>" if codebegin==1 & dup==1
	replace doc_line = "<</dd_do>>" if codebegin==-1 & dup==0
	
	drop dup
	replace linenum = _n
	
* Add graphics preamble
	expand 6 if linenum == 1, generate(duppre)
	sort linenum duppre
	by linenum duppre: generate preamble = _n
	replace doc_line = "<<dd_do: quietly>>" if linenum==1 & preamble==1
	replace doc_line = "capture graph describe Graph" if duppre==1 & preamble==1
	replace doc_line = "tempname gdate" if duppre==1 & preamble==2
	replace doc_line = `"local \`gdate' = "\`r(command_date)' \`r(command_time)'" "' if duppre==1 & preamble==3
	replace doc_line = "<</dd_do>>" if duppre==1 & preamble==4
	
	drop duppre
	replace linenum = _n

* Add new graphics links
	expand 10 if codefence==1 & doc_line=="```", generate(dupgr)
	sort linenum dupgr
	by linenum dupgr: generate graphcheck = _n
//	replace doc_line = "INSERT CODE" if codebegin==-1 & dupgr==1 & graphcheck==1
	replace doc_line = `"<<dd_do: quietly>>"' if  codebegin==-1 & dupgr==1 & graphcheck==1
	replace doc_line = `"capture graph describe Graph"' if graphcheck==2
	replace doc_line = `"<</dd_do>>"' if graphcheck==3
	replace doc_line = `"<<dd_skip_if: ="\`\`gdate''" ~= "" & "\`r(command_date)' \`r(command_time)'" == "\`\`gdate''">>"' if graphcheck==4
	replace doc_line = `"<<dd_graph>>"' if graphcheck==5
	replace doc_line = `"<<dd_skip_end>>"' if graphcheck==6
	replace doc_line = `"<<dd_do: quietly>>"' if graphcheck==7
	replace doc_line = `"local \`gdate' = "\`r(command_date)' \`r(command_time)'""' if graphcheck==8
	replace doc_line = `"<</dd_do>>"' if graphcheck==9
	
	drop dupgr
	replace linenum= _n 
	
* Identify display directives
	generate dispbegin = ustrregexm(doc_line, "`s") if ~codebegin
	replace doc_line = ustrregexra(doc_line, "`s", "<<dd_display: ") if dispbegin==1
	replace doc_line = ustrregexra(doc_line, "`", ">>") if dispbegin==1

* Write out the result
	quietly compress doc_line
	outfile doc_line using "`saving'", noquote wide replace
	display "  {text:Output saved as {it:`saving'}}"

* Finish up
	restore
