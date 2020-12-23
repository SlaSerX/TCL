set badwords { 
"*sapun*bylgaria*"
"*vyn*koito*"
"*SVINE*SVINE*"


} 

bind pubm - "*" pubm:badword 

proc pubm:badword {nick uhost hand chan text} { 
 global badwords 
  if {[botisop $chan] && ![isbotnick $nick]} { 
   foreach badword $badwords { 
    if {[string match -nocase $badword $text]} { 
      putquick "MODE $chan +b *!*@[lindex [split $uhost @] 1]" 
      putquick "KICK $chan $nick :Hasta La Vista, Baby!" 
      } 
    } 
  } 
} 

putlog "Loaded:badword.tcl"