{smcl}
{* *! version 1.3 18jun2018}{...}
{* *! Doug Hemken}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "markdown" "help markdown"}{...}
{vieweralsosee "stmd2dyn" "help stmd2dyn"}{...}
{vieweralsosee "dyndoc" "help dyndoc"}{...}
{vieweralsosee "dyntext" "help dyntext"}{...}
{vieweralsosee "dynamic tags" "help dynamic tags"}{...}
{vieweralsosee "stpandoc" "help stpandoc"}{...}
{vieweralsosee "dyn2do" "help dyn2do"}{...}
{viewerjumpto "Syntax" "stmd##syntax"}{...}
{viewerjumpto "Description" "stmd##description"}{...}
{viewerjumpto "Options" "stmd##options"}{...}
{viewerjumpto "Remarks" "stmd##remarks"}{...}
{viewerjumpto "Examples" "stmd##examples"}{...}
{title:Title}

{phang}
{bf:stmd} Convert dynamic Markdown to HTML format, using Stata {cmd: dyndoc}{p_end}


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
	command.  {cmd:stmd} is just a wrapper for {cmd: stmd2dyn} followed by
	{cmd: dyndoc}


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt saving} {it: filename2} to specify the final HTML file name.{p_end}

{phang}
{opt replace} replace {it:filename2} if it already exists{p_end}

{dlgtab:More}
{phang}
{it:options} additional options which may be passed to {cmd:dydndoc}
are {cmd:remove}, {cmd:hardwrap}, {cmd:nomsg}, and {cmd:nostop}{p_end}

{marker remarks}{...}
{title:Remarks}

{pstd}
If {it: filename2} is not specified, then {it: filename} with an
.html file extension is tried.

{pstd}
The conventional style for dynamic Markdown files is for the dynamic
content to be specified in {it: fenced code blocks} with an
information tag.  For example {p_end}

{pin}{cmd: ```stata} {p_end}
{pin}{cmd: sysuse auto} {p_end}
{pin}{cmd: ```} {p_end}

{pstd}would be a dynamic code block that loaded the {cmd: auto} data set.  To
accomodate some existing Stata markdown usage, this may be written as three
or more backticks or tildes, the curly braces around "stata" are optional,
and "stata" may be abbreviated simply "s".

{pstd}
In addition to marking a fenced code block for dynamic execution, various
options may be included in the information tag that control whether a
block is executed, and what resulting text may be included in the document.

{pstd}
This takes the general form {p_end}

{pin}{cmd: ```stata}{it:, option(s)} {p_end}
{pin}{it:  -- stata commands --} {p_end}
{pin}{cmd: ```} {p_end}

{pin}
{it: NO EVAL}: To prevent code evaluation, simply don't include an
information tag.  Alternatively, include the {cmd: eval=FALSE} option
(from R).

{pin}
{it: NO COMMANDS}: To prevent the code from being echoed in your
document use any of {cmd: nocommands}, {cmd: echo=FALSE}, or a forward
slash immediately after "stata".

{pin}
{it: NO PROMPT}: To prevent the typical period prefixing echoed commands,
use the option {cmd: noprompt}.

{pin}
{it: NO OUTPUT}: To prevent the output from appearing in your document
(but to still see the commands and have them execute),
use the option {cmd: nooutput}, {cmd: results=FALSE} or {cmd: results="hide"}.

{pin}
{it: NO COMMANDS OR OUTPUT}: To prevent ANY output from appearing in your document
(but to still have your code execute),
use the option {cmd: quietly}.

{pstd}
For example, this would show your regression results, but not the
code that produced them:

{pin}{cmd: ```stata, nocommands}{p_end}
{pin}{cmd:    sysuse auto} {p_end}
{pin}{cmd:    regress price weight} {p_end}
{pin}{cmd: ```} {p_end}

{pstd}
For further information on writing Markdown documents, see 
{cmd: help markdown}

{marker examples}{...}
{title:Examples}

{phang}{cmd:. stmd example.stmd, replace}{p_end}


{title:Author}

{p 4} Doug Hemken {p_end}
{p 4} Social Science Computing Cooperative{p_end}
{p 4} Univ of Wisc-Madison{p_end}
{p 4} {browse "mailto:dehemken@wisc.edu":dehemken@wisc.edu}{p_end}
{p 4} https://www.ssc.wisc.edu/~hemken/Stataworkshops{p_end}
{p 4} https://github.com/Hemken/stmd{p_end}
