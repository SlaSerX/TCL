# Set the next line as the kick msg you want to say
set capslock_msg "Забранено е писаноето с CAPS в канала"
# Set the next line as the minimum length of text to scan
set capslock_len 35
# Set the next line as the channels you want to run in
set capslock_chans "#ruse"

bind pubm - * pubm_capslock
bind ctcp - ACTION ctcp_capslock

putlog "Инсталиран: Capslock.tcl"

proc testcapslock {arg} {
 foreach i [string tolower [split $arg ""]] {
  if {[string match *$i* "abcdefghijklmnopqrstuvwxyz"]} {
   return 1
  }
 }
 return 0
}

proc pubm_capslock {nick uhost hand chan arg} {
 global capslock_msg capslock_len capslock_chans botnick
 if {(([lsearch -exact [string tolower $capslock_chans] [string tolower $chan]] != -1) || ($capslock_chans == "*")) && (![matchattr $hand b]) && (![matchattr $hand F]) && ($nick != $botnick) && ($arg == [string toupper $arg]) && ([string length $arg] >= $capslock_len) && ([testcapslock $arg])} {
  putquick "KICK $chan $nick :$capslock_msg"
 }
}

proc ctcp_capslock {nick uhost hand chan keyword arg} {
 pubm_capslock $nick $uhost $hand $chan $arg
}
