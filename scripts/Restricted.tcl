####################################
#  zabraniawa wlizaneto w kanal ako nqmate flag +n
####################################
# w koj kanal da raboti skripta
set r_chan "#ruse"
####################################
set r_time 60
# duration of ban, 0 for perm, in minutes

###################################
#  You may not modify it
##################################

bind join -|- * out

proc out { nick uhost hand chan } {
	global r_time r_chan
	 if {![matchattr $hand n] } {
		putquick "KICK $r_chan $nick :Access Denied to This Channel"
		putquick "mode $r_chan +b $nick!*@*"
		newchanban "$r_chan" "$nick!*@*" Restrict "Access Denied to This Channel" $r_time
	}
}


putlog "Инсталиран: Restricted.tcl"
