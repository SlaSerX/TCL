set reasonsign "Excess flood"
set banreason "Excess flood"

bind SIGN - * sign_off

proc sign_off {nick uhost hand chan reason} {
global botnick owner reasonsign banreason jpcount
set mask *!*[string tolower [string range $uhost [expr [string first "!" $uhost] +2] end]]
if {[string match [string tolower $nick] [string tolower $owner]]} { return 0 }
if {[string match [string tolower $reason] [string tolower $reasonsign]]} {
    if {[info exists jpcount($nick)]} {
       if {[expr $jpcount($nick) >= 2]} {
       putquick "KICK $chan $nick :$banreason"
       newchanban $chan $nick $botnick $banreason 120
       #newchanban $chan $mask $botnick $banreason 10
           putquick "KICK $chan $nick :$banreason"
           putquick "MODE $chan +b $nick"
           putlog "\0034$nick is now kicked of $chan for none identification! 3 times sign off.\003"
           unset jpcount($nick)
           return 0
       } else {
           set jpcount($nick) [expr $jpcount($nick) + 1]
           putlog "$nick with $nick is quiting because of none identification for $jpcount($nick) time!"
           return 0
       }
    } else {
        set jpcount($nick) 1
        timer 10 "unset jpcount($nick)"
        putlog "$nick with $nick is quiting for none indentification! Marced for watch!"
    }
}
return 0
}

putlog "Инсталиран: Signoff.tcl"
