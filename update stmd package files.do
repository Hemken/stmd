* update stmd package files

local destpath "Z:/PUBLIC_Web/Stataworkshops/stmd"

copy stmd.ado       `destpath'/stmd.ado,       replace
copy stmd.sthlp     `destpath'/stmd.sthlp,     replace
copy stmd2dyn.ado   `destpath'/stmd2dyn.ado,   replace
copy stmd2dyn.sthlp `destpath'/stmd2dyn.sthlp, replace

copy stmd.dlg       `destpath'/stmd.dlg,       replace
copy stmd2dyn.dlg   `destpath'/stmd2dyn.dlg,   replace
copy dyndoc.dlg     `destpath'/dyndoc.dlg,     replace
copy dyntext.dlg    `destpath'/dyntext.dlg,    replace
copy markdown.dlg   `destpath'/markdown.dlg,   replace