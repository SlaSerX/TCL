## allop.tcl
##  - opar alla som joina kanalen

# I vilka kanaler ska de funka?
#  - viktigt, sätt "" för att de ska funka i alla kanaler annars #kanal
set avchan "#SweetHell"

## här börjar koden

bind join - * avjoin

proc avjoin {nick uhost hand chan} {
global avchan botnick
if {$nick == $botnick} {return 0}
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

putlog "allop bY dJ_TEDY Loaded."
