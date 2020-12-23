# Oidentd.tcl v1.0 (23 Sep 2007)
# Idea by Kiril Georgiev a.k.a Arkadietz
# created by TiSmA ( TiSmA@eXolia.fr )
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################

### Bind ###

bind evnt - connect-server oidentd

### Proc ###

proc oidentd {arg} {
	global env username
	if {![file exists "$env(HOME)/.oidentd.conf"]} { 
		set c_oidentd [open "$env(HOME)/.oidentd.conf" a+]
		close $c_oidentd
	}
	if {![file exists "$env(HOME)/.ispoof"]} { 
		set c_ispoof [open "$env(HOME)/.ispoof" a+]
		close $c_ispoof
	}
	set a_oidentd [open $env(HOME)/.oidentd.conf w+]
	puts $a_oidentd "global \{ reply \"$username\" \}"
	close $a_oidentd
	set a_ispoof [open $env(HOME)/.ispoof w+]
	puts $a_ispoof "$username"
	close $a_ispoof
}

putlog "TCL | Oidentd"
