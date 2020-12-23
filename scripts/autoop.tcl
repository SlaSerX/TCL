# Tuk slozhi kanala kydeto iskash da bachka tcl-to..
set avchan "#ruse"

# Ot tuk nadloy ne baraj nishto ..

bind join - * avjoin

proc avjoin {nick uhost hand chan} {
global avchan botnick
if {$nick == $botnick} {return 0}
if {$nick == Seens} {return 0}
if {$avchan == "" && [botisop $chan]} {
  pushmode $chan +o $nick
  return 0
}
set chan [string tolower $chan]
foreach i [string tolower $avchan] {
  if {$i == $chan && [botisop $chan]} {
   pushmode $chan +o $nick
   return 0
  }
}
}

putlog "Инсталиран: autoop.tcl"
