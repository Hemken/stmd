*! version 1.2
*! Doug Hemken
*! 3 April 2018

// pass arguments to dyndoc

capture program drop stmd2html
program define stmd2html, rclass
	syntax anything(name=infile)    /// input file name
		[,							/// 
		SAVing(string) REPLace		///  name of HTML file
		noREMove					///
		hardwrap					///
		nomsg						///
		nostop						///
		]
		
*display `"`infile'"'
	* infile checks	
	local infile = ustrtrim(usubinstr(`"`infile'"', `"""', "", .))
	confirm file `"`infile'"'
	
	* outfile checks
	if ("`saving'" == "" ) {
		mata:(void)pathchangesuffix("`infile'", "html", "saving", 0)
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

	* intermediate dyndoc file
	tempfile dyn
	* process
	stmd2dyn `infile', saving(`dyn') `replace'
	dyndoc `dyn', saving(`saving') `replace' `remove' `hardwrap' `msg' `stop'
	
end
