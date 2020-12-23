# .swhois nick - show whois on nick in partyline
### Settings ###

## What users can use the commands?
set swi_flag "n|n"

###### You don't need to edit below this ######

### Misc Things ###

set swi_ver "1.03"

### Bindings ###

bind dcc $swi_flag swhois dcc:swi_swhois
bind dcc $swi_flag swhowas dcc:swi_swhowas

### Whois Procs ###

proc raw:swi_wi301 {from key arg} {
global swi_idx
set awaymessage [string trimleft [join [lrange [split $arg] 2 end]] :]
	if {[valididx $swi_idx]} {
		putidx $swi_idx "8» 15Away съобщение: 14(9$awaymessage14)"
	}
}

proc raw:swi_wi311 {from key arg} {
global swi_idx
set nick [lindex [split $arg] 1]
set username [lindex [split $arg] 2]
set hostname [lindex [split $arg] 3]
set realname [string trimleft [join [lrange [split $arg] 5 end]] :]
	if {[valididx $swi_idx]} {
		putidx $swi_idx "15-=*14(8Whois14)15*=-"
		putidx $swi_idx "15---------------------------"
		putidx $swi_idx "8» 15Ник: $nick"
		putidx $swi_idx "8» 15Истинско име: $realname"
		putidx $swi_idx "8» 15Адрес:0 $username4@9$hostname"
	}
}

proc raw:swi_wi312 {from key arg} {
global swi_idx
set server [lindex [split $arg] 2]
set serverinfo [string trimleft [join [lrange [split $arg] 3 end]] :]
	if {[valididx $swi_idx]} {
		putidx $swi_idx "8»15 Сървър: 14(9$server14)"
		putidx $swi_idx "8»15 Описание: 14(9$serverinfo14)"
	}
}

proc raw:swi_wi313 {from key arg} {
global swi_idx
	if {[valididx $swi_idx]} {
		putidx $swi_idx "8»15 IRC Operator: 14(94Да14)"
	}
}

proc raw:swi_wi317 {from key arg} {
global swi_idx
set idletime [lindex [split $arg] 2]
set signontime [lindex [split $arg] 3]
	if {[catch {set idletime [duration $idletime]}]} { 
		set idletime "$idletime seconds"  
	}
	if {[valididx $swi_idx]} {
		putidx $swi_idx "8» 15Не е писал(a) от: 14(9$idletime14)"
		if {[swi_isnum $signontime]} { 
			putidx $swi_idx "8» 15Оnline е от: 14(9[ctime $signontime]14)" 
		}
	}
}

proc raw:swi_wi318 {from key arg} {
global swi_idx
	if {[valididx $swi_idx]} {
		putidx $swi_idx "15---------------------------"
		putidx $swi_idx "15-=*14(8Край на Whois Листа14)15*=-"
	}
	swi_wiunbindall
}

proc raw:swi_wi319 {from key arg} {
global swi_idx
set channels [string trimleft [join [lrange [split $arg] 2 end]] :]
	if {[valididx $swi_idx]} {
		putidx $swi_idx "8» 15Канали:10 $channels"
	}
}

proc raw:swi_wi401 {from key arg} {
global swi_idx
set nick [lindex [split $arg] 1]
	if {[valididx $swi_idx]} {
		putidx $swi_idx "--- Whois $nick"
		putidx $swi_idx " No such nick/channel"
	}
}

proc raw:swi_wi402 {from key arg} {
global swi_idx
	if {[valididx $swi_idx]} {
		putidx $swi_idx "--- Whois"
		putidx $swi_idx " No such server"
		putidx $swi_idx "--- End of Whois"
	}
	swi_wiunbindall
}

### Whowas Procs ###

proc raw:swi_ww314 {from key arg} {
global swi_idx
set nick [lindex [split $arg] 1]
set username [lindex [split $arg] 2]
set hostname [lindex [split $arg] 3]
set realname [string trimleft [join [lrange [split $arg] 5 end]] :]
	if {[valididx $swi_idx]} {
		putidx $swi_idx "--- Whowas $nick"
		putidx $swi_idx " Nick     : $nick"
		putidx $swi_idx " Realname : $realname"
		putidx $swi_idx " Address  : $username@$hostname"
	}
}

proc raw:swi_ww369 {from key arg} {
global swi_idx
	if {[valididx $swi_idx]} {
		putidx $swi_idx "--- End of Whowas"
	}
	swi_wwunbindall
}

proc raw:swi_ww402 {from key arg} {
global swi_idx
	if {[valididx $swi_idx]} {
		putidx $swi_idx "--- Whowas"
		putidx $swi_idx " No such server"
		putidx $swi_idx "--- End of Whowas"
	}
	swi_wwunbindall
}

proc raw:swi_ww406 {from key arg} {
global swi_idx
set nick [lindex [split $arg] 1]
	if {[valididx $swi_idx]} {
		putidx $swi_idx "--- Whowas $nick"
		putidx $swi_idx " There was no such nickname"
		putidx $swi_idx "--- End of Whowas"
	}
	swi_wwunbindall
}

### DCC Commands ###

proc dcc:swi_swhois {hand idx arg} {
global swi_idx
set arg [join [lrange [split $arg] 0 end]]
	putcmdlog "#$hand# swhois $arg"
	if {$arg == ""} {
		putidx $idx "Usage: .swhois \[server\] <nickmask>"
	} else {
		set swi_idx $idx
		swi_wibindall
		putquick "WHOIS $arg $arg"
	}
}

proc dcc:swi_swhowas {hand idx arg} {
global swi_idx
set arg [join [lrange [split $arg] 0 end]]
	putcmdlog "#$hand# swhowas $arg"
	if {$arg == ""} {
		putidx $idx "Usage: .swhowas <nick> \[count\] \[server\]"
	} else {
		set swi_idx $idx
		swi_wwbindall
		putserv "WHOWAS $arg"
	}
}

### Other Procs ###

proc swi_isnum {number} {
	if {($number != "") && (![regexp \[^0-9\] $number])} {
		return 1
	} else {
		return 0
	}
}

proc swi_wibindall { } {
	bind raw - 301 raw:swi_wi301
	bind raw - 311 raw:swi_wi311
	bind raw - 312 raw:swi_wi312
	bind raw - 313 raw:swi_wi313
	bind raw - 317 raw:swi_wi317
	bind raw - 318 raw:swi_wi318
	bind raw - 319 raw:swi_wi319
	bind raw - 401 raw:swi_wi401
	bind raw - 402 raw:swi_wi402
}

proc swi_wiunbindall { } {
	unbind raw - 301 raw:swi_wi301
	unbind raw - 311 raw:swi_wi311
	unbind raw - 312 raw:swi_wi312
	unbind raw - 313 raw:swi_wi313
	unbind raw - 317 raw:swi_wi317
	unbind raw - 318 raw:swi_wi318
	unbind raw - 319 raw:swi_wi319
	unbind raw - 401 raw:swi_wi401
	unbind raw - 402 raw:swi_wi402
}

proc swi_wwbindall { } {
	bind raw - 314 raw:swi_ww314
	bind raw - 369 raw:swi_ww369
	bind raw - 402 raw:swi_ww402
	bind raw - 406 raw:swi_ww406
}

proc swi_wwunbindall { } {
	unbind raw - 314 raw:swi_ww314
	unbind raw - 369 raw:swi_ww369
	unbind raw - 402 raw:swi_ww402
	unbind raw - 406 raw:swi_ww406
}

### End ###

putlog "Инсталиран: swhois.tcl"