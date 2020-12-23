set party-chan "#SweetHell"

proc login:party {hand idx} {
  global party-chan
  foreach who [dcclist] {
    if {[lindex $who 1] == $hand} {
      if {[string length [set email [getuser $hand XTRA EMAIL]]] > 0} {
        puthelp "PRIVMSG ${party-chan} :$hand \[\002$email\002\] \([lindex $who 2]\) has joining on partyline..."
      } else {
        puthelp "PRIVMSG ${party-chan} :$hand \([lindex $who 2]\) has joining on partyline..."
      }
      break
    }
  }
}

proc logout:party {hand idx} {
  global party-chan party-just-quit
  if {[info exists party-just-quit] && ${party-just-quit} == $hand} {unset party-just-quit ; return 0}
  puthelp "PRIVMSG ${party-chan} :$hand has quit on partyline \(lost connection\)."
}

proc logout:filt {idx text} {
  global party-chan party-just-quit
  set hand [idx2hand $idx]
  set party-just-quit $hand
  if {[llength $text] > 1} {
    puthelp "PRIVMSG ${party-chan} :$hand has quit on partyline \([lrange [split $text] 1 end]\)."
  } else {
    puthelp "PRIVMSG ${party-chan} :$hand has quit on partyline \(lost connection\)."
  }
  return $text
}

bind chon - * login:party
bind chof - * logout:party
bind filt - .quit* logout:filt

putlog "Party-line script by dJ_TEDY Loaded."