#####################################################################
#####################################################################
##           Addon.tcl By someone                                  ##
#####################################################################
#####################################################################

##########################################################################
# Bindings                                                               #
##########################################################################
unbind dcc n|n adduser *dcc:adduser
unbind dcc n|n deluser *dcc:deluser
unbind dcc n|n +user *dcc:+user
unbind dcc n|n -user *dcc:-user
unbind dcc n|n +bot *dcc:+bot
unbind dcc n|n -bot *dcc:-bot
unbind dcc n|n chattr *dcc:chattr
unbind dcc m|m +ban *dcc:+ban

bind dcc n|n adduser dcc:adduser
bind dcc n|n deluser dcc:deluser
bind dcc n|n +user dcc:+user
bind dcc n|n -user dcc:-user
bind dcc n|n +bot dcc:+bot
bind dcc n|n -bot dcc:-bot
bind dcc n|n chattr dcc:chattr
bind dcc m|- +ban dcc:+ban

##########################################################################
# Initilization                                                          #
##########################################################################
if {![info exists whois-fields]} {
    set whois-fields ""
}

# Add "Added" field
set ffound 0
foreach f2 [split ${whois-fields}] {
    if {[string tolower $f2] == [string tolower "ADDED"]} {
        set ffound 1
        break
    }
}
if {$ffound == 0} {
    append whois-fields " " "ADDED"
}

# Add "Changed" field
set ffound 0
foreach f2 [split ${whois-fields}] {
    if {[string tolower $f2] == [string tolower "CHANGED"]} {
        set ffound 1
        break
    }
}
if {$ffound == 0} {
    append whois-fields " " "CHANGED"
}
			    
##########################################################################
# dcc:chattr start                                                       #
##########################################################################
proc dcc:chattr {hand idx paras} {
 set user [lindex $paras 0]
 set flags [lindex $paras 1]
 set on_chan [lindex $paras 2]
 if {[validuser $user]} {
  *dcc:chattr $hand $idx $paras
  setuser $user xtra CHANGED "by $hand ([strftime %d-%m-%Y@%H:%M]) $flags $on_chan"
 } else {
  *dcc:chattr $hand $idx $paras
 }
}

##########################################################################
# dcc:add/deluser start                                                  #
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
            setuser $user xtra ADDED "by $hand as $user ([strftime %d-%m-%Y@%H:%M])"
		#tellaboutnew $hand $user
        
        	}
    }
}    

proc dcc:deluser {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
	*dcc:deluser $hand $idx $paras
     #tellaboutdel $hand $user
             } else {
	*dcc:deluser $hand $idx $paras
    }
}    

##########################################################################
# dcc:+/-user start                                                      #
##########################################################################
proc dcc:+user {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:+user $hand $idx $paras
    } else {
        *dcc:+user $hand $idx $paras
        if {[validuser $user]} {
            setuser $user xtra ADDED "by $hand as $user ([strftime %d-%m-%Y@%H:%M])"
		#tellaboutnew $hand $user
           
              }
    }
}

proc dcc:-user {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:-user $hand $idx $paras
        #tellaboutdel $hand $user
             } else {
        *dcc:-user $hand $idx $paras
    }
}

##########################################################################
# dcc:+/-bot start                                                       #
##########################################################################
proc dcc:+bot {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:+bot $hand $idx $paras
    } else {
        *dcc:+bot $hand $idx $paras
        if {[validuser $user]} {
            setuser $user xtra ADDED "by $hand as $user ([strftime %d-%m-%Y@%H:%M])"
		#tellaboutnew $hand $user
        }
    }
}

proc dcc:-bot {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:-bot $hand $idx $paras
        #tellaboutdel $hand $user
    } else {
        *dcc:-bot $hand $idx $paras
     }
}

##########################################################################
# +ban start                                                             #
##########################################################################
proc dcc:+ban {handle idx arg} {
  if {$arg == ""} {
    *dcc:+ban $handle $idx $arg
    return 0
  }
  *dcc:+ban $handle $idx "$arg (set by $handle on [strftime %d-%m-%Y@%H:%M])"
}
putlog "LoadeD:addon.tcl"
