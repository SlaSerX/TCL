#  Added.tcl by Nils Ostbjerg <shorty@business.auc.dk>
#  (C) Copyright (2000)
#
#  This script add a "Added" entry into the userfile for each user added
#  after the script is starte. It will also send a note to the users 
#  specified in the config file's notify-newusers setting.
#
#  This version of the Added script is useable (read tested) with Eggdrop
#  version 1.4.0 or higher.
#
#  Please report any bugs to me at shorty@business.auc.dk.
#  Idea and suggestion to new features are also welcome.
#
#                                 - Nils Ostbjerg <shorty@business.auc.dk>
#
#  Version 1.4.0 - 12 Mar 2000  First Version, should work ok.
#                                 - Nils Ostbjerg <shorty@business.auc.dk>
# 


##########################################################################
# Bind                                                                   #
##########################################################################

unbind msg - hello *msg:hello
unbind dcc m|m adduser *dcc:adduser 
unbind dcc m|- +user *dcc:+user
unbind dcc m|- +host *dcc:+host
unbind dcc t|- +bot *dcc:+bot

# many irc ops check for bots that respond to 'hello'. You can change 
# what  word the bot listens for by changing the line that looks like 
# this: 'bind msg - hello msg:hello' into 'bind msg - myword msg:hello'
# Where "myword" to the word you want to use instead of 'hello' 
# (it must be a single word)

bind msg - hello msg:hello
bind dcc m|m adduser dcc:adduser
bind dcc m|- +user dcc:+user
bind dcc m|- +host dcc:+host
bind dcc t|- +bot dcc:+bot



##########################################################################
# Initiliaze                                                             #
##########################################################################

if {![info exists whois-fields]} {
    set whois-fields ""
}

set ffound 0
set fhfound 0
set fhtfound 0
foreach f2 [split ${whois-fields}] {
    if {[string tolower $f2] == [string tolower "Added"]} {
        set ffound 1
    }
    if {[string tolower $f2] == [string tolower "LastAddHost"]} {
	  set fhfound 1
    }
    if {[string tolower $f2] == [string tolower "TotalHosts"]} {
	  set fhtfound 1
    }
}
if {$ffound == 0} {
    append whois-fields " " "Added"
}
if {$fhfound == 0} {
    append whois-fields " " "LastAddHost"
}
if {$fhtfound == 0} {
    append whois-fields " " "TotalHosts"
}


##########################################################################
# msg:hello start                                                        #
##########################################################################

proc msg:hello {nick host hand paras} {
    if { $hand != "*" } {
        *msg:hello $nick $host $hand $paras
    } elseif {[validuser $nick]} {
        *msg:hello $nick $host $hand $paras
    } else {
        *msg:hello $nick $host $hand $paras
	if {[validuser $nick]} {
            setuser $nick xtra Added "by $nick as $nick ([strftime %d-%m-%Y@%H:%M])"
	}
    }
}




##########################################################################
# dcc:adduser start                                                      #
##########################################################################

proc dcc:adduser {hand idx paras} {
    set user [lindex $paras 1]
    if {$user == ""} {
	if {[string index $paras 0] == "!"} {
	    set user [string range [lindex $paras 0] 1 end]
	} else {
	    set user [lindex $paras 0]
	}
    }
    if {[validuser $user]} {
	*dcc:adduser $hand $idx $paras
    } else {
	*dcc:adduser $hand $idx $paras
	if {[validuser $user]} {
            setuser $user xtra Added "by $hand as $user ([strftime %d-%m-%Y@%H:%M])"
	    tellabout $hand $user
	}
    }
}    

##########################################################################
# dcc:adduser end                                                        #
##########################################################################



##########################################################################
# dcc:+user start                                                        #
##########################################################################

proc dcc:+user {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:+user $hand $idx $paras
    } else {
        *dcc:+user $hand $idx $paras
        if {[validuser $user]} {
            setuser $user xtra Added "by $hand as $user ([strftime %d-%m-%Y@%H:%M])"
        }
    }
}


##########################################################################
# dcc:+bot end                                                           #
##########################################################################



##########################################################################
# dcc:+bot start                                                         #
##########################################################################

proc dcc:+bot {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:+bot $hand $idx $paras
    } else {
        *dcc:+bot $hand $idx $paras
        if {[validuser $user]} {
            setuser $user xtra Added "by $hand as $user ([strftime %d-%m-%Y@%H:%M])"
	    tellabout $hand $user
        }
    }
}

##########################################################################
# dcc:+user end                                                          #
##########################################################################

proc dcc:+host {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:+host $hand $idx $paras
	  setuser $user xtra LastAddHost "by $hand as [lindex $paras 1] ([strftime %d-%m-%Y@%H:%M])"
	  if {[string tolower $user] == "bnc"} {
		newban [lindex $paras 1] $hand [getuser $user COMMENT]
		set numhosts 0
		foreach hst [getuser $user HOSTS] {
			set numhosts [expr "$numhosts + 1"]
		}
		setuser $user xtra TotalHosts "$numhosts"
	  }
    } else {
        *dcc:+host $hand $idx $paras
        setuser $hand xtra LastAddHost "by $hand as [lindex $paras 1] ([strftime %d-%m-%Y@%H:%M])"
    }
}


##########################################################################
# tellabout start                                                        #
##########################################################################

proc tellabout {hand user} {
    global nick notify-newusers
    foreach ppl ${notify-newusers} {
	sendnote $nick $ppl "introduced to $user by $hand"
    }
}    

##########################################################################
# tellabout end                                                          #
##########################################################################

##########################################################################
# putlog                                                                 #
##########################################################################

