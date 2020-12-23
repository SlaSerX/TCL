#Ops limited for m/n/b
bind mode - *+o* no:op
proc no:op {nick uhost hand chan args} {
global botnick
set who [lindex $args 1]
if {[matchattr $hand m] || [matchattr $hand b] || [matchattr [nick2hand $who] b] || $nick == $botnick} {return 0}
putquick "mode $chan -oo $who $nick [maskhost $uhost]"
putquick "notice $nick :Само +m потребители могат да опват"
}

#Voices limited for m/n/b
bind mode - *+v* no:voice
proc no:voice {nick uhost hand chan args} {
global botnick
set who1 [lindex $args 1]
if {[matchattr $hand m] || [matchattr $hand b] || [matchattr [nick2hand $who1] b] || $nick == $botnick} {return 0}
putquick "mode $chan -vo $who1 $nick [maskhost $uhost]"
putquick "notice $nick :Само +m потребители могат да дават право на глас"
}

#Bans limited for m/n/b
bind mode - *+b* no:ban
proc no:ban {nick uhost hand chan args} {
global botnick
set who2 [lindex $args 1]
if {[matchattr $hand m] || [matchattr $hand b] || [matchattr [nick2hand $who2] b] || $nick == $botnick} {return 0}
putquick "mode $chan -bo+b $who2 $nick [maskhost $uhost]"
#putquick "PRIVMSG CS :acc $chan del $nick"
putquick "kick $chan $nick :Само +m потребители могат да налагат наказания"
}

#Exempts limited for m/n/b
bind mode - *+e* no:ex
proc no:ex {nick uhost hand chan args} {
global botnick
set who3 [lindex $args 1]
if {[matchattr $hand N] || [matchattr $hand b] || [matchattr [nick2hand $who3] b] || $nick == $botnick} {return 0}
putquick "mode $chan -oe+b $nick $who3 [maskhost $uhost]"
putquick "PRIVMSG CS :acc $chan del $nick"
putquick "kick $chan $nick :Само +N потребители могат да добавят ексемпти"
}

#deops limited for m/n/b
#bind mode - *-o* no:deop
#proc no:deop {nick uhost hand chan args} {
#global botnick
#set who [lindex $args 1]
#if {[matchattr $hand m] || [matchattr $hand b] || [matchattr [nick2hand $who] b] || $nick == $botnick} {return 0}
#putquick "mode $chan +o-o $who $nick [maskhost $uhost]"
#putquick "PRIVMSG CS :acc $chan del $nick"
#putquick "kick $chan :$nick Само +m потребители могат да деопват"
#}

#deops limited for m/n/b
#bind kick - * no:kick
#proc no:kick {nick uhost hand chan args} {
#global botnick
#set who [lindex $args 1]
#if {[matchattr $hand m] || [matchattr $hand b] || [matchattr [nick2hand $who] b] || $nick == $botnick} {return 0}
#putquick "mode $chan -o $nick [maskhost $uhost]"
#putquick "PRIVMSG CS :acc $chan del $nick"
#putquick "kick $chan :$nick Само +m потребители могат да кикват"
#}

#Bans limited for m/n/b
#bind mode - *-b* no:unban
#proc no:unban {nick uhost hand chan args} {
#global botnick
#set who2 [lindex $args 1]
#if {[matchattr $hand m] || [matchattr $hand b] || [matchattr [nick2hand $who2] b] || $nick == $botnick} {return 0}
#putquick "mode $chan +bo $who2 $nick [maskhost $uhost]"
#putquick "PRIVMSG CS :acc $chan del $nick"
#putquick "kick $chan :$nick Само +m потребители могат да премахват банове"
#}

putlog "Инсталиран: Bitch.tcl"