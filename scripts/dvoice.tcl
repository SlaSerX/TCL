bind nick -|- * no:op

proc no:op {nick uhost hand chan newnick} {
  global botnick

  if {[isbotnick $nick] == 1} {
    return 0
  }

  if {$hand != "*" && ([matchattr $hand n|n $chan] == 1 || [matchattr $hand b] == 1)} {
    return 0
  }
  
  pushmode $chan -v $newnick
}	  
putlog "deopnickchange.tcl By www.mIRCbg.net"