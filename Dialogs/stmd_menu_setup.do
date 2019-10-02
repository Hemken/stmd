*Install menu items for stmd, stmd2dyn, dyndoc, dyntext, markdown
version 15
window menu clear
window menu append submenu "stUser" "Documents"
if (c(stata_version)==15) {
	window menu append item "Documents" "Stata Markdown to HTML (stmd)" "db stmd15"
}
else if (c(stata_version)>=16) {
	window menu append item "Documents" "Stata Markdown to HTML, docx, PDF (stmd)" "db stmd"
}
window menu append item "Documents" "Stata Markdown to DYN  (stmd2dyn)" "db stmd2dyn"
window menu append separator "Documents"
if (c(stata_version)==15) {
	window menu append item "Documents" "DYN to HTML (dyndoc)" "db dyndoc15"
}
else if (c(stata_version)>=16) {
	window menu append item "Documents" "DYN to HTML, docx, PDF (dyndoc)" "db dyndoc"
}
window menu append item "Documents" "DYN to MD   (dyntext)" "db dyntext"
window menu append item "Documents" "MD to HTML  (markdown)" "db markdown"
window menu refresh
