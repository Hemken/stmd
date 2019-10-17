clear
sysuse auto

levelsof rep78, local(rep78levels)

foreach level of local rep78levels {
	preserve
	keep if rep78==`level'
	stmd "repeated datasets.stmd" `level', saving("rep78_data_`level'.html") ///
		replace embedimage
	restore
}