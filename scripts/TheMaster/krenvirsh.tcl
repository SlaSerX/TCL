set idle_interval "5"

set idle_time "20"

set idle_exclude_bots "1"
 
set idle_channels "#Sofia"

bind raw - 317 idlecheck

proc idlecheck {nick int arg} {
  global idle_time idle_channels
   set nick [string tolower [lindex $arg 1]]
   set idle [string tolower [lindex $arg 2]]
   set minutesidle [expr $idle / 60]
   if {$minutesidle > $idle_time && $nick != "" && $nick != "" && $nick != "" } {
      foreach channel $idle_channels {
#         putserv "PRIVMSG CS : op $channel -$nick"
         putserv "MODE $channel -o $nick"
         putlog "Took op from $nick on $channel (too much idle)"
      }
    }
}

proc perform_whois { } {
  global idle_channels botnick idle_exclude_bots idle_interval
    if {$idle_channels == " "} {
      set idle_temp [channels]
    } else {
    set idle_temp $idle_channels
    }
    foreach chan $idle_temp {
       foreach person [chanlist $chan] { 
         if { [isop $person $chan]} { 
           if {$idle_exclude_bots == 1} {
# Ако искате някои потребители да не бъдат деопвани (ботове) добавете никовете им на местата на Nick,...
             if {(![matchattr [nick2hand $person $chan] b]) && ($person != $botnick) && $person != "TheMaster" && $person != "Reborn"} { putserv "WHOIS $person $person" }
           }
           if {$idle_exclude_bots == 0} {
              if {$person != $botnick} { putserv "WHOIS $person $person" }
           }
         } 
       } 
    }
if {![string match "*time_idle*" [timers]]} {
 timer $idle_interval perform_whois
  }
}
if {![string match "*time_idle*" [timers]]} {
 timer $idle_interval perform_whois
  }
