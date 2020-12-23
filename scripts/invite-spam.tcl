##
# This script will kick and ban anyone in a specified room that mentions a certin word
# wildcards accepted!
#
# This script will only ban them if there is not a valid user with the flags you set
# below!
#
# Set this to the BAD words you don't want said by. 
# Wildcards NEEDED, if your bad word contain spaces... "quote it"!
# You can add as many channels as you would like (ie: set badwerds(#channel) { .. })
# If you want a bad word for ALL channels
# your bot is on, add it like this: 
# set badwerds(global) {
#  *badword*
#  "*anoter badword*"
# }
# look at the one I set below to get an idea :)
set badwerds(global) {
#aa
#aaa
}

set badwerds(message) {
*#*
*www.*
*http://*
}

# This is the ban time (in MIN.s)
#  set this to 0 to not add a ban in bot's banlist, just put a ban on the server (|hellman|)
#  set to anything greater than 0 for actuall bot's ban time.
#  set to -1 to turn off banning (MC_8)
set mc_time 30

# How many warnings do you want to give the person?  0 = no warnings (du hu :P~)
set bwerd(warn) 0

# What do you want to say on the warning message? (( %match == *the badwerd* ))
set bwerd(warn_msg) "-< This is a warning, watch what you say. >-"

# [0=no/1=yes] upon warning, do you want to kick em too?
set bwerd(warn_kick) 1

# Set this to the flag the person is required to have
# i.e.: let's say someone is supposed to be a voicer, but someone forgot to voice him?? 
#       you don't want to kick that person just cuz of that!
# set it to "-" for any user in database, or specify the certing flag required... "mno" is 
# master,owner,op .. this goes with the new flag system
# set to "" to turn this feature off.
set mc_flags "f"

# Set this to the kick message you want to show.
set mc_warning "invite/spam is not tolerated here!"

# [0=no/1=yes] do you want it to kick op's of the room?
set bwerd(kickops) 1

# [0=no/1=yes] do you want it to kick voiced ppl in the room?
set bwerd(kickvoice) 1

# [0=no/1=yes] Do you want to process MSGs as they were channel text, to be evaluated
#              by channel bad werds list.
set bwerd(procmsg) 1

# [0=no/1=yes] do you want to strip color/bold/uline/rev. characters from test?
#  example: some ppl get past the kick/ban by .. puting this www.something.net
#           on mirc, that shows up as www.something.net, normal, but to the bot it's 
#           NOT *www.*, it's *www.*
set bwerd(strip) 0

# How do you want it to mask a ban?  Default == 2
#      0 - *!user@host.domain
#      1 - *!*user@host.domain
#      2 - *!*@host.domain
#      3 - *!*user@*.domain
#      4 - *!*@*.domain
#      5 - nick!user@host.domain
#      6 - nick!*user@host.domain
#      7 - nick!*@host.domain
#      8 - nick!*user@*.domain
#      9 - nick!*@*.domain
#     You can also specify a type of 10 to 19 which correspond to masks 0 to 9, but
#     instead of using a * wildcard to replace portions of the host.domain, it uses ?
#     wildcards to replace the numbers in the address.
set bad_mask 2

#################################
set badwerds(version) v1.10

proc mc:weed {nick uhost hand chan args} {
 global botnick badwerds mc_time mc_flags mc_warning bwerd bad_mask
 if {![isop $botnick $chan]} {return 0}
 if {[info exists badwerds(message)]} {set chanz "message"} {set chanz ""}
 if {[info exists badwerds(global)]} {set chanz "$chanz global"}
 if {[info exists badwerds([string tolower $chan])]} {set chanz "$chanz [string tolower $chan]"}
 if {[lindex $chanz 0] == ""} {return 0}
 if {!$bwerd(kickops)} {if {[isop $nick $chan]} {return 0}}
 if {!$bwerd(kickvoice)} {if {[isvoice $nick $chan]} {return 0}}
 set args [lindex $args 0]
 if {$bwerd(strip)} {set args [mc:bwerds:strip:all $args]}
 if {([info exists mc_flags]) && ($mc_flags != "")} {
  if {[lindex [split $mc_flags |] 1] == ""} {if {[matchattr $hand $mc_flags]} {return 0}} {
   if {[matchattr $hand $mc_flags $chan]} {return 0}
  }
 }
 foreach chant $chanz {
  foreach bad1 [split $badwerds($chant) \n] {
   if {[set bad1 [string trim $bad1 "\" "]] == ""} {continue}
   if {[string match [string tolower $bad1] [string tolower $args]]} {
    if {[mc:bwerd:warn $nick $uhost $bad1]} {
     if {$bwerd(warn_kick)} {
      putserv "KICK $chan $nick :[mc:bwerds:replace $bwerd(warn_msg) "{%match} {$bad1}"]"
     } ; putlog "$nick was warned for saying $bad1 in $chan" ; break
    }
    set ban [mc:bwerds:masktype $nick!$uhost $bad_mask]
    if {$mc_time != "-1"} {
     putlog "Auto banned $nick ($ban) for saing $bad1 in $chan ([duration [expr $mc_time*60]])"
     putserv "MODE $chan +b $ban"
     putserv "KICK $chan $nick :[mc:bwerds:replace $mc_warning "{%match} {$bad1}"]"
     if {$mc_time > 0} {
      newchanban $chan $ban Auto-Set [mc:bwerds:replace $mc_warning "{%match} {$bad1}"] $mc_time
     } ; break
    } {putserv "KICK $chan $nick :[mc:bwerds:replace $mc_warning "{%match} {$bad1}"]"}
   }
  }
 }
}

proc mc:weed:act {nick uhost hand chan key args} {
 global botnick bwerd
 if {($chan == $botnick) && $bwerd(procmsg)} {
  foreach chan [channels] {mc:weed $nick $uhost $hand $chan $args}
 } {mc:weed $nick $uhost $hand $chan $args}
}

proc mc:msgm:weed {nick uhost hand args} {
 global bwerd ; if {$bwerd(procmsg)} {
  foreach chan [channels] {mc:weed:msgm $nick $uhost $hand $chan $args}
 }
}

proc mc:weed:msgm {nick uhost hand chan args} {
 global botnick badwerds mc_time mc_flags mc_warning bwerd bad_mask
 if {[info exists badwerds(global)]} {set chanz "global"} {set chanz ""}
 if {[info exists badwerds([string tolower $chan])]} {set chanz "$chanz [string tolower $chan]"}
 if {[lindex $chanz 0] == ""} {return 0}
 if {!$bwerd(kickops)} {if {[isop $nick $chan]} {return 0}}
 if {!$bwerd(kickvoice)} {if {[isvoice $nick $chan]} {return 0}}
 if {$bwerd(strip)} {set args [mc:bwerds:strip:all $args]}
 if {([info exists mc_flags]) && ($mc_flags != "")} {
  if {[lindex [split $mc_flags |] 1] == ""} {if {[matchattr $hand $mc_flags]} {return 0}} {
   if {[matchattr $hand $mc_flags $chan]} {return 0}
  }
 }
 foreach chant $chanz {
  foreach bad1 [split $badwerds($chant) \n] {
   if {[set bad1 [string trim $bad1 "\" "]] == ""} {continue}
   if {[string match [string tolower $bad1] [string tolower $args]]} {
    if {[mc:bwerd:warn $nick $uhost $bad1]} {
     if {$bwerd(warn_kick)} {
      putserv "KICK $chan $nick :[mc:bwerds:replace $bwerd(warn_msg) "{%match} {$bad1}"]"
     } ; putlog "$nick was warned for saying $bad1 via PrivMSG" ; break
    }
    set ban [mc:bwerds:masktype $nick!$uhost $bad_mask]
    putlog "Auto banned $nick ($ban) for saing $bad1 via PrivMSG ([duration [expr $mc_time*60]])"
    putserv "MODE $chan +b $ban"
    putserv "KICK $chan $nick :[mc:bwerds:replace $mc_warning "{%match} {$bad1}"]"
    if {$mc_time > 0} {
     newchanban $chan $ban Auto-Set [mc:bwerds:replace $mc_warning "{%match} {$bad1}"] $mc_time
    } ; break
   }
  }
 }
}

proc mc:weed:raw:notc {from key args} {
 if {[string index [lindex $args 0] 0] == "#"} {
  set nick [string range $from 0 [expr [string first "!" $from]-1]]
  set uhost [string range $from [expr [string first "!" $from]+1] e]
  set chan [lindex [lindex $args 0] 0]
  set hand [nick2hand $nick $chan]
  set args "\{[string trimright [string range $args [expr [string first ":" $args]+1] e] \}]\}"
  mc:weed $nick $uhost $hand $chan $args
 } ; return 0
}

proc mc:bwerd:warn {nick uhost bad} {
 global bwerd
 if {[info exists bwerd($uhost)]} {incr bwerd($uhost) 1} {set bwerd($uhost) 1}
 if {[expr $bwerd(warn)+1] <= $bwerd($uhost)} {unset bwerd($uhost) ; return 0}
 puthelp "PRIVMSG $nick :[mc:bwerds:replace $bwerd(warn_msg) "{%match} {$bad}"]"
# -=> \[Warning $bwerd($uhost) of $bwerd(warn)\]
 return 1
}

foreach chan [array names badwerds] {
 if {([string index $chan 0] == "#") && ([string tolower $chan] != $chan)} {
  set badwerds([string tolower $chan]) $badwerds($chan)
  unset badwerds($chan)
 }
}

proc mc:bwerds:strip:color {ar} {
 set argument ""
 if {![string match ** $ar]} {return $ar} ; set i -1 ; set length [string length $ar]
 while {$i < $length} {
  if {[string index $ar $i] == ""} {
   set wind 1 ; set pos [expr $i+1]
   while {$wind < 3} {
    if {[string index $ar $pos] <= 9 && [string index $ar $pos] >= 0} {
     incr wind 1 ; incr pos 1} {set wind 3
    }
   }
   if {[string index $ar $pos] == "," && [string index $ar [expr $pos + 1]] <= 9 &&
       [string index $ar [expr $pos + 1]] >= 0} {
    set wind 1 ; incr pos 1
    while {$wind < 3} {
     if {[string index $ar $pos] <= 9 && [string index $ar $pos] >= 0} {
      incr wind 1 ; incr pos 1} {set wind 3
     }
    }
   }
   if {$i == 0} { 
    set ar [string range $ar $pos end] 
    set length [string length $ar] 
   } { 
    set ar "[string range $ar 0 [expr $i - 1]][string range $ar $pos end]" 
    set length [string length $ar] 
   }
   set argument "$argument[string index $ar $i]"
  } {incr i 1}
 }
 set argument $ar
 return $argument
}

proc mc:bwerds:strip:bold {ar} {
 set argument ""
 if {[string match ** $ar]} {
  set i 0
  while {$i <= [string length $ar]} { 
   if {![string match  [string index $ar $i]]} { 
    set argument "$argument[string index $ar $i]"
   } ; incr i 1
  }
 } {set argument $ar}
 return $argument
}

proc mc:bwerds:strip:uline {ar} {
 set argument ""
 if {[string match ** $ar]} {
  set i 0
  while {$i <= [string length $ar]} { 
   if {![string match  [string index $ar $i]]} { 
    set argument "$argument[string index $ar $i]"
   } ; incr i 1
  }
 } {set argument $ar}
 return $argument
}

proc mc:bwerds:strip:reverse {ar} {
 set argument ""
 if {[string match ** $ar]} {
  set i 0
  while {$i <= [string length $ar]} { 
   if {![string match  [string index $ar $i]]} { 
    set argument "$argument[string index $ar $i]"
   } ; incr i 1
  }
 } {set argument $ar}
 return $argument
}

proc mc:bwerds:strip:all {ar} {
 return [mc:bwerds:strip:reverse [mc:bwerds:strip:uline [mc:bwerds:strip:bold [mc:bwerds:strip:color $ar]]]]
}

proc mc:bwerds:replace {string subs} {
 if {[llength $subs] == "1"} {set subs [lindex $subs 0]}
 for {set i 0} {[lindex $subs $i] != ""} {incr i 2} {
  regsub -all -- [lindex $subs $i] $string [lindex $subs [expr $i+1]] string
 } ; return $string
}

proc mc:bwerds:masktype {uhost type} {
 if {![string match "*!*@*.*" $uhost]} {
  set nick [lindex [split $uhost "!"] 0] ; set uhost "$nick![getchanhost $nick]"
  if {$uhost == "$nick!"} {set type "return_nothing"}
 }
 switch -exact $type {
  0 {set ban "*[string range $uhost [string first ! $uhost] e]"}
  1 {set ban "*!*[string trimleft [string range $uhost [expr [string first ! $uhost]+1] e] "~"]"}
  2 {set ban "*!*[string range $uhost [string first @ $uhost] e]"}
  3 {
   set ident [string range $uhost [expr [string first ! $uhost]+1] [expr [string last @ $uhost]-1]]
   set ban "*!*[string trimleft $ident "~"][string range [maskhost $uhost] [string first @ [maskhost $uhost]] e]"
  }
  4 {set ban "*!*[string range [maskhost $uhost] [string last "@" [maskhost $uhost]] e]"}
  5 {set ban $uhost}
  6 {
   set nick [string range $uhost 0 [expr [string first "!" $uhost]-1]]
   set ident [string range $uhost [expr [string first "!" $uhost]+1] [expr [string last "@" $uhost]-1]]
   set ban "$nick!*[string trimleft $ident "~"][string range $uhost [string last "@" $uhost] e]"
  }
  7 {
   set nick [string range $uhost 0 [expr [string first "!" $uhost]-1]]
   set ban "$nick!*[string range $uhost [string last "@" $uhost] e]"
  }
  8 {
   set nick [string range $uhost 0 [expr [string first "!" $uhost]-1]]
   set ident [string range $uhost [expr [string first "!" $uhost]+1] [expr [string last "@" $uhost]-1]]
   set ban "$nick!*[string trimleft $ident "~"][string range [maskhost $uhost] [string last "@" [maskhost $uhost]] e]"
  }
  9 {
   set nick [string range $uhost 0 [expr [string first "!" $uhost]-1]]
   set ban "$nick!*[string range [maskhost $uhost] [string last "@" [maskhost $uhost]] e]"
  }
  10 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {
    set host [mc:bwerds:replace $host "1 ? 2 ? 3 ? 4 ? 5 ? 6 ? 7 ? 8 ? 9 ? 0 ?"]
    set ident [string range $uhost [expr [string first "!" $uhost]+1] [expr [string last "@" $uhost]-1]]
    set ban "*!$ident$host"
   } {set ban [mc:bwerds:masktype $uhost 0]}
  }
  11 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {
    set host [mc:bwerds:replace $host "1 ? 2 ? 3 ? 4 ? 5 ? 6 ? 7 ? 8 ? 9 ? 0 ?"]
    set ident [string range $uhost [expr [string first "!" $uhost]+1] [expr [string last "@" $uhost]-1]]
    set ban "*!*[string trimleft $ident "~"]$host"
   } {set ban [mc:bwerds:masktype $uhost 1]}
  }
  12 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {
    set host [mc:bwerds:replace $host "1 ? 2 ? 3 ? 4 ? 5 ? 6 ? 7 ? 8 ? 9 ? 0 ?"]
    set ban "*!*$host"
   } {set ban [mc:bwerds:masktype $uhost 2]}
  }
  13 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {set ban [mc:bwerds:masktype $uhost 11]} {set ban [mc:bwerds:masktype $uhost 3]}
  }
  14 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {set ban [mc:bwerds:masktype $uhost 12]} {set ban [mc:bwerds:masktype $uhost 4]}
  }
  15 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {
    set host [mc:bwerds:replace $host "1 ? 2 ? 3 ? 4 ? 5 ? 6 ? 7 ? 8 ? 9 ? 0 ?"]
    set rest [string range $uhost 0 [expr [string last "@" $uhost]-1]]
    set ban $rest$host
   } {set ban [mc:bwerds:masktype $uhost 5]}
  }
  16 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {
    set host [mc:bwerds:replace $host "1 ? 2 ? 3 ? 4 ? 5 ? 6 ? 7 ? 8 ? 9 ? 0 ?"]
    set rest "[string range $uhost 0 [expr [string first "!" $uhost]-1]]!*[string trimleft [string range $uhost [expr [string first "!" $uhost]+1] [expr [string last "@" $uhost]-1]] "~"]"
    set ban $rest$host
   } {set ban [mc:bwerds:masktype $uhost 6]}
  }
  17 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {
    set host [mc:bwerds:replace $host "1 ? 2 ? 3 ? 4 ? 5 ? 6 ? 7 ? 8 ? 9 ? 0 ?"]
    set rest "[string range $uhost 0 [expr [string first "!" $uhost]-1]]!*"
    set ban $rest$host 
   } {set ban [mc:bwerds:masktype $uhost 7]}
  }
  18 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {set ban [mc:bwerds:masktype $uhost 16]} {set ban [mc:bwerds:masktype $uhost 8]}
  }
  19 {
   set host [string range $uhost [string last "@" $uhost] e]
   if {[mc:bwerd:inter:findip [string range $host 1 e]] == "0"} {set ban [mc:bwerds:masktype $uhost 17]} {set ban [mc:bwerds:masktype $uhost 9]}
  }
  return_nothing {set ban ""}
  default {set ban "*!*[string range $uhost [string first "@" $uhost] e]"}
 }
 set _nick [lindex [split $ban !] 0]
 set _ident [string range $ban [expr [string first ! $ban]+1] [expr [string last @ $ban]-1]]
 set _host [string range $ban [expr [string last @ $ban]+1] e]
 if {$_ident != [set temp [string range $_ident [expr [string length $_ident]-9] e]]} {
  set _ident *[string trimleft $temp *]
 }
 if {$_host != [set temp [string range $_host [expr [string length $_host]-63] e]]} {
  set _host *[string trimleft $temp *]
 } ; return $_nick!$_ident@$_host
}
proc mc:bwerd:inter:findip {args} {
 catch {unset mc_found_ip}
 if {![string match *.*.*.* $args]} {return 0}
 foreach arg $args {
  if {[string match *.*.*.* $arg]} {
   set mc_testa [split $arg "."] ; set i 0
   while {[llength $mc_testa] != $i} {
    set mc_test [lrange $mc_testa $i end]
    if {[string length [lindex $mc_test 1]]<4 && [string length [lindex $mc_test 2]]<4} {
     if {[lindex $mc_test 1] < 256 && [lindex $mc_test 2] < 256 && [lindex $mc_test 1] >= 0 && [lindex $mc_test 2] >= 0} {
      set first "abcdefghi"
      if {[string index [lindex $mc_test 0] [expr [string length [lindex $mc_test 0]] - 1]] <= 9 && [string index [lindex $mc_test 0] [expr [string length [lindex $mc_test 0]] - 1]] >= 0} {
       set first [string range [lindex $mc_test 0] [expr [string length [lindex $mc_test 0]] - 1] end]
       if {[string index [lindex $mc_test 0] [expr [string length [lindex $mc_test 0]] - 2]] <= 9 && [string index [lindex $mc_test 0] [expr [string length [lindex $mc_test 0]] - 2]] >= 0} {
        set first [string range [lindex $mc_test 0] [expr [string length [lindex $mc_test 0]] - 2] end]
        if {[string index [lindex $mc_test 0] [expr [string length [lindex $mc_test 0]] - 3]] <= 9 && [string index [lindex $mc_test 0] [expr [string length [lindex $mc_test 0]] - 3]] >= 0} {
         set first [string range [lindex $mc_test 0] [expr [string length [lindex $mc_test 0]] - 3] end]
        }
       }
      }
      set second [lindex $mc_test 1] ; set third [lindex $mc_test 2] ; set fourth "abcdefghi"
      if {[string index [lindex $mc_test 3] 0] <= 9 && [string index [lindex $mc_test 3] 0] >= 0} {
       set fourth [string index [lindex $mc_test 3] 0]
       if {[string index [lindex $mc_test 3] 1] <= 9 && [string index [lindex $mc_test 3] 1] >= 0} {
        set fourth $fourth[string index [lindex $mc_test 3] 1]
        if {[string index [lindex $mc_test 3] 2] <= 9 && [string index [lindex $mc_test 3] 2] >= 0} {
         set fourth $fourth[string index [lindex $mc_test 3] 2]
        }
       }
      }
      if {($first < 256) && ($second < 256) && ($third < 256) &&
          ($fourth < 256) && ($first > 0) && ($second > 0) &&
          ($third > 0) && ($fourth > 0) && ([string index $first 0] > 0) &&
          ([string index $second 0] > 0) && ([string index $third 0] > 0) &&
          ([string index $fourth 0] > 0)} {
       if {[info exists mc_found_ip]} {
        set mc_found_ip "$mc_found_ip $first.$second.$third.$fourth"
       } {set mc_found_ip $first.$second.$third.$fourth}
      }
     }
    } ; incr i +1
   }
  }
 } ; if {[info exists mc_found_ip]} {return $mc_found_ip} {return 0}
}

bind pubm - * mc:weed
bind ctcp - ACTION mc:weed:act
bind raw - NOTICE mc:weed:raw:notc
bind msgm - * mc:msgm:weed
putlog "invite/spam tcl by www.mIRCbg.net"
