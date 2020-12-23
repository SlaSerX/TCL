set csnicka "CS"
set reasonsign "Excess Flood"
set banreason "Excess Flood , Relax OutSide ChanneL"

bind SIGN - * sign_off

proc sign_off {nick uhost hand chan reason} {
 global botnick owner reasonsign banreason jpcount tmr
 set mask *!*[string tolower [string range $uhost [expr [string first "!" $uhost] +2] end]]
 if {[string match [string tolower $nick] [string tolower $owner]]} { return 0 }
 if {[string match [string tolower $reason] [string tolower $reasonsign]]} {
    if {[info exists jpcount($mask)]} {
       if {[expr $jpcount($mask) >= 3]} {
           newchanban $chan $nick!*@* $botnick $banreason 10
           putquick "MODE $chan +b $nick"
           putquick "KICK $chan $nick :$banreason"
           putlog "$nick is now kicked of $chan for Excess flood! 3 times sign off."
           unset jpcount($mask)
             killtimer $tmr($mask)
           return 0
       } else {
           set jpcount($mask) [expr $jpcount($mask) + 1]
           putlog "$nick with $mask is quiting Excess Flood --> $jpcount($mask) time!"
           return 0
       }
    } else {
        set jpcount($mask) 1
        set tmr($mask) [timer 120 "unset jpcount($mask)"]
        putlog "$nick with $mask is quiting Excess Flood! Marced for watch!"
    }
 }
 return 0
}



putlog "*** ban for Excess flood Loaded Successfully (SmasHinG Corp. INC.) ***"
