capture mata: mata drop _dd_do()
mata: string colvector function _dd_do(real matrix fenceinfo, real matrix tagmatch) {
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
