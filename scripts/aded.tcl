set verzia v1.0
# Bindings                                                                                                 
unbind dcc m|m adduser *dcc:adduser
unbind dcc m|m deluser *dcc:deluser
unbind dcc -|- +user *dcc:+user
unbind dcc -|- -user *dcc:-user
unbind dcc t|- +bot *dcc:+bot
unbind dcc t|- -bot *dcc:-bot
unbind dcc -|- chattr *dcc:chattr
unbind dcc o|o +ban *dcc:+ban
unbind dcc o|o -ban *dcc:-ban
unbind msg o|o voice *msg:voice
unbind dcc o|o kick *dcc:kick;
unbind dcc o|o voice *dcc:voice
unbind dcc -|- +host *dcc:+host
unbind dcc -|- -host *dcc:-host

bind dcc n|- adduser dcc:adduser
bind dcc n|- deluser dcc:deluser
bind dcc m|m +user dcc:+user
bind dcc m|m -user dcc:-user
bind dcc n|- +bot dcc:+bot
bind dcc n|- -bot dcc:-bot
bind dcc m|m chattr dcc:chattr
bind dcc n|- +ban dcc:+ban
bind dcc n|- -ban dcc:-ban
bind msg n|- voice msg:voice
bind dcc o|o kick kick:kick
bind dcc n|- voice dcc:voice
bind dcc m|- +host *dcc:+host
bind dcc m|- -host *dcc:-host
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
# dcc:chattr end                                                         #
##########################################################################

##########################################################################
# dcc:add/deluser start                                                  #
##########################################################################
proc dcc:adduser {hand idx paras} {
global botnick
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
		tellaboutnew $hand $user
        #putserv "PRIVMSG $user :You are added at me by $hand."
        #putserv "PRIVMSG $user :Please set your password at me -> /msg $botnick pass <your-password>"
        #putlog "Messages to $user was succifuly send."

	}
    }
}    

proc dcc:deluser {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
	*dcc:deluser $hand $idx $paras
      tellaboutdel $hand $user
         #putserv "PRIVMSG $user :You have been removed from me by $hand."
    } else {
	*dcc:deluser $hand $idx $paras
    }
}    
##########################################################################
# dcc:add/deluser end                                                    #
##########################################################################

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
		tellaboutnew $hand $user
        #putserv "PRIVMSG $user :You are added at me by $hand."
        #putserv "PRIVMSG $user :Please set your password at me -> /msg me pass <your-password>"
        #putlog "Messages to $user was succifuly send."
        }
    }
}

proc dcc:-user {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:-user $hand $idx $paras
        tellaboutdel $hand $user
         #putserv "PRIVMSG $user :You have been removed from me by $hand."
    } else {
        *dcc:-user $hand $idx $paras
    }
}
##########################################################################
# dcc:+/-user end                                                        #
##########################################################################

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
		tellaboutnew $hand $user
        }
    }
}

proc dcc:-bot {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:-bot $hand $idx $paras
        tellaboutdel $hand $user
    } else {
        *dcc:-bot $hand $idx $paras
     }
}
##########################################################################
# dcc:+/-bot end                                                         #
##########################################################################

##########################################################################
# tellaboutnew start                                                     #
##########################################################################
proc tellaboutnew {hand user} {
    global notify-newusers
    foreach ppl ${notify-newusers} {
	sendnote $hand $ppl "User $hand added $user ([strftime %d-%m-%Y@%H:%M])."
    }
}    
##########################################################################
# tellaboutnew end                                                       #
##########################################################################

##########################################################################
# tellaboutdel start                                                     #
##########################################################################
proc tellaboutdel {hand user} {
    global notify-newusers
    foreach ppl ${notify-newusers} {
	sendnote $hand $ppl "User $hand deleted $user ([strftime %d-%m-%Y@%H:%M])."
    }
}    
##########################################################################
# tellaboutdel end                                                       #
##########################################################################

##########################################################################
# +ban start                                                             #
##########################################################################
proc dcc:+ban {handle idx arg} {
global botnick
  if {$arg == ""} {
    *dcc:+ban $handle $idx $arg
    return 0
  }
  *dcc:+ban $handle $idx "$arg (set by $handle@$botnick on [strftime %d-%m-%Y@%H:%M])"
}
##########################################################################
# +ban end                                                               #
##########################################################################
proc dcc:-ban {handle idx arg} {
set arg1 [lindex $arg 0]
set arg2 [lindex $arg 1]
set arg3 [idx2hand $idx]
 if {$arg == ""} {
    *dcc:-ban $handle $idx $arg
    return 0
  }
  *dcc:-ban $handle $idx $arg
}


proc kick:kick {handle idx arg} {
global botnick
  if {$arg == ""} {
    *dcc:kick $handle $idx $arg
    return 0
  }
  set date [strftime %d.%m.%Y@%H:%M]
  *dcc:kick $handle $idx "$arg \[\By $handle@$botnick <$date>\]"
}

putlog "\[\002$botnick\002\] Aded TcL by 4AtlantisS 8Team ---\[LoaDeD\]---"

