set ptk:patrtout 1800
set ptk:patrmaxwrn 3
set ptk:clnttout 120
set ptk:clntmax 5
set ptk:logfname "/home/sAw/mirc/logs/ptrkill.log"


proc ptk:genpatr { word } {
	set word [string map {a l b l c l d l e l f l g l h l i l j l k l l l m l n l o l p l q l r l s l t l u l v l w l x l y l z l à l á l â l ã l ä l å l æ l ç l è l é l ê l ë l ì l í l î l ï l ð l ñ l ò l ó l ô l õ l ö l ÷ l ø l ù l ú l ü l þ l ÿ l} $word]
	set word [string map {A u B u C u D u E u F u G u H u I u J u K u L u M u N u O u P u Q u R u S u T u U u V u W u X u Y u Z u À u Á u Â u Ã u Ä u Å u Æ u Ç u È u É u Ê u Ë u Ì u Í u Î u Ï u Ð u Ñ u Ò u Ó u Ô u Õ u Ö u × u Ø u Ù u Ú u Ü u Þ u ß u} $word]
	set word [string map {0 n 1 n 2 n 3 n 4 n 5 n 6 n 7 n 8 n 9 n} $word]
	return $word
}

proc ptk:genesc { word } {
	set word [string map {\[ \\\[ \] \\\]} $word]
	return $word
}

proc ptk:addpatr { nick userhost } {
	set pattern [ptk:genpatr $nick!$userhost]
	set utimerid [utimer ${::ptk:patrtout} "ptk:delpatr [ptk:genesc $pattern]"]
	if {[set index [lsearch ${::ptk:patrlist} [ptk:genesc $pattern]]] > -1} {
		killutimer [lindex  ${::ptk:patrtimlist} $index]
		set ::ptk:patrtimlist [lreplace ${::ptk:patrtimlist} $index $index $utimerid]
	} else {
		set index [llength ${::ptk:patrlist}]
		lappend ::ptk:patrlist $pattern
		lappend ::ptk:patrtimlist $utimerid
		lappend ::ptk:patractlist 0
		lappend ::ptk:patrwrnlist 0
		lappend ::ptk:clntlist {}
		lappend ::ptk:clnttimlist {}
	}
	return "$index $pattern"
}

proc ptk:addclnt { index nick userhost pattern } {
	set clist [lindex ${::ptk:clntlist} $index]
	set ctlist [lindex ${::ptk:clnttimlist} $index]
	lappend clist $nick!$userhost
	lappend ctlist [utimer ${::ptk:clnttout} "ptk:delclnt [ptk:genesc $pattern] [ptk:genesc $nick] [ptk:genesc $userhost]"]
	set ::ptk:clntlist [lreplace ${::ptk:clntlist} $index $index $clist]
	set ::ptk:clnttimlist [lreplace ${::ptk:clnttimlist} $index $index $ctlist]
	return [llength $clist]
}

proc ptk:delpatr { pattern } {
	if {[set index [lsearch ${::ptk:patrlist} [ptk:genesc $pattern]]] > -1} {
		set ::ptk:patrlist [lreplace ${::ptk:patrlist} $index $index]
		set ::ptk:patrtimlist [lreplace ${::ptk:patrtimlist} $index $index]
		set ::ptk:patractlist [lreplace ${::ptk:patractlist} $index $index]
		set ::ptk:patrwrnlist [lreplace ${::ptk:patrwrnlist} $index $index]
		foreach utimerid [lindex ${::ptk:clnttimlist} $index] { catch {killutimer $utimerid} }
		set ::ptk:clntlist [lreplace ${::ptk:clntlist} $index $index]
		set ::ptk:clnttimlist [lreplace ${::ptk:clnttimlist} $index $index]
	}
}

proc ptk:delclnt { pattern nick userhost } {
	if {[set index [lsearch ${::ptk:patrlist} [ptk:genesc $pattern]]] > -1} {
		set clist [lindex ${::ptk:clntlist} $index]
		set ctlist [lindex ${::ptk:clnttimlist} $index]
		if {[set locindex [lsearch $clist [ptk:genesc $nick!$userhost]]] > -1} {
			set clist [lreplace $clist $locindex $locindex]
			set ctlist [lreplace $ctlist $locindex $locindex]
			set ::ptk:clntlist [lreplace ${::ptk:clntlist} $index $index $clist]
			set ::ptk:clnttimlist [lreplace ${::ptk:clnttimlist} $index $index $ctlist]
		}
	}
}

proc ptk:forcedelclnt { index nick userhost } {
	set clist [lindex ${::ptk:clntlist} $index]
	set ctlist [lindex ${::ptk:clnttimlist} $index]
	while {[set locindex [lsearch $clist [ptk:genesc $nick!$userhost]]] > -1} {
		killutimer [lindex $ctlist $locindex]
		set clist [lreplace $clist $locindex $locindex]
		set ctlist [lreplace $ctlist $locindex $locindex]
	}
	set ::ptk:clntlist [lreplace ${::ptk:clntlist} $index $index $clist]
	set ::ptk:clnttimlist [lreplace ${::ptk:clnttimlist} $index $index $ctlist]
}

proc ptk:connect { from keyword text } {
	if {[lrange $text 1 5] == ":*** Notice -- Client connecting:" && $from == [lindex [split ${::server} :] 0]} {
		set nick [lindex $text 6]
		set userhost [string trim [lindex $text 7] ()]
		set usern [lindex [split $userhost @] 0]
		set host [lindex [split $userhost @] 1]
		set ip [string trim [lindex $text 8] \[\]]
		set data [ptk:addpatr $nick $usern]
		set index [lindex $data 0]
		set pattern [lindex $data 1]
		if [lindex ${::ptk:patractlist} $index] {
			putquick "KLINE *@$ip :Klined Proxy or Bad Host !!!"
			lappend ::ptk:logbuf "[ptk:genesc $nick!$usern@$ip] [clock seconds]"
		} else {
			set cnum [ptk:addclnt $index $nick $usern@$ip $pattern]
			if {$cnum >= ${::ptk:clntmax}} {
				ptk:aprocess $index
			}
		}
	}
}

proc ptk:warn { nick userhost } {
	set usern [lindex [split $userhost @] 0]
	set host [lindex [split $userhost @] 1]
	set index [lindex [ptk:addpatr $nick $usern] 0]
	if ![lindex ${::ptk:patractlist} $index] {
		set warns {1+[lindex ${::ptk:patrwrnlist} $index]}
		if {$warns >= ${::ptk:patrmaxwrn}} {
			ptk:aprocess $index
		} else {
			set ::ptk:patrwrnlist [lreplace ${::ptk:patrwrnlist} $index $index $warns]
		}
	}
}

proc ptk:aprocess { index } {
	set ::ptk:patractlist [lreplace ${::ptk:patractlist} $index $index 1]
	set nick [lindex [split [lindex [lindex ${::ptk:clntlist} $index] 0] !] 0]
	set userhost [lindex [split [lindex [lindex ${::ptk:clntlist} $index] 0] !] 1]
	set usern [lindex [split $userhost @] 0]
	set host [lindex [split $userhost @] 1]
	while {$nick != ""} {
		ptk:forcedelclnt $index $nick $userhost
		putquick "KLINE *@$host :Klined Proxy or Bad Host !!!"
		lappend ::ptk:logbuf "[ptk:genesc $nick!$usern@$host] [clock seconds]"
		set nick [lindex [split [lindex [lindex ${::ptk:clntlist} $index] 0] !] 0]
		set userhost [lindex [split [lindex [lindex ${::ptk:clntlist} $index] 0] !] 1]
		set usern [lindex [split $userhost @] 0]
		set host [lindex [split $userhost @] 1]
	}
}

proc ptk:logdump {min hour day month year} {
	if [set lbuffer [llength ${::ptk:logbuf}]] {
		if {[catch {set handle [open ${::ptk:logfname} a]}] == 0} {
			set con 0
			while { $con < $lbuffer } {
				puts $handle [lindex ${::ptk:logbuf} $con]
				set con [expr 1 + $con]
			}
			set ::ptk:logbuf ""
			close $handle
		}
	}
}

set ptk:logbuf ""
set ptk:patrlist ""
if [info exists ptk:patrtimlist] { foreach utimerid ${::ptk:patrtimlist} { catch {killutimer $utimerid} } }
set ptk:patrtimlist ""
set ptk:patractlist ""
set ptk:patrwrnlist ""
set ptk:clntlist ""
if [info exists ptk:clnttimlist] { foreach ctlist ${::ptk:clnttimlist} { foreach utimerid $ctlist { catch {killutimer $utimerid} } } }
set ptk:clnttimlist ""

bind raw - NOTICE ptk:connect
bind time - "57 % % % %" ptk:logdump

putlog "AntiSocks By SmasHinG Loaded..."
