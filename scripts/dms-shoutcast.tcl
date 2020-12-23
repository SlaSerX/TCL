# DMS-Shoutcast.tcl v1.3.2 (c)  DMS <dms@electronic-culture.de> '2004
#
# Kritik und Anregungen gerne an mich.
#
# Diese TCL befaehigt euren Eggdrop Informationen ueber das aktuelle Programm eueres Shoutcast-Servers zu Informieren
#
# Folgende Informationen koennen angezeigt werden:
#    - Streaminfo (URL z.B.) [!stream]
#    - den aktuellen Song [!song]
#    - die Anzahl der Hoerer [!listener]
#    - den Moderator (soweit im IRC gesetzt) [!mod, !setmod]
#    - den Namen der Show (soweit im IRC gesetzt) [!show, !setshow]
#    - Info mit Show, Moderator, Song, Bitrate, Hoererzahl und Streaminfo [!info]
#
# Show und Moderator koennen (z.B. ueber php) an eine Website uebergeben werden
#
# Um einem Radioadmin die moeglichkeit zu geben einen Moderator oder eine Show zu setzen, muß ihm ein D Flag im eggdrop hinzugefuegt werden
# (.chattr name +D)
#
# Dieses skript benoetigt Lynx um die Daten abzufragen. Diese Variante wurde gewaehlt, 
# weil die Nutzung von Socks-Verbindungen auf einigen Netzwerken  zu einem "Ping Timeout" des Eggdrops fuehren kanne,
# wenn der Server mal nicht erreichbar ist.
#
#
# Einstellungen in der conf:
#    streamurl - URL des Radioservers
#    streamport - Baseport des Radioservers
#    streampass - Passwort zum streamen (sollte auf der Partyline (oder in den logs) Fehlermeldungen erscheinen, 
#                 die auf einen fehlerhaften Login hindeuten, so muß hier moeglicherweise das Admin Passwort eingetragen werden
#    streamInfo - Zeile, die bei Nutzung des Triggers !stream angezeigt werden soll. (Sinnvollerweise die URL)
#    radiochans - Channel in denen die Trigger zur Verfuegung stehen sollen, und in denen das Online und Offline gehen angezeigt werden sollen getrennt durch Leerzeichen
#    offlineText - Text der angezeigt werden soll, wenn der Server offline geht
#    onlineText - Text der angezeigt werden soll, wenn der Server online geht
#    allLine - Text der beim Trigger !info angezeigt werden soll
#    showline - Text der beim Trigger !show angezeigt werden soll
#    modline - Text der beim Trigger !mod angezeigt werden soll
#    setshowPHP - wenn angegeben wird beim aufruf von !setshow die show an die angegebene php-url übermittelt
#    setmodPHP - wenn angegeben wird beim aufruf von !setmod der mod an die angegebene php-url übermittelt
#
# 

set conf "dms-shoutcast.conf"

################### DON'T EDIT BELOW IF YOU DON'T KNOW WHAT YOU DO ########################

set currentListener ""
set peakListener ""
set maxListener ""
set reportedListener ""
set averageTime ""
set songTitle ""
set streamState 99
set bitrate 0

bind pub - !stream show_streaminfo
bind pub - !listener show_listener
bind pub - !song show_song
bind pub - !show show_show
bind pub - !mod show_mod
bind pub - !info show_info
bind pub - !streamhelp printhelp
bind pub D !setmod set_mod
bind pub D !setshow set_show
bind msg D !check shout_check
bind pub D !setsong set_song
bind pub - !stream_url send_url
bind msg - !stream_url send_url_priv

bind time - "?0 * * * *" check_online
bind time - "?5 * * *" check_online

set streamurl "http://192.168.1.3"
set streamport 8080
set streampass "lamzo123"
set streamInfo ""

set radioChans "#SF"
set offlineText ""
set onlineText ""

set listenerLine ""
set songLine ""
set allLine ""
set showLine ""
set modLine ""

set setshowPHP ""
set setmodPHP ""

proc send_url {nick uhost hand chan arg} {
	putlog "$nick requested url"
	global streamurl streamport
	putserv "PRIVMSG $nick : $streamurl:$streamport"
}

proc send_url_priv { nick uhost hand arg} {
	send_url $nick $uhost $hand $nick $arg
}



proc printhelp {nick uhost hand chan arg} {
	global DMSShoutcastVersion
	putserv "PRIVMSG $nick :- available trigger for DMS-Shoutcast $DMSShoutcastVersion © DMS '04 -"
	putserv "PRIVMSG $nick :\003\002!streamhelp\002 - show this help"
	putserv "PRIVMSG $nick :\003\002!stream\002 - show streaminfo"
	putserv "PRIVMSG $nick :\003\002!stream_url\002 - show clear stream url without pls"
	putserv "PRIVMSG $nick :\003\002!song\002 - show current song"
	putserv "PRIVMSG $nick :\003\002!listener\002 - show number of listeners"
	putserv "PRIVMSG $nick :\003\002!mod\002 - show moderator"
	putserv "PRIVMSG $nick :\003\002!show\002 - show current show"
	putserv "PRIVMSG $nick :\003\002!info\002 - show all information at once (plus bitrate)"
	putserv "PRIVMSG $nick :\003"
	putserv "PRIVMSG $nick :\037for radio admins only"
	putserv "PRIVMSG $nick :\003\002!setmod \[NAME\]\002 - set moderator to NAME (whitout argument to own nick)"
	putserv "PRIVMSG $nick :\003\002!setshow \[NAME\]\002 - set show to NAME (or to default with no argument)"
	putserv "PRIVMSG $nick :\003\002!setsong \[NAME\]\002 - set song to NAME until next update"	
}

proc shoutcast_replace {text from to } {
	set text2 $text
	while {[string first [string toupper $from] [string toupper $text2]] !=-1} {
		set start [string first [string toupper $from] [string toupper $text2] ]
		set ende $start;
		set ende  [incr ende [string length $from]]
		incr ende -1
		set text2 [string replace $text2 $start $ende $to]
	}
	return $text2
}

proc shoutcast_parseconf {line} {
	global streamurl streamport streampass streamInfo offlineText onlineText listenerLine songLine allLine showLine modLine radioChans setshowPHP setmodPHP
        set parts [split $line "="]
	set value [string trim [lindex $parts 1]]
	for {set x 2} {$x<[llength $parts]} {incr x} {
		set value "$value=[lindex $parts $x]"
	}
	if {[llength $parts]>=2} {
		set name [string trim [string toupper [lindex $parts 0]]]
		set value [string map {"\\002" "\002" "\\003" "\003" "\\037" "\037" "\\017" "\017"} $value]
		if {$name=="STREAMURL"} {set streamurl $value}
		if {$name=="STREAMPORT"} {set streamport $value}
		if {$name=="STREAMPASS"} {set streampass $value}
		if {$name=="STREAMINFO"} {set streamInfo $value}
		if {$name=="OFFLINETEXT"} {set offlineText $value}
		if {$name=="ONLINETEXT"} {set onlineText $value}
		if {$name=="LISTENERLINE"} {set listenerLine $value}
		if {$name=="SONGLINE"} {set songLine $value}
		if {$name=="ALLLINE"} {set allLine $value}
		if {$name=="SHOWLINE"} {set showLine $value}
		if {$name=="MODLINE"} {set modLine $value}
		if {$name=="SETSHOWPHP"} {set setshowPHP $value}
		if {$name=="SETMODPHP"} {set setmodPHP $value}
		if {$name=="RADIOCHANS"} {set radioChans [split $value " "]}
	}
}

proc shoutcast_readconf {} {
	global conf
	if {[file exist $conf]} {
                set cfile [open $conf r]
                while {[eof $cfile]!=1} {
                        set line "[gets $cfile]"
			shoutcast_parseconf $line
                }
                close $cfile
	}
}

shoutcast_readconf

proc show_listener {nick uhost hand chan arg} {
	if {[isRadioChan $chan]==0} return;
	putlog "$nick requested listener"
	global currentListener peakListener maxListener reportedListener listenerLine
	refreshData
	if {[isOnline]  == -1} {
		show_offline $chan
		return
	}
	set out [shoutcast_replace [shoutcast_replace [shoutcast_replace [shoutcast_replace $listenerLine "\$reportedListener" $reportedListener] "\$maxListener" $maxListener] "\$peakListener" $peakListener] "\$currentListener" $currentListener]
	putserv "privmsg $chan :$out"
}

proc show_offline {chan} {
	global offlineText
	putserv "privmsg $chan :$offlineText"
}

proc show_streaminfo {nick uhost hand chan arg} {
	if {[isRadioChan $chan]==0} return;
	putlog "$nick requested streaminfo"
	global streamInfo streamport streamurl
	refreshData
        if {[isOnline]  == -1} {
                show_offline $chan
                return
        }
	set out [shoutcast_replace [shoutcast_replace $streamInfo "\$streamport" $streamport] "\$streamurl" $streamurl]
        putserv "privmsg $chan :$out"
}

proc show_song {nick uhost hand chan arg} {
	if {[isRadioChan $chan]==0} return;
	putlog "$nick requested song"
	global songTitle songLine
	refreshData
        if {[isOnline]  == -1} {
                show_offline $chan
                return
        }
	set out [shoutcast_replace $songLine "\$song" $songTitle]
	putserv "privmsg $chan :$out"
}

proc show_info {nick uhost hand chan arg} {
	if {[isRadioChan $chan]==0} return;
	putlog "$nick requested info"
        global currentListener peakListener maxListener reportedListener averageTime songTitle streamState bitrate allLine
        refreshData
        if {[isOnline]  == -1} {
                show_offline $chan
                return
        }
	if {[file exist "show"]} {
                set file [open "show" r]
                set show [gets $file]
                close $file
	}
	if {[file exist "moderator"]} {
                set file [open "moderator" r]
                set mod [gets $file]
                close $file
	}
	set out [shoutcast_replace [shoutcast_replace [shoutcast_replace [shoutcast_replace $allLine "\$bitrate" $bitrate] "\$song" $songTitle] "\$mod" $mod] "\$show" $show]
	set out [shoutcast_replace [shoutcast_replace [shoutcast_replace [shoutcast_replace $out "\$reportedListener" $reportedListener] "\$maxListener" $maxListener] "\$peakListener" $peakListener] "\$currentListener" $currentListener]
	putserv "privmsg $chan :$out"
	show_streaminfo $nick $uhost $hand $chan $arg
}

proc show_show {nick uhost hand chan arg} {
	global showLine
	if {[isRadioChan $chan]==0} return;
	putlog "$nick requested show"
	if {[file exist "show"]} {
		set file [open "show" r]
		set show [gets $file]
		close $file
		 set out [shoutcast_replace $showLine "\$show" $show]
		putserv "privmsg $chan :$out" 
	}
}
proc show_mod {nick uhost hand chan arg} {
	global modLine
	if {[isRadioChan $chan]==0} return;
	putlog "$nick requested mod"
	if {[file exist "moderator"]} {
                set file [open "moderator" r]
                set mod [gets $file]
                close $file
		set out [shoutcast_replace $modLine "\$mod" $mod]
		putserv "privmsg $chan :$out"
        }
}
proc set_show {nick uhost hand chan arg} {
	global setshowPHP 
	if {$arg==""} { set arg "musike mit $nick " }
        putlog "$nick requested setting show to: $arg"
	set file [open "show" w]
	puts $file $arg
	close $file
	if {[string compare $setshowPHP ""]!=0} {
		putlog "sending show to php"
		set arg [parsePHP $arg]
		set url [shoutcast_replace $setshowPHP "\$show" $arg]
		exec lynx -connect_timeout=10 -preparsed -dump $url
	}
	show_show $nick $uhost $hand $chan $arg
}

proc set_mod {nick uhost hand chan arg} {
	global setmodPHP
	if {$arg==""} { set arg $nick }
	putlog "$nick requested setting mod to: $arg"
	set file [open "moderator" w]
        puts $file $arg
	close $file
	if {[string compare $setmodPHP ""]!=0} {
		putlog "sending mod to php"
		set arg [parsePHP $arg]
		set url [shoutcast_replace $setmodPHP "\$mod" $arg]
        	exec lynx -connect_timeout=10 -preparsed -dump $url
	}
	show_mod $nick $uhost $hand $chan $arg
}

proc set_song {nick uhost hand chan arg} {
	global streamurl streamport streampass
        if {$arg==""} { return }
        putlog "setting song to $arg"
        set song [parsePHP $arg]
        set url "$streamurl:$streamport/admin.cgi?pass=$streampass&mode=updinfo&song=$song"
	set auth "admin:$streampass"
	set err [catch {exec lynx -connect_timeout=20 -preparsed -dump -auth=$auth $url}]
}

proc shout_check { nick uhost hand arg} {
	putlog "$nick forced shoutcast server check"
	check_online 0 0 0 0 0 
}

proc check_online  {min hr day month year} {
	global streamState bitrate offlineText onlineText
	set lastState $streamState
	set lastBitrate $bitrate
	putlog "checking if stream is online"
	refreshData
	if {$lastState != $streamState} {
		if {$streamState==0}  {
			sendToRadioChans $offlineText
		}
		if {$streamState==1} {
			sendToRadioChans $onlineText
		}
		return
	}
	if {($lastBitrate != $bitrate)&&($streamState==1)} {
		sendToRadioChans "\002\00310 ..::: \003\002 bitrate switched to $bitrate kbs \002\00310 :::.."
	}
}

proc isOnline {} {
	global streamState
	if {$streamState == 1} return 1
	return -1
}

proc sendToRadioChans {msg} {
	global radioChans
	foreach chan $radioChans {
		putserv "privmsg $chan :$msg"
	}
}

proc isRadioChan {chan} {
	global radioChans
	foreach chanel $radioChans {
		if {$chan==$chanel} {
			return 1
		}
	
	}
	putlog "not a radio chan"
	return 0
}

proc extract {data left right} {
        set beg [string first $left $data]
        set ende [string first $right $data]
        incr beg [string length $left]
        incr ende -1
        if {($beg!=-1) && ($ende!=-1)} {
                return [string range $data $beg $ende]
        } else {
                return ""
        }
}

proc extractData {} {
	global currentListener peakListener maxListener reportedListener averageTime songTitle streamState bitrate
	set file [open "shoutcast.xml" r]
	set count 0
	set data ""
	while {[eof $file]!=1} {
		set line "[gets $file]"
		set data "$data$line"
		incr count
	}
	close $file
	if {$count>1} {
		putlog "count>1 ($count)"
	}
	if {$count<1} {
                set streamState 3
                putlog "count<1 ($count)"
        }
		set data [parseXML [extract $data "<SHOUTCASTSERVER>" "</SHOUTCASTSERVER>"]]
		set currentListener [extract $data "<CURRENTLISTENERS>" "</CURRENTLISTENERS>"]
		set peakListener [extract $data "<PEAKLISTENERS>" "</PEAKLISTENERS>"]
		set maxListener [extract $data "<MAXLISTENERS>" "</MAXLISTENERS>"]
		set reportedListener [extract $data "<REPORTEDLISTENERS>" "</REPORTEDLISTENERS>"]
		set averageTime [extract $data "<AVERAGETIME>" "</AVERAGETIME>"]
		set songTitle [extract $data "<SONGTITLE>" "</SONGTITLE>"]
		set streamState [extract $data "<STREAMSTATUS>" "</STREAMSTATUS>"]
		set bitrate [extract $data "<BITRATE>" "</BITRATE>"]
		putlog "streamstate: $streamState"
}

proc refreshData {} {
	global streamurl streamport streampass
	set url "$streamurl:$streamport/admin.cgi?pass=$streampass&mode=viewxml&page=1"
	set auth "admin:$streampass"
	if {[catch {exec lynx -connect_timeout=20 -preparsed -dump -auth=$auth $url >shoutcast.xml}] !=0} {
		putlog "Can't connect to server. Maybe offline !?"
		set blank "<SHOUTCASTSERVER><STREAMSTATUS>0</STREAMSTATUS></SHOUTCASTSERVER>"
		set file [open "shoutcast.xml" w]
		puts $file $blank
		close $file
	}	
	extractData
}

proc parsePHP {text} {
	return [string map {" " "%20" "!" "%21" "\"" "%22" "#" "%23" "\$" "%24" "&" "%26"} $text]
}

proc parseXML {text} {
	return [string map {"&#xE4;" "ä" "&#xC4;" "A" "&#xF6;" "ö" "&#xD6;" "Ö" "&#xFC;" "ü" "&#xDC;" "Ü" "&#xDF;" "ß" "&qout;" "\"" "&amp;" "&" "&lt;" "<" "$gt;" ">" "&#x26;" "&"} $text]

}
set DMSShoutcastVersion "1.3.2"
putlog "DMS-Shoutcast-TCL $DMSShoutcastVersion loaded"
refreshData
