#denied.tcl
proc secure:sim {hand idx arg} {
global owner
set whosim [lindex $arg 0]
set whoidx [hand2idx $whosim]
set simtext [lrange $arg 1 end]
if {$hand==$owner} {
dccsimul $whoidx "$simtext"
} else {
 putdcc $idx "Access Denied"
 putdcc $whoidx "$hand want to simul you so be careful:"
 putdcc $whoidx "$hand want you to exec this: $simtext"
}
}
unbind dcc o|- msg *dcc:msg
bind dcc o|- msg secure:msg
proc secure:msg {hand idx arg} {
global owner
set whomsg [ string tolower [lindex $arg 0]]
set msgtext [lrange $arg 1 end]
 if {[regexp -nocase "," $whomsg] == 1} { 
  putidx $idx "Can't use ',' in msg-nick"
   } else {
  if {$whomsg=="ns" || $whomsg=="ms" || $whomsg=="cs"} {
  if {[ispermowner $hand]} {
   putserv "PRIVMSG $whomsg :$msgtext "
   putdcc $idx "msg to $whomsg: $msgtext"
  } else {
   putdcc $idx "You have not permission to this command" 
  }
  } else {
   putserv "PRIVMSG $whomsg :$msgtext "
   putdcc $idx "msg to $whomsg: $msgtext"
  }
 }
}
