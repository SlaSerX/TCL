# Moderator-02.tcl by nix@valium.org

###########################
# CONFIG BADWORD
###########################

# prevenir 1 fois avant kick pour les badword? 1/0
set Mod(Warn) 0

# si on previent kel est le message a envoyer?
set Mod(WarnMsg) "Helooo!?! Mind your language!"

# bannir pour badword? 1/0
set Mod(Ban) 1

# bannir combien de temps? (en minute)
set Mod(BanTime) 120

# kicker pour badword? 1/0
set Mod(Kick) 1

# kel raison pour le kick?
set Mod(KickReason) " Upotrebihte losha duma i ste kiknat! \[$Mod(BanTime) min. ban\]"

###########################
# CONFIG REPEAT
###########################

# combien de repetion maxi?
set Mod(RptMax) 2

# bannir pour repetition? 1/0
set Mod(BanRep) 1

# combien de temps? (en minute)
set Mod(BanRepTime) 30

# raisons de kick pour les repetions
set Mod(Reason) "repeat flood \[$Mod(BanRepTime) min. ban\]"

###########################
# CONFIG CAPS
###########################

# Max de Caps ?
set Mod(MaxCaps) 60

# prevenir la personne en notice ? 1/0
set Mod(CapsWarn) 0

# quel message?
set Mod(CapsWarnMsg) "Watch those CAPS!!"

# kicker les CAPS ? 1/0
set Mod(KCaps) 1

# quel raison pour le kick?
set Mod(KCapsReason) "Molia prestanete da izpolzvate tolkova mnogo glavni bukvi!"

###########################
# CONFIG LONG WORD
###########################

# kick on long words? 1/0
set Mod(MaxMot) 1

# maximum word size? 1/0
set Mod(MaxMotSize) 100

# kick reason?
set Mod(MaxMotReason) "Flood??"


###################################################################

proc KReason {} {
	global Mod
#	return [lindex $Mod(Reason) [rand [llength $Mod(Reason)]]]
	return $Mod(Reason)
}

#on set les listes au demarrage en lisant les fichiers
set BWC ""
foreach c [channels] {
	if {[file exists "Moderator.[string tolower $c].list"]} {
		set f [open Moderator.[string tolower $c].list r]
		set BWL([string tolower $c]) "[string tolower [gets $f]]"
		close $f
		lappend BWC [string tolower $c]
	}
}

#proc pour checker si le channel est a surveiller
proc ChkWbBwVar {cha} {
	global BWC
	foreach c $BWC {
		if {$c == "$cha"} {return 1; break}
	}
	return 0
}

#check les NOTICE PRIVMSG ACTION SOUND
bind raw - NOTICE PubChkNOT
proc PubChkNOT {from keyword arg} {
	set from [split $from !]
	PubChk [lindex $from 0] [lindex $from 1] * [lindex $arg 0] [lrange $arg 1 end]
}
bind ctcp - ACTION PubChkACTSND
bind ctcp - SOUND PubChkACTSND
proc PubChkACTSND {nick uhost hand dest keyword text} {
	if {[string match &* $dest] || [string match #* $dest]} {
		PubChk $nick $uhost $hand $dest $text
	}
}
bind pubm - * PubChk
proc PubChk {nick userhost handle channel text} {
	global BWN BWL BWC RPT Mod
# anti bad word
	if {[ChkWbBwVar [string tolower $channel]]} {
		set hostban [lindex [split $userhost @] 1]
		set identban [lindex [split $userhost @] 0]
		set templist [join [split [string tolower $text] "!&\"'(-_)=~\{\[|`\\^@\]\}\$%µ?,;:/§"]]
		foreach wdt $BWL([string tolower $channel]) {
			if {[lsearch -exact "$templist" $wdt] != -1} {
				if {$Mod(Warn)} {
					if {![info exists BWN([string tolower $userhost])]} {
						putserv "NOTICE $nick :$Mod(WarnMsg)"
						set BWN([string tolower $userhost]) [expr [clock seconds] + 1800]
					} else {
						if {$Mod(Ban)} {
						    if { [regexp {html\.chat$} $hostban] } {
#							newchanban $channel *!*$identban@* Moderator "$Mod(KickReason)" $Mod(BanTime)
							putserv "MODE $channel +b *!*$identban@*"
						       } else {
							newchanban $channel *!*@$hostban Moderator "$Mod(KickReason)" $Mod(BanTime)
						       }
						   }
						if {$Mod(Kick)} {putserv "KICK $channel $nick :$Mod(KickReason)"}
					}
					return 1
				} else {
					if {$Mod(Ban)} {
					    if { [regexp {html\.chat$} $hostban] } {
#						newchanban $channel *!*$identban@* Moderator "$Mod(KickReason)" $Mod(BanTime)
						putserv "MODE $channel +b *!*$identban@*"
					       } else {
						newchanban $channel *!*@$hostban Moderator "$Mod(KickReason)" $Mod(BanTime)
					       }
					   }
					if {$Mod(Kick)} {putserv "KICK $channel $nick :$Mod(KickReason)"}
					return 1
				}
			}
		}
# anti repetitions
		regsub -all {\\} $text {\\\\} text
		regsub -all {\{} $text {\{} text
		regsub -all {\}} $text {\}} text
		regsub -all {\]} $text {\]} text
		regsub -all {\[} $text {\[} text
		regsub -all {\"} $text {\"} text
		if {[info exists RPT($nick)]} {
			if {[lrange $RPT($nick) 2 end] == "$text"} {
				set cnt [lindex $RPT($nick) 1]; incr cnt
				set RPT($nick) "[lindex $RPT($nick) 0] $cnt [lrange $RPT($nick) 2 end]"
				if {[lindex $RPT($nick) 1] > $Mod(RptMax)} {
					putserv "KICK $channel $nick :[KReason]"
					if {$Mod(BanRep)} {
					    if { [regexp {html\.chat$} $hostban] } {
#						newchanban $channel *!*$identban@* Moderator "Repeat" 10
						putserv "MODE $channel +b *!*$identban@*"
					       } else {
						newchanban $channel *!*@$hostban Moderator "Repeat" 10
					       }
					   }
					unset RPT($nick)
				}
			} else {set RPT($nick) "[expr [clock seconds] + 10] 1 $text"}
		} else {set RPT($nick) "[expr [clock seconds] + 10] 1 $text"}
# anti majuscule / longue chaine
		set upper 0
		set space 0
		foreach i [split $text {}] {
			if [string match \[A-Z\] $i] {incr upper}
			if {$i == " "} {incr space}
		}
		if {$upper > $Mod(MaxCaps)} {
	 		if {$Mod(CapsWarn)} {putserv "NOTICE $nick :$Mod(CapsWarnMsg)"}
			if {$Mod(KCaps)} {putserv "KICK $channel $nick :$Mod(KCapsReason)"}
		}
		if {$space == 0 && [string length $text] > $Mod(MaxMotSize) && $Mod(MaxMot)} {
			putserv "KICK $channel $nick :$Mod(MaxMotReason)"
		}
	}
}
proc UnsetRepeat {} {
	global RPT
	foreach nick [array names RPT] {
		if {[lindex $RPT($nick) 0] < [clock seconds]} {unset RPT($nick)}
	}
	utimer 5 UnsetRepeat
}
foreach t [utimers] {
	if {[lindex $t 1] == "UnsetRepeat"} {killutimer [lindex $t 2]}
}
UnsetRepeat

#toute les minute on check pour unseter les var des nick qui sont en avertissement
bind time - "* * * * *" UnsetTmpVar
proc UnsetTmpVar {min hour day month year} {
	global BWN RPT
	foreach nt [array names BWN] {
		if {$BWN($nt) < [clock seconds]} {unset BWN($nt)}
	}
}

#procs pour ajouter, enlever, lister les mots a bannir
bind dcc o|o addword AddBadWord
proc AddBadWord {hand idx args} {
	global BWL
	set chan [string tolower [lindex [console $idx] 0]]
	if {![validchan $chan]} {putdcc $idx "Invalid console for ($chan)"; return 0}
	if {![matchattr [idx2hand $idx] o|o $chan]} {putdcc $idx "Access denied for $chan"; return 0}
	set word [string tolower [lindex $args 0]]
	if {$word == ""} {putdcc $idx ".addword <word> (add a word)"; return 0}
	if {![info exists BWL($chan)]} {set BWL($chan) ""}
	if {[lsearch -exact "x $BWL($chan)" "$word"] == -1} {
		lappend BWL($chan) $word
		set f [open Moderator.$chan.list w]
		puts $f "$BWL($chan)"
		close $f
		putdcc $idx "$word added."
		return 1
	} else {putdcc $idx "$word is already in the list! (type .listword to see the list)"; return 0}
}
bind dcc o|o delword DelBadWord
proc DelBadWord {hand idx args} {
	global BWL
	set chan [string tolower [lindex [console $idx] 0]]
	if {![validchan $chan]} {putdcc $idx "Invalid console for ($chan)"; return 0}
	if {![matchattr [idx2hand $idx] o|o $chan]} {putdcc $idx "Access denied for $chan"; return 0}
	if {![info exists BWL($chan)]} {putdcc $idx "No word for $chan"; return 0}
	set word [string tolower [lindex $args 0]]
	if {$word == ""} {putdcc $idx ".delword <word> (erase a word)"; return 0}
	if {[lsearch -exact "$BWL($chan)" "$word"] != -1} {
		set f [open Moderator.$chan.list r]
		gets $f tmpl
		close $f
		set newlist ""
		foreach t $tmpl {
			if {$t != "$word"} {lappend newlist $t}
		}
		set f [open Moderator.$chan.list w]
		puts $f "$newlist"
		set BWL($chan) $newlist
		close $f
		putdcc $idx "$word deleted."
		return 1
	} else {putdcc $idx "$word is not in the list! (type .listword to see the list)"; return 0}
}
bind dcc o|o listword ListBadWord
proc ListBadWord {hand idx args} {
	global BWL
	set chan [string tolower [lindex [console $idx] 0]]
	if {![validchan $chan]} {putdcc $idx "Invalid console for ($chan)"; return 0}
	if {![matchattr [idx2hand $idx] o|o $chan]} {putdcc $idx "Access denied for $chan"; return 0}
	if {![info exists BWL($chan)]} {putdcc $idx "No word for $chan"; return 0}
	putdcc $idx "List of Badwords: $BWL($chan)"
	return 1
}

#procs pour ajouter enlever lister les chans a checker

bind dcc o|o +modchan AddChan
proc AddChan {hand idx args} {
	global BWC BWL
	set tchan [string tolower [lindex $args 0]]
	if {$tchan == ""} {putdcc $idx ".+modchan <#channel> (add a channel to supervise)"; return 0}
	if {![validchan $tchan]} {putdcc $idx "Invalid channel - ($tchan)"; return 0}
	if {![matchattr [idx2hand $idx] o|o $tchan]} {putdcc $idx "Access denied for $tchan"; return 0}
	if {[lsearch -exact "x $BWC" "$tchan"] == -1} {

		set f [open Moderator.$tchan.list w]
		close $f
		set BWL($tchan) ""

		set f [open Moderator.chan w]
		puts $f [lappend BWC $tchan]
		close $f
		putdcc $idx "$tchan added."
		return 1
	} else {putdcc $idx "$tchan is already in the list! (type .modchan for the list)";return 0}
}
bind dcc o|o -modchan DelChan
proc DelChan {hand idx args} {
	global BWC
	set tchan [string tolower [lindex $args 0]]
	if {$tchan == ""} {putdcc $idx ".-modchan <#channel> (remove a channel to supervise)"; return 0}
	if {![validchan $tchan]} {putdcc $idx "Invalid channel - ($tchan)"; return 0}
	if {![matchattr [idx2hand $idx] o|o $tchan]} {putdcc $idx "Access denied for $tchan"; return 0}
	if {[lsearch -exact "x $BWC" "$tchan"] != -1} {
		set f [open Moderator.chan r]
		set tmpl [gets $f]
		close $f
		set newlist ""
		foreach t $tmpl {
			if {$t != "$tchan"} {lappend newlist $t}
		}
		set f [open Moderator.chan w]
		puts $f "$newlist"
		close $f
		set BWC $newlist
		putdcc $idx "$tchan erased."
		return 1
	} else {putdcc $idx "$tchan is not in the list! (type .modchan to view list)";return 0}
}
bind dcc - modchan ListChan
proc ListChan {hand idx args} {
	global BWC
	putdcc $idx "Channel list: $BWC"
	return 1
}
bind dcc - Moderator Moderator
proc Moderator {hand idx args} {
	global Mod
	putdcc $idx "      Moderator2.tcl      "
	putdcc $idx ""
	putdcc $idx "This script contains an anti badword, anti"
	putdcc $idx "repetition, anti caps and anti long word"
	putdcc $idx "protection. It acts on public msgs/notices"
	putdcc $idx "actions/sounds"
	putdcc $idx ""
	putdcc $idx "commands for the badword protection"
	putdcc $idx "addword <word> (add a word)"
	putdcc $idx "delword <word> (delete a word)"
	putdcc $idx "listword (list words)"
	putdcc $idx ""
	putdcc $idx "channel commands"
	putdcc $idx "+modchan <#channel> (add a channel to monitor)"
	putdcc $idx "-modchan <#channel> (remove a channel from monitoring)"
	putdcc $idx "modchan (list channels)"
	putdcc $idx ""
	return 1
}

putlog "Moderator-02.tcl - (.Moderator for help) fixed By SmasHinG"
