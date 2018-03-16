*! version 1.5.2
*! Doug Hemken
*! 7 February 2018

// ISSUES
// ======
// ensure infile does not have "smd" extension -- done?
// better, more extensive preamble ?
// NOGRaph option
// wrapper with dyndoc, pandoc
// rewrite in Mata

capture program drop md2dyn
program define md2dyn, rclass
	syntax anything(name=infile), [LINElength(integer 256)] ///
		[SAVing(string) replace]
	preserve

	local infile = ustrtrim(usubinstr(`"`infile'"', `"""', "", .))
display `"infile is `infile'"'	
	confirm file `"`infile'"'
display "infile confirmed"	
	if ("`saving'" == "" ) {
		mata:(void)pathchangesuffix("`infile'", "smd", "saving", 0)
		}
	mata: (void)pathresolve("`c(pwd)'", `"`saving'"', "saving")
	local issame = 0
	mata: (void)filesarethesame("`infile'", "`saving'", "issame")
	if ("`issame'" == "1") {
display in error "target file can not be the same as the source file"
		exit 602			
	}
	if ("`replace'"=="") {
		confirm new file "`saving'"
		}
	clear
	
* Read in file
quietly {
	infix str doc_line 1-`linelength' using `"`infile'"'
	compress doc_line
}
* Then identify code blocks
quietly {
	generate linenum = _n

	local infofence = "^( ? ? ?)(```+|~~~+)\{?s(tata)?\/?(,.*)?\}?$"
	generate codebegin = ustrregexm(doc_line, "`infofence'")
	generate prespace = length(ustrregexs(1)) if ustrregexm(doc_line, "`infofence'")
	generate fencel = length(ustrregexs(2)) if ustrregexm(doc_line, "`infofence'")
	generate infoopts = ustrregexs(4) if ustrregexm(doc_line, "`infofence'")
	replace codebegin = 0 if ustrregexm(infoopts, "eval=FALSE") & codebegin
		
	generate codeopts = ustrregexm(infoopts, ",") if codebegin
	generate noecho = ustrregexm(infoopts, "echo=FALSE") if codebegin & codeopts
	replace noecho = 1 if ustrregexm(doc_line, "\/") & codebegin & codeopts
	generate noresults = ustrregexm(infoopts, "results=FALSE") if codebegin & codeopts
	generate noprompt = ustrregexm(infoopts, "noprompt=TRUE") if codebegin & codeopts
	
	local codefence = "^( ? ? ?)(```+|~~~+)([ ]*)$"
	generate codefence = ustrregexm(doc_line, "`codefence'") if ~codebegin
	replace fencel = length(ustrregexs(2)) if ustrregexm(doc_line, "`codefence'")
	
	levelsof linenum if codebegin, local(cb)
	foreach block of local cb {
		di "begin at `block'"
		summarize fencel in `block'
		local fencel = r(mean)
		levelsof linenum if codefence & (fencel >= `fencel') & (linenum > `block'), local(cbe)
		local cbe : word 1 of `cbe'
		di "end at `cbe'"
		replace codebegin = -1 in `cbe'
	}
	* Add dd_do
	expand 2 if codebegin ~= 0, generate(dup)
	sort linenum dup
	replace doc_line = "`"*fencel if codebegin==1 & dup==0
	replace doc_line = "<<dd_do>>" if codebegin==1 & dup==1 & codeopts==0
	*replace doc_line = "" if codebegin==1 & dup==1 & noeval==1
	replace doc_line = "<<dd_do: nocommands>>" if codebegin==1 & dup==1 & noecho==1
	replace doc_line = "<<dd_do: nooutput>>" if codebegin==1 & dup==1 & noresults==1
	replace doc_line = "<<dd_do: noprompt>>" if codebegin==1 & dup==1 & noprompt==1
	replace doc_line = "<<dd_do: quietly>>" if codebegin==1 & dup==1 & noecho==1 & noresults==1
	replace doc_line = "<</dd_do>>" if codebegin==-1 & dup==0
	
	drop dup
	replace linenum = _n
}
* Add graphics preamble
quietly {
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
	}
* Add new graphics links
quietly {
	*expand 11 if codefence==1 & doc_line=="```", generate(dupgr)
	expand 11 if codebegin==-1 & ustrregexm(doc_line, "`codefence'"), generate(dupgr)
	sort linenum dupgr
	by linenum dupgr: generate graphcheck = _n
//	replace doc_line = "INSERT CODE" if codebegin==-1 & dupgr==1 & graphcheck==1
	replace doc_line = `"<<dd_do: quietly>>"' if  codebegin==-1 & dupgr==1 & graphcheck==1
	replace doc_line = `"capture graph describe Graph"' if graphcheck==2
	replace doc_line = `"local checkdate = "\`r(command_date)' \`r(command_time)'" "' if graphcheck==3
	replace doc_line = `"<</dd_do>>"' if graphcheck==4
	replace doc_line = `"<<dd_skip_if: ="\`\`gdate''"~="" & "\`\`gdate''"=="\`checkdate'">>"' if graphcheck==5
	replace doc_line = `"<<dd_graph>>"' if graphcheck==6
	replace doc_line = `"<<dd_skip_end>>"' if graphcheck==7
	replace doc_line = `"<<dd_do: quietly>>"' if graphcheck==8
	replace doc_line = `"local \`gdate' = "\`r(command_date)' \`r(command_time)'""' if graphcheck==9
	replace doc_line = `"<</dd_do>>"' if graphcheck==10
	
	drop dupgr
	replace linenum= _n 
}
* Identify display directives
quietly {
	generate dispbegin = ustrregexm(doc_line, "`s") if ~codebegin
	replace doc_line = ustrregexra(doc_line, "`s", "<<dd_display: ") if dispbegin==1
	replace doc_line = ustrregexra(doc_line, "`", ">>") if dispbegin==1
}
* Write out the result
	quietly keep doc_line
	quietly compress doc_line
	mata: document = st_sdata(.,1)
	mata: saving = st_local("saving")
	mata: unlink(saving)
	mata: docwrite(saving, document)
	*outfile doc_line using "`saving'", noquote wide replace
	display "  {text:Output saved as {it:`saving'}}"

* Finish up
	restore
	return local outfile "`saving'"
end

mata:
void function docwrite(string scalar filename, ///
		string colvector document) {
	fh = fopen(filename, "w")
	for (i=1; i<=length(document); i++) {
		fput(fh, document[i])
	}
	fclose(fh)
	}
end
