###
# netops.tcl - (c) 2000,2001 by cucgod, (c) 199x by KuNgFo0
###

# based on netops.tcl v1.0 written by KuNgFo0 (KuNgFo0@tasam.com)
# changelog:
# - removed "authrequest" - useless
# - removed "cycle" & "cycle_msg" - just anoying
# - in certain conditions bots are opless even if they are linked to opped
#   bots - this should be FIXED
# - after unban bot joins immediatly - better channel security?
# - rushed over the whole source-code and tidied up things
# - added netops_loaded
# - removed the function that the scripts added hosts to a bot...
#   in some cases it adds a bogus host, i think every botnetmaster should be 
#   smart enough to add all hosts to a bot
# - added encryption for more security
# - set version to 1.3

### variables ###
set netops_version "1.3"
# this is needed for encryption (must be the same on all bots)
set cryptokey "brockhaus5"

### bindings ###
bind bot - request bot_request
bind bot - response bot_response
bind bot - broadcast bot_broadcast
bind mode - "* +o" mode_broadcast
bind join - * join_request

# kill any old timers left over after a rehash
utimer 4 { kill_channels }
# set each channel's request modes 
utimer 5 do_channels

proc request { what chan } {
    global botnick botname cryptokey

    if {[bots] == ""} {
        putlog "netops: no bots linked - cannot request $what on $chan"
        return 0
    }
    if {$what == "op"} {
        if {![opless $chan]} {
            requestop $chan
            return 1
        }
        putlog "netops: $chan seems opless to me?!"
        return 0
    }
    if {![onchan $botnick $chan]} {
        regsub -all " " [bots] ", " botlist
        putlog "netops: requesting $what for $chan (querying: $botlist)"
        putallbots "request [encrypt $cryptokey "$what $chan $botnick $botname"]"
    }
}

proc bot_request { frombot idx arg } {
    global botnick botname cryptokey

    set arg [decrypt $cryptokey [lindex $arg 0]]

    set command [lindex $arg 0]
    set chan [string tolower [lindex $arg 1]]
    set nick [lindex $arg 2]
    set bothost [lindex $arg 3]

    if {(![matchattr $frombot b])} {
        putlog "netops: unknown bot ($frombot) requested $command for $chan (ignored)"
        return 0
    }
    if {$command != "takekey"} {
        if {![validchan $chan]} {
            putbot $frombot "response I don't monitor $chan"
            return 0
        }
        if {(![onchan $botnick $chan]) && ($command != "join") } {
            putbot $frombot "response I'm not on $chan"
            return 0
        }
        if {(![botisop $chan]) && ($command != "key") && ($command != "join")} {
            putbot $frombot "response I don't have op on $chan"
            return 0
         }
     }
     switch -exact $command {
         "op" {
             if {![onchan $nick $chan]} {
                 putbot $frombot "response you ($nick) are not on $chan for me"
                 return 0
             }
             if {$bothost != "$nick![getchanhost $nick $chan]"} {
                 putbot $frombot "response i don't recognize your host ($bothost)"
                 return 0
             }
             if {[string tolower $frombot] == [string tolower $nick]} {
                 putlog "netops: $frombot requested op on $chan"
             } else {
                 putlog "netops: $frombot requested op as $nick on $chan"
             }
             if {[matchattr $frombot o|o $chan]} {
                 utimer [rand 10] "delay_request op $chan $nick"
                 return 1
             }
             putbot $frombot "response you wont get op on $chan (not +o)"
             return 1
         }
         "unban" {
             putlog "netops: $frombot requested to be unbanned on $chan"
             utimer [rand 10] "delay_request unban $chan { $bothost $frombot }"
             return 1
         }
         "join" {
             putlog "netops: $frombot unbanned me on $chan ... REJOINING!"
             putserv "JOIN $chan"
             return 1
         }
         "invite" {
             if {[string tolower $frombot] == [string tolower $nick]} {
                 putlog "netops: $frombot requested an invite to $chan"
             } else {
                 putlog "netops: $frombot requested an invite as $nick to $chan"
             }
             putserv "INVITE $nick $chan"
             return 1
         }
         "limit" {
             putlog "netops: $frombot requested a limit raise on $chan"
             utimer [rand 10] "delay_request limit $chan null"
             return 1
         }
         "key" {
             putlog "netops: $frombot requested the key for $chan"
             if {[string match *k* [lindex [getchanmode $chan] 0]]} {
                 putbot $frombot "request [encrypt $cryptokey "takekey $chan $botnick $botname [lindex [getchanmode $chan] 1]"]"
                 return 1
             }
             putbot $frombot "response there is no key for $chan"
             return 0
         }
         "takekey" {
             putlog "netops: $frombot gave me the key for $chan"
             if {[validchan $chan] && ![onchan $botnick $chan]} {
                 putserv "JOIN $chan [lindex $arg 4]"
                 return 1
             }
         }
         default {
             putlog "netops: !!warning!! - $frombot sent fake 'request' message: $command - !!warning!!"
             return 0
         }
     }
}

proc opless { chan } {
    foreach user [chanlist $chan] {
        if {[isop $user $chan]} { return 0 }
    }
    return 1
}

proc delay_request { command chan arg } {
    global botnick botname cryptokey

    switch -exact $command {
        "op" {
            if {![isop $arg $chan]} {
                pushmode $chan +o $arg
                putlog "netops: opped $arg on $chan"
            }
        }
        "unban" {
            foreach ban [chanbans $chan] {
                if {[string match [string tolower [lindex $ban 0]] [string tolower [lindex $arg 0]]]} {
                    pushmode $chan -b [lindex $ban 0]
                    putlog "netops: took $ban from banlist on $chan"
                    putbot [lindex $arg 1] "respond unbanned from $chan"
                    putbot [lindex $arg 1] "request [encrypt $cryptokey "join $chan $botnick $botname"]"
                    return 1
                }
            }
        }
        "limit" {
            set curlimit [string range [getchanmode $chan] [expr [string last " " [getchanmode $chan]] + 1] end]
            if {$curlimit <= [llength [chanlist $chan]]} {
                set newlimit [expr [llength [chanlist $chan]] + 1]
                pushmode $chan +l $newlimit
                putlog "netops: raised limit on $chan"
                return 1
            }
            return 0
        }
    }
}

proc bot_response { hand idx arg } {
    putlog "netops: $hand responded: $arg"
}

proc kill_channels { } {
    global chanset

    foreach chan [channels] {
        if {[info exist chanset($chan)]} {
            unset chanset($chan)
        }
    }

    foreach i [timers] {
        if {[lindex $i 1] == "do_channels"} {
            killtimer [lindex $i 2]
        }
    }
}

proc do_channels { } {
    global chanset

    foreach chan [channels] {
        if {![info exist chanset($chan)]} {
            channel set $chan need-op "request op $chan"
            channel set $chan need-key "request key $chan"
            channel set $chan need-invite "request invite $chan"
            channel set $chan need-unban "request unban $chan"
            channel set $chan need-limit "request limit $chan"
            set chanset($chan) 1
        }
    }
    if {![string match "*do_channels*" [timers]]} {
        timer 5 do_channels
    }
}

proc requestop { chan } {
    global botnick botname cryptokey
    
    if {[isop $botnick $chan]} { return 0 }
    set nicks ""
    foreach nick [chanlist $chan b] {
        if {([isop $nick $chan]) && ([lsearch -exact [string tolower [bots]] [string tolower [nick2hand $nick $chan]]] != -1)} {
            lappend nicks $nick
        }
    }
    if {$nicks != ""} {
        set bot1 [nick2hand [lindex $nicks [rand [llength $nicks]]] $chan]
        set bot2 [nick2hand [lindex $nicks [rand [llength $nicks]]] $chan]
        putbot $bot1 "request [encrypt $cryptokey "op $chan $botnick $botname"]"
        if {($bot2 != $bot1) && ($bot2 != "") && ($bot2 != "*")} {
            putbot $bot2 "request [encrypt $cryptokey "op $chan $botnick $botname"]"
            putlog "netops: requested op from $bot1 and $bot2 on $chan"
            return 1
        } else {
            putlog "netops: requested op from $bot1 on $chan"
            return 1
        }
    } else {
        putlog "netops: no bots to ask for op on $chan"
        return 0
    }
}

proc bot_broadcast { hand idx arg } {
    global botnick botname cryptokey
    
    if {([validchan $arg]) && ([onchan $botnick $arg]) && (![botisop $arg])} {
        putbot $hand "request [encrypt $cryptokey "op $arg $botnick $botname"]"
        putlog "netops: requested op from $hand on $arg"
    }
}

proc mode_broadcast { nick uhost hand chan arg victim } {
    global botnick
 
    if {$victim == $botnick} {
        putallbots "broadcast $chan"
    }
}

proc join_request { nick uhost hand chan } {
    global botnick

    if {$nick == $botnick} {
        do_channels
        utimer 10 "requestop $chan"
    }
}

set netops_loaded 1
putlog "Netops v$netops_version by dJ_TEDY Loaded."