# AntiFlood.tcl v1.0 (1 Nov 2006)
# Copyright by Kiril Georgiev a.k.a Arkadietz
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################

# koga da kick, koga da ban, za kakvo vreme
# Sintaksis redove za kick : redove za ban : vreme 
#
# Public flood
set tfvar "5:5:10"
## Reason pri kick
set eflood(etextReason1) "Quit They flood here thereupon already"
## Reason pri ban 
set eflood(etextReason2) "Quit They flood here thereupon already"

# Flood pri /msg botnick
set msgvar "5:6:20"
## Reason pri kick
set eflood(emsgmReason1) "Ohh, please stop trying to flood me!"
## Reason pri ban
set eflood(emsgmReason2) "Ohh, I can't Anymore...So Go in Hell!"

# Notice flood
set notcvar "3:3:10"
## Reason pri kick
set eflood(enotcReason1) "Notice Hmz.."
## Reason pri ban
set eflood(enotcReason2) "Notice, But Not Here dude !"

# Quit flood
set quitvar "3:4:120"
## Reason pri kick
set eflood(equitReason1) "Stop with this Quit Last Warning!"
## Reason pri ban
set eflood(equitReason2) "Go In Hell! I hate this Quit Flood!"

# CTCP/ACTION ( /me ) flood
set ctcpvar "3:3:10"
## Reason pri kick
set eflood(ectcpReason1) "Too many CTCP/Action lines!"
## Reason pri ban
set eflood(ectcpReason2) "... no thanks."

# Repeat section
set repeatvar "4:4:10"
## Reason pri kick
set eflood(erepeatReason1) "Quit recuring already"
## Reason pri ban
set eflood(erepeatReason2) "Quit recuring already"

# Mass join flood
## joins : sekundi
set joinvar "7:1"
# Pri mass flood kolko vreme da bude zakliuchen kanala ? v minuti
set eflood(LockTime) "3"

# Nastroiki za dulug tekst
# Na kakva duljina da nakazva 
set eflood(Length) "450"
# Reason 
set eflood(LongReason) "Too many Long line/word"

# Kakva da e maskata na bana
# 1 - $nick!*@*
# 2 - *!*ident@www.linux.com
# 3 - *!*ident@*
# 4 - *!*@www.linux.com
set eflood(BanType) "4"

# Kolko vreme shte dyrji bana 
set eflood(BanLast) "12000"

# Useri, s kakvi flags da ne budat nakazvani ? 
set eflood(ExemptFlags) "fob"

# Hostovete, koito sudurjat tova po-dolu nqma da budat nakazvani ;)
set eflood(ExemptList) {
       {UniBG.services}
	{109.104.203.4}
	{109.104.204.5}
	{kiril.FreeBSD.org}
	{seenserv.unibg.org}
}

# Bind-vame
bind pubm - * e:textflood
bind msgm - * e:msgflood
bind notc - * e:notcflood
bind sign - * e:quitflood
bind ctcp - * e:ctcpflood
bind join - * e:joinflood

proc e:joinflood {n u h c} {
        global ejoin
	foreach {o s} [split $::joinvar ":"] {break}
	switch [set ts [follow $s ejoin([string tolower $c]:massflood) $o "0"]] {
                1 {return}
		3 {e:flchanlock $c}
                default {return}
        }
}


# Syshtinskata chast
proc e:textflood {n u h c t} {
	global etext erepeat
	if {[e:flisexempt $n $h $u]} {return}
	if {[e:islong $t]} {e:flpunish $n $u $h $::eflood(LongReason)}
	foreach {k o s} [split $::tfvar ":"] {break}
		switch [set ts [follow $s etext([string tolower $u:$c]) $o $k]] {
			1 {}
			3 {e:flpunish $n $u $h $::eflood(etextReason2)}
			2 {putserv "KICK $c $n :$::eflood(etextReason1)"}
			default {}
	}
	foreach {a b v} [split $::repeatvar ":"] {break}
	switch [follow $v erepeat([md5 [string tolower $u:$t:$c]]) $b $a] {
                        1 {return}
                        3 {e:flpunish $n $u $h $::eflood(erepeatReason2)}
                        2 {putserv "KICK $c $n :$::eflood(erepeatReason1)"}
                        default {return}
        }
}

proc e:msgflood {n u h t} {
	global emsgm
	if {[e:flisexempt $n $h $u]} {return}
        foreach {k o s} [split $::msgvar ":"] {break}
                switch [set ts [follow $s emsgm([string tolower $u:$n]) $o $k]] {
                        1 {return}
                        3 {e:flpunish $n $u $h $::eflood(emsgmReason2)}
                        2 {putserv "KICK #bulgaria $n :$::eflood(emsgmReason1)"}
                        default {return}
        }
}
proc e:notcflood {n u h t d} {
	global enotc
	if {[e:flisexempt $n $h $u]} {return}
        foreach {k o s} [split $::notcvar ":"] {break}
                switch [set ts [follow $s enotc([string tolower $u:$d]) $o $k]] {
                        1 {return}
                        3 {e:flpunish $n $u $h $::eflood(enotcReason2)}
                        2 {putserv "KICK $d $n :$::eflood(enotcReason1)"}
                        default {return}
        }
}
proc e:quitflood {n u h c r} {
	global equit
	if {[e:flisexempt $n $h $u]} {return}
	foreach {k o s} [split $::quitvar ":"] {break}
        	switch [follow $s equit([string tolower $u:$c]) $o $k] {
                        1 {return}
                        3 {e:flpunish $n $u $h $::eflood(equitReason2)}
                        2 {putserv "KICK $c $n :$::eflood(equitReason1)"}
                        default {return}
        }
}

proc e:ctcpflood {n u h d k t} {
	global ectcp
	if {[e:flisexempt $n $h $u]} {return}
        foreach {k o s} [split $::ctcpvar ":"] {break}
                switch [set ts [follow $s ectcp([string tolower $u:$d]) $o $k]] {
                        1 {return}
                        3 {e:flpunish $n $u $h $::eflood(ectcpReason2)}
                        2 {putserv "KICK $d $n :$::eflood(ectcpReason1)"}
                        default {return}
        }
}

 
proc follow {secs fvar pun ban {value 1}} {
 upvar $fvar follow
 if {![info exists follow]} {
  set o $value ; set t [clock clicks -milliseconds]
 } {
  foreach {o t} $follow {break} ; incr o $value
 }
 if {[set z [expr {([clock clicks -milliseconds]-$t)/1000.0}]] > $secs} {
  set o $value ; set t [clock clicks -milliseconds]
 } {
  if {$o == $ban} {set follow [list $o $t];return 2}
  if {$o >= $pun} { followrem $fvar ; return 3 }
 }
 set follow [list $o $t]
 return 1
}

proc followrem fvar {
	upvar $fvar frem
	if {[info exists frem]} {
		unset frem
	}
}

proc e:flpunish {n u h r} {
	if {[isbotnick $n]} {return 0}
	set ban [e:flmakeban $n $u]
	if {![string match $ban $::botname]} {
		newban $ban $::botnick $r $::eflood(BanLast)
	}
	foreach chan [channels] {
		if {[onchan $n $chan]} {
			e:flbannick $ban $chan
		}
	}
	return
}

proc e:flmakeban {nick uhost} {
	switch $::eflood(BanType) {
		1 {return "$nick!*@*"}
		2 {return "*!*$uhost"}
		3 {return "*!*[lindex [split $uhost "@"] 0]*@*"}
		4 {return "*!*@[lindex [split $uhost "@"] 1]"}
	}
}

proc e:flbannick {ban chan} {
  if {$chan == "" || $ban == "*!*@*" || $ban == ""} {return}
  if {[validchan $chan] == 1 && [botonchan $chan] == 1 && [botisop $chan] == 1} {
    pushmode $chan +b $ban
    return
  }
  return
}
proc e:flisexempt {nick hand host} {
	if {[isbotnick $nick]} {return 1}
	if {$hand == "*" || $hand == ""} {return 0}
	if {$::eflood(ExemptFlags) == ""} {return 0}
	if {[matchattr $hand $::eflood(ExemptFlags)] == 1} {return 1}
	foreach exhost $::eflood(ExemptList) {
		if {[string match $exhost $host]} {return 1}
	}
	return 0
}
proc e:islong {t} {
	if {[string length $t] > $::eflood(Length) } {
		return 1
	}
	return 0
}
proc e:flchanlock c {
	putserv "MODE $c +imqr"
	timer $::eflood(LockTime) [list putserv "MODE $c -imqr"]
putserv "NOTICE $c :Channel is locked due flood, we will be back shortly"
}

putlog "Loaded:AntiFlood.tcl"
