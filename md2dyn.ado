*! version 1.5.4
*! Doug Hemken
*! 26 March 2018

// ISSUES
// ======
// better, more extensive preamble ?
// NOGRaph option
// wrapper with dyndoc, pandoc
// rewrite in Mata

capture program drop md2dyn
capture mata: mata clear
program define md2dyn, rclass
	syntax anything(name=infile), [LINElength(integer 256)] ///
		[SAVing(string) replace]

	local infile = ustrtrim(usubinstr(`"`infile'"', `"""', "", .))
*display `"infile is `infile'"'	
	confirm file `"`infile'"'
*display "infile confirmed"	
	if ("`saving'" == "" ) {
		mata:(void)pathchangesuffix("`infile'", "dyn", "saving", 0)
		mata: (void)st_local("saving", pathjoin("`c(pwd)'", `"`saving'"'))
		}
	mata: (void)pathresolve("`c(pwd)'", `"`saving'"', "saving")
*display `"saving `saving'"'
	
	local issame = 0
	mata: (void)filesarethesame("`infile'", "`saving'", "issame")
	if ("`issame'" == "1") {
display in error "target file can not be the same as the source file"
		exit 602			
	}
	if ("`replace'"=="") {
		confirm new file "`saving'"
		}

* Read in file

/*	preserve
	clear
quietly {
	infix str doc_line 1-`linelength' using `"`infile'"'
	compress doc_line
}
*/
	mata: X=docread("`infile'")
//	mata: st_sstore(., 1, X)
	
* Then identify code blocks
/*
quietly {
	generate linenum = _n
	* find codeblocks and dynamic codeblocks
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
	
	* find the end of each codeblock
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
*/	
mata: fenceinfo = _fence_info(X)
mata: infotags  = _info_tags(X)
mata: tagmatchs = _tag_match(infotags)
/*
	* Add dd_do
	expand 2 if codebegin ~= 0, generate(dup)
	sort linenum dup
	replace doc_line = "`"*fencel if codebegin==1 & dup==0
	replace doc_line = "<<dd_do>>" if codebegin==1 & dup==1 & codeopts==0
	replace doc_line = "<<dd_do: nocommands>>" if codebegin==1 & dup==1 & noecho==1
	replace doc_line = "<<dd_do: nooutput>>" if codebegin==1 & dup==1 & noresults==1
	replace doc_line = "<<dd_do: noprompt>>" if codebegin==1 & dup==1 & noprompt==1
	replace doc_line = "<<dd_do: quietly>>" if codebegin==1 & dup==1 & noecho==1 & noresults==1
	replace doc_line = "<</dd_do>>" if codebegin==-1 & dup==0
	
	drop dup
	replace linenum = _n
}
*/
mata: dotags = _dd_do(fenceinfo, tagmatchs)
/*
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
	expand 11 if codebegin==-1 & ustrregexm(doc_line, "`codefence'"), generate(dupgr)
	sort linenum dupgr
	by linenum dupgr: generate graphcheck = _n
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
*/
* Identify display directives
/*
quietly {
	generate dispbegin = ustrregexm(doc_line, "`s") if ~codebegin
	replace doc_line = ustrregexra(doc_line, "`s", "<<dd_display: ") if dispbegin==1
	replace doc_line = ustrregexra(doc_line, "`", ">>") if dispbegin==1
}
*/
mata: document = _stitch(X, fenceinfo, dotags)

* Write out the result
/*	quietly keep doc_line
	quietly compress doc_line
	mata: document = st_sdata(.,1)
	mata: saving = st_local("saving")
	mata: unlink(saving)
	mata: docwrite(saving, document)
	display "  {text:Output saved as {it:`saving'}}"
*/
	mata: saving = st_local("saving")
	mata: docwrite(saving, document)
	display "  {text:Output saved as {it:`saving'}}"

* Finish up
//	restore
	return local outfile "`saving'"
end

mata
string colvector docread(string scalar filename) {
	fh = fopen(filename, "r")
	string colvector document
	document= J(0,1,"")
	while ((line=fget(fh))!=J(0,0,"")) {
		document = (document\line)
	}
	fclose(fh)
	return(document)
	}
	
void function docwrite(string scalar filename, ///
		string colvector document) {
	fh = fopen(filename, "w")
	for (i=1; i<=length(document); i++) {
		fput(fh, document[i])
	}
	fclose(fh)
	}
	
real matrix function _fence_info(string colvector X) {

	codefence = "^( ? ? ?)(```+|~~~+)([ ]*)$"
	infofence = "^( ? ? ?)(```+|~~~+)\{?s(tata)?\/?(,.*)?\}?$"
	fence = ustrregexm(X, codefence)
	codebegin = ustrregexm(X, infofence)
	fence = fence + codebegin
	prespace = J(rows(X),1,.)
	fencel = J(rows(X),1,.)
	cb = 0
	cbfl = 0
	for (i=1; i<=rows(X); i++) {
		if (ustrregexm(X[i,1], infofence)) {
			prespace[i] = ustrlen(ustrregexs(1))
			fencel[i]   = ustrlen(ustrregexs(2))
			cb = 1
			cbfl = fencel[i]
		}
		else if (ustrregexm(X[i,1], codefence)) {
			prespace[i] = ustrlen(ustrregexs(1))
			fencel[i]   = ustrlen(ustrregexs(2))
			if (cb & fencel[i]>=cbfl) {
				codebegin[i] = -1
				cb = 0
				cbfl = 0
				}
		}
	}
	return(fence,codebegin,prespace,fencel)
}

string colvector function _info_tags(string colvector X) {
	infofence = "^( ? ? ?)(```+|~~~+)\{?s(tata)?\/?(,.*)?\}?$"
//infofence
	infotags = J(rows(X),1,"")
	for (i=1; i<=rows(X); i++) {
		if (ustrregexm(X[i,1], infofence)) {
			infotags[i]  = ustrregexs(4)
		}
	}
	return(infotags)
}

real matrix function _tag_match(string colvector infotags) {
	codeopts = ustrregexm(infotags, ",")
	noeval   = ustrregexm(infotags, "eval=FALSE")
	noecho1 = ustrregexm(infotags, "echo=FALSE")
	noecho2 = ustrregexm(infotags, "\/")
	noecho = noecho1+noecho2
	noresults = ustrregexm(infotags, "results=FALSE")
	noprompt = ustrregexm(infotags, "noprompt=TRUE")
	
	return(codeopts, noeval, noecho, noresults, noprompt)
}

string colvector function _dd_do(real matrix fenceinfo, real matrix tagmatch) {
	dotags = J(rows(fenceinfo),1,"")
	for (i=1; i<=rows(fenceinfo); i++) {
		if (fenceinfo[i,2]==1) {
			if (sum(tagmatch[i,.])==0) dotags[i,1]=("<<dd_do>>")
			else if (tagmatch[i,3]==1) {
				if (tagmatch[i,4]==0) dotags[i,1]=("<<dd_do: nocommands>>")
				else if (tagmatch[i,4]==1) dotags[i,1]=("<<dd_do: quietly>>")
				}
			else if (tagmatch[i,3]==0 & tagmatch[i,4]==1) dotags[i,1]=("<<dd_do: nooutput>>")
			else if (tagmatch[i,5]==1) dotags[i,1]=("<<dd_do: noprompt>>")
			}
		else if (fenceinfo[i,2]==-1) dotags[i,1]=("<</dd_do>>")
		else dotags[i,1]=("")
		}
	return(dotags)
}

string colvector function _gr_preamble() {
	GR = "<<dd_do: quietly>>"\			
		"capture graph describe Graph"\ 
		"tempname gdate"\				
		`"local \`gdate' = "\`r(command_date)' \`r(command_time)'" "'\ 
		"<</dd_do>>"
	return(GR)	
	}

string colvector function _gr_link() {
	GL = `"<<dd_do: quietly>>"' \
		`"capture graph describe Graph"' \
		`"local checkdate = "\`r(command_date)' \`r(command_time)'" "' \
		`"<</dd_do>>"' \
		`"<<dd_skip_if: ="\`\`gdate''"~="" & "\`\`gdate''"=="\`checkdate'">>"' \
		`"<<dd_graph>>"' \
		`"<<dd_skip_end>>"' \
		`"<<dd_do: quietly>>"' \
		`"local \`gdate' = "\`r(command_date)' \`r(command_time)'""' \
		`"<</dd_do>>"' 
	return(GL)	
	}
	
string colvector function _stitch(string colvector X,
		real matrix fenceinfo, string colvector dotags) {
	lce = 0
	Y = _gr_preamble()
	for (i=1; i<=rows(X); i++) {
	X[i,.]
		if (fenceinfo[i,2]==1) {
			Y = Y \ X[(lce+1)..i,.]\dotags[i,.]
			lce = i
			}
		else if (fenceinfo[i,2]==-1) {
			Y= Y \X[(lce+1)..(i-1),.]\dotags[i,.]\X[i,.]\_gr_link()
			lce = i
			}
		}
	return(Y)
	}

end
