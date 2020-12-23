set clock_chans {
    "#ruse"
}

# Posochete prez kakav interval ot vreme da go kazva (v minuti)
set interval 22

############################################################################

bind pub - !time say_time
timer 22 vreme

proc vreme {} {
    global interval clock_chans
    set Kalimera [strftime %T]
    foreach zaek $clock_chans {
	putserv "PRIVMSG $zaek :Chasut e $Kalimera"
    }
    timer 19 vreme
}

proc say_time {nick uhost hand kanal kom} {
    set chas [strftime %T]
    puthelp "PRIVMSG $kanal :V momenta e: $chas"
    return 0
}
putlog "Инсталиран: time.tcl"
