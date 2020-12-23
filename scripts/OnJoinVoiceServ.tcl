# set list of good servers
set goodserv(serverlist) {
  irc.server.com
}

# channels where the check is active (leave blank for all, otherwise separate with a " ")
set goodserv(chan) "#ruse"

bind join -|- * goodserv:process
proc goodserv:isgoodchan {chan} {
  global goodserv
  if {[string length $goodserv(chan)]==0} {return 1}
  foreach ch [split $goodserv(chan) " "] {
    if {[string tolower $ch]==[string tolower $chan]} {return 1}
  }
  return 0
}
proc goodserv:isgoodserv {serv} {
  global goodserv
  foreach server $goodserv(serverlist) {
    if {[string tolower [lindex [split $server "|"] 0]]==[string tolower $serv]} {return 1}
  }
  return 0
}
proc goodserv:process {nick uhost hand chan} {
  global botnick
  if {[string tolower $botnick] == [string tolower $nick]} {return}
  if {[goodserv:isgoodchan $chan]} {putserv "WHOIS $nick"}
}
bind raw - 312 goodserver:whois
proc goodserver:whois {from key data} {
  set nick [lindex [split $data " "] 1]
  set server [string tolower [lindex [split $data " "] 2]]
  if {[goodserv:isgoodserv $server]} {
    foreach chan [channels] {
      if {[goodserv:isgoodchan $chan]} {
        if {[onchan $nick $chan]} {
          if {![isvoice $nick $chan]} {
            pushmode $chan +v $nick
          }
        }
      }
    }
  }
}

putlog "*** GoodServ.TCL * Polizei.Co * Loaded !!"
