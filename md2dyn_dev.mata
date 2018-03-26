mata
	codefence = "^( ? ? ?)(```+|~~~+)([ ]*)$"
	infofence = "^( ? ? ?)(```+|~~~+)\{?s(tata)?\/?(,.*)?\}?$"
	fence = ustrregexm(X, codefence)
	dynbegin = ustrregexm(X, infofence)
	prefence = J(rows(X),1,.)
	fencel = J(rows(X),1,.)
	infotag = J(rows(X),1,"")
	noeval = J(rows(X),1,.)
	for (i=1; i<=rows(X); i++) {
//X[i,1]
		if (ustrregexm(X[i,1], infofence)) {
//X[i,1]
			fence[i] = 0
			prefence[i] = ustrlen(ustrregexs(1))
			fencel[i]   = ustrlen(ustrregexs(2))
			infotag[i]  = ustrregexs(4)
			noeval[i]   = ustrregexm(infotag[i], "eval=FALSE")
			if (noeval[i]) {
				dynbegin[i] = 0
			}
		}
	}
	
//dynbegin,prefence,fencel,noeval
//infotag

	codeopts = ustrregexm(infotag, ",") //if dynbegin
	noecho1 = ustrregexm(infotag, "echo=FALSE") //if dynbegin & codeopts
	noecho2 = ustrregexm(infotag, "\/") //if dynbegin & codeopts
	noecho = noecho1+noecho2 //if ustrregexm(doc_line, "\/") & dynbegin & codeopts
	noresults = ustrregexm(infotag, "results=FALSE") //if dynbegin & codeopts
	noprompt = ustrregexm(infotag, "noprompt=TRUE") //if dynbegin & codeopts
codeopts, noecho, noresults, noprompt

end
