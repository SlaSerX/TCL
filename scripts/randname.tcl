# randname.tcl v1.04 [1 August 2000] 
# Copyright (C) 1999-2000 Teemu Hjelt <temex@iki.fi>
#
# Latest version can be found from http://www.iki.fi/temex/eggdrop/
# 
# If you have any suggestions, questions or you want to report 
# bugs, please feel free to send me email to temex@iki.fi
#
# This script gets a random realname for the bot from a list.
#
# Note: If you have any other scripts that uses 
# the realname variable load them BEFORE this script.
#
# Tested on eggdrop1.4.4 with TCL 7.6
#
# Version history:
# v1.00 - The very first version!
# v1.01 - Added more realnames and removed useless variables.
# v1.02 - Now the bot doesn't set a new value for realname when the 
#         bot is rehashed, it only sets it when the bot is started.
#         Also removed the randnames that had the $botnick variable
#         because they didn't work.
# v1.03 - Checked everything and modified realnames.
# v1.04 - Some cosmetic changes.

###### You don't need to edit below this ######

### Misc Things ###

set rn_ver "1.04"

### Possible Realnames ###

set rn_realnames {
	"powered by spambuster v2.4"
	
}


### Sets ###

if {([info exists rn_alreadyset]) && ([info exist rn_randname])} {
	set realname $rn_randname
} else {
	set rn_randname [lindex $rn_realnames [rand [llength $rn_realnames]]]
	set realname $rn_randname
	set rn_alreadyset 1
	putlog "randname: Realname set to '$realname'"
}	

### End ###

putlog "Rrandname v$rn_ver bY dJ_TEDY Loaded."