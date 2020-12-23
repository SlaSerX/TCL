set longword(protect) "f"
set longword(text_length) 300
set longword(bantime) 30

bind pubm - * longword_pubm
proc longword_pubm {nick uhost hand chan text} {
	longword_offend $nick $uhost $hand $text $chan
}

bind notc - * longword_notc
proc longword_notc {nick uhost hand text target} {
	longword_offend $nick $uhost $hand $text $target
}

proc longword_offend {nick uhost hand text chan} {
	global longword

	if {![validchan $chan]} {
		return 0
	}

	if {![botisop $chan]} {
		return 0
	}

	if {[isbotnick $nick]} {
		return 0
	}

	if {[matchattr $hand $longword(protect) $chan]} {
		return 0
	}

	if {[string length $text] > $longword(text_length)} {
		set ban "*!*@[lindex [split $uhost @] 1]"
		newchanban $chan $ban "LongWord.tcl" "Tvyrde dylag red chesto izpolzvana taktika pri Flooders ( 30 min. Ban" $longword(bantime)
	}
}
