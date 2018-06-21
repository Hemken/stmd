capture mata: mata drop _fence_info()
mata: 
real matrix function _fence_info(string colvector X) {

	codefence = "^( ? ? ?)(```+|~~~+)([ ]*)$"
	infofence = "^( ? ? ?)(```+|~~~+)\{?s(tata)?\/?(,.*)?\}?$"
	fence = ustrregexm(X, codefence)
	codebegin = ustrregexm(X, infofence)
	fence = fence + codebegin
	prespace = J(rows(X),1,.)
	cbdepth = J(rows(X),1,0)
	fencel = J(rows(X),7,.)
	doblock = 0
	//cbflen = 0
	for (i=1; i<=rows(X); i++) {
		// check out the fence
		if (i>=2) {
			cbdepth[i]=cbdepth[i-1]
			fencel[i,.]=fencel[i-1,.]
		}
		if (ustrregexm(X[i,1], infofence) | ustrregexm(X[i,1], codefence)) {
//X[i,1]		
			if (ustrregexm(X[i,1], infofence)) {
				prespace[i] = ustrlen(ustrregexs(1))
				fl = ustrlen(ustrregexs(2))
			}
			else if (ustrregexm(X[i,1], codefence)) {
				prespace[i] = ustrlen(ustrregexs(1))
				fl = ustrlen(ustrregexs(2))
			}
//fl
			// doable?
			if (cbdepth[i]==0 & ustrregexm(X[i,1], infofence)) {
				cbdepth[i]=cbdepth[i]+1
				fencel[i, cbdepth[i]]   = fl
				codebegin[i] = 1 // redundant
				doblock = 1
				//cbflen = fencel[i]
			}
			// not doable: deeper?
			else if (ustrregexm(X[i,1], infofence) | cbdepth[i]==0) {
				cbdepth[i]=cbdepth[i]+1
				fencel[i, cbdepth[i]]   = fl
				codebegin[i] = 0 // redundant
			}
			// also deeper
			else if (fl < fencel[i, cbdepth[i]]) {
				cbdepth[i]=cbdepth[i]+1
				fencel[i, cbdepth[i]]   = fl
			}
			else {
				fencel[i, cbdepth[i]] = .
				cbdepth[i] = cbdepth[i]-1
			}
			// is this the end of doable?
			if (cbdepth[i]==0 & doblock) {
				codebegin[i] = -1
				doblock=0
			}
		}

//X[i,1]
	}
	return(fence,codebegin,cbdepth,prespace,fencel)
}
end
