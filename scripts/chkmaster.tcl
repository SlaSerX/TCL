bind dcc m|- umatch *dcc:umatch
bind dcc m|- chkmaster *dcc:chkmaster

proc *dcc:chkmaster {hand idx arg} {
global flags whotomatch
set flags "+m"
set whotomatch [string tolower [lindex $arg 0]]
if {$whotomatch == ""} {
    putdcc $idx "Usage: .chkmaster <nick> or .chkmaster all"
    return 0
  }
 putcmdlog "#$hand# chkmaster $whotomatch"
              if {[matchchanattr $whotomatch "+n"]}   {set flags *}
              if {[matchchanattr $whotomatch "+m-n"]} {set flags +}
              if {[matchchanattr $whotomatch "-m"]} { putdcc $idx "Not A Master" 
return 0 }
if {$whotomatch == "all"} {
    foreach g [userlist m] {
               if {[matchchanattr $g "+n"]}   {set flags *}
               if {[matchchanattr $g "+m-n"]} {set flags +}    
getusers $idx $g
  }
return 0
}
              if {![matchchanattr $whotomatch ""]} { putdcc $idx "No Such User"
return 0 }
getusers $idx $whotomatch 
}
proc getusers {idx whomatch} {
global whotomatch flags 
set ops 0
set masters 0
set owners 0
set bots 0
set spisak ""

foreach g [userlist] {
if {[string tolower [lindex [getuser $g xtra Added] 1]] == [string tolower "$whomatch"]} {
if {[matchattr $g n|n]} {
incr owners 
continue
     }
if {[matchattr $g b]} {
incr bots
continue
     }

if {[matchattr $g m|m]} {
incr masters 
continue
    }
        if {[matchattr $g h|o]} {
lappend spisak $g 
incr ops
continue
    }
 }
}
putdcc $idx  "$flags$whomatch \[$ops\] : $spisak" 
if {$whotomatch == "all"} { return 1 }
putdcc $idx "Total($whomatch): Owners $owners Masters $masters Ops $ops Bots $bots"
}

proc *dcc:umatch {hand idx arg} {
  set whotomatch [string tolower [lindex $arg 0]]
  set usersadded 1
  if {$whotomatch == ""} {
    putdcc $idx "Usage: umatch <nick> \[-f\]"
    return 0
  }
  if {[lindex $arg 1] != "-f" && [lindex $arg 1] != ""} {
    putdcc $idx "Usage: umatch <nick> \[-f\]"
    return 0
  }
  if {[lindex $arg 1] == ""} {
    foreach i [userlist] {
      if {[string match "$whotomatch" [string tolower [lindex [getuser $i xtra Added] 1]]]} {
        if {[matchattr $i b]} {
          putdcc $idx "\[$i\] (Bot)"
          set usersadded 2
        } else {
          set usersadded 2
          putdcc $idx "\[$i\] (User)" }
      } else {
        if {$usersadded != 2} {
          set usersadded 0
        }
      }
    }
  } elseif {[lindex $arg 1] == "-f"} {
    putcmdlog "#$hand# umatch $whotomatch -f"
    foreach u [userlist] {
      if {[string tolower [lindex [getuser $u xtra Added] 1]] == "$whotomatch"} {
        if {[matchattr $u b]} {
          putdcc $idx "--\[$u\] (Bot)-- global flags: [chattr $u]"
          foreach z [channels] {
            putdcc $idx "$z: [string trimleft [string range [chattr $u $z] [string first "|" [chattr $u $z]] end] |]"
          }
        } else {
            putdcc $idx "--\[$u\] (User)-- global flags: [chattr $u]"
            foreach z [channels] {
              putdcc $idx "$z: [string trimleft [string range [chattr $u $z] [string first "|" [chattr $u $z]] end] |]"
            }
          }
        }
      }
    }
  if {$usersadded == 0} {
    putcmdlog "#$hand# umatch $whotomatch"
    putdcc $idx "No users/bots added from $whotomatch"
  }
  if {$usersadded == 2} {
    putcmdlog "#$hand# umatch $whotomatch"
  }
}
putlog "Chkmaster bY dJ_TEDY Loaded."
