set verzia v1.2

##########################################################################
# Bindings                                                               #
##########################################################################
unbind dcc m|m adduser *dcc:adduser
unbind dcc m|m deluser *dcc:deluser
unbind dcc m|- +user *dcc:+user
unbind dcc m|- -user *dcc:-user
unbind dcc t|- +bot *dcc:+bot
unbind dcc t|- -bot *dcc:-bot
unbind dcc m|m chattr *dcc:chattr
unbind dcc o|o +ban *dcc:+ban

bind dcc m|m adduser dcc:adduser
bind dcc m|m deluser dcc:deluser
bind dcc m|- +user dcc:+user
bind dcc m|- -user dcc:-user
bind dcc t|- +bot dcc:+bot
bind dcc t|- -bot dcc:-bot
bind dcc m|m chattr dcc:chattr
bind dcc o|o +ban dcc:+ban

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
        }
    }
}

proc dcc:deluser {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:deluser $hand $idx $paras
      tellaboutdel $hand $user
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
        }
    }
}

proc dcc:-user {hand idx paras} {
    set user [lindex $paras 0]
    if {[validuser $user]} {
        *dcc:-user $hand $idx $paras
        tellaboutdel $hand $user
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
  if {$arg == ""} {
    *dcc:+ban $handle $idx $arg
    return 0
  }
  *dcc:+ban $handle $idx "$arg (set by $handle on [strftime %d-%m-%Y@%H:%M])"
}
##########################################################################
# +ban end                                                               #
##########################################################################

putlog "########################################"
putlog "#\002Add/Del/Change/Ban\002 addon $verzia by NoVaK"
putlog "########################################"

