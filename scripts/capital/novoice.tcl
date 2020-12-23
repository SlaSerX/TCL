set channels "#Sofia"          ;# channels where will this TCL be applied
set allow 1                          ;# change this to 1 if you want masters/owners to be allowed to kick from the channels

set allow_flag "bW"                   ;# flag for allowed users
set kickmsg "For more information, visit -> http://Lamzo-Forum.Tk/"            ;#kickmessage.


#po dolu ne baraite ako ne znaete kakvo pravite :)

bind mode - * mode:no_voice
proc mode:no_voice {nick uhost handle channel mchange theone} {
 global channels kickmsg botnick allow allow_flag
  set mode [lindex $mchange 0]
  if {$mode != "+v" || ![string match "* [string tolower $channel ]*" "l [string tolower $channels] l"]} {return 0}
  if {$allow == 1 && ([matchattr $handle $allow_flag]) } {return 0}
  if {[matchattr $handle W] || [string tolower $nick] == [string tolower $botnick]} {return 0}
  pushmode $channel -v $theone
  pushmode $channel -o $nick
  #putserv "KICK $channel $nick :$kickmsg"
  return 0
}

putlog "Loaded:noVoice.tcl"

