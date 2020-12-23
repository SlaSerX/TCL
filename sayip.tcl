setudef flag sayip
setudef str sayiptype
set trycwh ""
set ip2cpath "scripts/db/"
set ip2cfile "ip2c.db"
bind join - * join:checkhtml
proc join:checkhtml {nick h hand c} {global botnick
  if {[lsearch -exact [channel info $c] +sayip] != -1} {
        if {[channel get $c sayiptype]==""} {
            channel set $c sayiptype "color" ;# cvetno
			set swtype color
        } else  {
            set swtype [channel get $c sayiptype]
        }
  if {$nick == $botnick || [matchattr $hand b]} {return 0}
  if {$nick != $botnick} {
  if {[string match "*.html.chat" $h]} {set host "[lindex [split $h "@"] 0]" ;set ip [getiph $host]} else {set ip "[lindex [split $h @] 1]" }
checklookedip $ip $c chan $swtype $nick
		}
	}
}

bind pub f !ip ppw
proc ppw {nick u h c t} {global trycwh stype
set trycwh $c
set stype msg
set h [lindex $t 0]
        if {[channel get $c sayiptype]==""} {
            channel set $c sayiptype "color" ;# cvetno
			set swtype color
        } else  {
            set swtype [channel get $c sayiptype]
        }
if {$h == ""} {putquick "privmsg $c :Използвайте [tt2 "!i <host>"] Пример: [tt2 "!i ~Drujba@84.40.99.41"] или [tt2 "!i 54286329@eu.html.chat"] или [tt2 "!i ~trivia@95-42-205-85.btc-net.bg"] или [tt2 "!i <nick>"]" ;return 0}
if {![string match "*@*" $t]} {
	putquick "whois $t"
	} else {
  if {[string match "*.html.chat" $h]} {set host "[getiph [lindex [split $h "@"] 0]]" } else {set host "[lindex [split $h @] 1]" }
	checklookedip $host $c msg $swtype
	}
}

set stype ""
bind dcc n ip dcc:ip
proc dcc:ip {hand idx t} {global trycwh stype
set trycwh $idx
set stype dcc
set h [lindex $t 0]
if {$h == ""} {putdcc $idx "Използвайте [tt2 ".ip <host>"] Пример: [tt2 ".ip ~Drujba@84.40.99.41"] или [tt2 ".ip 54286329@eu.html.chat"] или [tt2 ".ip ~trivia@95-42-205-85.btc-net.bg"]" ;return 0}
set swtype color
if {![string match "*@*" $t]} {
	putquick "whois $t"
	} else {
	if {[string match "*.html.chat" $h]} {set host "[lindex [split $h "@"] 0]";set ip [getiph $host]} else {set ip "[lindex [split $h @] 1]" }
	checklookedip $ip $idx dcc $swtype
	}
}


proc dnsall {ip host status ipl c type swtype {nick ""}} {
if {$nick == "" && $ip == "0.0.0.0"} {htsinfo $type $c "Не можах да получа информация за $ipl понеже е със SPOOF" ;return 0} elseif { $nick != "" && $ip == "0.0.0.0"} { htsinfo $type $c "Не можах да получа информация за $nick понеже е със SPOOF" ;return 0}
	set url "http://whatismyipaddress.com/ip/$ip"
  	set agent "Mozilla/5.0 (X11; Linux i686; rv:2.0.1) Gecko/20100101 Firefox/4.1.[strftime %S]"
    set http [::http::config -useragent $agent] 
if {[catch {  
    set http [::http::geturl $url -timeout 60000]
    set html [::http::data $http]; ::http::cleanup $http
	} err]} {htsinfo $type $c "Не можах да се свържа със сървъра: $err"}
	set f [open ip.db w];puts $f $html;	close $f
    regsub -all "\n" $html "" html
	regsub -all "	" $html "" html
regexp {<tr><th>Country:</th><td>(.*?) <img} $html - country
regexp {<tr><th>City:</th><td>(.*?)</td></tr>} $html - city
regexp {<tr><th>ISP:</th><td>(.*?)</td>} $html - isp
set token [::http::geturl $url -timeout 60000]
set status [::http::status $token]
if {![info exists country] && ![info exists city] && ![info exists isp] || $status ne "ok"} {
if {$nick == ""} {htsinfo $type $c "Не можах да получа информация за $ip"} else { htsinfo $type $c "Не можах да получа информация за $nick" }  
return 0 } else {
		append _msg2 "идент: [iptohex $ip] -> Ип: $ip "
		if {[info exists country]} {append _msg2 "-> Държава: $country "} else { append _msg2 "-> Държава: ? " }
		if {[info exists city]} {append _msg2 "-> Град: $city "} else { append _msg2 "-> Град: ? " }
		if {[info exists isp] && $isp != ""} {append _msg2 "-> Доставчик: $isp "} else { append _msg2 "-> Доставчик: ? " }
		if {$host != $ip} {append _msg2 "-> Хост: $host -!-"} else {append _msg2 "-> Хост: $ip -!-"}
		switch $swtype {
	color {
	if {$nick != ""} {append _msg "[c]08[b]$nick [c]04->[b] "}
		append _msg "[b][c]09идент:[c][b] [iptohex $ip] [b][c]04->[c]09 Ип:[c][b] $ip "
		if {[info exists country]} {append _msg "[b][c]04->[c]09 Държава:[c][b] $country "}
		if {[info exists city]} {append _msg "[b][c]04->[c]09 Град:[c][b] $city "}
		if {[info exists isp] && $isp != ""} {append _msg "[b][c]04->[c]09 Доставчик:[c][b] $isp "}
		if {$host != $ip} {append _msg "[b][c]04->[c]09 Хост:[c][b] $host"}
	}
	nocolor {
	if {$nick != ""} {append _msg "$nick -> "}
		append _msg "идент: [iptohex $ip] -> Ип: $ip "
		if {[info exists country]} {append _msg "-> Държава: $country "}
		if {[info exists city]} {append _msg "-> Град: $city " }
		if {[info exists isp] && $isp != ""} {append _msg "-> Доставчик: $isp " }
		if {$host != $ip} {append _msg "-> Хост: $host"}
			}
		}
	ip2csave $_msg2 $ip
	htsinfo $type $c $_msg
	}
}

if {![file exists $ip2cpath$ip2cfile]} {set f [open $ip2cpath$ip2cfile w];puts $f ""; close $f }

proc ip2csave {info ip} {global ip2cfile ip2cpath
    if {![file isdirectory $ip2cpath]} {
      file mkdir $ip2cpath
    }
set fr [open $ip2cpath$ip2cfile r]
set fw [open $ip2cpath$ip2cfile.tmp w]
	while {![eof $fr]} {
		set line [gets $fr]
		if {$line != ""} {
			set ipf [lindex $line 4]
			if {$ipf != $ip} {
				puts $fw "$line"
	} else { close $fr;close $fw;return 0 }
 	}	}
puts $fw "$info"
	close $fr
	flush $fw
	close $fw
	file rename -force "$ip2cpath$ip2cfile.tmp" $ip2cpath$ip2cfile
}

proc checklookedip {ip c type swtype {nick ""}} {global ip2cfile ip2cpath
set fr [open $ip2cpath$ip2cfile r]
	while {![eof $fr]} {
		set line [gets $fr]
		if {$line != ""} {
		set ipf [lindex $line 4]
		set words [regexp -all -- {\S+} $line]
		set hh [lindex $line [expr $words - 2]]
			if {$ipf == $ip || $ip == $hh} {
				set found "$line"
			}	
		}	
	}
	close $fr
	if {[info exists found]} {
	##code start
		if {[regexp {идент:(.*?) -> Ип:(.*?) -> Държава:(.*?) -> Град:(.*?) -> Доставчик:(.*?) -> Хост:(.*?)-!-} $found - id ip cc city isp hosta]} {
		regsub -all " " $hosta "" hosta;regsub -all " " $ip "" ip;regsub -all " " $cc "" cc
		regsub -all " " $city "" city;
		switch $swtype {
	color {
	if {$nick != ""} {append _msg "[c]08[b]$nick [c]04->[b] "}
		append _msg "[b][c]09идент:[c][b] $id [b][c]04->[c]09 Ип:[c][b] $ip "
		if {$cc != "?"} {append _msg "[b][c]04->[c]09 Държава:[c][b] $cc "}
		if {$city != "?"} {append _msg "[b][c]04->[c]09 Град:[c][b] $city " }
		if {$isp != " ?"} {append _msg "[b][c]04->[c]09 Доставчик:[c][b] $isp " }
		if {$hosta != $ip } {append _msg "[b][c]04->[c]09 Хост:[c][b] $hosta"}
	}
	nocolor {
		if {$nick != ""} {append _msg "$nick -> "}
		append _msg "идент: $id -> Ип: $ip "
		if {$cc != " ?"} {append _msg "-> Държава: $cc "}
		if {$city != " ?"} {append _msg "-> Град: $city " }
		if {$isp != " ?"} {append _msg "-> Доставчик: $isp " }
		if {$hosta != $ip } {append _msg "-> Хост: $hosta"}
			}
		}
	}
	#code end
	htsinfo $type $c $_msg
	} else { dnslookup $ip dnsall $ip $c $type $swtype $nick }
}

bind raw - 311 raw:w311
proc raw:w311 {f k t} {
global trycwh stype
	set n [lindex $t 1]
	set ip [lindex $t 2]@[lindex $t 3]
	if {[string match "*.html.chat" $ip]} {set host "[lindex [split $ip "@"] 0]";set ip [getiph $host]} else {set ip "[lindex [split $ip @] 1]" }
	if {[string match "#*" $trycwh]} {
if {[channel get $trycwh sayiptype]==""} {
    channel set $trycwh sayiptype "color" ;# cvetno
	set swtype color
    } else  {
    set swtype [channel get $trycwh sayiptype]
		}
	} else {set swtype color }
	if {$stype == "dcc"} {
	checklookedip $ip $trycwh dcc color $n
	} else {
	checklookedip $ip $trycwh msg $swtype $n
	}
}

bind msg f ip mmw
proc mmw {nick u h t} {global trycwh stype
set trycwh $nick
set stype msg
set h [lindex $t 0]
if {$h == ""} {putquick "privmsg $nick :Използвайте [tt2 "!i <host>"] Пример: [tt2 "!i ~Drujba@84.40.99.41"] или [tt2 "!i 54286329@eu.html.chat"] или [tt2 "!i ~trivia@95-42-205-85.btc-net.bg"] или [tt2 "!i <nick>"]" ;return 0}
if {![string match "*@*" $t]} {
	putquick "whois $t"
	} else {
	set swtype color
	if {[string match "*.html.chat" $h]} {set host "[getiph [lindex [split $h "@"] 0]]" } else {set host "[lindex [split $h @] 1]" }
	checklookedip $host $nick msg $swtype
	}
}

set tryseenip 0
bind raw - 401 raw:w401
proc raw:w401 {f k t} {global tryseenip
set tryseenip 1
putquick "privmsg SS :seen [lindex $t 1]"
}


bind notc - * sayipseencheck
proc sayipseencheck {n u h t d} {global tryseenip trycwh stype
set swtype color
set nick [lindex $t 3]
	if {$tryseenip == 0} {return 0}
	if {$n == "SeenServ" && [string match "*I*last*saw*" $t]} {
	set ip [lindex $t 4]
	set ip [string map [list ")" {}] $ip]
	set ip [string map [list "(" {}] $ip]
	  if {[string match "*.html.chat" $ip]} {set host "[getiph [lindex [split $ip "@"] 0]]" } else {set host "[lindex [split $ip @] 1]" }
	  if {$stype != "dcc"} {
	  set stype msg
	  checklookedip $host $trycwh msg $swtype $nick
		} else {
		set stype dcc
	checklookedip $host $trycwh dcc $swtype $nick
		}
	}
	if {$n == "SeenServ" && [string match "I*haven't*seen*recently" $t]} {
	set n [lindex $t 3]
	htsinfo $stype $trycwh "$n e pochinal v blizkia 1 mesec"
	return 0
	}
	set tryseenip 0
}

proc htsinfo {t c m} {
if {$t == "chan" || $t == "msg"} {
	putquick "privmsg $c :$m"
	} elseif {$t == "dcc"} {
	 putdcc $c "$m"
	}
}


proc getiph {t} {
set txta [format {%d.%d.%d.%d} 0x[string range $t 0 1] 0x[string range $t 2 3] 0x[string range $t 4 5] 0x[string range $t 6 7]]
return "$txta"
}

proc iptohex {t} {
set t1 [lindex [split $t .] 0]
set t2 [lindex [split $t .] 1]
set t3 [lindex [split $t .] 2]
set t4 [lindex [split $t .] 3]
regsub -all " " $t "" t
#set txta [format {%x%x%x%x} $t1 $t2 $t3 $t4]
set txta [format {%02x%02x%02x%02x} $t1 $t2 $t3 $t4]
return "$txta"
}

proc u {} {return \037};                  #underline
proc r {} {return \026};                  #reverse
proc b {} {return \002};                  #bold
proc c {} {return \003};                  #color 
proc a {} {return \001};                  #action
proc o {} {return }; #maha cvqt i odebelenie