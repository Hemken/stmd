clear frames
sysuse auto

levelsof rep78, local(rep78levels)

foreach level of local rep78levels {
	frame put if rep78==`level', into(rep78_`level')
	stmd "repeated frames.stmd" `level', saving("rep78_`level'.html") ///
		replace embedimage
}