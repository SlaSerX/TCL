################################
##  IP Whois (IPv6 Supported) ##
################################

set whoisinfo(trigger) "!ip"
set whoisinfo(port) 43
set whoisinfo(ripe) "whois.ripe.net"
set whoisinfo(arin) "whois.arin.net"
set whoisinfo(apnic) "whois.apnic.net"
set whoisinfo(lacnic) "whois.lacnic.net"
set whoisinfo(afrinic) "whois.afrinic.net"

bind pub - $whoisinfo(trigger) pub_whoisinfo

proc whoisinfo_setarray {} {
	global query
	set query(netname) "(none)"
	set query(country) "(none)"
	set query(orgname) "(none)"
	set query(orgid) "(none)"
	set query(range) "(none)"
}

proc whoisinfo_display { chan } {
	global query
	putlog "Firstline: $query(firstline)"
	puthelp "PRIVMSG $chan :12---====9 Range :8 $query(range) 12-9 NetName :8 $query(netname) 12-9Organization :8 $query(orgname) 12-9 Country :8 $query(country) 12====---"
}

proc pub_whoisinfo {nick uhost handle chan search} {
	global whoisinfo
	global query
	whoisinfo_setarray 
	if {[whoisinfo_whois $whoisinfo(arin) $search]==1} {
		if {[string compare [string toupper $query(orgid)] "RIPE"]==0} {
			if {[whoisinfo_whois $whoisinfo(ripe) $search]==1} {
				whoisinfo_display $chan
			}
		 } elseif {[string compare [string toupper $query(orgid)] "APNIC"]==0} {
			if {[whoisinfo_whois $whoisinfo(apnic) $search]==1} {
				whoisinfo_display $chan
			}
		 } elseif {[string compare [string toupper $query(orgid)] "LACNIC"]==0} {
			if {[whoisinfo_whois $whoisinfo(lacnic) $search]==1} {
				whoisinfo_display $chan
				}
		 } elseif {[string compare [string toupper $query(orgid)] "AFRINIC"]==0} {
			if {[whoisinfo_whois $whoisinfo(afrinic) $search]==1} {
				whoisinfo_display $chan
				}
		 } else {
			whoisinfo_display $chan
		}
	} else {
		if { [info exist query(firstline)] } {
			puthelp "PRIVMSG $chan :4$query(firstline)"
		} else {
			puthelp "PRIVMSG $chan :4Error!"
		}
	}
}

proc whoisinfo_whois {server search} {
	global whoisinfo
	global query
	set desccount 0
	set firstline 0
	set reply 0
	putlog "Whois: $server:$whoisinfo(port) -> $search"
	if {[catch {set sock [socket -async $server $whoisinfo(port)]} sockerr]} {
      	puthelp "PRIVMSG $chan :4Error: $sockerr. Try again later."
      	close $sock
		return 0
    	}
	puts $sock $search
	flush $sock
	while {[gets $sock whoisline]>=0} {
		putlog "Whois: $whoisline"
		if {[string index $whoisline 0]!="#" && [string index $whoisline 0]!="%" && $firstline==0} {
			if {[string trim $whoisline]!=""} {
				set query(firstline) [string trim $whoisline]
				set firstline 1
			}
		}
		if {[regexp -nocase {netname:(.*)} $whoisline all item]} {
			set query(netname) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {owner-c:(.*)} $whoisline all item]} {
			set query(netname) [string trim $item]
			set reply 1 
		} elseif {[regexp -nocase {country:(.*)} $whoisline all item]} {
			set query(country) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {descr:(.*)} $whoisline all item] && $desccount==0} {
			set query(orgname) [string trim $item]
			set desccount 1
			set reply 1
		} elseif {[regexp -nocase {orgname:(.*)} $whoisline all item]} {
			set query(orgname) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {owner:(.*)} $whoisline all item]} {
			set query(orgname) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {orgid:(.*)} $whoisline all item]} {
			set query(orgid) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {inetnum:(.*)} $whoisline all item]} {
			set query(range) [string trim $item]
			set reply 1
		} elseif {[regexp -nocase {netrange:(.*)} $whoisline all item]} {
			set query(range) [string trim $item]
			set reply 1
		}
	}
	close $sock
	return $reply
}
putlog "+++ zombie IP Whois TCL Loaded"
