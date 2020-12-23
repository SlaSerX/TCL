# BanAccess.tcl v1.0 (1 Nov 2006)
# Copyright by Kiril Georgiev a.k.a Arkadietz
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################

unbind dcc o|o -ban *dcc:-ban
bind dcc o|o -ban dcc:-ban
proc dcc:-ban {hand idx arg} {
set ban {}
if {$arg == ""} {
	putdcc $idx "Usage: -ban <hostmask|ban #> \[channel\]"
	return
} elseif { [lindex $arg 1] != ""} {
	foreach bans [banlist [lindex $arg 1]] {
		set mask [lindex $bans 0]
		set who [lindex $bans 5]
		if { $mask == [lindex $arg 0] } {
			set ban [lindex $arg 0]
			if {$who == $hand || [matchattr $hand n]} {
				killchanban [lindex $arg 1] [lindex $arg 0]
				putdcc $idx "Removed ban: [lindex $arg 0]"
				return
			} else {
				putdcc $idx "No Access to Remove this ban! - it's seted by $who"
				return
			}
		}
	}
	if {$ban eq {}} { putdcc $idx "No such ban."}
} else {
	foreach bans [banlist] {
		set mask [lindex $bans 0]
		set who [lindex $bans 5]
		if { $mask == [lindex $arg 0] } {
			set ban [lindex $arg 0]
			if {$who == $hand || [matchattr $hand n]} {
				killban [lindex $arg 0]
				putdcc $idx "Removed ban: [lindex $arg 0]"
				return
			} else {
				putdcc $idx "No Access to Remove this ban! - it's seted by $who"
				return
			}
		}
	}
}
if {$ban eq {}} { putdcc $idx "No such ban."}
}

putlog "TCL | Ban Access"
