unbind dcc - +host *dcc:+host
bind dcc p|p +host *dcc:+host

proc *dcc:+host {hand idx arg} {
	if {[llength $arg] < 1} {
		putdcc $idx "Usage: +host \[handle\] <newhostmask>"
		return
	}
	if {[llength $arg] > 1} {
		set user [lindex $arg 0]
		set host [lindex $arg 1]
		if {[validuser $user] == 0} {
			putdcc $idx "No such user."
			return
		}
		if {[llength [getuser $user HOSTS]] > 2 && $user != "nick1" && $user != "Hristoff" && $user != "nick3"} {
			putdcc $idx "Sorry brato, pove4e ot 3 hosta nea ima." 
			return
		}
		putlog "#$hand# +host $user $host"
		setuser $user hosts $host
		putdcc $idx "Added '$host' to $user"
		return
	}
	set host [lindex $arg 0]
# Ако искате някои потребители да могат да адват повече от 3 хост-а заменете имената им с Nick, Nick1 ...
	if {[llength [getuser $hand HOSTS]] > 2 && $hand != "dJ_TEDY" && $hand != "USER"} {
		putdcc $idx "Sorry brato, pove4e ot 3 hosta nea imash."
		return
	}
	putlog "#$hand# +host $hand $host"
	setuser $hand hosts $host
	putdcc $idx "Added '$host' to $hand"
	return
}

putlog "HostLimit bY d_TEDY Loaded!!!"