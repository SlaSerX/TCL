set badwords {
"*rent*"
"*prodavam*"
"irc.*"
"www.*"
"eftino"
"evtino"
}

bind pubm - "*" pubm:badword

proc pubm:badword {nick uhost hand chan text} {
 global badwords
  if {[botisop $chan] && ![isbotnick $nick]} {
   foreach badword $badwords {
    if {[string match -nocase $badword $text]} {
      putquick "MODE $chan +b *!*@[lindex [split $uhost @] 1]"
      putquick "KICK $chan $nick :Spamming/Selling is NOT allowed in here!"
      }
    }
  }
} 