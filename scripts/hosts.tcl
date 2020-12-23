#  .hosthelp to see this list of commands in dcc chat."
#  .hostcheck <number> to see how many hosts users have."
#  .hostlist <nick> to see what hosts that user has."
#  .hostfix <nick> to normalize a users hosts."
#  .hostadd <nick> to let me grab a new hostmask for the user."
#  .hostdel <nick> <hostmask|hostmask #|all> to delete a users hosts."

#set this to the channel you will grab hostmasks from
set channel "#SweetHell"

##############################################
# no need to edit this unless you need to 

bind dcc m|m hostcheck dcc:hostcheck
bind dcc m|m hostlist  dcc:hostlist
bind dcc m|m hostfix   dcc:hostfix  
bind dcc m|m hosthelp  dcc:hosthelp
bind dcc m|m hostadd   dcc:hostadd
bind dcc m|m hostdel   dcc:dh_delhost

unbind dcc - -host *dcc:-host
bind   dcc - -host dcc:dh_delhost

proc dcc:hostadd {handle idx arg} {
  global channel
  if {$arg == ""} {
     putdcc $idx "usage: .hostadd <nick>"
     return
  }
  if {![validuser $arg]} {
    putidx $idx "No such user."
  } else {

    set newhost [getchanhost $arg $channel]
    if { $newhost != "" } {
       setuser $arg HOSTS "*!$newhost"
       putidx $idx "*Apending to $arg's hostmask list"
       putidx $idx "    apending $newhost"
       dcc:hostfix $handle $idx $arg 
    } else {
       putidx $idx "$arg is not in $channel"
    }
  }
}

proc dcc:hostfix {handle idx arg} {
  if {$arg == ""} {
     putdcc $idx "usage: .hostfix <nick>"
     return
  }
  if {![validuser $arg]} {
    putidx $idx "No such user."
  } else {
    set index "1"
    putdcc $idx "*Rehashing $arg's hostmasks... "

    foreach host [getuser $arg hosts] {
      putdcc $idx " $index) removing $host"
      delhost $arg $host 
      set cleaned [cleanhost $host]
      if { $cleaned != 0 } {
         putdcc $idx "    updating $cleaned"
         setuser $arg HOSTS $cleaned
         putdcc $idx "---------------------------------"
      } else {
         putdcc $idx "---------------------------------"
      }
      incr index
    }
  }
}

proc dcc:hostcheck {handle idx arg} {
   set hosts $arg
   if {$hosts == ""} {
      putdcc $idx "usage: .hostcheck <hosts>"
      return
   }
   append list ""
   putcmdlog "#$handle# hostcheck $hosts"
   set usercount 0
   foreach user [userlist] {
      set hostcount 0
      foreach host [getuser $user hosts] {
         incr hostcount 1
      }
      if {$hostcount >= $hosts} {
         append list "$user, "
         incr usercount 1
      }
   }
   if {$list >= 1} {
      putdcc $idx "$usercount users with $hosts or more hosts: [string trimright $list ", "]"
   } else {
      putdcc $idx "no users found with $hosts or more hosts"
   }
}

proc dcc:hostlist {handle idx arg} {
  if {$arg == ""} {
     putdcc $idx "usage: .hostlist <nick>"
     return
  }
  if {![validuser $arg]} {
    putidx $idx "No such user."
  } else {
    set index "1"
    putdcc $idx "$arg has these hosts... "
    foreach host [getuser $arg hosts] {
      putdcc $idx " $index) $host"
      incr index
    }
  }
}

proc dcc:dh_delhost {hand idx arg} {
  if {[llength $arg] == 1} { 
    set user $hand 
    set host [lindex [split $arg] 0]
  } elseif {[llength $arg] >= 2} {
    set user [lindex [split $arg] 0] 
    set host [lindex [split $arg] 1]
  } else {
    putidx $idx "Usage: .-host \[handle\] <hostmask|hostmask #|all>"
    return 0
  }

  if {![validuser $user]} {
    putidx $idx "No such user."
  } elseif {([getuser $hand HOSTS] == "") || ([llength [getuser $user HOSTS]] == 0)} {
    putidx $idx "Failed."
  } else {
    if {[dh_isnum $host]} {
      if {($host == 0) || ($host > [llength [getuser $user HOSTS]])} {
	putidx $idx "Failed."
      } else {
	*dcc:-host $hand $idx "$user [lindex [getuser $user HOSTS] [expr $host -1]]"
      }
    } elseif {[string tolower $host] == "all"} {
      set hostamount [llength [getuser $user HOSTS]]
      set secondhost [lindex [getuser $user HOSTS] 1]
      # Checks that $hand is allowed to remove hosts from $user.
      *dcc:-host $hand $idx "$user [lindex [getuser $user HOSTS] 0]"
      if {([llength [getuser $user HOSTS]] > 0) && ([llength [getuser $user HOSTS]] == [expr $hostamount -1]) && ([lindex [getuser $user HOSTS] 0] == $secondhost)} {
  	set allhosts [join [getuser $user HOSTS] ", "]
  	setuser $user HOSTS
	putidx $idx "Removed '$allhosts' from $user"
      }
    } else {
    *dcc:-host $hand $idx "$user $host"
    }
  }
}

proc dh_isnum {number} {
	if {($number != "") && (![regexp \[^0-9\] $number])} {
		return 1
	} else {
		return 0
	}
}

proc dcc:hosthelp {handle idx arg} {
  putdcc $idx " \[q_balzz's\] - Extra Host Functions tcl"
  putdcc $idx " .hostcheck <number> to see how many hosts users have."
  putdcc $idx " .hostlist <nick> to see what hosts that user has."
  putdcc $idx " .hostfix <nick> to normalize a users hosts."
  putdcc $idx " .hostadd <nick> to let me grab a new hostmask for the user."
  putdcc $idc " .hostdel <nick> <hostmask> to delete a users hosts"
  putdcc $idx "--------------------------------------------------------------"
}

### BEGING of cleanhost ###
proc cleanhost {arg} {
  set host $arg
  set newmask [string range $host 0 [string first "@" $host] ]
  set restofit [string range $host [expr [string first "@" $host] +1] end]
  set count 0

  for {set x 0} {$x < 9} {incr x} {
    if { [string first "." $restofit] != "-1" } {
       set restofit [string range $restofit [expr [string first "." $restofit]+1] end]    
       incr count
    }
  }

  if { $count == 0 } { 
     #without a . its a bad mask.. ERROR BAD MASK
     return 0     
  } elseif { $count < 3 } {
     set end1 [string range $host [expr [string first "@" $host] +1] end]
     set end2 [string range $end1 [string first "." $end1] end]
     append newmask "*"
     append newmask $end2
     return $newmask
  } elseif { $count > 3 } {
     set end1 [string range $host [expr [string first "@" $host] +1] end]
     for {set y 0} {$y < [expr $count - 2]} {incr y} {
       set end1 [string range $end1 [expr [string first "." $end1]+1] end]
     }
     append newmask "*."
     append newmask $end1
     return $newmask
  } elseif { $count == 3 } {
     set end1 [string range $host [expr [string first "@" $host] +1] end]
     set classA [string range $end1 0 [expr [string first "." $end1] -1] ] 
     if { ($classA > 0) && ($classA < 255) } {
       set end1 [string range $end1 [expr [string first "." $end1]+1] end]
       set classB [string range $end1 0 [expr [string first "." $end1] -1] ] 
       if { ($classB > 0) && ($classB < 255) } {
          set end1 [string range $end1 [expr [string first "." $end1]+1] end]
          set classC [string range $end1 0 [expr [string first "." $end1] -1] ]
          set classD [string range $end1 [expr [string first "." $end1]+1] end]
          append newmask $classA
          append newmask "."
          append newmask $classB
          append newmask "."
          append newmask $classC
          append newmask "."
          if { ($classD > 0) && ($classD < 255) } {
             append newmask $classD
          } else {
             append newmask "*" 
          }
          return $newmask
       } else {
          return 0
       }
    } else {
        set end1 [string range $end1 [expr [string first "." $end1]+1] end]
        append newmask "*."
        append newmask $end1
        return $newmask
    }
  } else {
     return 0
  }
}
putlog "Hostcheck bY dJ_TEDY Loaded."
