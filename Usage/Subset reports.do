clear
sysuse auto

levelsof rep78, local(rep78levels)

foreach level of local rep78levels {
	stmd "repeated subsets.stmd" `level', saving("rep78 eq `level'.html") ///
		replace embedimage
}