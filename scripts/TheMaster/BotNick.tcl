#Copyright 2001 by WantedGirl ®

# Usage: .botnick <newnick>

proc bn_dccbotnick {hand idx arg} {
  global altnick nick
  putcmdlog "#$hand# botnick $arg"
  set newnick [lindex [split $arg] 0]
  if {$newnick == ""} {
    putidx $idx "Molia izpolzvai: botnick <newnick>, $nick"
    return 0
  }
  if {$newnick == "-altnick"} {
    set newnick $altnick
  }
  while {[regsub -- \\? $newnick [rand 10] newnick]} {continue}
  putidx $idx "Promqna na nika na '$newnick'..."
  set nick $newnick
  return 0
}

bind dcc n botnick bn_dccbotnick

return