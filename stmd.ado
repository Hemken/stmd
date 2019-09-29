*! version 1.7
*! Doug Hemken
*! 28 Sep 2019

// ISSUES
// ======
// revise dialogs
// revise Help files

// capture program drop stmd
program define stmd, rclass
	syntax anything(everything)     /// input file name, plus arguments
		[,							/// 
		SAVing(string) REPLace		///  name of HTML file
		noREMove					///
		embedimage					/// requires Stata 16
		hardwrap					///
		nomsg						///
		nostop						///
		pegdown						///
		docx						/// requires Stata 16
		flexdocx					/// requires Stata 16
		pdf							/// requires Stata 16
		]
	
	version 15


	
	gettoken infile opargs : anything
	
// display `"source file: `infile'"'
	* infile checks	
	local infile = ustrtrim(usubinstr(`"`infile'"', `"""', "", .))
	confirm file `"`infile'"'
	
	* outfile checks
	local saving = ustrtrim(`"`saving'"')
	if (`'"`saving'"' == "" ) {
		if ("`docx'" != "" | "`flexdocx'" != "") {
			mata:(void)pathchangesuffix("`infile'", "docx", "saving", 0)
		}
		else if ("`pdf'" != "") {
			mata:(void)pathchangesuffix("`infile'", "pdf", "saving", 0)
		}
		else {
			mata:(void)pathchangesuffix("`infile'", "html", "saving", 0)
		}
	}
	else {
		mata:_getfileextension(`"`saving'"', "targetext")
		if (`"`targetext'"' == "docx") {
			local docx = "docx"
		}
		else if (`"`targetext'"' == "pdf") {
			local pdf = "pdf"
		}
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
// display `"target file: `saving' "'

	* intermediate dyndoc file
	tempfile dyn
	* intermediate docx file
	if ("`pdf'" != "") {
		tempfile docxfile
	}
	* process
	stmd2dyn "`infile'", saving(`dyn') `replace' `msg'
	if ("`pdf'" == "") {
		dyndoc `"`dyn'"' `opargs', saving(`"`saving'"') `replace' `remove' ///
			`embedimage'	///
			`hardwrap' `msg' `stop' `pegdown' `docx' `flexdocx'
	}
	else {
// di `'"intermediate docx: `docxfile'"'
		dyndoc `"`dyn'"' `opargs', saving(`"`docxfile'"') `replace' `remove' ///
			`embedimage'	///
			`hardwrap' nomsg `stop' `pegdown' docx `flexdocx'
		if ("`msg'" != "nomsg") {
			display "  {text:docx file saved as {it:`docxfile'}}"
		}
		docx2pdf `"`docxfile'"', saving(`"`saving'"') `replace' `msg'
	}
	
	
end
