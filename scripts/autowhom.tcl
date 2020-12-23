### autowhom.tcl v1.0.0, 7 April 2002
### by Graeme Donaldson
### (Souperman @ #eggdrop @ Undernet)
### Visit http://www.eggdrop.za.net/ for updates and other Tcl scripts.
###
### Automatically does a .whom when a user logs on to partyline.
###
### To use:
###  - Extract to your eggdrop scripts dir.
###  - Add 'source scripts/autowhom.tcl' to the end of your bot's config
###  - .rehash
###
################################################################################



### NO EDITING REQUIRED ###
set awver "1.0.0"
set awnver "100000"

putlog "Инсталиран: autowhom.tcl"

bind chon - * awdowhom

proc awdowhom {hand idx} {
	putlog "14***4 Сега да видим кой е тук..."
	*dcc:whom $hand $idx *
}