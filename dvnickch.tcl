## this will check for +o, changing nicks
set dvnickch(deop) 1
## this will also check for +v
set dvnickch(devoice) 1

bind nick -|- * no:op

proc no:op {nick uhost hand chan newnick} {
  global dvnickch

  if {[isbotnick $nick] == 1} {
    return 0
  }

  if {$hand != "*" && ([matchattr $hand n|n $chan] == 1 || [matchattr $hand b] == 1)} {
    return 0
  }

  if {![botisop $chan]} {
    return 0
  }

  if {$dvnickch(deop) == 1 && [isop $newnick $chan]} {
    pushmode $chan -o $newnick
  }

  if {$dvnickch(devoice) == 1 && [isvoice $newnick $chan]} {
    pushmode $chan -v $newnick
  }
}	  
