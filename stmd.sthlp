{smcl}
{* *! version 1.7 29sep2019}{...}
{* *! Doug Hemken}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "stmd2dyn" "help stmd2dyn"}{...}
{vieweralsosee "markdown" "help markdown"}{...}
{vieweralsosee "dyndoc" "help dyndoc"}{...}
{vieweralsosee "dyntext" "help dyntext"}{...}
{vieweralsosee "dynamic tags" "help dynamic tags"}{...}
{viewerjumpto "Syntax" "stmd##syntax"}{...}
{viewerjumpto "Description" "stmd##description"}{...}
{viewerjumpto "Options" "stmd##options"}{...}
{viewerjumpto "Remarks" "stmd##remarks"}{...}
{viewerjumpto "Examples" "stmd##examples"}{...}
{title:Title}

{p2colset 1 9 19 2}{...}
{p2col:{bf:stmd} {hline 2}}
Convert standard dynamic Markdown to HTML, DOCX, or PDF format, using 
  Stata {cmd: dyndoc}{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:stmd}
{it:srcfile}
[{it:arguments}]
[{cmd:,} {it:options}]
{p_end}

{phang}
{it:srcfile} is a plain text file containing text
and code blocks in standard dynamic Markdown format.{p_end}

{phang}
{it:arguments} are stored in the local macros {cmd:`1'}, {cmd:`2'}, etc,
and passed to {it:srcfile}.{p_end}

{phang}
Enclose filenames in double quotes
if they contain blanks or other special characters.{p_end}

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt sav:ing(targetfile)}}specify the target HTML, Word, 
or PDF file to be saved{p_end}
{synopt:{opt replace}}replace {it:targetfile} if it already exists{p_end}

{syntab:Other}
{synopt :{opt docx}}output a Word (.docx) document{p_end}
{synopt :{opt pdf}}output a PDF document{p_end}
{synopt :{opt embedimage}}for HTML documents, embed images 
rather than link them{p_end}
{synopt :{opt hardwrap}}conserve line breaks from the 
{it:srcfile}{p_end}
{synopt :{opt nomsg}}suppress file messages{p_end}
{synopt :{opt noremove}}suppress {cmd:<<dd_remove>>} processing{p_end}
{synopt :{opt nostop}}do not stop if an error occurs{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}


{marker description}{...}
{title:Description}

{pstd}
{cmd:stmd} takes a dynamic Markdown document which uses conventional
 markdown specification and converts it to HTML, Word, or PDF via
 Stata's {cmd: dyndoc} command.  {cmd:stmd} is a wrapper for
 {cmd: stmd2dyn} followed by {cmd: dyndoc}.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt saving} {it: targetfile} to specify the final document's file
 name. If not specified this defaults to
{it:srcfile} with the appropriate file extension.{p_end}

{phang}
{opt replace} replace the {it:targetfile} if it already exists{p_end}

{dlgtab:Other}
{phang}
Additional options (which are passed to {cmd:dydndoc})
are {cmd:docx}, {cmd:pdf}, {cmd:embedimage}, {cmd:hardwrap}, 
{cmd:nomsg}, {cmd:noremove}, and {cmd:nostop}{p_end}

{phang}
{opt docx} specifies the {it:targetfile} be saved in
Microsoft Word format.

{phang}
{opt pdf} specifies the {it:targetfile} be saved in
Adobe PDF format.

{phang}
{opt embedimage} specifies that any images be saved as
part of the (HTML) {it:targetfile}, rather than as
linked files.

{phang}
{opt hardwrap} specifies that hard wraps (line breaks) in the
{it:srcfile} are reproduced in the {it:targetfile}.

{phang}
{opt nomsg} suppresses intermediate file messages and the 
link to the {it:targetfile}.

{phang}
{opt noremove} specifies that {cmd:<<dd_remove>>} and {cmd:<</dd_remove>>} 
tags should not be processed.

{phang}
{opt nostop} allows the document to continue being processed even if an error
occurs.

{marker remarks}{...}
{title:Remarks}

{pstd}
The conventional style for dynamic Markdown files is for the dynamic
content to be specified in {it: fenced code blocks} with an
information tag.  For example {p_end}

{pin}{cmd: ```stata} {p_end}
{pin}{cmd: sysuse auto} {p_end}
{pin}{cmd: ```} {p_end}

{pstd}would be a dynamic code block that loaded the {cmd: auto} data set.  To
accomodate some existing Stata markdown usage, this may be written as three
or more backticks or tildes, curly braces around "stata" may be added,
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
{it: NO COMMANDS}: To prevent the code from being echoed in your
document use the {cmd: nocommands} option.  Alternatively, this
may be specified as {cmd: echo=FALSE}, or a forward
slash immediately after "stata".

{pin}
{it: NO PROMPT}: To prevent the typical period prefixing echoed commands,
use the option {cmd: noprompt}.

{pin}
{it: NO OUTPUT}: To prevent the output from appearing in your document
(but to still see the commands and have them execute),
use the option {cmd: nooutput}.  Alternatively, use
{cmd: results=FALSE} or {cmd: results="hide"}.

{pin}
{it: NO COMMANDS OR OUTPUT}: To prevent ANY output from appearing in your document
(but to still have your code execute),
use the option {cmd: quietly}.

{pin}
{it: NO EVALUATION}: To prevent code evaluation, simply don't include an
information tag.  Alternatively, include the {cmd: eval=FALSE} option
(from R).

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
