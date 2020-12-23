# Fun tcl by NewOrder 


# SetZ

set msgflood 0
set flood_time 10

setudef flag fun
setudef flag relayed

# BindZ

bind msgm - "*" private_shit
bind pub - .msg ganja_talk
bind pub m .fun funoffon
bind pub m .ignore ignoreuser
bind pub m .active activechanz
bind pub m .inactive inactivechanz
bind pub m .relay chrealyon
bind pub m .unrelay chrelayoff
bind pub m .nick chnick
bind pub m .say chansay
bind pub m .f1 pomosht
bind pubm - "*" chanrelay
bind pub m .f1 pomosht



# ProcZ

proc pomosht {nick uhost hand chan arg} {
	putserv "notice $nick :==== Help ==== "
	putserv "notice $nick : .msg <nick> <message>"
	putserv "notice $nick : .fun <off/on>"
	putserv "notice $nick : .ignore <nick>"
	putserv "notice $nick : .active <channel>"
	putserv "notice $nick : .inactive <channel>"
	putserv "notice $nick : .relay <channel>"
	putserv "notice $nick : .unrelay <channel>"
	putserv "notice $nick : .say <channel> <message>"
	putserv "notice $nick : .nick <newnick>"
	putserv "notice $nick : .f1"
	putserv "notice $nick : ==== EOF ===="

}
	







proc chansay {nick uhost hand chan arg} {
	set chanmsg [lindex $arg 0]
	set messagech [join [lrange [split $arg] 1 end]]
	putserv "privmsg $chanmsg :$messagech"
	putserv "notice $nick :Send msg to channel $chanmsg - $messagech"
	return 0
}



proc chnick {nick uhost hand chan arg} {
	set newnick [lindex $arg 0]
	if {$newnick == ""} {
		putserv "notice $nick :use .nick <newnick>"
		return 0
		}
	putserv "nick $newnick"
	return 0
}



proc chrealyon {nick uhost hand chan arg} {
	set rlchan [lindex $arg 0]
	channel set $rlchan +relayed
	putserv "notice $nick :Messages in channel $rlchan now is relayed"
	return 0
}


proc chrelayoff {nick uhost hand chan arg} {
	set rlchan [lindex $arg 0]
	channel set $rlchan -relayed
	putserv "notice $nick :No more relay messages in channel $rlchan"
	return 0
}

proc chanrelay {nick uhost hand chan arg} {
	if {[string match *+relayed* [channel info $chan]]} {
		foreach chanz [channels] {
		if {[string match *+fun* [channel info $chanz]]} {putserv "PRIVMSG $chanz :$chan = $nick = $arg"}
		}
	}
}



proc private_shit {nick uhost hand arg} {

	if {[matchattr $hand +m]} {return 0}
	foreach chan [channels] {
	if {[string match *+fun* [channel info $chan]]} {putserv "PRIVMSG $chan :$nick => $arg"}
	}
}


proc ganja_talk {nick uhost hand chan arg} {	
	global msgflood flood_time

	if {![matchattr $hand +m]} {
	
  if ($msgflood) { 
    utimer $flood_time { set msgflood 0 }
    return 1 
  }
  set msgflood 1
  utimer $flood_time { set msgflood 0 }


	putserv "PRIVMSG $chan :Ei $nick ne ti e porasnala pishkata oshte da mojesh da .msg"
	return 0}
	set jertva [lindex $arg 0]
	set message [join [lrange [split $arg] 1 end]]
	putserv "privmsg $jertva :$message"
	putserv "notice $nick :message sended to $jertva body - $message"
}

proc funoffon {nick uhost hand chan arg} {
	set prop [lindex $arg 0]
	if {$prop == "off"} {
	channel set $chan -fun
	putserv "notice $nick :Fun in channel $chan is off"
	return 0
	}
	if {$prop == "on"} {
	channel set $chan +fun
	putserv "notice $nick :Fun in channel $chan is on"
	return 0
	}
	putserv "notice $nick  :Use .fun off/on"
	return 0
}


proc ignoreuser {nick uhost hand chan arg} {
	set ignuser [lindex $arg 0]
	if {$ignuser == ""} {
		putserv "notice $nick :??? ignore who ???"
		return 0
		}
	newignore [lindex $ignuser 0]!*@* $nick "requested by fun.tcl" 60
	putserv "notice $nick :user $ignuser is ignored !"
	return 0
}


proc activechanz {nick uhost hand chan arg} {
	set targetchan [lindex $arg 0]
	if {$targetchan == ""} {
		putserv "notice $nick :??? channel ???"
		return 0;
		}
		channel set $targetchan -inactive
		putserv "notice $nick :The channel $targetchan now is active!"
		return 0
}


proc inactivechanz {nick uhost hand chan arg} {
	set targetchan [lindex $arg 0]
	if {$targetchan == ""} {
		putserv "notice $nick :??? channel ???"
		return 0;
		}
		channel set $targetchan +inactive
		putserv "notice $nick :The channel $targetchan now is inactive!"
		return 0
}