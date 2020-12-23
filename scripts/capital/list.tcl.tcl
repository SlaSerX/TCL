bind dcc m list dcc:listusers

proc dcc:listusers {hand idx param} {
 if {$param == ""} {
        putdcc $idx "!- Listing masters/owners -!"

        foreach master [userlist m] {
            added:check $master $idx
        }

        putdcc $idx "Found: [llength [userlist n]] owners, [expr [llength [userlist m]] - [llength [userlist n]]] masters, [expr [llength [userlist p]] - [llength [userlist m]]] users and [llength [userlist b]] bots"

        putdcc $idx "!- List End -!"
   }
}

proc added:check {hand idx} {
  set UsersAdded [string trimleft [getuser $hand xtra Users] (]
  set UsersAdded [string trimright $UsersAdded )]

  if {$UsersAdded == ""} {
        set UsersAdded 0
  }

  set morn ""

    if {[matchattr $hand n]} {
          set morn "\(n\)"
        } elseif {[matchattr $hand m]} {
          set morn "\(m\)"
        }

  set lusers ""

  foreach lusern [userlist n] {
        if {[lindex [getuser $lusern xtra Added] 1] == $hand} {
    if {![matchattr $lusern b]} {
    append lusers " \(n\)$lusern"
        }
   }
  }
  foreach luserm [userlist m] {
        if {[lindex [getuser $luserm xtra Added] 1] == $hand} {
    if {![matchattr $luserm nb]} {
    append lusers " \(m\)$luserm"
        }
   }
  }
  foreach lusero [userlist o] {
        if {[lindex [getuser $lusero xtra Added] 1] == $hand} {
    if {![matchattr $lusero mnb]} {
     append lusers " \(o\)$lusero"
        }
   }
  }
  foreach luserf [userlist f] {
        if {[lindex [getuser $luserf xtra Added] 1] == $hand} {
    if {![matchattr $luserf mnob]} {
    append lusers " \(f\)$luserf"
        }
   }
  }
  foreach luserb [userlist b] {
        if {[lindex [getuser $luserb xtra Added] 1] == $hand} {
     if {[matchattr $luserb b]} {
     append lusers " \(bot\)$luserb"
        }
   }
  }

  regsub -all {^ } $lusers {} lusers
  regsub -all { } $lusers {, } lusers

  if {$morn != ""} {
         putdcc $idx "$morn$hand ($UsersAdded): $lusers"
  }
}

putlog "Loaded:list.tcl"
