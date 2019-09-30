{smcl}
{* *! version 1.7 30sep2019}{...}
{* *! Doug Hemken}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "stmd" "help stmd"}{...}
{vieweralsosee "dyndoc" "help dyndoc"}{...}
{vieweralsosee "markdown" "help markdown"}{...}
{vieweralsosee "dynamic tags" "help dynamic tags"}{...}
{viewerjumpto "Syntax" "stmd2dyn##syntax"}{...}
{viewerjumpto "Description" "stmd2dyn##description"}{...}
{viewerjumpto "Options" "stmd2dyn##options"}{...}
{viewerjumpto "Remarks" "stmd2dyn##remarks"}{...}
{viewerjumpto "Examples" "stmd2dyn##examples"}{...}
{title:Title}

{phang}
{bf:stmd2dyn} Convert standard dynamic Markdown to Stata {cmd: dyndoc} 
dynamic document format.{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:stmd2dyn}
{it:srcfile}
[{cmd:,} {it:options}]

{phang}
{it:srcfile} is a plain text file containing text
and code blocks in standard dynamic Markdown format.{p_end}

{phang}
Enclose filenames in double quotes
if they contain blanks or other special characters.{p_end}


{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt sav:ing(targetfile)}}save {cmd: dyndoc} file as {it:targetfile}{p_end}
{synopt:{opt replace}}replace {it:targetfile} if it already exists{p_end}

{syntab:Other}
{synopt :{opt nomsg}}suppress message of a link to {it:targetfile}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}


{marker description}{...}
{title:Description}

{pstd}
{cmd:stmd2dyn} takes a Markdown document which uses standard markdown
	specification and converts it to Stata's dialect using {cmd: dyndoc}
	dynamic tags.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opth saving:(filename:targetfile)} to save the {cmd: dyndoc}, which can
	then be processed by Stata.{p_end}

{phang}
{opt replace} replace {it:targetfile} if it already exists{p_end}

{dlgtab:More}

{phang}
{opt nomsg} suppresses the message that contains a link to the target file.


{marker remarks}{...}
{title:Remarks}

{pstd}
If {it: targetfile} is not specified, then {it: srcfile} with an
.dyn file extension is used.

{pstd}
For more on how to format documents, see {cmd: help stmd}.


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
