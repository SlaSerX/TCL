
# H for *!*@host ; I for *!*ident@host ; N for nick!ident@host
# S to stop placing bans
set bantype "H"
set bantime 60
set maxchbans 15

bind mode - "*~+b*" ban_count
proc ban_count {nick host handle chan args} {
	global botnick maxchbans
	set numbanlist [llength [chanbans $chan]]
	if { $numbanlist >= $maxchbans } {
		set ban1 [lindex [lindex [chanbans $chan] 1] 0]
		set ban2 [lindex [lindex [chanbans $chan] 2] 0]
		set ban3 [lindex [lindex [chanbans $chan] 3] 0]
		set ban4 [lindex [lindex [chanbans $chan] 4] 0]
		putserv "MODE $chan -bbbb $ban1 $ban2 $ban3 $ban4"
	}
	return 0
}

bind bot o NEW_BAN bot_new_ban
proc bot_new_ban { bot cmd args } {
	global botnick bantype bantime
	if ![matchattr $bot S] {
		putlog "Bot NEWBAN command from unauthorized bot $bot - IGNORED"
		return 0
	}
	set args [lindex $args 0]
	set host [lindex $args 0]
	set nick [lindex $args 1]
	set uhost [lindex $args 2]
	set keyword [lindex $args 3]
	set who_user [finduser $nick!$uhost]
	set reason "is sucker"
	if { [matchattr $who_user p] } {return 0}
	if { [matchattr $who_user o] } {return 0}
	if { $bantype == "H" } { set banmask $host }
	if { $bantype == "I" } { set banmask "*!*$uhost" }
	if { $bantype == "N" } { set banmask "$nick!$uhost" }
	if { $bantype == "S" } { return 0 }
	if { $keyword == "virus" } { set reason "sends viruses" }
	if { $keyword == "invite" } { set reason "makes invites" }
	if { $keyword == "repeats" } { set reason "makes repeats" }
	if { $keyword == "flood" } { set reason "makes flood" }
	putlog "NEWBAN from: $bot for $nick $uhost $reason"
	newban $banmask $bot "$nick $uhost $reason" $bantime
	putserv "MODE #lamerzone -o+b $nick $banmask"
	return 1
}

bind bot o NEW_CHANBAN bot_new_chanban
proc bot_new_chanban { bot cmd args } {
	global botnick bantype bantime
	if ![matchattr $bot S] {
		putlog "Bot NEWCHANBAN command from unauthorized bot $bot - IGNORED"
		return 0
	}
	set args [lindex $args 0]
	set chan [lindex $args 0]
	set host [lindex $args 1]
	set nick [lindex $args 2]
	set uhost [lindex $args 3]
	set keyword [lindex $args 4]
	set who_user [finduser $nick!$uhost]
	set reason "is sucker"
	if { [validchan $chan] <1 } {return 0}
	if { [matchattr $who_user o|o $chan] } {return 0}
	if { $bantype == "H" } { set banmask $host }
	if { $bantype == "I" } { set banmask "*!*$uhost" }
	if { $bantype == "N" } { set banmask "$nick!$uhost" }
	if { $bantype == "S" } { return 0 }
	if { $keyword == "virus" } { set reason "sends viruses" }
	if { $keyword == "invite" } { set reason "makes invites" }
	if { $keyword == "repeats" } { set reason "makes repeats" }
	if { $keyword == "flood" } { set reason "makes flood" }
	putlog "NEWCHANBAN from: $bot for $banmask on $chan $nick $uhost $reason"
	putserv "MODE $chan -o+b $nick $banmask"
	newchanban $chan $banmask $bot "$nick $uhost $reason" $bantime
	return 1
}

putlog "Bot Commands + Ban Limiter v1.1 by dJ_TEDY (c) 30.08.2000"
