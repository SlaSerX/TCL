#set mask - "I" for *!*ident@host "P" for *!*@host
set mask "I"
#set bantime - ban time (minutes)
set bantime 60
bind bot - SPAM dcc_invite
bind dcc o checkers checkers
proc checkers {handle idx args} {
	putcmdlog "#$handle# checkers"
	putallbots "check_checkers"
}
bind bot - check_response check_response
proc check_response {bot com arg} {
	putlog "Checker FOUND: $bot"
}
proc dcc_invite {bot com arg} {
	global bantime mask
	set knick [lindex $arg 0]
        set n2hand [nick2hand $knick]
        if {([matchattr $n2hand m|m] || [matchattr $n2hand p]  || [matchattr $n2hand b] || [matchattr $n2hand n|n] || [matchattr $n2hand f|f])} {return 0}
	set banmask [lindex $arg 1]
	set banmask [string range $banmask 1 [expr [string length $banmask]-1]]
	set bmask $banmask
	if {[string match "I" $mask]} {set banmask *!*$banmask}
	if {[string match "P" $mask]} {set banmask *!*@[lindex [split $banmask "@"] 1]}
	switch -exact $com {
		SPAM {
			if {![isban $banmask]} {newban $banmask $bot "Inviter/Spammer/Virii infected: $knick!$bmask" $bantime}
			return 0
		}
		default { return }
	}
	return 0
}

putlog "TCL Loaded: checker::MAD_ZooM"
