#Copyright 2001-2003 by WantedGirl ®

# Settings

#the channels you want it to work on.
set channels "#NightLight"

#change this to 1 if you want masters/owners to be allowed to kick from the channels.
set allowmn 1

#the kickmessage.
set kickmsg "Don't try this mode -> LAME"

##Dont modify anything below this

set tclver "Copyright 2001 by WantedGirl ®"
bind mode - * mode:bitchie_staff
proc mode:bitchie_staff {nick uhost handle channel mchange theone} {
 global channels kickmsg botnick allowmn
  set mode [lindex $mchange 0]
  if {$mode != "+o" || ![string match "* [string tolower $channel ]*" "l [string tolower $channels] l"] || [matchattr $handle b] || [string tolower $theone] == [string tolower $botnick] || [string tolower $nick] == [string tolower $botnick]} {return 0}
  if {$allowmn == 1 && ([matchattr $handle n] || [matchattr $handle m] || [matchattr $handle o] || [matchattr $handle b])} {return 0}
  pushmode $channel -o $nick
  pushmode $channel -o $theone
  putserv "KICK $channel $nick :$kickmsg"
  return 0
}
