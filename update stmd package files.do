* update stmd package files
cd "Z:/Stata/stmd"
local destpath "Z:/PUBLIC_Web/Stataworkshops/stmd"

copy stmd.ado       `destpath'/stmd.ado,       replace
copy stmd.sthlp     `destpath'/stmd.sthlp,     replace
copy stmd2dyn.ado   `destpath'/stmd2dyn.ado,   replace
copy stmd2dyn.sthlp `destpath'/stmd2dyn.sthlp, replace

copy Dialogs/stmd.dlg       `destpath'/Dialogs/stmd.dlg,       replace
copy Dialogs/stmd15.dlg     `destpath'/Dialogs/stmd15.dlg,     replace
copy Dialogs/stmd2dyn.dlg   `destpath'/Dialogs/stmd2dyn.dlg,   replace
copy Dialogs/dyndoc.dlg     `destpath'/Dialogs/dyndoc.dlg,     replace
copy Dialogs/dyndoc15.dlg   `destpath'/Dialogs/dyndoc15.dlg,   replace
copy Dialogs/dyntext.dlg    `destpath'/Dialogs/dyntext.dlg,    replace
copy Dialogs/markdown.dlg   `destpath'/Dialogs/markdown.dlg,   replace