{smcl}
{* *! version 1.1 19nov2017}{...}
{* *! Doug Hemken}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "dyndoc" "help dyndoc"}{...}
{vieweralsosee "dyntext" "help dyntext"}{...}
{vieweralsosee "dynamic tags" "help dynamic tags"}{...}
{viewerjumpto "Syntax" "stmd2dyn##syntax"}{...}
{viewerjumpto "Description" "stmd2dyn##description"}{...}
{viewerjumpto "Options" "stmd2dyn##options"}{...}
{viewerjumpto "Remarks" "stmd2dyn##remarks"}{...}
{viewerjumpto "Examples" "stmd2dyn##examples"}{...}
{title:Title}

{phang}
{bf:stmd2dyn} Convert common Markdown to Stata {cmd: dyndoc} 
dynamic document format{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:stmd2dyn}
filename
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt sav:ing(filename2)}}save {cmd: dyndoc} file as {it:filename2}{p_end}
{synopt:{opt replace}}replace {it:filename2} if it already exists{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}


{marker description}{...}
{title:Description}

{pstd}
{cmd:stmd2dyn} Takes a Markdown document using conventional markdown
	specification and converts it to Stata's dialect using {cmd: dyndoc}
	dynamic tags.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt saving} {it: filename2} to save the {cmd: dyndoc}, which can
	then be processed by Stata.{p_end}

{phang}
{opt replace} replace {it:filename2} if it already exists{p_end}


{marker remarks}{...}
{title:Remarks}

{pstd}
If {it: filename2} is not specified, then {it: filename} with an
.dyn file extension is tried.



{marker examples}{...}
{title:Examples}

{phang}{cmd:. stmd2dyn using example.stmd}{p_end}


{title:Author}

{p 4} Doug Hemken {p_end}
{p 4} Social Science Computing Cooperative{p_end}
{p 4} Univ of Wisc-Madison{p_end}
{p 4} {browse "mailto:dehemken@wisc.edu":dehemken@wisc.edu}{p_end}
{p 4} https://www.ssc.wisc.edu/~hemken/Stataworkshops{p_end}
{p 4} https://github.com/Hemken/stmd2dyn{p_end}
