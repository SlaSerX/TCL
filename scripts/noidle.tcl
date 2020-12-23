#Vreme (v minuti) prez koeto bota shte prawi /whois na operatorite, za da gi proverqwa za idle.
set idle_interval "5"

#Idle (v minuti) koeto trqbwa da ima operatora, za da byde deopnat.
set idle_time "15"

#Dali da ne proverqwa botove (preporuchitelno)
set idle_exclude_bots "1"

#Kanal v koito shte deistva tcla.
set idle_channels "#Sexy"


bind raw - 317 idlecheck

proc idlecheck {nick int arg} {
  global idle_time idle_channels
   set nick [lindex $arg 1]
   set idle [lindex $arg 2]
   set minutesidle [expr $idle / 60]
   if {$minutesidle > $idle_time} {
      foreach channel $idle_channels {
         putquick "MODE $channel -o $nick"
         puthelp "PRIVMSG $channel :Svalqm op na \002$nick\002 (\002$minutesidle\002 mins. idle)"
	 puthelp "NOTICE $nick :Your (+o) mode was took by me, because you had $minutesidle minutes idle time, remove your op status when you aren't on the PC!"
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
             if {(![matchattr [nick2hand $person $chan] bn]) && ($person != $botnick) && $person != "ka6e" && $person != "OPGUard" && $person != "itsko_^^" && $person != "Elinkaa"} { putserv "WHOIS $person $person" }
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

putlog "TCL: AntiIDLE loaded!"