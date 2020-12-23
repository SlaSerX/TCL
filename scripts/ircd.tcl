package require Tcl 8.0
package require eggdrop 1.6
package require http 2.0

namespace eval ircd {

variable version "FreeUniBG-0.2(10.10.2012)."

if [info exists ::ircd(name)] {variable myname $::ircd(name)} {variable myname "cs-bg.info"}
if [info exists ::ircd(servers)] {variable servers $::ircd(servers)} {variable servers "192.168.1.3:9000:linkme"}
if [info exists ::ircd(servtype)] {variable servtype $::ircd(servtype)} {variable servtype "hybrid7"}
if [info exists ::ircd(servinfo)] {variable servinfo $::ircd(servinfo)} {variable servinfo "PLAY HARD GO PRO!"}
if [info exists ::ircd(floodset)] {variable floodset $::ircd(floodset)} {variable floodset 10:10}
if [info exists ::ircd(pingfreq)] {variable pingfreq $::ircd(pingfreq)} {variable pingfreq 180}
if [info exists ::ircd(connfreq)] {variable connfreq $::ircd(connfreq)} {variable connfreq 60}
if [info exists ::ircd(loglevel)] {variable loglevel $::ircd(loglevel)} {variable loglevel 1}
if [info exists ::ircd(maxrpeat)] {variable maxrpeat $::ircd(maxrpeat)} {variable maxrpeat 10}
if [info exists ::ircd(botattr)] {variable botattr $::ircd(botattr)} {variable botattr "I"}
if [info exists ::ircd(limbo)] {variable limbo $::ircd(limbo)} {variable limbo 0}

if [info exists ::botnet-nick] {variable me ${::botnet-nick}} {variable me $::nick}

if ![info exists connected] {variable connected 0}
if ![info exists serveridx] {variable serveridx -1}

if ![info exists idx] {variable idx -1}

variable source [info script]

if {[catch {setudef flag r:relay}] || [catch {setudef str r:name}]} {
	putlog "${version}: cannot load, setudef cmd absent/bad; upgrade the bot"
	return
}

setudef flag r:relay	;# is relayed
setudef flag r:sts	;# set channel TS
setudef flag r:mod	;# relay mode changes
setudef flag r:tpc	;# relay topic changes
setudef flag r:pub	;# relay public chatter
setudef flag r:say	;# relay public chatter back
setudef flag r:msg	;# relay private messages
setudef str r:name	;# relayed channel name

bind raw	- 329				::ircd::chants
bind time	- "% % % % %"		       ::ircd::timer
bind evnt	- disconnect-server	       ::ircd::disconnect
bind join	- "% %"			::ircd::join
bind part	- "% %"			::ircd::part
bind kick	- "% % *"			::ircd::kick
bind sign	- "% %"			::ircd::quit
bind nick	- "% %"			::ircd::nick
bind mode	- ircd		       	::ircd::mode
bind topc	- ircd			       ::ircd::topic
bind pubm	- "% *"			::ircd::public
bind ctcp	- *				::ircd::action
bind notc	- *				::ircd::notice
bind msgm	- *				::ircd::private
bind bot	- ircd			       ::ircd::bot
bind dcc	n ircd			       ::ircd::dcc

putlog "$version by LuD loaded"

proc log {text} {
	variable loglevel; variable version
	putloglev $loglevel * "${version}: $text" 
}

proc debug {xxx text} {
	variable loglevel; variable version
	putloglev [expr $loglevel + 2] * "${version}: ($xxx) $text"
}

proc isspam {str} {
	set str [string map {"" "" "_" ""} $str]
	return [regexp (?i)(http://|www\\.|irc\\.|\[\[:space:\]\]#) $str]
}

proc lsearch {list elem} {
	return [::lsearch [string tolower [split $list]] [string tolower $elem]]
}

proc fill {char num} {
	for {set i 0} {$i < $num} {incr i} {append str $char}
	return $str
}

proc putdcc {idx text} {
	if $::ircd::limbo return
	::putdcc $idx $text
	debug ">>>" $text
}

proc killdcc {idx} {
	if !$::ircd::limbo {::killdcc $idx}
}

proc valididx {idx} {
	if !$::ircd::limbo {return [::valididx $idx]} else {return 1}
}

proc isflood {nick} {
	variable flood
	scan $::ircd::floodset %\[^:\]:%s threshold period
	lappend flood($nick) [unixtime]
	if {[llength $flood($nick)] > $threshold} {
		set diff [expr [unixtime] - [lindex $flood($nick) 0]]
		unset flood($nick)
		if {$diff < $period} {return 1}
	}
	return 0
}

proc isrepeat {nick msg} {
	variable repeat
	if [info exists repeat($nick)] {
		if [string equal $msg [lindex $repeat($nick) 0]] {
			set num [lindex $repeat($nick) 1]; incr num
			set repeat($nick) [lreplace $repeat($nick) 1 1 $num]
			return [expr $num > $::ircd::maxrpeat? 1 : 0]
		}
	}
	set repeat($nick) [list $msg 1]
	return 0
}

# this filter borrowed from ppslim
proc ctrl:filter {str} {
  regsub -all -- {([\003]{1}[0-9]{0,2}[\,]{0,1}[0-9]{0,2})} $str "" str; #color
  regsub -all -- "\017" $str "" str; #plain
  regsub -all -- "\037" $str "" str; #underline
  regsub -all -- "\002" $str "" str; #bold
  regsub -all -- "\026" $str "" str; #reverse
  return $str
}

proc time2str {period} {
	set days [expr $period / (3600 * 24)]
	set hour [expr ($period - (3600 * 24 * $days)) / 3600]
	set mins [expr (($period - (3600 * 24 * $days)) % 3600) / 60]
	if $days {append str "$days day(s), "}
	if $hour {append str "$hour hour(s), "}
	return [append str "$mins minute(s)"]
}

proc dcc {hand ndx text} {
	variable idx
	variable connected
	set text [split $text]
	set cmd [lindex $text 0]
	switch $cmd {
		"version" {putdcc $ndx $::ircd::version}
		"status" {if $connected {
			if !$::ircd::limbo {
				set period [expr [unixtime] - $::ircd::uptime]
				putdcc $ndx "connected for: [time2str $period]"
				putdcc $ndx "uplink       : $::ircd::uplink"
			} else {putdcc $ndx "operating in limbo"}
			} else {putdcc $ndx "not connected!"}}
		"jump" {if $connected {
				send_but "" "" "disconn"
				if {!$::ircd::limbo && [valididx $idx]} {
					putdcc $idx "ERROR: jumping..."
					killdcc $idx
				}
			}; set connected 0; timer 00 x x x x}
		default {
			putdcc $ndx "usage: .ircd \[version|status|jump\]"
			set invalid 1
		}
	}
	if ![info exists invalid] {return 1}
}

proc introduce_server {host port password} {
	variable connected
	variable idx; variable myname
	if ![valididx $idx] return
	set connected 1; variable gotpong 0
	log "connected to $host:$port, introducing myself..."
	switch $::ircd::servtype {
		"hybrid6" {putdcc $idx "PASS $password :TS"}
		"hybrid7" {putdcc $idx "PASS $password :TS"; putdcc $idx "CAPAB :LL"}
		"unreal"  {putdcc $idx "PASS :$password"; putdcc $idx "PROTOCTL SJOIN"}
		default {
			log "invalid ircd(servtype)! bailing out..."
			set connected 0; killdcc $idx
			return
		}
	}
	putdcc $idx "SERVER $myname 1 :$::ircd::servinfo"
	putdcc $idx "PING :$myname"
       putdcc $idx "VERSION :$myname"
       putdcc $idx "TIME :$myname"
}

proc disconnect {event} {
	variable idx; variable connected
	send_but "" "" "disconn"
	if ![valididx $idx] return
	if $connected {
		if !$::ircd::limbo {
			log "disconnected! squiting uplink..."
		}
		putdcc $idx "ERROR :got disconnected from bot server"
		set connected 0
		killdcc $idx
	}
}

proc chants {from keyword text} {
	variable ts
	set text [split $text]
	set timestamp [lindex $text 2]
	set channel [lindex $text 1]
	set ts($channel) $timestamp
}

proc map {mchan} {
	foreach chan [channels] {
		set chans [channel get $chan r:name]
		if {$chans == ""} {set chans [list $chan]} else {set chans [split $chans]}
		if {[lsearch $chans $mchan] != -1} {return $chan}
	}
	return "nonexistent!"
}

proc which {chan nick remove} {
	variable nicks; variable cha
	set chans [channel get $chan r:name]
	if {$chans == ""} {set chans [list $chan]} else {set chans [split $chans]}
	foreach achan $chans {
		if ![info exists cha($achan)] continue
		if {[set ndx [lsearch $cha($achan) $nick]] != -1} {
			if !$remove {return $achan} else {
				if ![info exists rchan] {set rchan $achan}
				set cha($achan) [lreplace $cha($achan) $ndx $ndx]
			}
		}
	}
	if !$remove {return "nonexistent!"}; set more 0
	foreach {key nlist} [array get cha] {
		if {[set ndx [lsearch $nlist $nick]] != -1} {set more 1}
	}
	if {!$more && [set ndx [lsearch $nicks $nick]] != -1} {
		set nicks [lreplace $nicks $ndx $ndx]
	}
	if [info exists rchan] {return $rchan} else {return $chan}
}

proc remove {chan nick} {
	variable nicks; variable cha
	if ![info exists cha($chan)] {return 0}
	if {[set ndx [lsearch $cha($chan) $nick]] != -1} {
		set cha($chan) [lreplace $cha($chan) $ndx $ndx]
		set more 0
		foreach {key nlist} [array get cha] {
			if {[set ndx [lsearch $nlist $nick]] != -1} {set more 1}
		}
		if {!$more && [set ndx [lsearch $nicks $nick]] != -1} {
			set nicks [lreplace $nicks $ndx $ndx]
			return 1
		}
	}
	return 0
}

proc join {nick uhost hand chan} {
	variable idx; variable nicks
	variable myname; variable cha
	if ![valididx $idx] return
	if ![channel get $chan r:relay] return
	if {!$::ircd::connected || $nick == $::botnick} return
	if {[lsearch $nicks $nick] == -1} {
		lappend nicks $nick; set uhost [getchanhost $nick $chan]
		if {$::ircd::servtype == "unreal"} {set umode ""} else {set umode "+i"}
		set buf "NICK $nick 1 [unixtime] $umode [::join [split $uhost @]] $myname :$nick"
		putdcc $idx $buf; send_but "" "" "clnt $buf"
	}
	set chans [channel get $chan r:name]
	if {$chans == ""} {set chans [list $chan]} else {set chans [split $chans]}
	set time [getchanjoin $::botnick $chan]
	set achan [lindex $chans [rand [llength $chans]]]
	if [info exists cha($achan)] {
		if {[lsearch $cha($achan) $nick] != -1} return
	}
	set buf ":$myname SJOIN $time $achan [getchanmode $chan] :$nick"
	putdcc $idx $buf; send_but "" "" "sjoin $buf"
	lappend cha($achan) $nick
}

proc part {nick uhost hand chan msg} {
	variable idx; variable nicks
	if ![valididx $idx] return
	if ![channel get $chan r:relay] return
	if {!$::ircd::connected || $nick == $::botnick} return
	set buf ":$nick PART [which $chan $nick 1] :$msg"
	putdcc $idx $buf; send_but "" "" "part $buf"
	if {[lsearch $nicks $nick] == -1} {
		set buf ":$nick QUIT :parted all channels"
		putdcc $idx $buf; send_but "" "" "quit $buf"
	}
}

proc kick {nick uhost hand chan victim reason} {
	variable idx; variable nicks
	if ![valididx $idx] return
	if ![channel get $chan r:relay] return
	if {!$::ircd::connected || $nick == $::botnick || $victim == $::botnick} return
	set buf ":$nick KICK [which $chan $victim 1] $victim :$reason"
	putdcc $idx $buf; send_but "" "" "kick $buf"
	if {[lsearch $nicks $victim] == -1} {
		set buf ":$victim QUIT :Read error: Connection reset by peer"
		putdcc $idx $buf; send_but "" "" "quit $buf"
	}
}

proc quit {nick uhost hand chan reason} {
	variable idx; variable nicks
	variable myname; variable cha
	if ![valididx $idx] return
	if ![channel get $chan r:relay] return
	if {!$::ircd::connected || $nick == $::botnick} return
	set buf ":$nick QUIT :$reason"
	putdcc $idx $buf; send_but "" "" "quit $buf"
	foreach {key nlist} [array get cha] {
		if {[set ndx [lsearch $nlist $nick]] != -1} {
			set cha($key) [lreplace $cha($key) $ndx $ndx]
		}
	}
	if {[set ndx [lsearch $nicks $nick]] != -1} {
		set nicks [lreplace $nicks $ndx $ndx]
	}
}

proc nick {nick uhost hand chan newnick} {
	variable idx; variable nicks
	variable myname; variable cha
	if ![valididx $idx] return
	if ![channel get $chan r:relay] return
	if {!$::ircd::connected || $nick == $::botnick} return
	set buf ":$nick NICK $newnick :[unixtime]"
	putdcc $idx $buf; send_but "" "" "nick $buf"
	foreach {key nlist} [array get cha] {
		if {[set ndx [lsearch $nlist $nick]] != -1} {
			set cha($key) [lreplace $cha($key) $ndx $ndx $newnick]
		}
	}
	if {[set ndx [lsearch $nicks $nick]] != -1} {
		set nicks [lreplace $nicks $ndx $ndx $newnick]
	}
}

proc mode {nick uhost hand chan change victim} {
	variable idx; variable nicks
	if ![valididx $idx] return
	if {![channel get $chan r:relay] || ![channel get $chan r:mod]} return
	if {!$::ircd::connected || $nick == $::botnick} return
	set buf ":$nick MODE [which $chan $nick 0] $change $victim"
	putdcc $idx $buf; send_but "" "" "mode $buf"
}

proc topic {nick uhost hand chan topic} {
	variable idx; variable nicks
	if ![valididx $idx] return
	if {![channel get $chan r:relay] || ![channel get $chan r:tpc]} return
	if {!$::ircd::connected || $nick == $::botnick} return
	set buf ":$nick TOPIC [which $chan $nick 0] :$topic"
	putdcc $idx $buf; send_but "" "" "topic $buf"
}

proc public {nick uhost hand chan text} {
	variable idx; variable nicks
	if ![valididx $idx] return
	if {![channel get $chan r:relay] || ![channel get $chan r:pub]} return
	if {!$::ircd::connected || $nick == $::botnick} return
	set buf ":$nick PRIVMSG [which $chan $nick 0] :$text"
	putdcc $idx $buf; send_but "" "" "public $buf"
}

proc action {nick uhost hand dest ctcp text} {
	variable idx; variable nicks
	if ![valididx $idx] return
	if {$dest == $::botnick} return; set chan $dest
	if {![channel get $chan r:relay] || ![channel get $chan r:pub]} return
	if {!$::ircd::connected || $nick == $::botnick} return
	set buf ":$nick PRIVMSG [which $chan $nick 0] :\001$ctcp $text\001"
	putdcc $idx $buf; send_but "" "" "action $buf"
}

proc notice {nick uhost hand text dest} {
	variable idx; variable nicks
	if ![valididx $idx] return
	if {$dest == $::botnick} return; set chan $dest
	if {![channel get $chan r:relay] || ![channel get $chan r:pub]} return
	if {!$::ircd::connected || $nick == $::botnick} return
	set buf ":$nick NOTICE [which $chan $nick 0] :$text"
	putdcc $idx $buf; send_but "" "" "notice $buf"
}

proc private {nick uhost hand text} {
	variable assoc; variable bots
	variable idx; variable nicks
	if ![valididx $idx] return
	foreach chan [channels] {if [onchan $nick $chan] {set achan $chan}}
	if {[info exists achan] && ![channel get $achan r:msg]} return
	set anick [string tolower $nick]
	if [info exists assoc($anick)] {
		if ![llength $assoc($anick)] return
		foreach peon $assoc($anick) {
			if [string match -nocase *${peon}* $text] {
				set ndx [lsearch $assoc($anick) $peon]
				set assoc($anick) [lreplace $assoc($anick) $ndx $ndx]
				set direct 1; break
			}
		}
		if ![info exists direct] {
			set peon [lindex $assoc($anick) end]
			set assoc($anick) [lreplace $assoc($anick) end end]
		}
		spylog $nick $peon $text
		set buf ":$nick PRIVMSG $peon :$text"
		if [info exists bots] {
			foreach {bot nlist} [array get bots] {
				if {[lsearch $nlist $peon] != -1} {set remote $bot}
			}
			if [info exists remote] {
				putbot $remote "ircd $::ircd::me $remote private $buf"
				return
			}
		}
		putdcc $idx $buf
	}
}

proc spylog {from to text} {
	set str [format "%12s -> %-12s: %s" $from $to $text]
	putloglev [expr $::ircd::loglevel + 1] * "spy: $str"
}

proc bot {from command text} {
	variable assoc
	variable botattr; variable myname
	variable idx; variable bots; variable me
	if ![matchattr $from $botattr] return
	set text [split $text]
	set source [lindex $text 0]
	set target [lindex $text 1]
	set what [lindex $text 2]
	if {$target == "(all)"} {
		send_but $from $command [::join $text]
	}
	if ![matchattr $source $botattr] return
	switch $what {	
		"connect" {burst_to $source}
		"disconn" {
			if {!$::ircd::connected || ![valididx $idx]} return
			if [info exists bots($source)] {
				foreach nick $bots($source) {
					putdcc $idx ":$nick QUIT :remote bot got disconnected"
				}
				unset bots($source)
			}
		}
		"talk" {
			set src [lindex $text 4]
			set dest [lindex $text 5]
			set what [lindex $text 3]
			set msg [::join [lrange $text 6 end]]
			if [info exists bots($source)] {
			if {[lsearch $bots($source) $src] == -1} {
				lappend bots($source) $src
			}} else {lappend bots($source) $src}
			if {[string index $msg 0] != "\001"} {set pref "<$src> "} else {set pref ""}
			if {[string index $dest 0] == "#"} {
				set dest [map $dest]; if ![channel get $dest r:say] return
			} elseif {[onchan $dest]} {
				foreach chan [channels] {
					if {[onchan $dest $chan] && ![channel get $chan r:msg]} return
				}
				lappend assoc([string tolower $dest]) $src
				spylog $src $dest $msg
			}
			puthelp "$what $dest :$pref$msg"
		}
		"clnt" {
			set nick [lindex $text 4]
			if {!$::ircd::connected || ![valididx $idx]} return
			if {![info exists bots($source)] || [lsearch $bots($source) $nick] == -1} {
				if {[lsearch $::ircd::nicks $nick] == -1} {
					lappend bots($source) $nick
					set umode [lindex $text 7]
					if {[string index $umode 0] == "+"} {
						if {$::ircd::servtype == "unreal"} {set text [lreplace $text 7 7 ""]}
					} else {
						if {$::ircd::servtype != "unreal"} {set text [lreplace $text 7 7 "+i"]}
					}
					set text [lreplace $text 10 10 $myname]
					putdcc $idx [::join [lrange $text 3 end]]
				}
			}
		}
		"sjoin" {
			if {!$::ircd::connected || ![valididx $idx]} return
			set text [lreplace $text 3 3 ":$myname"]
			putdcc $idx [::join [lrange $text 3 end]]
		}
		default {
			if {!$::ircd::connected || ![valididx $idx]} return
			if {$what == "private"} {
				set msg [string trimleft [::join [lrange $text 6 end]] :]
				set src [string trimleft [lindex $text 3] :]
				set dest [lindex $text 5]
				spylog $src $dest $msg
			}
			putdcc $idx [::join [lrange $text 3 end]]
		}
	}
}

proc send_but {from command text} {
	variable me; variable botattr
	foreach record [botlist] {
		set bot [lindex $record 0]
		set uplink [lindex $record 1]
		if {$bot != $from && $uplink == $me && [matchattr $bot $botattr]} {
			if {$command == ""} {
				putbot $bot "ircd $me (all) $text"
			} else {
				putbot $bot "$command $text"
			}
		}
	}
}

proc burst_to {target} {
	variable myname; variable me
	variable nicks; variable cha
	if [info exists nicks] {foreach nick $nicks {
		if {[set uhost [getchanhost $nick]] != ""} {
			if {$::ircd::servtype == "unreal"} {set umode ""} else {set umode "+i"}
			set buf "NICK $nick 1 [unixtime] $umode [::join [split $uhost @]] $myname :$nick"
			putbot $target "ircd $me $target clnt $buf"
		}
	}}
	if [info exists cha] {foreach {key nlist} [array get cha] {
		set chan $key
		foreach nick $nlist {
			lappend dozen $nick
			if {[llength $dozen] == 12} {
				set buf ":$myname SJOIN [unixtime] $chan + :[::join $dozen]"
				putbot $target "ircd $me $target sjoin $buf"
				unset dozen
			}
		}
		if [info exists dozen] {
			set buf ":$myname SJOIN [unixtime] $chan + :[::join $dozen]"
			putbot $target "ircd $me $target sjoin $buf"
			unset dozen
		}
	}}
}

proc burst {} {
	variable repeat
	variable myname; variable cha
	variable idx; variable nicks {}
	variable assoc; variable flood; variable bots
	if {!$::ircd::connected || ![valididx $idx]} return
	catch {unset cha; unset bots; unset assoc; unset flood; unset repeat}
	log "bursting clients/channels/modes..."
	foreach chan [channels] {
		if ![botonchan $chan] continue
		if ![channel get $chan r:relay] continue
		set sts [channel get $chan r:sts]
		set cts [info exists ::ircd::ts($chan)]
		if {$sts} {set mode [getchanmode $chan]} else {set mode "+"}
		if {$sts && $cts} {
			set time [set ::ircd::ts($chan)]
		} else {
			set time [getchanjoin $::botnick $chan]
		}
		set chans [channel get $chan r:name]
		if {$chans == ""} {set chans [list $chan]} else {set chans [split $chans]}
		foreach rchan $chans {
			if ![info exists cha($rchan)] {set cha($rchan) {}}
		}
		foreach nick [chanlist $chan] {
			if {$nick == $::botnick} continue
			if {[lsearch $nicks $nick] == -1} {
				lappend nicks $nick; set uhost [getchanhost $nick $chan]
				if {$::ircd::servtype == "unreal"} {set umode ""} else {set umode "+i"}
				set buf "NICK $nick 1 [unixtime] $umode [::join [split $uhost @]] $myname :$nick"
				putdcc $idx $buf; send_but "" "" "clnt $buf"
			}
			set pref ""; if [isvoice $nick $chan] {append pref +}
			if [ishalfop $nick $chan] {append pref %}
			if [isop $nick $chan] {append pref @}
			lappend dozen "$pref$nick"
			if {[llength $dozen] == 12} {
				set achan [lindex $chans [rand [llength $chans]]]
				set buf ":$myname SJOIN $time $achan $mode :[::join $dozen]"
				putdcc $idx $buf; send_but "" "" "sjoin $buf"
				foreach elem $dozen {lappend cha($achan) [string trimleft $elem +%@]}
				unset dozen
			}
		}
		if [info exists dozen] {
			set achan [lindex $chans [rand [llength $chans]]]
			set buf ":$myname SJOIN $time $achan $mode :[::join $dozen]"
			putdcc $idx $buf; send_but "" "" "sjoin $buf"
			foreach elem $dozen {lappend cha($achan) [string trimleft $elem +%@]}
			unset dozen
		}
		if ![channel get $chan r:mod] continue
		foreach rchan $chans {
			foreach ban [chanbans $chan] {
				lappend dozen [lindex $ban 0]
				if {[llength $dozen] == ${::modes-per-line}} {
					set buf ":$myname MODE $rchan +[fill b [llength $dozen]] [::join $dozen]"
					putdcc $idx $buf; send_but "" "" "mode $buf"
					unset dozen
				}
			}
			if [info exists dozen] {
				set buf ":$myname MODE $rchan +[fill b [llength $dozen]] [::join $dozen]"
				putdcc $idx $buf; send_but "" "" "mode $buf"
				unset dozen
			}
		}
	}
}

proc timer {min hour day month year} {
	variable idx; variable connected
	variable servers; variable serveridx
	variable pingfreq; variable connfreq
	if {$pingfreq < 60} {set pingfreq 60}
	if {$connfreq < 60} {set connfreq 60}
	if {$min == "00" && $hour == "01"} {update; return}
	if {$min != "00"} {set min [string trimleft $min 0]}
	if {!$connected && ($min % ($connfreq / 60)) == 0} {
		set servers [split $servers]
		if {!${::server-online} || [unixtime] - ${::server-online} < 60} return
		if {[incr serveridx] == [llength $servers]} {set serveridx 0}
		scan [lindex $servers $serveridx] %\[^:\]:%\[^:\]:%s host port password
		if !$::ircd::limbo {
			if [catch {set idx [connect $host $port]}] {
				log "cannot connect to $host:$port, DNS lookup failed"
			} else {
				variable uptime [unixtime]
				control $idx ::ircd::handler
			}
		} else {
			log "reconnected as limbo, setting flag..."
			set connected 1; burst
			send_but "" "" "connect"
		}
	} elseif {!$::ircd::limbo && $connected && ($min % ($pingfreq / 60)) == 0} {
		if ![valididx $idx] return
		if !$::ircd::gotpong {
			log "ping timeout to $::ircd::uplink, disconnecting..."
			putdcc $idx "ERROR :ping timeout, disconnected"
			set connected 0
			killdcc $idx
		} else {
			putdcc $idx "PING :$::ircd::myname"
			variable gotpong 0 
		}
	}
}

proc handler {idx text} {
	variable assoc; variable bots
	variable myname; variable connected
	variable servers; variable serveridx
	if {$text == ""} {
		log "lost connection to uplink..."
		set connected 0; return
	}
	if !$connected {
		scan [lindex $servers $serveridx] %\[^:\]:%\[^:\]:%s host port password
		introduce_server $host $port $password
		burst; send_but "" "" "connect"
		return
	}
	debug "<<<" $text
	set text [split $text]
	switch [lindex $text 1] {
#		"PRIVMSG" - "NOTICE"
		"PRIVMSG" {
			set what [lindex $text 1]
			set dest [lindex $text 2]
			set src [string trimleft [lindex $text 0] :]
			set msg [string trimleft [::join [lrange $text 3 end]] :]
			if {[isflood $src] || [isrepeat $src $msg]} {
				putdcc $idx ":$myname NOTICE $src :don't flood or/and repeat, numbnut"
				return
			}
			if [isspam [set msg [ctrl:filter $msg]]] return
			if {[string index $msg 0] != "\001"} {set from "<$src> "} else {
				if {[string range $msg 1 4] == "PING" && [string index $dest 0] != "#"} {
					putdcc $idx ":$dest NOTICE $src :$msg"
				}; set from ""
			}
			if [info exists bots] {foreach {bot nlist} [array get bots] {
				if {[lsearch $nlist $dest] != -1} {set remote $bot}
			}}
			if [info exists remote] {
				if {[string index $dest 0] != "#"} {
					spylog $src $dest $msg
				}
				putbot $remote "ircd $::ircd::me $remote talk $what $src $dest $msg"
			} else {
				if {[string index $dest 0] == "#"} {
					set dest [map $dest]; if ![channel get $dest r:say] return
				} elseif {[onchan $dest]} {
					foreach chan [channels] {
						if {[onchan $dest $chan] && ![channel get $chan r:msg]} return
					}
					lappend assoc([string tolower $dest]) $src
					spylog $src $dest $msg
				}
				puthelp "$what $dest :$from$msg"
			}
		}
		"KILL" {
			variable nicks; variable cha
			foreach {key nlist} [array get cha] {
				if {[set ndx [lsearch $nlist [lindex $text 2]]] != -1} {
					set cha($key) [lreplace $cha($key) $ndx $ndx]
				}
			}
			if {[set ndx [lsearch $nicks [lindex $text 2]]] != -1} {
				set nicks [lreplace $nicks $ndx $ndx]
			}
		}
		"KICK" {
			if [remove [lindex $text 2] [lindex $text 3]] {
				putdcc $idx ":[lindex $text 3] QUIT :kicked on uplink"
			}
		}
		"VERSION" {
			set target [string trimleft [lindex $text 0] :]
			putdcc $idx ":$myname 351 $target $::ircd::version $myname :FreeUniBG-0.1"
		}
		"PING" {
			set target [lindex $text 2]
			putdcc $idx ":$myname PONG $myname $target"
		}
		"PONG" {
			set source [string trimleft [lindex $text 0] :]
			if {$source == $::ircd::uplink} {variable gotpong 1}
		}
	}
	switch [lindex $text 0] {
		"SERVER" {
			if {[lindex $text 2] == "1"} {variable uplink [lindex $text 1]}
		}
		"PING" {
			set target [lindex $text 1]
			putdcc $idx ":$myname PONG $myname $target"
		}
		"ERROR" {
			log "uplink closed connection: $text"
			set connected 0; return 1
		}
	}
}

proc update {} {
	variable version
	set url "http://demond.net/[lindex [split $version -] 0].tcl"
	catch {set token [::http::geturl $url]}
	if [info exists token] {
		if {[::http::ncode $token] == 200} {
			foreach line [split [::http::data $token] \n] {
				if [string match "variable version *" $line] break
			}
			if {[string compare [lindex $line 2] $version] > 0} {
				set file [open $::ircd::source w]
				set data [split [::http::data $token] \n]
				foreach line [lrange $data 0 end-1] {puts $file $line}
				close $file
				log "updated with NEW version, reloading..."
				uplevel #0 {source $::ircd::source}
			}
		} else {
			log "update error: [::http::code $token]"
		}
		::http::cleanup $token
	}
}

}
