bind nick -|- * no:op4e

proc no:op4e {nick uhost hand chan newnick} {
  global botnick
  if {[isbotnick $nick] == 1} {
    return 0
  }
  if {$hand != "*" && ([matchattr $hand b] == 1)} {
    return 0
  }
  
  pushmode $chan -o $newnick
}	  

putlog "Инсталиран: deop.tcl"