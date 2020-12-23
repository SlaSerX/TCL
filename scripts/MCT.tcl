##############################################################################################
##############################################################################################
##############################################################################################

set tcm:version "tcm-hybrid-v3.1.1-pre(20021229_0)"

set tcm:server "irc.is-bg.com"

set tcm:ctcpchk 0		;# check for cloaked ctcp
set tcm:maxhops 2		;# max client hops (fast connect/quits)
set tcm:verdela 10		;# ctcp version check delay in sec (avoiding join mute)
set tcm:minstay 20		;# minimum stay period (for detecting hops) in sec
set tcm:maxtime 200		;# maximum time allowed for maxhops (in sec)
set tcm:tkltime 300		;# temporary kline time in mins
set tcm:kreason "cloaked/broken script or drone"
set tcm:passwd "123456"	;# bot's oper password

set tcm:shitver {"*Mardam-Bey*"}

bind raw -	215		tcm:215
bind raw -	NOTICE	tcm:notice
bind time -	"00 02 % % %" tcm:time
bind time -	"% % % % %"	tcm:chkver
bind ctcr -	VERSION	tcm:version
bind evnt -	init-server	tcm:initsrv
bind notc - "*try again*" tcm:again

proc tcm:initsrv {type} {
	catch {unset ::tcm:exempts}
	putquick "STATS i"
}

proc tcm:again {nick uhost hand text dest} {
	if {$dest != $::botnick} return
	if [info exists ::tcm:ctcp($nick)] {
		scan [set ::tcm:ctcp($nick)] "%s %d" host ts
		set ::tcm:ctcp($nick) "$host [unixtime]"
		utimer ${::tcm:verdela} "puthelp \"PRIVMSG $nick :\001VERSION\001\""
	}
}

proc tcm:215 {from keyword text} {
	set text [split $text]
	scan [lindex $text 4] %\[-!+\$%=^><\]%s flags uhost
	if [info exists flags] {
	if {[string first ^ $flags] != -1} {
		set spoof [lindex $text 2]
		if {$spoof == "NOMATCH"} {
			lappend ::tcm:exempts $uhost
		} else {
			if ![string match *@* $spoof] {set spoof *@$spoof}
			lappend ::tcm:exempts $spoof 
		}
	}}
}

proc tcm:version {nick uhost hand dest keyword text} {
	if {$dest != $::botnick} return
	if [info exists ::tcm:ctcp($nick)] {
		foreach ver ${::tcm:shitver} {
			if [string match -nocase $ver $text] return
		}
		scan [set ::tcm:ctcp($nick)] "%s %d" host ts
		if {[unixtime] - $ts < ${::tcm:minstay}} {unset ::tcm:ctcp($nick)}
	}
}

proc tcm:chkver {min hour day month year} {
	if ![info exists ::tcm:ctcp] return
	foreach {nick value} [array get ::tcm:ctcp] {
		scan $value "%s %d" host ts
		if {[unixtime] - $ts > ${::tcm:minstay}} {
			putlog "${::tcm:version}: klining cloaked $host"
			#putquick "KLINE ${::tcm:tkltime} @$host :${::tcm:kreason}"
			unset ::tcm:ctcp($nick)
		}
	}
	if {$min == "00"} {unset ::tcm:ctcp}
}

proc tcm:notice {from keyword text} {
	if ![string equal $from ${::tcm:server}] return
	set text [split $text]
	set what [join [lrange $text 4 5]]
	if {$what == "Client connecting:"} {
		scan [lindex $text 7] (%\[^@\]@%\[^)\] user host
		set ip [string trim [lindex $text 8] \[\]]
		set ::tcm:connects($ip) "$host [unixtime]"
		if ${::tcm:ctcpchk} {
			set nick [lindex $text 6]
			#if [matchattr [finduser $nick!$user@$host] of|of] return
			if [info exists ::tcm:exempts] {
			foreach uhost ${::tcm:exempts} {
				if [string match -nocase $uhost $user@$host] {set found 1}
			}}; if ![info exists found] {
				set ::tcm:ctcp($nick) "$host [unixtime]"
				utimer ${::tcm:verdela} "puthelp \"PRIVMSG $nick :\001VERSION\001\""
			}
		}
	} elseif {$what == "Client exiting:"} {
		set ip [string trim [lindex $text end] \[\]]
		if [info exists ::tcm:connects($ip)] {
			scan [set ::tcm:connects($ip)] "%s %d" host ts
			unset ::tcm:connects($ip)
			if {[unixtime] - $ts < ${::tcm:minstay}} {
				if [info exists ::tcm:drones($ip)] {
					scan [set ::tcm:drones($ip)] "%s %d %d" host ts num
					incr num; set ::tcm:drones($ip) "$host $ts $num"
					if {$num > ${::tcm:maxhops}} {
						unset ::tcm:drones($ip)
						if {[unixtime] - $ts < ${::tcm:maxtime}} {
							putlog "${::tcm:version}: klining hopper $host"
							#putquick "KLINE ${::tcm:tkltime} @$host :${::tcm:kreason}"
						}						
					}
				} else {
					set ::tcm:drones($ip) "$host [unixtime] 1"
				}
			} 
		}
	}
}

proc tcm:time {min hour day month year} {
	if [info exists ::tcm:connects] {unset ::tcm:connects}
	if [info exists ::tcm:drones] {unset ::tcm:drones}
}

if ${server-online} {tcm:initsrv blah}
putlog "Инсталиран: MCT.tcl"