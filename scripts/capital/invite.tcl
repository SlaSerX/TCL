#####################################################################
#####################################################################
##           Invite.tcl By someone                                 ##
#####################################################################
#####################################################################

set type_ban "20"

# Types are:
## 1 - nick!*@*
## 2 - nick*!*@*
## 3 - *nick*!*@*
## 4 - *!ident@*
## 5 - *!*ident@*
## 6 - *!*ident*@*
## 7 - *!*ident@*.host.com
## 8 - *!ident@*.host.com
## 9 - *!*ident*@*.host.com
## 10 - *!ident@some.host.com
## 11 - *!*ident@some.host.com
## 12 - *!*ident*@some.host.com
## 13 - nick!*@*.host.com
## 14 - nick*!*@*.host.com
## 15 - *nick*!*@*.host.com
## 16 - nick*!*@some.host.com
## 17 - *nick*!*@some.host.com
## 18 - nick!*@some.host.com
## 19 - *!*@*.host.com
## 20 - *!*@some.host.com
## 21 - nick!ident@some.host.com
## 22 - nick*!*ident@some.host.com
## 23 - *nick*!*ident@some.host.com
## 24 - nick!*ident@some.host.com
## 25 - nick*!ident@some.host.com
## 26 - *nick*!ident@some.host.com
## 27 - nick!ident@some.host.com
## 28 - nick*!*ident*@some.host.com
## 29 - *nick*!*ident*@some.host.com
## 30 - nick!*ident*@some.host.com
## 31 - nick*!*ident@*.host.com
## 32 - *nick*!*ident@*.host.com
## 33 - nick!*ident@*.host.com
## 34 - nick*!ident@*.host.com
## 35 - *nick*!ident@*.host.com
## 36 - nick!ident@*.host.com
## 37 - nick*!*ident*@*.host.com
## 38 - *nick*!*ident*@*.host.com
## 39 - nick!*ident*@*.host.com
## 40 - n?c?!*i?e?t@*.host.com
## 41 - n?c?!i?e?t@some.host.com
## 42 - n?c?!*i?e?t@some.host.com
## 43 - n?c?!*ident@*.host.com
## 44 - n?c?!ident@some.host.com
## 45 - n?c?!*ident@some.host.com
## 46 - nick!*i?e?t@*.host.com
## 47 - nick!i?e?t@some.host.com
## 48 - nick!*i?e?t@some.host.com

## Set this to the words that are forbidden, like b if It sees *b* boom banned!
## ** These words are for all of the things you want to check.
## ** The second var is for a couple of words i.e. "join my ch|part my ch"
## if it sees *join my ch* banned!
## i.e "*irc.*"
set forbidden "*irc.*"
set forbidden "*www.*"
set forbidden "*turnir*"
set forbidden "*prodavam*"

## To ban when a user <B> MESSAGEs </B> me with the word(s). The second is
## for phrases.
set forbidden "*irc.*"
set forbidden "*www.*"
set forbidden "*turnir*"
set forbidden "*prodavam*"

## To ban when a user says <B> ACTION </B> the word(s). The second is for
## phrases.
set forbidden "*irc.*"
set forbidden "*www.*"
set forbidden "*turnir*"
set forbidden "*prodavam*"

## To ban when a user <B> NOTICE </B> me with the word(s). The second is for
## phrases.
set notc_forb "*"
set whole_notc "*"

## To ban when a user <B> QUIT </B> with the word(s). The second is for 
## phrases.
set forbidden "*irc.*"
set forbidden "*www.*"
set forbidden "*turnir*"
set forbidden "*prodavam*"

## To ban when a user <B> CTCP </B> me with the word(s). The second is for
## phrases.
set forbidden "*irc.*"
set forbidden "*www.*"
set forbidden "*turnir*"
set forbidden "*prodavam*"

## To ban when a user <B> CTCP REPLY </B> me with the word(s). The second is
## for phrases.
set forbidden "*irc.*"
set forbidden "*www.*"
set forbidden "*turnir*"
set forbidden "*prodavam*"


## To ban when a user <B> KICK </B> someone of a channel with the word(s).
## The second is for phrases.
set kick_forb "*irc.*"
set whole_kick "Take*"

## To ban when a user set the <B> TOPIC </B> of a channel to some word(s).
## The second is for phrases.
set topc_forb "TakeOver"
set whole_topc "Take Over"

## Set this to the reason, why it is kick banned!
set reason "Hasta La Vista, Baby!!!"

## Set this to the time that the ban exists. Set to 0,if you want it to be perm.
set time 60

## Do you want to kb, to bk or to kick. Or you want it to don't take actions,
## only to make a global ban. Only one can be 1, the others should be 0.
set kb 0
set bk 1
set k 0

## Which users will I not ban? When they have flags:
set flags "f"

## /me is still needed to be done!
## You want to check:
# /msg
set msg 1
# public
set pub 1
# /notice
set notc 1
# /ctcp
set ctcp 1
# /ctcp reply
set ctcr 1
# /quit
set quit 0
# /topic
set invt 0
# kick message
set invk 1
# action on the botnet
set dcca 1

################################################################################
#### YOU DO NOT NEED TO CHANGE ANYTHING BELOW, UNLESS YOU REALLY KNOW WHAT  ####
#### YOU ARE DOING !!!                                                      ####
################################################################################

# Needed to bind all.
if {$msg  == 1} { bind msgm - * invite_msg  }
if {$pub  == 1} { bind pubm - * invite_pub  }
if {$notc == 1} { bind notc - * invite_notc }
if {$ctcp == 1} { bind ctcp - * invite_ctcp }
if {$ctcr == 1} { bind ctcr - * invite_ctcr }
if {$quit == 1} { bind sign - * invite_quit }
if {$invt == 1} { bind topc - * invite_topc }
if {$invk == 1} { bind kick - * invite_kick }
if {$dcca == 1} { bind act  - * invite_act  }

# Checks if you've edit the invite.tcl right.
if {$k  == 1 && $bk == 1} {
    die "Error in Configuration file invite.tcl line: 76-78"
}
if {$k  == 1 && $kb == 1} {
    die "Error in Configuration file invite.tcl line: 76-78"
}
if {$kb == 1 && $bk == 1} {
    die "Error in Configuration file invite.tcl line: 76-78"
}

#######################
# BAN for KICK reason #
#######################
proc invite_kick {nick uhost hand chan targ arg} {
    global botnick reason time bk flags forbidden kick_forb whole_kick whole_forb
	set arg [strip:all $arg]
    if {[matchattr $hand $flags] == 1 || $nick == $botnick || [lindex [split $uhost @] 1] == ""} {
	return
    }
    set goon 0
    foreach bind $forbidden {
	if {[string match "*$bind*" $arg]} {
	    set goon 1
	}
    }
    foreach bindk $kick_forb {
	if {[string match "*$bindk*" $arg]} {
	    set goon 1
	}
    }
    foreach wk [split $whole_kick |] {
	if {[string match "*$wk*" $arg]} {
	    set goon 1
	}
    }
    foreach wf [split $whole_forb |] {
	if {[string match "*$wf*" $arg]} {
	    set goon 1
	}
    }
    if {$goon == 1} {
        set ban [bancheck $uhost $nick]
        foreach chan [channels] {
	    if {[onchan $nick $chan] == 1} {
	        bk $nick $chan $ban
	    }
	}
    }
}

########################
# BAN for TOPIC change #
########################
proc invite_topc {nick uhost hand chan arg} {
    global botnick reason time bk flags forbidden topc_forb whole_topc whole_forb
    set arg [strip:all $arg]
	if {[matchattr $hand $flags] == 1 || [string tolower $nick] == [string tolower $botnick] || [lindex [split $uhost @] 1] == ""} {
	return
    }
    set goon 0
    foreach bind $forbidden {
	if {[string match "*$bind*" $arg]} {
	    set goon 1
	}
    }
    foreach bindtop $topc_forb {
	if {[string match "*$bindtop*" $arg]} {
	    set goon 1
	}
    }
    foreach wt [split $whole_topc |] {
	if {[string match "*$wt*" $arg]} {
	    set goon 1
	}
    }
    foreach wf [split $whole_forb |] {
	if {[string match "*$wf*" $arg]} {
	    set goon 1
	}
    }
    if {$goon == 1} {
        foreach chan [channels] {
	    if {[onchan $nick $chan] == 1} {
                  bk $nick $chan $ban
	    }
	}
    }

}

#######################
# BAN for MSG invites #
#######################
proc invite_msg {nick uhost hand arg} {
    global botnick reason time bk flags forbidden msg_forb whole_msg whole_forb
    set arg [strip:all $arg]
	
    if {[matchattr $hand $flags] == 1  || [string tolower $nick] == [string tolower $botnick] || [lindex [split $uhost @] 1] == ""} {
	return
    }
    set goon 0
    foreach bind $forbidden {
	if {[string match "*$bind*" $arg]} {
	    set goon 1
	}
    }
    foreach bindm $msg_forb {
	if {[string match "*$bindm*" $arg]} {
	    set goon 1
	}
    }
    foreach wm [split $whole_msg |] {
	if {[string match "*$wm*" $arg]} {
	    set goon 1
	}
    }
    foreach wf [split $whole_forb |] {
	if {[string match "*$wf*" $arg]} {
	    set goon 1
	}
    }
    if {$goon == 1} {
        set ban [bancheck $uhost $nick]
        newban $ban $botnick $reason $time
        foreach chan [channels] {
	    if {[onchan $nick $chan] == 1} {
                #putquick "MODE $chan :+m"
	        bk $nick $chan $ban
	        utimer 300 [list putquick "MODE $chan -m)"] 
           }
	}
    }
}

###########################
# BAN for ACTION invites #
###########################
proc invite_pub {nick uhost hand chan arg} {
    global botnick reason time bk k kb flags forbidden pub_forb whole_pub whole_forb

    set arg [strip:all $arg]
	set go 0
    if {[matchattr $hand $flags] == 1 || [string tolower $nick] == [string tolower $botnick] || [lindex [split $uhost @] 1] == ""} {
	return
    }
    foreach bind $forbidden {
	if {[string match "*$bind*" $arg]} {
	    set go 1
	}
    }
    foreach bindp $pub_forb {
	if {[string match "*$bindp*" $arg]} {
	    set go 1
	}
    }
    foreach wp [split $whole_pub |] {
	if {[string match "*$wp*" $arg]} {
	    set go 1
	}
    }
    foreach wf [split $whole_forb |] {
	if {[string match "*$wf*" $arg]} {
	    set go 1
	}
    }
    if {$go == 1} {
        set ban [bancheck $uhost $nick]
        newban $ban $botnick $reason $time
        foreach chan [channels] {
	    if {[onchan $nick $chan] == 1} {
                #putquick "MODE $chan :+m"
	        bk $nick $chan $ban
	        utimer 300 [list putquick "MODE $chan -m)"] 
	    }
	}
    }
}

##########################
# BAN for NOTICE invites #
##########################
proc invite_notc {nick uhost hand arg dest} {
    global botnick reason time bk flags forbidden notc_forb whole_notc whole_forb
    set arg [strip:all $arg]
	
    if {[matchattr $hand $flags] == 1 || [string tolower $nick] == [string tolower $botnick] || [lindex [split $uhost @] 1] == ""} {
	return
    }
    set goon 0
    foreach bind $forbidden {
	if {[string match "*$bind*" $arg]} {
	    set goon 1
	}
    }
    foreach bindn $notc_forb {
	if {[string match "*$bindn*" $arg]} {
	    set goon 1
	}
    }
    foreach wn [split $whole_notc |] {
	if {[string match "*$wn*" $arg]} {
	    set goon 1
	}
    }
    foreach wf [split $whole_forb |] {
	if {[string match "*$wf*" $arg]} {
	    set goon 1
	}
    }
    if {$goon == 1} {
        set ban [bancheck $uhost $nick]
        newban $ban $botnick $reason $time
        foreach chan [channels] {
	    if {[onchan $nick $chan] == 1} {
                #putquick "MODE $chan :+m"
	        bk $nick $chan $ban
	        utimer 300 [list putquick "MODE $chan -m)"] 
	    }
	}
    }
}

##############################
# BAN for CTCP REPLY invites #
##############################
proc invite_ctcr {nick uhost hand dest keyword args} {
    set arg "$keyword [lindex [split [string trimleft $args \{] "\}"] 0]"
    global botnick reason time bk flags forbidden ctcr_forb whole_ctcr whole_forb
    set arg [strip:all $arg]
	
    if {[matchattr $hand $flags] == 1 || [string tolower $nick] == [string tolower $botnick] || [lindex [split $uhost @] 1] == ""} {
	return
    }
    set goon 0
    foreach bind $forbidden {
	if {[string match "*$bind*" $arg]} {
	    set goon 1
	}
    }
    foreach bindcp $ctcp_forb {
	if {[string match "*$bindcp*" $arg]} {
	    set goon 1
	}
    }
    foreach wr [split $whole_ctcr |] {
	if {[string match "*$wr*" $arg]} {
	    set goon 1
	}
    }
    foreach wf [split $whole_forb |] {
	if {[string match "*$wf*" $arg]} {
	    set goon 1
	}
    }
    if {$goon == 1} {
        foreach chan [channels] {
	    if {[onchan $nick $chan] == 1} {
	        bk $nick $chan $ban
	    }
	}
    }
}

########################
# BAN for CTCP invites #
########################
proc invite_ctcp {nick uhost hand dest keyword args} {
    set arg "$keyword [lindex [split [string trimleft $args \{] "\}"] 0]"
    global botnick reason time bk flags forbidden ctcp_forb whole_ctcp whole_forb
    set arg [strip:all $arg]
	
	if {[matchattr $hand $flags] == 1 || [string tolower $nick] == [string tolower $botnick] || [lindex [split $uhost @] 1] == ""} {
	return
    }
    set goon 0
    foreach bind $forbidden {
	if {[string match "*$bind*" $arg]} {
	    set goon 1
	}
    }
    foreach bindcr $ctcp_forb {
	if {[string match "*$bindcr*" $arg]} {
	    set goon 1
	}
    }
    foreach wp [split $whole_ctcp |] {
	if {[string match "*$wp*" $arg]} {
	    set goon 1
	}
    }
    foreach wf [split $whole_forb |] {
	if {[string match "*$wf*" $arg]} {
	    set goon 1
	}
    }
    if {$goon == 1} {
        foreach chan [channels] {
	    if {[onchan $nick $chan] == 1} {
 	        bk $nick $chan $ban
	    }
	}
    }
}

########################
# BAN for QUIT invites #
########################
proc invite_quit {nick uhost hand chan arg} {
    global botnick reason time bk flags forbidden quit_forb whole_quit whole_forb
    set arg [strip:all $arg]
	
    if {[matchattr $hand $flags] == 1 || [lindex [split $uhost @] 1] == ""} {
	return
    }
    set goon 0
    foreach bind $forbidden {
	if {[string match "*$bind*" $arg]} {
	    set goon 1
	}
    }
    foreach bindq $quit_forb {
	if {[string match "*$bindq*" $arg]} {
	    set goon 1
	}
    }
    foreach wq [split $whole_quit |] {
	if {[string match "*$wq*" $arg]} {
	    set goon 1
	}
    }
    foreach wf [split $whole_forb |] {
	if {[string match "*$wf*" $arg]} {
	    set goon 1
	}
    }
    if {$goon == 1} {
        foreach chan [channels] {
	    if {[onchan $nick $chan] == 1} {
	        bk $nick $chan $ban
	    }
	}
    }
}

# With this proc you can really get your wanted ban!
proc bancheck {uhost nick } {
    global type_ban
    if {$type_ban == 1} {
	return "$nick!*@*"
    }
    if {$type_ban == 2} {
	return "$nick*!*@*"
    }
    if {$type_ban == 3} {
	return "*$nick*!*@*"
    }
    if {$type_ban == 4} {
	return "*![lindex [split $uhost "@"] 0]@*"
    }
    if {$type_ban == 5} {
        regsub {~} $uhost "" uhost
	return "*!*[lindex [split $uhost "@"] 0]@*"
    }
    if {$type_ban == 6} {
        regsub {~} $uhost "" uhost
	return "*!*[lindex [split $uhost "@"] 0]*@*"
    }
    if {$type_ban == 7} {
        regsub {~} $uhost "" uhost
	return "*!*[lindex [split [maskhost $uhost] "!"] 1]"
    }
    if {$type_ban == 8} {
        regsub {~} $uhost "" uhost
	return "*!*[lindex [split $uhost "@"] 0]*@*"
    }
    if {$type_ban == 9} {
        regsub {~} $uhost "" uhost
	return "*!*[lindex [split $uhost "@"] 0]*@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 10} {
	return "*!$uhost"
    }
    if {$type_ban == 11} {
        regsub {~} $uhost "" uhost
    	return "*!*$uhost"
    }
    if {$type_ban == 12} {
        regsub {~} $uhost "" uhost
	return "*!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 13} {
	return "$nick!*@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 14} {
	return "$nick*!*@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 15} {
	return "*$nick*!*@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 16} {
	return "$nick*!*@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 17} {
	return "*$nick*!*@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 18} {
	return "$nick!*@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 19} {
	return "*!*@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 20} {
	return "*!*@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 21} {
	return "$nick!$uhost"
    }
    if {$type_ban == 22} {
        regsub {~} $uhost "" uhost
	return "$nick*!*$uhost"
    }
    if {$type_ban == 23} {
        regsub {~} $uhost "" uhost
	return "*$nick*!*$uhost"
    }
    if {$type_ban == 24} {
        regsub {~} $uhost "" uhost
	return "$nick!*$uhost"
    }
    if {$type_ban == 25} {
	return "$nick*!$uhost"
    }
    if {$type_ban == 26} {
	return "*$nick*!$uhost"
    }
    if {$type_ban == 27} {
	return "$nick!$uhost"
    }
    if {$type_ban == 28} {
        regsub {~} $uhost "" uhost
	return "$nick*!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 29} {
        regsub {~} $uhost "" uhost
	return "*$nick*!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 30} {
        regsub {~} $uhost "" uhost
	return "$nick!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 31} {
        regsub {~} $uhost "" uhost
	return "$nick*!*[lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 32} {
        regsub {~} $uhost "" uhost
	return "*$nick*!*[lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 33} {
        regsub {~} $uhost "" uhost
	return "$nick!*[lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 34} {
	return "$nick*![lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 35} {
	return "*$nick*![lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 36} {
	return "$nick![lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 37} {
        regsub {~} $uhost "" uhost
	return "$nick*!*[lindex [split $uhost "@"] 0]*@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 38} {
        regsub {~} $uhost "" uhost
	return "*$nick*!*[lindex [split $uhost "@"] 0]*@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 39} {
        regsub {~} $uhost "" uhost
	return "$nick!*[lindex [split $uhost "@"] 0]*@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 40} {
        regsub {~} $uhost "" uhost
	set all [sh_ban $uhost $nick]
	return "[lindex $all 0]!*[lindex $all 1]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 41} {
        regsub {~} $uhost "" uhost
	set all [sh_ban $uhost $nick]
	return "[lindex $all 0]![lindex $all 1]@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 42} {
        regsub {~} $uhost "" uhost
	set all [sh_ban $uhost $nick]
	return "[lindex $all 0]!*[lindex $all 1]@[lindex [split $uhost "@"] 1]"
    }
    if {$type_ban == 43} {
        regsub {~} $uhost "" uhost
	set all [sh_ban $uhost $nick]
	return "[lindex $all 0]!*[lindex $all 1]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 44} {
        regsub {~} $uhost "" uhost
	set all [sh_ban $uhost $nick]
	return "[lindex $all 0]![lindex $all 1]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 45} {
        regsub {~} $uhost "" uhost
	set all [sh_ban $uhost $nick]
	return "[lindex $all 0]!*[lindex $all 1]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 46} {
        regsub {~} $uhost "" uhost
	set all [sh_ban $uhost $nick]
	return "[lindex $all 0]!*[lindex $all 1]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 47} {
        regsub {~} $uhost "" uhost
	set all [sh_ban $uhost $nick]
	return "[lindex $all 0]![lindex $all 1]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
    if {$type_ban == 48} {
        regsub {~} $uhost "" uhost
	set all [sh_ban $uhost $nick]
	return "[lindex $all 0]!*[lindex $all 1]@[lindex [split [maskhost $uhost] "@"] 1]"
    }
}

# Heh, I'm lame to make the n?c? stuff with TCL!:=)) // Not anymore, the jobe
# is done by TCL, thanks to $myass.
proc sh_ban {uhost nick} {
    set send ""
    set aq 0
    set all1 ""
    foreach bau [split $nick ""] {
        if {$aq == 1} {
            append all1 "?"
    	    set aq 0
        } else {
            append all1 "$bau"
	    set aq 1
        }
    }
    append send "$all1"
    set aq 0
    set all1 ""
    foreach baua [split [lindex [split $uhost @] 0] ""] {
        if {$aq == 1} {
            append all1 "?"
    	    set aq 0
        } else {
            append all1 "$baua"
	    set aq 1
        }
    }
    append send " $all1"
    set aq 0
    set all1 ""
    foreach baub [split [lindex [split $uhost @] 1] ""] {
	if {$baub == "."} {
	    append all1 $baub
	} else {
            if {$aq == 1} {
                append all1 "?"
    	        set aq 0
	    } else {
                append all1 "$baub"
	        set aq 1
            }
	}
    }
    append send " $all1"
    return "$send"
}

# Kick banning the user.
proc kb {nick chan ban} {
    global reason
    if {[botisop $chan] == 1} {
        putkick $chan $nick $reason
        pushmode $chan +b $ban
    }
}

# Ban kicking the user.
proc bk {nick chan ban} {
    global reason
    if {[botisop $chan] == 1} {
	putquick "MODE $chan +b :$ban"
        putquick "KICK $chan $nick :$reason"
        }
}

# Kicking the user.
proc k {nick chan ban} {
    global reason
    if {[botisop $chan] == 1} {
	putkick $chan $nick $reason
    }
}

proc strip:color {string} {
  regsub -all \003\[0-9\]{1,2}(,\[0-9\]{1,2})? $string {} string
  return $string
}

proc strip:bold {string} {
  regsub -all \002 $string {} string
  return $string
}

proc strip:underline {string} {
  regsub -all \037 $string {} string
  return $string
}

proc strip:all {string} {
  return [strip:color [strip:bold [strip:underline $string]]]
}

putlog "LoadeD:invite.tcl"
