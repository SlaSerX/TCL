#####################################################
#####################################################
####                                             ####
### l33t limit protection by compudaze.           ###
### email me with any                             ###
###            questions/comments/fixes/additions ###
### dazed@columbus.rr.com                         ###
### tested on eggdrop 1.1.5.                      ###
###                                               ###
### distro'd with my settings. every 3 mins it'll ###
### check to see if the current  channel limit is ###
### 5 over the number of users in the chan. if it ###
### isn't, it  will  change the  limit 5 over the ###
### userlimit. this  will not  effect  #psxtrade. ###
### change the vars  to work how  you want it to. ###
### it's  on  by default.  .limit <on/off/status> ###
####                                             ####
#####################################################
####                                             ####
### history:                                      ###
###   1.0b4 - 1st public release                  ###
###   1.0b5 - renamed  the tcl  to l33t-limit.tcl ###
###           to  keep  people   happy,  this  is ###
###           different than  limit1.2 1.2.a etc. ###
####                                             ####
#####################################################
#####################################################

################################################
### build date: Tue, Dec 15 1998; 5:09PM EST ###
################################################
#set limit_version "1.0b4"
############
### vars ###
############
if {![info exists limit_bot]} {
  set limit_bot 5
}
if {![info exists limit_buffer]} {
  set limit_buffer 15
}
if {![info exists limit_time]} {
  set limit_time 2
}
if {![info exists dont_limit_channels]} {
  set dont_limit_channels ""
}
#############################################
######### dont touch anything below #########
######### here or you will be sorry #########
#############################################
proc clear_limit_timers {} {
  foreach timer [timers] {
    if {[lindex $timer 1] == "adjust_limit"} {
      killtimer [lindex $timer 2]
    }
  }
}
proc adjust_limit {} {
  global limit_time limit_bot dont_limit_channels limit_buffer
  if {$limit_bot} {
    foreach chan [channels] {
      if {[lsearch -exact [string tolower $dont_limit_channels] [string tolower $chan]] != -1} {
      } else {
        if {[string match *kl* [lindex [split [getchanmode $chan] " "] 0]]} {
          set curr_limit [lindex [split [getchanmode $chan] " "] 2]
        } elseif {[string match *l* [lindex [split [getchanmode $chan] " "] 0]]} {
          set curr_limit [lindex [split [getchanmode $chan] " "] 1]
        } else {
          set curr_limit 0
        }
        set numusers [llength [chanlist $chan]]
        set newlimit [expr $numusers + $limit_buffer]
        if {$curr_limit != $newlimit} {
          pushmode $chan +l $newlimit
        }
        }
      }
    }
  timer $limit_time adjust_limit
  return 0
}
bind dcc n limit dcc_limit
proc dcc_limit {handle idx arg} {
  global limit_bot limit_time limit_buffer
  set cmd [lindex $arg 0]
  if {$cmd == ""} {
    putdcc $idx "\00315Izpolzwai: Komandi:\0034.limit \0039on\0038/\0034off\0038/\00315status"
    return 0
  }
  if {$cmd == "on"} {
    set limit_bot 1
    putcmdlog "#$handle# limit on"
    putdcc $idx "\0039Limita e wkl. \: ON"
    return 0
  }
  if {$cmd == "off"} {
    set limit_bot 0
    putcmdlog "#$handle# limit off"
    putdcc $idx "\0034Limita izkl.\: OFF"
    return 0
  }
  if {$cmd == "status"} {
    putcmdlog "#$handle# limit status"
    if {$limit_bot} {
      putdcc $idx "\0039Wreme prez koeto se slaga limita sled wlizane na now user $limit_time min. i bufer na limita $limit_buffer"
      return 0
    } else {
      putdcc $idx "\0034Limita e bil izkl. \0039Za vkl..limit ON"
      return 0
    }
  }
}
clear_limit_timers
timer $limit_time adjust_limit
putlog "\0038ChanLimit.tcl Loaded"
putlog "\00315Limit BOT \0034-> \00315$limit_bot!"
putlog "\00315Limit Buffer \0034-> \00315$limit_buffer!"
putlog "\00315Limit Time \0034-> \00315$limit_time!"
putlog "\00315Channels not limit \0034-> \00315$dont_limit_channels!"
putlog "\00315Za poveche info \0034.limit \00315!"
 
