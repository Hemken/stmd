*! version 1.5.4
*! Doug Hemken
*! 27 March 2018

// ISSUES
// ======
// wrapper with dyndoc, pandoc
// better, more extensive preamble, e.g. linesize, other options?
// NOGRaph option
// ignore executable code within non-executable fence

capture program drop stmd2dyn
capture mata: mata clear
program define stmd2dyn, rclass
	syntax anything(name=infile), [SAVing(string) replace]

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
	mata: X=docread("`infile'")
	
* Then identify code blocks and tags
	mata: fenceinfo = _fence_info(X) // fences
	mata: infotags  = _info_tags(X)  // retrieve infotags
	mata: tagmatchs = _tag_match(infotags) // parse infotags
	mata: dotags = _dd_do(fenceinfo, tagmatchs) // generate <<dd_do>>

* Identify display directives
	mata: X = _inline_code(X)

* assemble pieces of a dyndoc
	mata: document = _stitch(X, fenceinfo, dotags)

* Write out the result
	mata: saving = st_local("saving")
	mata: docwrite(saving, document)
	display "  {text:Output saved as {it:`saving'}}"

* Finish up
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
	unlink(filename)
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
	//X[i,.]
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
	
string colvector function _inline_code(string colvector X) {
	for (i=1; i<=rows(X); i++) {
		dispdir = ustrregexm(X[i,1], "(`|~)\{?s(tata)?(.*)(`)")
		while (dispdir) {
			X[i,1] = ustrregexra(X[i,1], "(`|~)\{?s(tata)?", "<<dd_display: ")
			X[i,1] = ustrregexra(X[i,1], "`", ">>")
			dispdir = ustrregexm(X[i,1], "(`|~)\{?s(tata)?(.*)(`)")
			}
		}
	return(X)
	}

end
