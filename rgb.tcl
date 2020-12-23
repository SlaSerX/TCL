# Remove Global Bans By Users in list with big rull #
set usrs "SmasHinG KiT"
bind mode - *-b* h_rem_ban
proc h_rem_ban {nick host hand chan mdechg ban} {
	global usrs
	if {([lsearch -exact [string tolower $usrs] [string tolower $hand]] != -1)} {
		if {[isban $ban] || [ispermban $ban] || [matchban $ban]} {
			if {[killban $ban]} { 
				putserv "NOTICE $nick :Success removed $ban"
				return 0 
			} else { 
				putserv "NOTICE $nick :Unable to remove $ban"
				return 0 
			}
		}
		if {[isban $ban "#Cancel"] || [ispermban $ban "#Cancel"] || [matchban $ban "#Cancel"]} {
			if {[killchanban $chan $ban]} { 
				putserv "NOTICE $nick :Success removed $ban" 
				return 0
			} else { 
				putserv "NOTICE $nick :Unable to remove $ban" 
				return 0
			}
		}
	}
	if {([lsearch -exact [string tolower $usrs] [string tolower $nick]] != -1)} {
		if {[isban $ban] || [ispermban $ban] || [matchban $ban]} {
			if {[killban $ban]} { 
				putserv "NOTICE $nick :Success removed $ban"
				return 0  
			} else { 
				putserv "NOTICE $nick :Unable to remove $ban" 
				return 0 
			}
		}
		if {[isban $ban "#Cancel"] || [ispermban $ban "#Cancel"] || [matchban $ban "#Cancel"]} {
			if {[killchanban $chan $ban]} { 
				putserv "NOTICE $nick :Success removed $ban" 
				return 0 
			} else { 
				putserv "NOTICE $nick :Unable to remove $ban" 
				return 0 
			}
		}
	}
}
