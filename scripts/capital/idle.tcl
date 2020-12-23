# set the interval between idlechecks in minutes
set idle_interval "30"
# set the idle-time an operator must have to get deopped by the bot in minutes
set idle_time "30"
# [0/1] do we want to exclude bots from being idle-deopped?
# generally a good idea
set idle_exclude_bots "1"
# set channels where idle-deopper should be active seperated by spaces
# set to " " for all
set idle_channels "#Sofia"

#########################################################################################

## End of configuration ### Do Not edit anything here! ##################################

#########################################################################################



bind raw - 317 idlecheck
proc idlecheck {nick int arg} {
  global idle_time idle_channels
   set nick [string tolower [lindex $arg 1]]
   set idle [string tolower [lindex $arg 2]]
   set minutesidle [expr $idle / 60]
   if {$minutesidle > $idle_time} {
      dccbroadcast "$nick has too much idle"
      foreach channel $idle_channels {
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
       dccbroadcast "Now checking \002$chan\002 for idle"
       foreach person [chanlist $chan] {
         if { [isop $person $chan]} {
           if {$idle_exclude_bots == 1} {
             if {(![matchattr [nick2hand $person $chan] b]) && ($person != $botnick)} { putserv "WHOIS $person $person" }
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

