##########################################################################
# TCL. DiePass by Arkadietz                                              #
# Kiril Georgiev email: <Arakdietz@yahoo.com>		                 #
##########################################################################

##########################################################################################
## This script makes owners (+n users) to enter a password to use ".die"  This also      #
## disables /msg <bot> die. Thanks to Nilsy on undernet for all the help.		 #
##########################################################################################

#############################################################
## Just load the script, set the variables, and RESTART.   ##
#############################################################

##############################
# Set your die password here.#
##############################

set pass "NAPISHETE-PAROLATA-TUK"

##################################################################
# Would you like to log all die attempts with invalid passwords? #
##################################################################

set useinfo "1"

###################################################################################################
# Set the channel or nick to private message when an attempt is made. (Only if useinfo is enabled)#
###################################################################################################

set infodest "#ruse"

##################################################################################################################
# Message to send on failure, NOTE: only enter what would come after the users handle, the handle is hard-coded. #
##################################################################################################################

set failmsg "Just tried to issue a .die command with an invalid password."

####################
# Code begins here #
####################

bind dcc n|- die dcc:die
unbind msg n|- die *msg:die

proc dcc:die {hand idx text} {
	global useinfo infodest failmsg pass
	if {$text == ""} {
		putidx $idx "Usage: die <password> \[reason\]"
		return 0
	}
	set chkpass [lindex $text 0]
	if {$chkpass == $pass} { 
		if {[llength $text] > 1} {
			set reason [lrange $text 1 end]
		} else {
			set reason "Authorized by $hand"
		}
		die $reason 
		return 1
	} else {
		putidx $idx "DIEPASS: Invalid die password, attempt has been logged."
		if {$useinfo == 1} { 
			puthelp "PRIVMSG $infodest :DIEPASS: $hand $failmsg."
			putlog "DIEPASS: $hand just tried to issue a .die command with the invalid password \"$chkpass\" "
			return 0
		} 
		return 0
	}
}

putlog "Инсталиран: DiePass.tcl"

