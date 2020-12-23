###############################################################################
#                                                                             #
# Russian roulette script v1.0                                                #
#  by Temmer (email: dentemmer@yahoo.com)                                     #
#                                                                             #
# Put the channelflag +rr to play                                             #
#  Use !rr in the channel to play, !rr <nick> can be used to try to kill      #
#  someone else in the channel, !rrstat to print the number of killed people  #
#                                                                             #
# Feel free to copy/edit/distribute/molest this script, as long as you        #
#  include this banner                                                        #
#                                                                             #
###############################################################################

set rr_count 0
set rr_bullet [rand 6]
if {![info exists rr_kicks]} {
	set rr_kicks 0
}

setudef flag rr

bind pub * !rr russian_roulette
bind pub * !rrstat russian_roulette_stats

proc russian_roulette {nick uhost hand chan args} {
	global rr_count rr_bullet rr_kicks
	if {[botisop $chan] && [ischanflag $chan "+rr"]} {
		set args [lindex $args 0]
		set rr_nick $nick
		if {[llength $args] > 0} {
			if {[onchan [lindex $args 0] $chan] && ![isbotnick [lindex $args 0]] && [rand 3] == 0} {
				set rr_nick [lindex $args 0]
			}
		}
		if {$rr_count >= $rr_bullet} {
			set rr_count 0
			set rr_bullet [rand 6]
			set rr_kicks [expr $rr_kicks + 1]
			putserv "privmsg $chan :\002*BANG*\002"
			putserv "kick $chan $rr_nick :You're dead -$rr_kicks-"
		} else {
			set rr_count [expr $rr_count + 1]
			putserv "privmsg $chan :\002*CLICK*\002 Close one, huh $rr_nick"
		}
	}
	return 0
}

proc russian_roulette_stats {nick uhost hand chan args} {
	global rr_kicks
	if {[ischanflag $chan "+rr"]} {
		putserv "privmsg $chan :Russian Roulette Dead Count: $rr_kicks"
	}
	return 0
}

proc ischanflag {chan flag} {
	foreach f [channel info $chan] {
		if {$f == $flag} {
			return 1
		}
	}
	return 0
}
putlog "Russian Roulette loaded"
