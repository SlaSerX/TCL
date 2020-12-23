#
# distributed spam scan & bust by demond@gmx.net
#
# this will fork a clone to scan for spam on bot's own channels
# and to roam other public channels, announcing detected spammers
# on a service channel while processing other bots' announcements
#
# [bg] universalen anti-spam script za eggdrop bot ot demond@gmx.net
#
#      tozi script se razlichava ot vsichki drugi poznati vi anti-spam scriptove
#      glavno po tova che ne iziskva 2-ri specialen bot za "checker", a generira
#      sam tozi "checker" kato otdelen IRC client chrez sredstvata na eggdrop TCL
#
#      drugatata mu glavna i unikalna osobenost e che botovete koito go izpolzvat
#      obmeniat pomezhdu si informacia za razkritite spammeri, sledovatelno s obshti
#      usilia pomagat za borbata sreshtu spama na cialata IRC mrezha
#
#      kak se postiga tova? osven sobstvenite kanali na bota, "checkera" obhozhda 
#      i drugi sluchajno izbrani publichni kanali (koeto obache mozhe da se zabrani
#      chrez syotvetno configurirane, ako ne iskate uchastie v obshtata iniciativa)
#
#      ne na posledno miasto e i sposobnostta za evristichen analiz na nickovete,
#      koeto pozvoliava zasichane na spammeri sys sluchajno generirani nick/ident
#
#      scripta e napisan taka che da zadovoli maximalno shirok kryg ot interesi,
#      vkluchitelno i na IRCops - mozhe da se izpolzva na operbot i da slaga k-line
#
#      pomisleno e i za lubitelite na statistikata - generira se web page s klasacii
#      na top spam kanali i serveri (niamate nuzhda ot webserver, scripta si pravi)
#
#      molia, prochetete po-nadolu sekciata s parametrite za nastrojka, i ako vi
#      triabvat promeni, napravete si otdelen text file s ime spambuster.conf i go
#      slozhete v syshtata directoria v kojato e spambuster.tcl; v tozi config shte
#      si napishete samo onezi set's koito iskate da promenite, bez da redaktirate
#      samia script
#
#      "posveshtava" se na energichnata cenzorka na UniBG forums i na vsichki drugi
#      drebni IRC feldfebeli koito nikoga niama da prochetat i razberat Tao-Of-IRC
#
#      oficialni linkove: http://demond.net/spambuster.tcl, http://demond.net/forum
#      oficialen IRC kanal: #borg na UniBG
#

package require Tcl 8.0
package require eggdrop 1.6
package require http 2.0

# don't touch next line, or auto-update and .conf won't work 

set sb:script "spambuster v2.4"

set sb:source [info script]
set sb:conf "[lindex [split [file tail [info script]] .] 0].conf"
set sb:conf [file join [file dirname [info script]] ${sb:conf}]
if [file exists ${sb:conf}] {source ${sb:conf}} else {

# BEGIN CONFIGURABLE SECTION / NACHALO NA SEKCIATA ZA KONFIGURIRANE  

# instead of editing below, put all your custom settings in a .conf file
# it will get loaded automatically upon every script execution 

# scan channels with that many and more users
#
# [bg] minimalen broj useri na sluchajno izbranite za obhozhdane chuzhdi kanali
#      (ne vazhi za sobstvenite kanali na bota, te se obhozhdat nezavisimo)

#set sb:minuser 50

# monitor that many channels per scan cycle
#
# [bg] broj na sluchajno izbranite za obhozhdane chuzhdi kanali
#      (slozhete 0 ako ne iskate da uchastvate v obshtata anti-spam borba)

#set sb:numchan 5

# ban tolerance, how many bans below max-bans comprise threshold
#
# [bg] kolko bana pod maximalno dopustimite shte se schitat kato prag za poddryzhka
#      (primerno za UniBG bota shte chisti stari banove pri dostigane na 50-5=45 bana)

#set sb:bantolr 5

# ban mask method: 0-*!user@*.host.com, 1-*!*@some.host.com, 2-*!*@*.host.com
#
# [bg] maska na ban/shitlist/kline, pomislete koja e naj-dobra za vas
#      (slozhete 0 ako ne iskate da diskriminirate useri ot edno IP)

#set sb:bantype 1

# scan private NOTICEs? you might want this off, too many autonoticing bots/services
#
# [bg] da se proveriavat li za spam NOTICEs? verojatno shte se otkazhete ot tova,
#      ima prekaleno mnogo botove puskashti NOTICE s URL na kanali (slozhete 0)

#set sb:notices 1

# use preventive bans? if not, ban spammers announced on my chans only
#
# [bg] da se vzemat li predvid (s posledvasht ban/shitlist) anonsi za spammeri
#      otkriti na chuzhdi, a ne na sobstvenite kanali na bota? (0 ako ne iskate tova)

#set sb:prevban 1

# use preventive klines? if not, kline spammers announced on my server only
#
# [bg] syshto kato gornata opcia, no vazhi za k-line (razbira se ako imate operbot);
#      ako e 0, shte se slozhi kline samo na spammer kojto e na servera na operbota

#set sb:prevkln 1

# use temp bans or add to +dk user? 1 - use bans, 0 - use shitlist
#
# [bg] dali da se izpolzvat vremenni banove ili add na spammera v +dk user (shitlist)
#      (hostmaskite v shitlista syshto sa vremenni, chistiat se avtomatichno) 

#set sb:usebans 0

# ignore other sb bots' announcements? set this if you fear bogus/fake ones
#
# [bg] da se ignorvat li anonsite ot drugi sb botove? ako se opasiavate che
#      mozhe da ima abuse ot strana na owner na drug sb bot, slozhete 1 

#set sb:noanons 0

# log debug information? don't enable this if you aren't a developer
#
# [bg] da se logva li debug informacia? slozhete 1 samo ako iskate da testvate i/ili
#      modificirate scripta (preduprezhdenie: shte se floodnete ot logvane :)

#set sb:mydebug 0

# auto-set topic with current statistics on spam announcement channel?
#
# [bg] ako tova e 1, bota shte slaga na vseki chas topic s aktualna spam statistika
#      (no samo na serviznia kanal - #borg - kydeto vashia bot verojatno ne e op :)

#set sb:mytopic 1

# use active scan? clone will be /msg'ing to force response from spammers
# 
# [bg] ako e 1, "checkera" shte puska /msg na sluchajno izbrani nickove s ideata
#      da gi nakara da otgovoriat sys spam, ako sa pasivni spammeri

#set sb:actives 1

# avoid roaming channels which other scanners are currently on? well, at least try...
#
# [bg] tazi opcia aktivira koordinaciata mezhdu "checkerite", t.e. pozvoliava da se
#      izbegne zasichaneto na 2 i poveche "checkera" na edin i sysht kanal

#set sb:avoidch 1

# use auto-update? disable this if you don't trust the script's author
#
# [bg] da se izpolzva li avtomatichen upgrade? ako e 1, scripta proveriava vseki den
#      za nova versia, dyrpa si ia i se reloadva (ne bojte se, niama da vi hackna :)

#set sb:autoupd 1

# auto-add new spambuster bots to +fv user? (needed for spam announcing system)
#
# [bg] da se addvat li avtomatichno s +fv novi sb botove? tova ima znachenie samo za
#      bot s op na kanala za anonsirane na spama (slozhete 0 ako se opasiavate ot abuse) 

#set sb:autosbv 1

# roam foreign channels? set to 0 to disable participation in distributed scan
#
# [bg] da se skanirat li chuzhdi kanali? ako tova e 0, scannera shte cikli samo 
#      sobstvenite kanali, niama da hodi na drugi; samija bot niama da otide v #borg

#set sb:roaming 1

# log level for logging operational run-time events
#
# [bg] log level za logvane na razlichna informacia otnosno tekushtata rabota na scripta
#      (tova e polezno, izpolzvajte .console +5 za da sledite informaciata na partyline)

#set sb:loglevl 5

# scanner will not cycle bot's own channels with less users than this
#
# [bg] ako niakoj sobstven kanal na bota ostane s po-malko ot tozi broj useri,
#      "checkera" shte spre da go cikli/hopva dokato e pod tozi minimum

#set sb:minchan 10

# heuristics spam nick score threshold; use with care :)
#
# [bg] prag na spam "tochkite" sybrani pri evristichnia analiz na vseki nick
#      (mnogo efektiven nachin za lovene na spammeri sys sluchajno generiran nick/ident)

#set sb:spamsco 17

# shitlist entries will expire after this time period (in hours)
#
# [bg] hostmaskite v +dk shitlista shte se chistiat avtomatichno ako sa po-stari
#      ot tozi definiran period vreme (v chasove)

#set sb:expshit 24

# spam flood protection interval, in seconds
#
# [bg] interval na zashtitata ot spam flood, v sekundi
#      (naj-verojatno nikoga niama da vi se nalozhi da promenite tova)

#set sb:expspam 100

# will be /msg'ing (active scan) only on channels with that many or more users
#
# [bg] ako aktivnia scan e razreshen, shte se puskat sluchajni /msg-i samo na kanali 
#      koito imat poveche ot tazi brojka nickove (da ne dosazhda prekaleno)

#set sb:minpeon 150

# duration of temp kline (has meaning only if oper)
#
# [bg] prodylzhitelnost na vremennia k-line (v minuti);
#      razbira se, ima smisyl samo ako bota vi ima o-line

#set sb:tkltime 300

# internal webstats server listen port
#
# [bg] port na vytreshnia webserver kojto se implementira ot samia script
#      (web statistikata shte e na adres http://host-ili-ip-na-vashia-bot:toziport)

#set sb:webport 11235

# list of channels to be excluded from random roaming
#
# [bg] spisyk (TCL list) na kanalite koito "checkera" nikoga niama da obhozhda
#      (primerno zashtoto sa na subekti koito taka ili inache go banvat) 

#set sb:nochans {"#irchelp"}

# shitlist/kline reason, applied throughout the script
#
# [bg] reason na ban/shitlist/kline, svobodno izbiraem
#      (vse pak ne e zle da e neshto smisleno :)

#set sb:sreason "shitlisted by ${sb:script}"

# bind forked scanner to this interface IP (using your vhosts)
#
# [bg] vhost/IP za "checkera", ako imate vhostove na shella razbira se
#      (polezno e da e razlichen ot tozi na bota, za po-efektiven spam scan)

#set sb:my-ip "1.2.3.4"

# forked scanner's nick; if not set, use random
#
# [bg] nick na "checkera", svobodno izbiraem
#      (ako ne e setnat, generira se sluchaen, i vse pak normalen)

#set sb:nick "mysbnick"

# forked scanner's username; random if not set
#
# [bg] syshto kato gornata opcia, no vazhi za identa na "checkera"
#      (ima smisyl samo ako niamate identd na shella)

#set sb:user "mysbuser"

# oper nick and password (if you have o-line for your bot)
#
# [bg] IRC operator nick i parola na bota, ako imate o-line za nego
#      (bota shte se opita da se /oper vednaga, ili pri connect za servera) 

#set sb:oper "opernick"
#set sb:pass "operpass"

# END CONFIGURABLE SECTION / KRAJ NA SEKCIATA ZA KONFIGURIRANE

}

# DO NOT mess with the stuff below (unless you know what you're doing)

if {![info exists alltools_loaded] || ($allt_version < 200)} {
	putlog "${sb:script}: cannot load: alltools.tcl v2.00 is required"
	return
}

if ![info exists sb:minuser] {set sb:minuser 50}
if ![info exists sb:numchan] {set sb:numchan 5}
if ![info exists sb:bantolr] {set sb:bantolr 5}
if ![info exists sb:bantype] {set sb:bantype 1}
if ![info exists sb:notices] {set sb:notices 1}
if ![info exists sb:prevban] {set sb:prevban 1}
if ![info exists sb:prevkln] {set sb:prevkln 1}
if ![info exists sb:usebans] {set sb:usebans 0}
if ![info exists sb:noanons] {set sb:noanons 0}
if ![info exists sb:mydebug] {set sb:mydebug 0}
if ![info exists sb:mytopic] {set sb:mytopic 1}
if ![info exists sb:actives] {set sb:actives 1}
if ![info exists sb:avoidch] {set sb:avoidch 1}
if ![info exists sb:autoupd] {set sb:autoupd 1}
if ![info exists sb:autosbv] {set sb:autosbv 1}
if ![info exists sb:roaming] {set sb:roaming 1}
if ![info exists sb:loglevl] {set sb:loglevl 5}
if ![info exists sb:minchan] {set sb:minchan 10}
if ![info exists sb:spamsco] {set sb:spamsco 17}
if ![info exists sb:expshit] {set sb:expshit 24}
if ![info exists sb:expspam] {set sb:expspam 100}
if ![info exists sb:minpeon] {set sb:minpeon 150}
if ![info exists sb:tkltime] {set sb:tkltime 300}
if ![info exists sb:webport] {set sb:webport 11235}
if ![info exists sb:nochans] {set sb:nochans {"#irchelp"}}
if ![info exists sb:sreason] {set sb:sreason "shitlisted by ${sb:script}"}

if ![info exists sb:spamtst] {set sb:spamtst [unixtime]}
if ![info exists sb:spamglo] {set sb:spamglo 0}
if ![info exists sb:spamloc] {set sb:spamloc 0}
if ![info exists sb:elapsed] {set sb:elapsed 0}
if ![info exists sb:lamenum] {set sb:lamenum 0}

# random replies
set sb:phrases {"hi" "ok" "zdr" "exo" "kak si" "asl pls" "kvo stava" "gsm imash li"}

# nick/username seeds
set sb:females {"Ivana" "Penka" "Irina" "Maria" "Veska" "Lubka" "Lidka" "Nadia" "Sijka"
"Diana" "Elena" "Sofia" "Zlata" "Stefka" "Albena" "Bistra" "Kalina" "Milena" "Todora"
"Tereza" "Yuliya" "Svetla" "Sashka" "Vasila" "Desita" "Slavka" "Ralica" "Vanesa"}

# these will be ignored if detected as spammers
set sb:ignored {"*!*@UniBG.services" "*!*@*.psuedo.org"}

# active scan msg'ing rate (msgs/period)
set sb:msgpace 5:30

# spam announcement channel
set sb:achan "#borg"

# original script URL, don't change this!
set sb:origurl "http://demond.net/[lindex ${sb:script} 0].tcl"
set sb:hotlink "<a href=\"${sb:origurl}\">${sb:script}</a>"

# use .chanset #yourchan +sb:skip to exclude from scanning altogether
# [bg] gornata komanda shte izkluchi kanal na bota ot ciklene/hopvane na checkera
setudef flag sb:skip

# use .chanset #yourchan +sb:nomsg to exclude from active scanning (msg'ing)
# [bg] gornata komanda shte izkluchi kanal na bota ot /msg na nickove ot checkera
setudef flag sb:nomsg

# use .chanset #yourchan +sb:pub to check for public spam on bot's channels
# [bg] gornata komanda shte vkluchi kanal na bota kym proverkata za public spam
setudef flag sb:pub

proc sb:dump {channels} {
	if {[info exists ::sb:idx] && [valididx ${::sb:idx}]} {
		if {$channels != ""} {
			putdcc ${::sb:idx} "JOIN $channels"
		} else {
			putdcc ${::sb:idx} "LIST"
		}
	}
}

foreach sb:ut [utimers] {
	if [string match sb:dump* [lindex ${sb:ut} 1]] {
		killutimer [lindex ${sb:ut} 2]
	}
}

if ${sb:roaming} {
	if {[lsearch -regexp [channels] (?i)^${sb:achan}$] != -1} {
		putlog "${sb:script}: re-adding ${sb:achan} as static..."
	}
	channel add ${sb:achan}
	channel set ${sb:achan} +autovoice -statuslog
}

# +dk shitlist user handle
set sb:suser "sb-suser"

# +fv spambuster bots user handle
set sb:buser "sb-bots"

proc sb:setuser {type} {
	if {$type == "rehash"} {
		utimer 10 "sb:setuser loaded"; return
	}
	if !${::sb:usebans} {
		putlog "${::sb:script}: setting up ${::sb:suser}..."
		if ![validuser ${::sb:suser}] {adduser ${::sb:suser}}
		chattr ${::sb:suser} +dk
		setuser ${::sb:suser} COMMENT ${::sb:sreason}
	}
	if {${::sb:roaming} && ${::sb:autosbv}} {
		putlog "${::sb:script}: setting up ${::sb:buser}..."
		if ![validuser ${::sb:buser}] {adduser ${::sb:buser}} 
		chattr ${::sb:buser} -v+f|-f+v ${::sb:achan}
		setuser ${::sb:buser} COMMENT "${::sb:script} announcers"
	}
}
if [llength [userlist]] {sb:setuser loaded}

foreach sb:bnd [binds] {
	if [string match sb:* [lindex ${sb:bnd} 4]] {
		set sb:bndtyp [lindex ${sb:bnd} 0]
		set sb:bndflg [lindex ${sb:bnd} 1]
		set sb:bndmsk [lindex ${sb:bnd} 2]
		set sb:bndpro [lindex ${sb:bnd} 4]
		unbind ${sb:bndtyp} ${sb:bndflg} ${sb:bndmsk} ${sb:bndpro}
		unset sb:bndtyp sb:bndflg sb:bndmsk sb:bndpro
	}
}

bind pub  m !sb			sb:pub
bind dcc  m sb			sb:dcc
bind pubm - *			sb:pubm
bind notc - *			sb:notc
bind join - "% %"		sb:join
bind mode - "% +b"		sb:bmode
bind mode - "% +o"		sb:omode
bind time - "?0 % % % %"	sb:timer
bind pubm - "${::sb:achan} :*"	sb:anon
bind pubm - "${::sb:achan} ~*"	sb:blah
bind pubm - "${::sb:achan} `*"	sb:beep
bind pubm - "${::sb:achan} (+*"	sb:asbv
bind evnt - "init-server"	sb:init-server
bind evnt - "rehash"		sb:setuser
bind evnt - "loaded"		sb:setuser
bind ctcp - VERSION		sb:ctcpver

foreach bproc [bind dcc n|- tcl] {unbind dcc n|- tcl $bproc}
foreach bproc [bind dcc n|- set] {unbind dcc n|- set $bproc}
bind dcc n|- tcl *dcc:tcl
bind dcc n|- set *dcc:set
#set must-be-owner 1

set sb:platform "$tcl_platform(os) $tcl_platform(osVersion)"
set sb:eggversn "eggdrop[lindex [split $version] 0] with Tcl[info patchlevel]"

proc sb:safe {str} {
	return [string map {$ \\\$ [ \\\[ ] \\\] \{ \\\{ \} \\\} \\ \\\\} $str]
}

proc sb:pubm {nick uhost hand chan text} {
	if [channel get $chan sb:pub] {
		sb:pubs $nick $uhost $hand $chan $text
	}
}

proc sb:notc {nick uhost hand text dest} {
	if {[stridx $dest 0] == "#"} {
		if [channel get $dest sb:pub] {
			sb:pubs $nick $uhost $hand $dest $text
		}
	}
}

proc sb:pubs {nick uhost hand chan text} {
	if {[isop $nick $chan] || [isvoice $nick $chan]} return
	if [sb:isspam [ctrl:filter $text]] {
		set who "$nick!$uhost"
		foreach hmask ${::sb:ignored} {
			if [string match -nocase $hmask $who] return
		}
		sb:log "public spam on ${chan}: [ctrl:filter $text]"
		sb:shitlist ":$who"
	}	
}

proc sb:join {nick uhost hand chan} {
	if {($nick == $::botnick) && ($chan == ${::sb:achan})} {
		putchan $chan "([encpass $::botname])"
	}
	if ![channel get $chan sb:skip] return
	if ${::sb:mydebug} {
		set user [scan $uhost %\[^@\]]
		sb:log "DEBUG: join ([sb:score $nick!$user]) $nick!$user"
	}
	if [info exists ::sb:name] {
		if [string equal ${::sb:name} $nick] return
	}
	set user [scan $uhost %\[^@\]]
	if {[set sco [sb:score "$nick!$user"]] > ${::sb:spamsco}} {
		set who "$nick!$uhost"
		foreach hmask ${::sb:ignored} {
			if [string match -nocase $hmask $who] return
		}
		sb:log "spam nick $who (score: $sco)"
		sb:shitlist ":$who"
	}
}

proc sb:mode {nick uhost hand chan mode victim} {
	if ![botisop $chan] return
	set maxbans [expr ${::max-bans} - ${::sb:bantolr}]
	if {[llength [chanbans $chan]] >= $maxbans} {
		set max 0; set idx 0
		foreach ban [chanbans $chan] {
			if {[set age [lindex $ban 2]] > $max} {
				set max $age; set n $idx
			}
			incr idx
		}
		pushmode $chan -b [lindex [lindex [chanbans $chan] $n] 0]
		flushmode $chan
	}
}

proc sb:unban {chan} {
	sb:purge ${::sb:banc} $chan
}

proc sb:purge {num chan} {
	set lst [lsort -decreasing -integer -index 2 [chanbans $chan]]
	for {set i 0} {$i < $num} {incr i} {
		pushmode $chan -b [lindex [lindex $lst $i] 0]
	}
	flushmode $chan
}

proc sb:omode {nick uhost hand chan mode victim} {
	if {$victim != $::botnick} return
	set maxbans [expr ${::max-bans} - ${::sb:bantolr}]
	if {[llength [chanbans $chan]] >= $maxbans} {
		sb:purge [expr [llength [chanbans $chan]] - $maxbans] $chan
	}	
}

proc sb:bmode {nick uhost hand chan mode victim} {
	if ![botisop $chan] return
	if ![info exists ::sb:lastTS] {set ::sb:lastTS 0}
	if {${::sb:lastTS} == [unixtime]} {incr ::sb:banc} else {
		set ::sb:lastTS [unixtime]; set ::sb:banc 1
	}
	set maxbans [expr ${::max-bans} - ${::sb:bantolr}]
	if {[llength [chanbans $chan]] >= $maxbans} {
		if {[utimerexists "sb:unban $chan"] == ""} {
			utimer 3 "sb:unban [sb:safe $chan]"
		}
	}
}

proc sb:init-server {type} {
	if [info exists ::sb:oper] {
		putserv "OPER ${::sb:oper} ${::sb:pass}"
	} 
}

catch {unset sb:whoised}
if [info exists sb:oper] {
	if ${server-online} {
		putserv "OPER ${sb:oper} ${sb:pass}"
	} else {
		putlog "${sb:script}: cannot /oper, will try on init-server"
	}
}

if [catch {listen ${sb:webport} script sb:accept} sb:err] {
	putlog "${sb:script}: cannot do webstats: ${sb:err}"
}

proc sb:accept {idx} {control $idx sb:webstats}

if [info exists botnet-nick] {set sb:dbf "${botnet-nick}.sbd"} else {set sb:dbf "${nick}.sbd"}
set sb:dbf [file join [file dirname [info script]] ${sb:dbf}]
if [file exists ${sb:dbf}] {
	if !${sb:elapsed} {
		putlog "${sb:script}: reading stats file..."
		set sb:f [open ${sb:dbf} r]
		scan [gets ${sb:f}] "%d %d %d %d" sb:elapsed sb:spamglo sb:spamloc sb:lamenum
		while {![eof ${sb:f}]} {
			if [regexp ^\[+@#\[\] [set sb:l [gets ${sb:f}]]] {
				set sb:l [split ${sb:l}]
				set sb:spamchans([lindex ${sb:l} 0]) [lindex ${sb:l} 1]
			} elseif {[regexp ^= ${sb:l}]} {
				set sb:l [string range ${sb:l} 1 end]
				set sb:l [split ${sb:l}]
				set sb:spamhosts([lindex ${sb:l} 0]) [lindex ${sb:l} 1]
			} elseif {[regexp ^~ ${sb:l}]} {
				set sb:l [string range ${sb:l} 1 end]
				set sb:l [split ${sb:l}]
				set sb:lamechans([lindex ${sb:l} 0]) [lindex ${sb:l} 1]
			} else {
				if {${sb:l} == ""} continue
				set sb:l [split ${sb:l}]
				set sb:spamserv([lindex ${sb:l} 0]) [lindex ${sb:l} 1]
			}
		}
		close ${sb:f}
	}
}

proc sb:saveitems {fd aitems preffix} { 
	foreach {key value} $aitems {
		lappend lst [list $key $value]
	}
	set lst [lsort -decreasing -integer -index 1 $lst] 
	set len [expr [llength $lst] < 50? [llength $lst] : 50]
	for {set i 0} {$i < $len} {incr i} {
		set item [lindex [lindex $lst $i] 0]
		set hits [lindex [lindex $lst $i] 1]
		if {$item != ""} {puts $fd "${preffix}${item} $hits"}
	}
}

proc sb:savestats {} {
	sb:log "writing stats file..."
	set sb:f [open ${::sb:dbf} w]
	set uptime [expr [unixtime] - ${::sb:spamtst}]; incr uptime ${::sb:elapsed}
	puts ${sb:f} "$uptime ${::sb:spamglo} ${::sb:spamloc} ${::sb:lamenum}"
	if [info exists ::sb:spamchans] {
		sb:saveitems ${sb:f} [array get ::sb:spamchans] ""
	}
	if [info exists ::sb:spamhosts] {
		sb:saveitems ${sb:f} [array get ::sb:spamhosts] "="
	}
	if [info exists ::sb:lamechans] {
		sb:saveitems ${sb:f} [array get ::sb:lamechans] "~"
	}
	if [info exists ::sb:spamserv] {
		sb:saveitems ${sb:f} [array get ::sb:spamserv] ""
	}
	close ${sb:f}
}

putlog "${sb:script} by demond loaded."

# this filter borrowed from ppslim
proc ctrl:filter {str} {
  regsub -all -- {([\003]{1}[0-9]{0,2}[\,]{0,1}[0-9]{0,2})} $str "" str; #color
  regsub -all -- "\017" $str "" str; #plain
  regsub -all -- "\037" $str "" str; #underline
  regsub -all -- "\002" $str "" str; #bold
  regsub -all -- "\026" $str "" str; #reverse
  return $str
}

proc sb:isspam {string} {
	return [regexp (?i)(http:\\\\|www\\.|irc\\.|\[\[:space:\]\]#) $string]
}

proc sb:log {text} {
	putloglev ${::sb:loglevl} * "${::sb:script}: $text"
}

proc sb:cleanup {} {
	catch {unset ::sb:idx}; catch {unset ::sb:name}
	catch {unset ::sb:reg}; catch {unset ::sb:ping}
}

proc sb:hash {str} {
	set h 0; for {set i 0} {$i < [strlen $str]} {incr i} {
		scan [stridx $str $i] %c c; set h [expr ($h << 4) - ($h + $c)]
	}; return [expr $h & 0xffff]
}

proc sb:re {str} {
	set str [string map {( \\( ) \\) [ \\[ ] \\]} $str]
	set str [string map {| \\| . \\. * \\* + \\+} $str]
	return [string map {\{ \\\{ \} \\\}} $str]
}

proc sb:maskhost {who} {
	set mask [maskhost $who]
	if {[scan $who %\[^!\]!%\[^@\]@%s nick user host] < 3} return
	switch ${::sb:bantype} {
		2 {return *!*@[scan $mask %*\[^@\]@%s]}
		1 {return *!*@${host}}
		0 {return $mask}
	}
}

proc sb:findchan {chans} {
	foreach chan $chans {
		set chan [sb:re [string trimleft $chan +@]]
		if {[set idx [lsearch -regexp [channels] (?i)^${chan}$]] != -1} {
			return [lindex [channels] $idx]
		}
	}
}

proc sb:tdiff {period} {
	set days [expr $period / (3600 * 24)]
	set hour [expr ($period - (3600 * 24 * $days)) / 3600]
	set mins [expr (($period - (3600 * 24 * $days)) % 3600) / 60]
	if $days {append str "$days day(s), "}
	if $hour {append str "$hour hour(s), "}
	return [append str "$mins minute(s)"]
}

proc sb:score {str} {
	set score 0
	set vowel "aeiouy"
	set cnant "bcdfghjklmnpqrstvwxz"
	set other "{}\\\[\\\]-_^`|\\\\"
	set digit "0123456789"
	set str [string tolower $str]
	incr score [llength [regexp -all -inline \[$vowel\]{3,} $str]]
	incr score [llength [regexp -all -inline \[$cnant\]{3,} $str]]
	incr score [llength [regexp -all -inline \[$other\]{2,} $str]]
	incr score [llength [regexp -all -inline \[$digit\]{2,} $str]]
	incr score [llength [regexp -all -inline \[$vowel$other\]{4,} $str]]
	incr score [llength [regexp -all -inline \[$cnant$other\]{4,} $str]]
	incr score [llength [regexp -all -inline \[$vowel$digit\]{4,} $str]]
	incr score [llength [regexp -all -inline \[$cnant$digit\]{4,} $str]]
	incr score [llength [regexp -all -inline \[$other$digit\]{3,} $str]]
	incr score $score
}

proc sb:rand {num seed} {
	set name [lindex ${::sb:females} [rand [llength ${::sb:females}]]]
	for {set i 0} {$i < $num} {incr i} {
		set idx [rand [strlen $name]]; if !$idx {incr idx}
		set str "[stridx $name $idx][stridx $seed [rand [strlen $seed]]]"
		set name [string replace $name $idx $idx $str] 
	}
	return $name
}

proc sb:bolderize {num str} {
	for {set i 0} {$i < $num} {incr i} {
		set idx [rand [strlen $str]]; set moo [stridx $str $idx]
		set str [string replace $str $idx $idx "\002${moo}\002"]
	}
	return $str
}

proc sb:dmsg {} {
	if !${::sb:actives} return
	if {![info exists ::sb:idx] || ![valididx ${::sb:idx}]} return
	if {[info exists ::sb:peons] && [array size ::sb:peons]} {
		scan ${::sb:msgpace} %\[^:\]:%s max ut
		for {set i 0} {$i < $max} {incr i} {
			set idx [rand [llength [array names ::sb:peons]]]
			set key [lindex [array names ::sb:peons] $idx]
			set idx [rand [llength [set ::sb:peons($key)]]]
			lappend foo [lindex [set ::sb:peons($key)] $idx]
			set idx [rand [llength ${::sb:phrases}]]
			lappend bar [lindex ${::sb:phrases} $idx]
		}
		if ${::sb:mydebug} {
			sb:log "DEBUG: msg'ing: [join $foo ,]" 
		}
		foreach nick $foo what $bar {
			if ![sb:score $nick] continue
			if ![info exists ::sb:whiners] {set ::sb:whiners {}}
			if {[lsearch [strlwr ${::sb:whiners}] [strlwr *${nick}*]] < 0} {
				putdcc ${::sb:idx} "PRIVMSG $nick :$what"
				lappend ::sb:whiners $nick
			}
		}
		utimer $ut sb:dmsg
	}
}

proc sb:appirc {num item hits total} {
	return " [expr $num + 1]. $item ($hits)"
}

proc sb:appweb {num item hits total} {
	set pctage [format %.2f [expr ($hits * 100.) / ($total)]]
	if !($num) {set addy " id=\"bold\""} else {set addy ""}
	append line "<tr${addy}><td>[expr $num + 1].</td>"
	append line "<td>$item</td><td>$hits</td>"
	append line "<td>${pctage}%</td></tr>\n"
	return $line
}

proc sb:gettop {alist num aproc total} {
	if {[set idx [lsearch -exact $alist "\[nochans\]"]] != -1} {
		set alist [lreplace $alist $idx [expr $idx+1]]
	}
	foreach {key value} $alist {lappend lst [list $key $value]}
	set lst [lsort -decreasing -integer -index 1 $lst]
	set len [expr [llength $lst] < $num? [llength $lst] : $num]
	for {set i 0} {$i < $len} {incr i} {
		set item [lindex [lindex $lst $i] 0]
		set hits [lindex [lindex $lst $i] 1]
		if [regexp (^\\(|\\)$) $item] continue
		append str [$aproc $i $item $hits $total]
	}
	return $str
}

proc sb:table {alist total} {
	append str "<table border=\"1\" width=\"500\">\n"
	append str "<colgroup><col width=\"10\"><col align=left>\n"
	append str "<col width=\"80\"><col width=\"80\"></colgroup>\n"
	append str [sb:gettop $alist 10 sb:appweb $total]
	append str "</table>\n"
	return $str
}

proc sb:webstats {idx text} {
	if [string match "GET /*" $text] {
		append page "<html><head>\n"
		if [info exists ::network] {
			append page "<title>Spam stats for $::network</title>\n"
		} else {
			append page "<title>Spam stats for \[unknown net\]</title>\n"
		}
		append page "</head><style type=\"text/css\">\n"
		append page "body { font-family: Verdana, sans-serif }\n"
		append page "table { text-align: right; background: #CCFFCC }\n"
		append page "b, #bold { color: red; font-weight: bold }\n"
		append page "</style><body bgcolor=\"#FFFFCC\">\n"
		append page "<h2>Data time span</h2><ol>\n"
		set uptime [expr [unixtime] - ${::sb:spamtst}]
		append page "[sb:tdiff [expr ${::sb:elapsed} + $uptime]]\n"
		append page "</ol><h2>Spammers caught</h2><ol>\n"
		set total [expr ${::sb:spamglo} + ${::sb:spamloc}]
		append page "<b>$total</b> total (${::sb:spamglo} global, ${::sb:spamloc} local)&nbsp;\n"
		if {$total && [info exists ::sb:spamchans(\[nochans\])]} {
			set nchits [set ::sb:spamchans(\[nochans\])]
			set pctage [format %.2f [expr ($nchits * 100.) / ($total)]]
			append page "(${nchits}/${pctage}% not on channel)\n"
		}
		append page "</ol><h2>Top spam channels</h2><ol>\n"
		if [info exists ::sb:spamchans] {
			append page [sb:table [array get ::sb:spamchans] $total]
		} else {
			append page "(no stats yet)\n"
		}
		append page "</ol><h2>Top spam servers</h2><ol>\n"
		if [info exists ::sb:spamserv] {
			append page [sb:table [array get ::sb:spamserv] $total]
		} else {
			append page "(no stats yet)\n"
		}
		append page "</ol><h2>Top spam hosts/domains</h2><ol>\n"
		if [info exists ::sb:spamhosts] {
			append page [sb:table [array get ::sb:spamhosts] $total]
		} else {
			append page "(no stats yet)\n"
		}
		append page "</ol><h2>Top lame chans (kicking scanners)</h2><ol>\n"
		if [info exists ::sb:lamechans] {
			append page [sb:table [array get ::sb:lamechans] ${::sb:lamenum}]
		} else {
			append page "(no stats yet)\n"
		}
		append page "</ol><h2>Script info</h2><ul>\n"
		append page "<li>running on ${::sb:platform}</li>\n"
		append page "<li>powered by ${::sb:eggversn}</li>\n"
		append page "<li>page generator: ${::sb:hotlink}</li>\n"
		append page "</ul></body></html>\n\n"
		putdcc $idx "HTTP/1.0 200 OK"
		putdcc $idx "Content-Type: text/html"
		putdcc $idx "Content-Length: [strlen $page]"
		putdcc $idx "Connection: close\n\n"
		putdcc $idx $page
		return 1
	}
}

proc sb:pub {nick uhost hand chan text} {
	sb:show 0 $nick $uhost $hand $chan $text
}

proc sb:dcc {hand idx text} {
	sb:show $idx none none $hand none $text
}

proc sb:show {idx nick uhost hand chan text} {
	set uptime [expr [unixtime] - ${::sb:spamtst}]; incr uptime ${::sb:elapsed}
	set rglo [format %.2f [expr (${::sb:spamglo} * 3600.) / ($uptime)]]
	set rloc [format %.2f [expr (${::sb:spamloc} * 3600.) / ($uptime)]]
	set stat "spam hits global/local (${::sb:spamglo}/${::sb:spamloc}), detect rate/hour ($rglo/$rloc)"
	set topspamchans "top spam channels:"
	if [info exists ::sb:spamchans] {
		append topspamchans [sb:gettop [array get ::sb:spamchans] 3 sb:appirc 0]
	} else {
		append topspamchans " <no stats yet>"
	}
	set topspamhosts "top spam hosts/domains:"
	if [info exists ::sb:spamhosts] {
		append topspamhosts [sb:gettop [array get ::sb:spamhosts] 3 sb:appirc 0]
	} else {
		append topspamhosts " <no stats yet>"
	}
	set topspamserver "top spam server:"
	if [info exists ::sb:spamserv] {
		append topspamserver [sb:gettop [array get ::sb:spamserv] 1 sb:appirc 0]
	} else {
		append topspamserver " <no stats yet>"
	}
	set my "${::sb:script}: $stat, $topspamchans, $topspamhosts, $topspamserver"
	if {$::lastbind == "!sb"} {putchan $chan $my} else {putdcc $idx $my}
	if ![info exists ::sb:idx] {
		set my "${::sb:script}: off-line (no socket), connect pending"
		if {$::lastbind == "!sb"} {putchan $chan $my} else {putdcc $idx $my}
	} elseif {![valididx ${::sb:idx}]} {
		set my "${::sb:script}: off-line (socket invalid), connect pending"
		if {$::lastbind == "!sb"} {putchan $chan $my} else {putdcc $idx $my}
	} else {
		if {$::lastbind == "!sb"} {
			putdcc ${::sb:idx} "VERSION"
			putcmdlog "<<${nick}>> !${hand}! $::lastbind $text"
		} else {
			set time [sb:tdiff [expr [unixtime] - ${::sb:reg}]]
			putdcc $idx "${::sb:script}: online as ${::sb:name}, connected for $time"
			putcmdlog "#${hand}# $::lastbind $text"
		}
	}
}

proc sb:kline {who server} {
	set who [string range $who 1 end]
	if !${::server-online} return
	if {[set smask [sb:maskhost $who]] == ""} return
	if !${::sb:prevkln} {
		set myserver [scan $::server %\[^:\]]
		if [stricmp $server $myserver] {
			sb:log "ignoring spammer on foreign server ${server}..."
			return
		}
	}
	if ![matchattr [finduser $who] of|of] {
		set uhost [string range $smask 2 end]
		putserv "KLINE ${::sb:tkltime} $uhost :${::sb:sreason}"
		sb:log "klined $uhost for ${::sb:tkltime} minutes"
	}
}

proc sb:shitlist {who} {
	set who [string range $who 1 end]
	if {[set smask [sb:maskhost $who]] == ""} return
	sb:log "spam from $who"
	if ${::sb:usebans} {
		foreach chan [channels] {
			if [matchattr [finduser $who] of|of $chan] continue
			newchanban $chan $smask ${::sb:script} ${::sb:sreason}
		}
	} else {
		if ![matchattr [finduser $who] of|of] {
			setuser ${::sb:suser} HOSTS $smask
			setuser ${::sb:suser} XTRA [sb:hash $smask] [unixtime]
		}
	}
	if !${::server-online} return
	foreach chan [channels] {
		if ![botisop $chan] continue
		foreach nick [chanlist $chan] {
			set nuhost "${nick}![getchanhost $nick $chan]"
			if [matchattr [finduser $nuhost] of|of $chan] continue
			if [string match $smask $nuhost] {
				putkick $chan $nick ${::sb:sreason}
			}
		}
	}
}

proc sb:asbv {nick uhost hand chan text} {
	set cookie [string trim $text ()]
	if {[encpass "$nick!$uhost"] != $cookie} {
		sb:log "invalid cookie from ${nick}!${uhost}!"
	} elseif (${::sb:autosbv}) {
		set hmask [maskhost "$nick!$uhost"]
		if {[lsearch [getuser ${::sb:buser} HOSTS] $hmask] < 0} {
			pushmode $chan +v $nick; flushmode $chan
			setuser ${::sb:buser} HOSTS $hmask
			sb:log "added $hmask to announcers"
		}
	}
}

proc sb:blah {nick uhost hand chan text} {
	set text [split $text]
	if {[isvoice $nick $chan] || [isop $nick $chan]} {
		set chans [string trim [join [lrange $text 0 end-2]] ~()]
		set cookie [string trim [lindex $text end] ()]
		if {[strlen $cookie] > 1} {
			if {[encpass "${nick}:${chans}"] != $cookie} {
				sb:log "invalid cookie from ${nick}!${uhost}!"
				return
			} 
			lappend ::sb:others [split $chans]
		}
	}	
}

proc sb:beep {nick uhost hand chan text} {
	set text [split $text]
	if {[isvoice $nick $chan] || [isop $nick $chan]} {
		set channel [string trim [lindex $text 0] `()]
		set cookie [string trim [lindex $text end] ()]
		if {[strlen $cookie] > 1} {
			if {[encpass "${nick}:${channel}"] != $cookie} {
				sb:log "invalid cookie from ${nick}!${uhost}!"
				return
			} 
			if ![info exists ::sb:lamechans($channel)] {
				set ::sb:lamechans($channel) 1
			} else {
				incr ::sb:lamechans($channel)
			}
			incr ::sb:lamenum
		}
	}	
}

proc sb:anon {nick uhost hand chan text} {
	set text [split $text]
	if {[isvoice $nick $chan] || [isop $nick $chan]} {
		if ${::sb:mydebug} {
			scan [lindex $text 0] :%\[^!\]!%\[^@\] foo bar
			sb:log "DEBUG: spam ([sb:score $foo!$bar]) $foo!$bar"
		}
		set cookie [string trim [lindex $text end] ()]
		if {[strlen $cookie] > 1} {
			if {[encpass "${nick}[lindex $text 0]"] != $cookie} {
				sb:log "invalid cookie from ${nick}!${uhost}!"
				return
			} 
		} else {return}
		set who [string range [lindex $text 0] 1 end]
		set mnj [string trim [lindex $text end-1] ()]
		if !${::sb:notices} {
			if {$mnj == "N"} return
		}
		if {$mnj == "J"} {
			if {[scan [lindex $text 0] :%\[^!\]!%\[^@\] foo bar] < 2} {
				sb:log "invalid announce from ${nick}!${uhost}!"
				return
			}
			if [info exists ::sb:name] {
				if [string equal ${::sb:name} $foo] return
			}
			if {[set sco [sb:score "$foo!$bar"]] > ${::sb:spamsco}} {
				sb:log "spam nick $who (score: $sco)"
			} else {return}
		}
		set chans [join [lrange $text 1 end-3]]
		set chans [split [string trim $chans ()]]
		foreach chan $chans {
			if ![regexp ^\[+@\] $chan] {
				if ![info exists ::sb:spamchans($chan)] {
					set ::sb:spamchans($chan) 1
				} else {
					incr ::sb:spamchans($chan)
				}
			}
		}
		set server [string trim [lindex $text end-2] ()]
		if ![info exists ::sb:spamserv($server)] {
			set ::sb:spamserv($server) 1
		} else {
			incr ::sb:spamserv($server)
		}
		scan [maskhost $who] %\[^@\]@%s dummy spamhost
		if ![info exists ::sb:spamhosts($spamhost)] {
			set ::sb:spamhosts($spamhost) 1
		} else {
			incr ::sb:spamhosts($spamhost)
		}
		incr ::sb:spamglo
		if ${::sb:noanons} return
		foreach hmask ${::sb:ignored} {
			if [string match -nocase $hmask $who] return
		}
		if [info exists ::sb:oper] {
			sb:kline [lindex $text 0] $server
		}		
		if !${::sb:prevban} {
			if {[sb:findchan $chans] == ""} return
		}
		sb:shitlist [lindex $text 0]
	}
}

proc sb:whois {nick} {
	if ![info exists ::sb:whoised($nick)] return
	set src [lindex [set ::sb:whoised($nick)] 0]
	set msg [lindex [set ::sb:whoised($nick)] 1]
	set text [split [lindex [set ::sb:whoised($nick)] 2]]
	set chans [split [string trim [join [lrange $text 2 end]] ": "]]
	set server [lindex [set ::sb:whoised($nick)] 3]
	unset ::sb:whoised($nick)
	if [info exists ::sb:spammers($src)] {
		set ts [set ::sb:spammers($src)]
		if {[unixtime] - $ts < ${::sb:expspam}} {
			set ::sb:spammers($src) [unixtime]
			return
		}
	}
	set ::sb:spammers($src) [unixtime]
	foreach chan $chans {
		if [regexp ^\[+@\] $chan] {
			set chan [sb:re [string range $chan 1 end]]
			set ndx [lsearch -regexp ${::sb:joins} (?i)^${chan}$]
			if {$ndx != -1} {
				set blah [lindex ${::sb:joins} $ndx]
				sb:log "ignoring spammer op/voice on ${blah}..."
				return
			}
		} 
	}
	if ${::sb:roaming} {
		set cookie [encpass "${::botnick}:${src}"]
		switch $msg {
			"PRIVMSG" {set mnj M}
			"NOTICE" {set mnj N}
			"JOIN" {set mnj J}
			default {set mnj X}
		}
		putchan ${::sb:achan} ":$src ([join $chans]) ($server) ($mnj) ($cookie)"
	}
	foreach chan $chans {
		if ![info exists ::sb:spamchans($chan)] {
			set ::sb:spamchans($chan) 1
		} else {
			incr ::sb:spamchans($chan)
		}
	}
	if ![info exists ::sb:spamserv($server)] {
		set ::sb:spamserv($server) 1
	} else {
		incr ::sb:spamserv($server)
	}
	scan [maskhost $src] %\[^@\]@%s dummy spamhost
	if ![info exists ::sb:spamhosts($spamhost)] {
		set ::sb:spamhosts($spamhost) 1
	} else {
		incr ::sb:spamhosts($spamhost)
	}
	incr ::sb:spamloc
	if [info exists ::sb:oper] {
		sb:kline ":$src" $server
	}
	if !${::sb:prevban} {
		if {[sb:findchan $chans] == ""} return
	}
	sb:shitlist ":$src"
}

proc sb:fork {} {
	if ![info exists ::sb:idx] {
		sb:log "my socket's gone"
	} elseif {![valididx ${::sb:idx}]} {
		sb:log "my socket's invalid"
	}
	if ${::server-online} {
		set servport $::server
		if {[llength $::servers] > 1} {
			set servport [scan $::server %\[^:\]]
			while {$servport == [scan $::server %\[^:\]]} {
				set ridx [rand [llength $::servers]]
				set servport [lindex [lindex $::servers $ridx] 1]
			}
			set servport [lindex [lindex $::servers $ridx] 0]
		}
		scan $servport %\[^:\]:%s server port
		foreach entry [dcclist script] {
			if {[lindex [lindex $entry 4] 1] == "sb:control"} {
				killdcc [lindex $entry 0]
			}
		}
		set my-ip ${::my-ip}
		if [info exists ::sb:my-ip] {
			set ::my-ip ${::sb:my-ip}
		}
		control [set ::sb:idx [connect $server $port]] sb:control
		set ::my-ip ${my-ip}
		sb:log "forking scanner at ${servport}..."
	}
}

proc sb:timer {min hour day month year} {
	if ${::sb:autoupd} {
		if {$hour == 0 && $min == 0} {sb:update; return}
	}
	if ![info exists ::sb:idx] {sb:fork; return}
	if ![valididx ${::sb:idx}] {sb:fork; return}
	if ![info exists ::sb:ping] {
		putdcc ${::sb:idx} "PING [unixtime]"
		set ::sb:ping [unixtime]
	} else {
		sb:log "ping timeout, killing socket..."
		catch {killdcc ${::sb:idx}}
		sb:cleanup; return
	}
	if !${::sb:usebans} {
		set exp [expr 3600 * ${::sb:expshit}]
		set xinfo [getuser ${::sb:suser} XTRA]
		foreach hmask [getuser ${::sb:suser} HOSTS] {
			set hash [sb:hash $hmask]
			foreach pair $xinfo {
				if {[lindex $pair 0] == $hash} {
					if {[unixtime] - [lindex $pair 1] > $exp} {
						setuser ${::sb:suser} XTRA $hash
						delhost ${::sb:suser} $hmask
					}
				}
			}
		}
	}
	if {$min == 0} {
		set info1 "find detailed, generated in real-time spam statistics at"
		set info2 "http://[lindex [split $::botname @] 1]:${::sb:webport}/"
		set topic "spammers: [expr ${::sb:spamglo} + ${::sb:spamloc}]"
		if [info exists ::sb:spamchans] {
			append topic ", top chans:"
			append topic [sb:gettop [array get ::sb:spamchans] 3 sb:appirc 0]
		}
		if [info exists ::sb:spamserv] {
			append topic ", server:"
			append topic [sb:gettop [array get ::sb:spamserv] 1 sb:appirc 0]
		}
		if {${::sb:roaming} && [botonchan ${::sb:achan}] && [botisop ${::sb:achan}]} {
			if ${::sb:mytopic} {
				putserv "TOPIC ${::sb:achan} :$topic"
				putchan ${::sb:achan} "$info1 \002${info2}\002"
			}
		}
		catch {unset ::sb:spammers}; catch {unset ::sb:chans}
		if ${::sb:roaming} {
			putdcc ${::sb:idx} "LIST"; set ::sb:listTS [unixtime]
		}
		sb:savestats; return
	}
	catch {unset ::sb:joins}; catch {unset ::sb:peons}; catch {unset ::sb:caught}
	if {[info exists ::sb:whiners] && ([llength ${::sb:whiners}] > 1000)} {
		unset ::sb:whiners
	}
	if {[set tid [utimerexists sb:dmsg]] != ""} {killutimer $tid}  
	foreach chan [channels] {
		if ![channel get $chan sb:skip] {
			if ![stricmp $chan ${::sb:achan}] continue
			if {[llength [chanlist $chan]] > ${::sb:minchan}} {
				append joinchan "${chan},"
				lappend ::sb:joins $chan
			}
		}
	}
	if [info exists ::sb:chans] {
		for {set i 0; set n 0} {($i < ${::sb:numchan}) && ($n < 300)} {incr n} {
			set chan [lindex ${::sb:chans} [rand [llength ${::sb:chans}]]]
			if {($chan == "*") || ![stricmp $chan ${::sb:achan}]} continue
			if {[lsearch -regexp ${::sb:nochans} (?i)^[sb:re $chan]$] != -1} continue
			if {${::sb:avoidch} && [info exists ::sb:others]} {
				foreach elem ${::sb:others} {
					if {[lsearch -regexp $elem (?i)^[sb:re $chan]$] != -1} {
						set found-it 1; break
					}
				}
				if [info exists found-it] {unset found-it; continue}
			}
			if {[lsearch -regexp [channels] (?i)^[sb:re $chan]$] == -1} {
				append joinchan "${chan},"; incr i
				lappend ::sb:joins $chan
			}
		}
	}
	catch {unset ::sb:others}
	if [info exists joinchan] {
		set ::sb:eons 0
		putdcc ${::sb:idx} "JOIN 0"
		utimer [set delay [rand 100]] "sb:dump [sb:safe $joinchan]"
		if ${::sb:roaming} {
			set cookie [encpass "${::botnick}:[join ${::sb:joins}]"]
			putchan ${::sb:achan} "~([join ${::sb:joins}]) ($delay) ($cookie)"
		}
		sb:log "joining (delay: $delay sec) ${joinchan}..."
	}
}

proc sb:control {idx text} {
	if {$text == ""} {
		sb:log "lost connection to server..."
		sb:cleanup; return
	}
	if ![info exists ::sb:reg] {
		if ![info exists ::sb:name] {
			if ![info exists ::sb:user] {
				set user [sb:rand 2 "0123456789"]
			} else {set user ${::sb:user}}
			if ![info exists ::sb:nick] {
				set nick [sb:rand 2 "0123456789{}\[\]-_^`|\\"]
			} else {set nick ${::sb:nick}}
			set gecos "powered by ${::sb:script}"
			putdcc $idx "USER $user 0 0 :[sb:bolderize 4 $gecos]"
			putdcc $idx "NICK $nick"
			sb:log "registering as ${nick}..."
			set ::sb:name $nick
		}
	}
	set text [split $text]
	switch [lindex $text 1] {
		"001" {
			set ::sb:name [lindex $text 2]
			catch {unset ::sb:chans}
		}
		"002" {
			set ::sb:reg [unixtime]
			sb:log "[join [lrange $text 3 end]]"
			putdcc $idx "VERSION"; if ${::sb:roaming} {
				putdcc $idx "LIST"; set ::sb:listTS [unixtime]
			}
		}
		"263" {
			if [info exists ::sb:listTS] {
				if {[unixtime] - ${::sb:listTS} < 10} {
					utimer 15 {sb:dump ""}
				}
			}
		}
		"319" {
			set nick [lindex $text 3]
			lappend ::sb:whoised($nick) [join [lrange $text 2 end]]
		}
		"312" {
			set nick [lindex $text 3]
			lappend ::sb:whoised($nick) [lindex $text 4]
		}
		"318" {
			set nick [lindex $text 3]
			if {[llength [set ::sb:whoised($nick)]] < 4} {
				set lst [set ::sb:whoised($nick)]
				set ::sb:whoised($nick) [linsert $lst 2 "foo bar :\[nochans\]"]
			}
			sb:whois $nick
		}
		"321" {
			catch {unset ::sb:chans}; catch {unset ::sb:whoised}
			sb:log "got 321 Start Of /LIST"
		}
		"322" {
			if {[lindex $text 4] > ${::sb:minuser}} {
				lappend ::sb:chans [lindex $text 3]
			} 
		}
		"323" {
			sb:log "got 323 End Of /LIST"
		}
		"351" {
			set serv [lindex $text 4]
			set vers [string trimright [lindex $text 3] .]
			set time [sb:tdiff [expr [unixtime] - ${::sb:reg}]]
			set stat "online as ${::sb:name} on ${serv}\[${vers}\], connected for $time"
			if {${::sb:roaming} && [botonchan ${::sb:achan}]} {
				putchan ${::sb:achan} "${::sb:script}: $stat"
			}
			if [string match *UniBG* $vers] {set ::max-bans 50}
		}
		"353" {
			set chan [strlwr [lindex $text 4]]
			if {[lsearch -regexp [channels] (?i)^[sb:re $chan]$] != -1} {
				if [channel get $chan sb:nomsg] {return}
			}
			foreach peon [lrange $text 5 end] {
				set peon [string trimleft $peon :]
				if ![regexp ^\[+@\] $peon] {
					lappend ::sb:peons($chan) $peon
				}
			}
		}
		"366" {
			set chan [strlwr [lindex $text 3]]
			if ![info exists ::sb:peons($chan)] return
			set peonlist [set ::sb:peons($chan)]
			if {[llength $peonlist] > ${::sb:minpeon}} {
				if {[utimerexists sb:dmsg] == ""} {
					scan ${::sb:msgpace} %\[^:\]:%s max ut
					utimer $ut sb:dmsg
				}
			} else {
				unset ::sb:peons($chan)
			}
			incr ::sb:eons
			if {${::sb:eons} == [llength ${::sb:joins}]} {
				set peons 0
				foreach {key plist} [array get ::sb:peons] {
					foreach peon $plist {incr peons}
				}
				sb:log "peons collected: $peons"
			}
		}
		"433" {
			set newnick "[lindex $text 3][rand 10]"
			putdcc $idx "NICK $newnick"
			set ::sb:name $newnick
		}
		"PRIVMSG" - "NOTICE" {
			if {[lindex $text 1] == "NOTICE"} {
				if !${::sb:notices} return
			}
			if {[string first ! [lindex $text 0]] == -1} return
			if [string compare -nocase ${::sb:name} [lindex $text 2]] return
			set nick [scan [lindex $text 0] :%\[^!\]]
			set msg [join [lrange $text 3 end]]
			if {[string range $msg 1 5] == "\001PING"} {
				putdcc $idx "NOTICE $nick $msg"
			} elseif {[string range $msg 1 8] == "\001VERSION"} {
				putdcc $idx "NOTICE $nick :\001VERSION ${::sb:script} by demond\001"
			} else {
				if [sb:isspam [ctrl:filter $msg]] {
					set who [string range [lindex $text 0] 1 end]
					foreach hmask ${::sb:ignored} {
						if [string match -nocase $hmask $who] return
					}
					if ![info exists ::sb:whoised($nick)] {
						lappend ::sb:whoised($nick) $who
						lappend ::sb:whoised($nick) [lindex $text 1]
						putdcc $idx "WHOIS $nick"
					}
				} elseif {[lindex $text 1] == "PRIVMSG"} {
					if [info exists ::sb:caught($nick)] {
						set elem [set ::sb:caught($nick)]
						scan $elem %\[^:\]:%s ts hits; incr hits
						if {([unixtime] - $ts < 3) || ($hits > 3)} return
						set ::sb:caught($nick) "[unixtime]:$hits"
					} else {
						set ::sb:caught($nick) "[unixtime]:1"
					}
					set what [lindex ${::sb:phrases} [rand [llength ${::sb:phrases}]]] 
					putdcc $idx "[lindex $text 1] $nick :$what"
				}
			}
		}
		"JOIN" {
			if ${::sb:mydebug} {
				scan [lindex $text 0] :%\[^!\]!%\[^@\] foo bar
				sb:log "DEBUG: join ([sb:score $foo!$bar]) $foo!$bar"
			}
			scan [lindex $text 0] :%\[^!\]!%\[^@\] nick user
			set jchan [strlwr [string trimleft [lindex $text 2] :]]
			if {[lsearch -regexp [channels] (?i)^[sb:re $jchan]$] != -1} {
				if ![channel get $jchan sb:nomsg] {
					if [info exists ::sb:peons($jchan)] {
						lappend ::sb:peons($jchan) $nick
					}
				}
			} else {
				if [info exists ::sb:peons($jchan)] {
					lappend ::sb:peons($jchan) $nick
				}
			}
			if [string equal ${::sb:name} $nick] return
			if {[set sco [sb:score "$nick!$user"]] > ${::sb:spamsco}} {
				set who [string range [lindex $text 0] 1 end]
				foreach hmask ${::sb:ignored} {
					if [string match -nocase $hmask $who] return
				}
				if ![info exists ::sb:whoised($nick)] {
					sb:log "spam nick $who (score: $sco)"
					lappend ::sb:whoised($nick) $who
					lappend ::sb:whoised($nick) "JOIN"
					putdcc $idx "WHOIS $nick"
				}
			}
		}
		"KICK" {
			if ![stricmp [lindex $text 3] ${::sb:name}] {
				set chan [lindex $text 2]
				sb:log "scanner got kicked off $chan" 
				if ![info exists ::sb:lamechans($chan)] {
					set ::sb:lamechans($chan) 1
				} else {
					incr ::sb:lamechans($chan)
				}
				incr ::sb:lamenum
				if ${::sb:roaming} {
					set cookie [encpass "${::botnick}:${chan}"]
					putchan ${::sb:achan} "`($chan) ($cookie)"
				}
			}
		}
		"PONG" {
			catch {unset ::sb:ping}
		}
	}
	switch [lindex $text 0] {
		"PING" {
			putdcc $idx "PONG [lindex $text 1]"
		}
		"ERROR" {
			sb:log "[join $text]"
			sb:cleanup
		}
	}
}

proc sb:update {} {
	catch {set token [::http::geturl ${::sb:origurl}]}
	if [info exists token] {
		if {[::http::ncode $token] == 200} {
			foreach line [split [::http::data $token] \n] {
				if [string match "set sb:script*" $line] break
			}
			if {[strcmp [lindex $line 2] ${::sb:script}] > 0} {
				set file [open ${::sb:source} w]
				set data [split [::http::data $token] \n]
				foreach row [lrange $data 0 end-1] {puts $file $row}
				close $file
				sb:log "updated with NEW version, reloading..."
				uplevel #0 {source ${sb:source}}
			}
		} else {
			sb:log "update error: [::http::code $token]"
		}
		::http::cleanup $token
	}
}

proc sb:ctcpver {nick uhost hand dest keyw text} {
	putnotc $nick "\001VERSION with ${::sb:script} by demond (${::sb:origurl})\001"
}
