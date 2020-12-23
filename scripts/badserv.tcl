# Ako potrebitel ot tozi server wleze w kanalyt wi shte byde bannat!
set badservers {
  {sanserv.services}
}

# Za koj kanal da sledim za join ot badservers
set chan "#SweetHell"

# S kakyw reason shte bydat KICK potrebitelite ot badservers
set kreason "Bad Server!Bate B0ik0 Bate !!!"


# +--------------------- DO NOT EDIT LINES BELLOW -------------------------+ #

bind join -|- * pun:server
proc pun:server {nick uhost hand chan} {
  global botnick

  if {[string tolower $botnick] == [string tolower $nick]} {
    return
  }

  putserv "whois $nick"
}

bind raw - 312 server:whois

proc server:whois {from key bns} {
  global chan kreason badservers
  set nick [lindex [split $bns " "] 1]
  set server [string tolower [lindex [split $bns " "] 2]]
  foreach bserv $badservers {
	if {[string tolower $bserv] == $server} {
	  pushmode $chan +b *!*@[lindex [split [getchanhost $nick] @] 1]
  	  putkick $chan $nick $kreason
	  return
	}
  }
}