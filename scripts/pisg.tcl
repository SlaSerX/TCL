#pisg.tcl v0.15 by HM2K - auto stats script for pisg (perl irc statistics generator)
#based on a script by Arganan

# WARNING - READ THIS
#
# If you use this script, PLEASE read the documentation about the "Silent"
# option. If you get the message "an error occured: Pisg v0.67 - perl irc
# statistics generator" in the channel, you are NOT running silent. Fix it.

set pisgver "0.15"

#Location of pisg execuitable perl script
set pisgexe "/home/teodor/pisg/pisg"

#URL of the generated stats
set pisgurl "http://Sofia-Stats.Tk .::Opers List::. http://SofiaTeam.Tk"
#set pisgurl "http://Sofia-Stats.Tk"

#channel that the stats are generated for
set pisgchan "#Sofia"

#Users with these flags can operate this function
set pisgflags "nm"

#How often the stats will be updated in minutes, ie: 30 - stats will be updated every 30 minutes
set pisgtime "300"

bind pub $pisgflags !stats pub:pisgcmd

proc pub:pisgcmd {nick host hand chan arg} {
	global pisgexe pisgurl pisgchan
	append out "PRIVMSG $pisgchan :" ; if {[catch {exec $pisgexe} error]} { append out "$pisgexe an error occured: [string totitle $error]" } else { append out ".::Channel Stats::. $pisgurl" }
	puthelp $out
}

proc pisgcmd_timer {} {
	global pisgexe pisgurl pisgchan pisgtime
	append out "PRIVMSG $pisgchan :" ; if {[catch {exec $pisgexe} error]} { append out "$pisgexe an error occured: [string totitle $error]" } else { append out ".::Channel Stats::. $pisgurl" }
	puthelp $out
	timer $pisgtime pisgcmd_timer
}

if {![info exists {pisgset}]} {
  set pisgset 1
  timer 2 pisgcmd_timer
}

putlog "pisg.tcl $pisgver loaded"
