* Check for previous installation
ado dir stmd
ado uninstall stmd
* If there are more than one previous installation,
*   you have to remove them by [number] rather than name

* The actual installation
net from https://www.ssc.wisc.edu/~hemken/Stataworkshops/
net install stmd, replace

* Check
which stmd
which stmd2dyn
