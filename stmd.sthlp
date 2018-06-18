{smcl}
{* *! version 1.3 18jun2018}{...}
{* *! Doug Hemken}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "stmd2dyn" "help stmd2dyn"}{...}
{vieweralsosee "dyndoc" "help dyndoc"}{...}
{vieweralsosee "dyntext" "help dyntext"}{...}
{vieweralsosee "dynamic tags" "help dynamic tags"}{...}
{vieweralsosee "pandoc" "help pandoc"}{...}
{vieweralsosee "dyn2do" "help dyn2do"}{...}
{viewerjumpto "Syntax" "stmd##syntax"}{...}
{viewerjumpto "Description" "stmd##description"}{...}
{viewerjumpto "Options" "stmd##options"}{...}
{viewerjumpto "Remarks" "stmd##remarks"}{...}
{viewerjumpto "Examples" "stmd##examples"}{...}
{title:Title}

{phang}
{bf:stmd} Convert dynamic Markdown to HTML format using Stata {cmd: dyndoc}{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:stmd}
filename
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt sav:ing(filename2)}}save HTML file as {it:filename2}{p_end}
{synopt:{opt replace}}replace {it:filename2} if it already exists{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}


{marker description}{...}
{title:Description}

{pstd}
{cmd:stmd} Takes a dynamic Markdown document using conventional markdown
	specification and converts it to HTML via Stata's {cmd: dyndoc}
	command.  This is just a wrapper for {cmd: stmd2dyn} followed by
	{cmd: dyndoc}


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt saving} {it: filename2} to specify the final HTML file name.{p_end}

{phang}
{opt replace} replace {it:filename2} if it already exists{p_end}

{phang}
{it:options} additional options may be passed to {cmd:dydndoc}{p_end}


{marker remarks}{...}
{title:Remarks}

{pstd}
If {it: filename2} is not specified, then {it: filename} with an
.html file extension is tried.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. stmd using example.stmd}{p_end}


{title:Author}

{p 4} Doug Hemken {p_end}
{p 4} Social Science Computing Cooperative{p_end}
{p 4} Univ of Wisc-Madison{p_end}
{p 4} {browse "mailto:dehemken@wisc.edu":dehemken@wisc.edu}{p_end}
{p 4} https://www.ssc.wisc.edu/~hemken/Stataworkshops{p_end}
{p 4} https://github.com/Hemken/stmd{p_end}
