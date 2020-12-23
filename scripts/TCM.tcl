###########################################################################################################
# Settings to change ######################################################################################
###########################################################################################################
# Operator password
set operpass "operpassnabota"
# Operator nickname
set opernick "Botnick"
# Server where is oper line
set servername "irc.server.com"
# Channel of the server
set ochan "#operwall"
# IP of clones
set ip "botrealip"
# UID of clones
set uid 20
# Max clones allowed per IP
set clones 20
# Max clones allowed for user
# Kill list
set klist ""
# Clones users:seconds
set c_flood 10:40
# Kline reason
set c_kreason "Прекалено много връзки са засечени от вашия хост"
# Kline time
set c_ktime 15

###########################################################################################################
# Bind ####################################################################################################
###########################################################################################################
### Events ###
bind evnt - init-server *try:oper
bind wall - * *show:wall
### Raws ###
bind raw - 209 *trace:class
bind raw - NOTICE *raw:ontcs
#bind raw - NOTICE *raw:pntcs
bind raw - NOTICE *raw:sntcs
bind raw - NOTICE *raw:localjupe
bind raw - NOTICE *raw:whois
bind raw - NOTICE *raw:admin
bind raw - NOTICE *raw:oper
bind raw - NOTICE *raw:add
bind raw - NOTICE *raw:trace
bind raw - NOTICE *raw:greq
bind raw - NOTICE *raw:kill
bind raw - NOTICE *raw:g
bind raw - NOTICE *raw:glinerunresv
bind raw - NOTICE *raw:split
bind raw - NOTICE *raw:operspy
bind raw - NOTICE *raw:introduced
bind raw - NOTICE *raw:cmds
bind raw - NOTICE *raw:foper
### DCC ###
bind dcc N strace *dcc:strace
bind dcc N xline *dcc:xline
bind dcc N unxline *dcc:unxline
bind dcc N srestart *dcc:srestart
bind dcc N locops *dcc:locops
bind dcc N wallops *dcc:wallops
bind dcc N operwall *dcc:operwall
bind dcc N connect *dcc:connect
bind dcc N squit *dcc:squit
bind dcc N rconnect *dcc:rconnect
bind dcc N kill *dcc:kill
bind dcc N gline *dcc:gline
bind dcc N ungline *dcc:ungline
bind dcc N dline *dcc:dline
bind dcc N undline *dcc:undline
bind dcc N kline *dcc:kline
bind dcc N unkline *dcc:unkline
bind dcc N srehash *dcc:srehash
bind dcc -|- thelp *dcc:thelp

###########################################################################################################
# Unbind ##################################################################################################
###########################################################################################################

### MSG ###
###########################################################################################################
# Do not change anything above exept you know what you are doing ##########################################
###########################################################################################################
proc xindex {xarg xarg1} {return [join [lrange [split $xarg] $xarg1 $xarg1]]}
proc xrange {xarg xarg1 xarg2} {return [join [lrange [split $xarg] $xarg1 $xarg2]]}

proc *try:oper {init-server} {
  global operpass opernick botnick foruser
  putquick "OPER $opernick $operpass"
  putquick "MODE $botnick +cbzZldwfrsuxy"
  putquick "TRACE"
  set foruser 0
}

proc *dcc:strace {h i a} {
  global uid foruser
  set foruser 1
  set uid $i
  putlog "#$h# strace"
  putquick "TRACE"
}

proc *dcc:locops {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .locops <текст>" ; return 0 }
  if {[lindex $arg 0] == ""} { putdcc $idx "Моля напишете вашето съобщение" ; return 0 }
  if {[lindex $arg 0] != ""} {
  set lmsg [lrange $arg 0 end]
  putcmdlog "#$hand# locops $lmsg"
  putquick "LOCOPS :$lmsg (by $hand)"
 }
}

proc *dcc:wallops {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .wallops <текст>" ; return 0 }
  if {[lindex $arg 0] == ""} { putdcc $idx "Моля напишете вашето съобщение" ; return 0 }
  if {[lindex $arg 0] != ""} {
  set wmsg [lrange $arg 0 end]
  putcmdlog "#$hand# wallops $wmsg"
  #putquick "WALLOPS :$hand: $wmsg"
  }
}

proc *dcc:operwall {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .operwall <текст>" ; return 0 }
  if {[lindex $arg 0] == ""} { putdcc $idx "Моля напишете вашето съобщение" ; return 0 }
  if {[lindex $arg 0] == ""} {
  set omsg [lrange $arg 0 end]
  putcmdlog "#$hand# operwall $omsg"
  #putquick "OPERWALL :$hand: $omsg"
  }
}

proc *dcc:connect {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .connect <сървър>:<порт>" ; return 0 } 
  if {[lindex $arg 0] == ""} { putdcc $idx "Трябва да избереш сървър" ; return 0 }
  if {[lindex $arg 0] != ""}
  set cserv [lindex $arg 0]
  if {[lindex $arg 1] == ""}
  set cport 9000
  if {[lindex $arg 1] != ""}
  set cport [lindex $arg 1]
  putquick "CONNECT $cserv $cport"
  putdcc "#$hand# connect $cserv $cport"
}

proc *dcc:squit {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .squit <сървър> <причина>" ; return 0 }
  if {[lindex $arg 0] == ""} { putdcc $idx "Трябва да избереш сървър" ; return 0 }
  if {[lindex $arg 0] != ""} 
  set sserv [lindex $arg 0]
  if {[lindex $arg 1] == ""}
  set sreason "reroute"
  if {[lindex $arg 1] != ""} 
  set sreason [lindex $arg 1]
  putcmdlog "#$hand# squit $sserv $sreason"
  #putquick "SQUIT $sserv $sreason"
}

proc *dcc:rconnect {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Usage: .rconnect <server>:<port> <server>" ; return 0 }
  if {[lindex $arg 0] == ""} { putdcc $idx "You must specify hub server" ; return 0 }
  if {[lindex $arg 0] != ""}
  set hserv [lindex $arg 0]
  if {[lindex $arg 1] == ""}
  set hcport 9000
  if {[lindex $arg 1] != ""}
  set hcport [lindex $arg 1]
  if {[lindex $arg 2] == ""} { putdcc $idx "You must specify leaf server" ; return 0 }
  if {[lindex $arg 2] != ""}
  set lserv [lindex $arg 2]
  putcmdlog "#$hand# remote connect $lserv $hcport $hserv"
  #putquick "CONNECT $lserv $hcport $hserv"
}

proc *dcc:kill {hand idx arg} {
  global botnick
  if {$arg == ""} {  putdcc $idx "Ползвай: .kill <ник> \[причина\]" ; return 0 }
  if {[lindex $arg 0] != $botnick} {
    set nick [xindex $arg 0]
    if {[lindex $arg 1] == ""} {
      set reason "request by $hand"
    } else { set reason [lrange $arg 1 end] }
  } else { putdcc $idx "Typ si e kirooooooo" ; return 0 }
  #putquick "KILL $nick :$reason"
  putlog "#$hand# kill $nick $reason"
}

proc *dcc:srestart {hand idx arg} {
  global botnick
  putcmdlog "#$hand# Restart"
  putquick "RESTART"
}

proc *dcc:gline {hand idx arg} {
 global botnick
 if {$arg == ""} { putdcc $idx "Ползвай: .gline \[време\] <хост> \[причина\]" ; return 0 }
 if {[isnumber [lindex $arg 0]]} {
 set gtime [lindex $arg 0]
 if {[lindex $arg 1] != ""} {
 set ghost [lindex $arg 1]
 if {[lindex $arg 2] != ""} {
 set reason [lrange $arg 2 end]
 } else { set reason "request by $hand" }
 } else { putdcc $idx "Ползвай: .gline \[време\] <хост> \[причина\]" }
 } else {
 set gtime 60
 set ghost [lindex $arg 0]
 if {[lindex $arg 1] != ""} {
 set reason [xrange $arg 1 end]
 } else { set reason "request by $hand" }
 }
 putcmdlog "#$hand# gline $gtime $ghost $reason"
 #putquick "GLINE $gtime $ghost :$reason by $hand"
 return 0
}

proc *dcc:ungline {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .ungline <хост>" ; return 0 }
  putquick "UNGLINE [lindex $arg 0]"
  putcmdlog "#$hand# ungline [lindex $arg 0]"
}

proc *dcc:dline {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .dline <хост> \[причина\]" ; return 0 }
  if {[lindex $arg 0] == ""} {
  set dhost [lindex $arg 0]
  if {[lindex $arg 1] == ""} {
  set reason "request by $hand" 
  putcmdlog "#$hand# dline $dhost $reason"
  putquick "DLINE $dhost :$reason by $hand"
  return 0
  }
 }
}

proc *dcc:undline {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .undline <hostmask>" ; return 0 }
  putquick "UNDLINE [lindex $arg 0]"
  putcmdlog "#$hand# undline [lindex $arg 0]"
}

####
proc *dcc:xline {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .xline *gecos* \[причина\]" ; return 0 }
  if {[lindex $arg 0] == ""} {
  set xhost [lindex $arg 0]
  if {[lindex $arg 1] == ""} {
  set reason "request by $hand" 
  putcmdlog "#$hand# xline $xhost $reason"
  putquick "XLINE $xhost :$reason by $hand"
  return 0
  }
 }
}

proc *dcc:unxline {hand idx arg} {
  global botnick
  if {$arg == ""} { putdcc $idx "Ползвай: .unxline *gecos*" ; return 0 }
  putquick "UNXLINE [lindex $arg 0]"
  putcmdlog "#$hand# unxline [lindex $arg 0]"
}

proc *dcc:kline {hand idx arg} {
  if {$arg == ""} { putdcc $idx "Ползвай: .kline \[време\] <хост> \[причина\]" ; return 0 }
  if {[isnumber [lindex $arg 0]]} {
    set ktime [lindex $arg 0]
    if {[lindex $arg 1] != ""} {
      set khost [lindex $arg 1]
      if {[lindex $arg 2] != ""} {
        set reason [xrange $arg 2 end]
      } else { set reason "request by $hand" }
    } else { putdcc $idx "Ползвай: .kline \[време\] <хост> \[причина\]" }
  } else {
    set ktime 60
    set khost [lindex $arg 0]
    if {[lindex $arg 1] != ""} {
      set reason [lrange $arg 1 end]
    } else { set reason "request by $hand" }
  }
  putlog "#$hand# kline $ktime $khost $reason"
  putquick "KLINE $ktime $khost :$reason by $hand"
}

proc *dcc:unkline {hand idx arg} {
  if {$arg == ""} { putdcc $idx "Ползвай: .unkline <хост>" ; return 0 }
  putquick "UNKLINE [lindex $arg 0]"
  putlog "#$hand# unkline [lindex $arg 0]"
}

proc *dcc:srehash {hand idx arg} {
  if {[lindex $arg 0] == ""} {
     putquick "REHASH"
     putlog "#$hand# rehash"
}
  if {[lindex $arg 0] == "DNS"} {
     putquick "REHASH DNS"
     putlog "#$hand# rehash DNS"
}
 if {[lindex $arg 0] == "IDENT"} {
     putquick "REHASH IDENT"
     putlog "#$hand# rehash users"
}
  if {[lindex $arg 0] == "BANS"} {
     putquick "REHASH BANS"
     putlog "#$hand# srehash BANS"
}
  if {[lindex $arg 0] == "MOTD"} {
     putquick "REHASH :MOTD"
     putlog "#$hand# srehash MOTD"
}
  if {[lindex $arg 0] == "OMOTD"} {
     putquick "REHASH OMOTD"
     putlog "#$hand# srehash OMOTD"
}
  if {[lindex $arg 0] == "GLINES"} {
     putquick "REHASH GLINES"
     putlog "#$hand# srehash GLINES"
}
  if {[lindex $arg 0] == "PGLINES"} {
     putquick "REHASH PGLINES"
     putlog "#$hand# srehash PGLINES"
}
  if {[lindex $arg 0] == "TKLINES"} {
     putquick "REHASH TKLINES"
     putlog "#$hand# srehash TKLINES"
}
  if {[lindex $arg 0] == "TDLINES"} {
     putquick "REHASH TDLINES"
     putlog "#$hand# srehash TDLINES"
}
  if {[lindex $arg 0] == "TXLINES"} {
     putquick "REHASH TXLINES"
     putlog "#$hand# srehash TXLINES"
}
  if {[lindex $arg 0] == "TRESVS"} {
     putquick "REHASH TRESVS"
     putlog "#$hand# srehash TRESVS"
}
  if {[lindex $arg 0] == "REJECTCACHE"} {
     putquick "REHASH REJECTCACHE"
     putlog "#$hand# srehash REJECTCACHE"
}
  if {[lindex $arg 0] == "HELP"} {
     putquick "REHASH HELP"
     putlog "#$hand# srehash HELP"
 }
}


proc *trace:class {from key arg} {
  global uid foruser
  if {$foruser == 1} { putdcc $uid "[lrange $arg 1 end]" }
}

proc *show:wall {h arg} {
  putlog "!$h! $arg"
} 

###########################
## Server STATS requests  #
###########################
proc *raw:ontcs {from key arg} {
  global botnick o_notice ochan stat_what stat_nick stat_nickhost stat_server
  if {[lindex $arg 8] == "isbgTCM"} { return }
  if {[lindex $arg 4] == "STATS"} {
  set stat_what [lindex $arg 5]
  set stat_nick [lindex $arg 8]
  set stat_nickhost [lindex $arg 9]
  set stat_server [lindex $arg 10]
  #putquick "PRIVMSG $ochan :STATS $stat_what поискан от $stat_nick $stat_nickhost от $stat_server"
  putquick "NOTICE $stat_nick :[lindex $o_notice [rand [llength $o_notice]]]"
  }
}

###########################
##     Whois me reply     #
###########################
### set whois_mask [lindex $arg 5]
proc *raw:whois {from key arg} {
  global botnick servername whois_nick whois_mask
  if {[lindex $arg 9] == "whois" && [lindex $arg 11] == "you"} {
  set whois_nick [lindex $arg 4]
  putquick "NOTICE $whois_nick :$whois_nick, нещо интересно ли има или просто гледаш?"
  return 0
  }
}

###########################
##     OPERSPY Reply      #
###########################
proc *raw:operspy {from key arg} {
  global botnick servername what_oper ochan what_do what_who
  if {[lindex $arg 4] == "OPERSPY"} {
  set what_oper [xrange $arg 5 end]
  #putquick "PRIVMSG $ochan :OPERSPY: $what_oper"
  return 0
  }
}

###########################
## Gliner/OS RESV Reply   #
###########################
proc *raw:localjupe {from key arg} {
  global botnick servername local_juped ochan
  if {[lindex $arg 12] == "juped1"} {
  set local_juped [lrange $arg 4 end]
  #putquick "PRIVMSG $ochan :$local_juped"
  return 0
  }
}

proc *raw:sntcs {from key arg} {
  global botnick s_notice stat_nick
  if {[lindex $arg 4] == "Client" && [lindex $arg 5] == "connecting:"} {
  set stat_nick [lindex $arg 6]
  puthelp "NOTICE $stat_nick :Благодарим ти, че избра irc.is-bg.com, 4$stat_nick. Хоста ти ще бъде сканиран за по-голяма сигурност на сървъра"
  putquick "PRIVMSG $stat_nick :\001VERSION\001"
  }
}

proc *raw:split {from key arg} {
  global botnick s_notice squit_serv conn_serv ochan
  if {[lindex $arg 6] == "split" && [lindex $arg 7] == "from"} {
  set squit_serv [lindex $arg 5]
  set conn_serv [lindex $arg 8]
  putlog "Connecting $squit_serv to $conn_serv with port 9000"
  #putquick "Connect $squit_serv 9000 $conn_serv"
  #putquick "PRIVMSG $ochan :Сървър $squit_serv се разкачи от $conn_serv"
  }
}

proc *raw:introduced {from key arg} {
  global botnick s_notice squit_serv1 conn_serv1 ochan
  if {[lindex $arg 7] == "introduced" && [lindex $arg 8] == "by"} {
  set squit_serv1 [lindex $arg 5]
  set conn_serv1 [lindex $arg 9]
  #putquick "Connect $squit_serv 9000 $conn_serv"
  #putquick "PRIVMSG $ochan :Сървър $squit_serv1 се закачи за $conn_serv1"
  }
}

proc *raw:foper {from key arg} {
  global botnick s_notice foper_nick foper_ident ochan
  if {[lindex $arg 4] == "Failed" && [lindex $arg 5] == "OPER"} {
  set foper_nick [lindex $arg 11]
  set foper_ident [lindex $arg 12]
  putlog "SENDING FOPER TO $ochan"
  putquick "PRIVMSG $ochan :$foper_nick $foper_ident се опита да се идентифицира като оператор/админ"
  }
}


proc *raw:admin {from key arg} {
  global botnick servername admin_nick
  if {[lindex $arg 4] == "admin" && [lindex $arg 5] == "requested" }  {
  set admin_nick [lindex $arg 7]
  putquick "NOTICE $admin_nick :Ако имате някакви въпроси се обръщайте към 14Paco"
  }
}


# Sending notice for /stats p
set p_notice {
 "Kazhi be, tursish li neshto?"
 "vizhdam, vizhdam... Vsichko vizhdam ;-)"
 "Znaesh li che shefa mi e do men i gleda kfi gi vurshish?"
 "Gledaj, gledaj.. na nikogo nyama da kazha"
 "Vyobshte znaesh li kakvo tyrsish.. ili prosto ej taka si pishesh komandichki"
 "Znaesh li, vyzbuzhdash me kato prawish taka (tmi)"
 "Oh, produlzhawaj da go prawish, pochti stignah do orgasm"
 "Predi dwa dni edin napisa syshtata komanda kato teb i oshte go tyrsyat w kiuncite"
 "Aman ot teb, ne ti li pisna da gledash?"
 "Pak li ti? Kakwo interesno ima tuk, che samo gledash?"
 "Horata sa kazali 'Naglosta nyama granici' ama ti prekrachwash granicata na naglostta"
 "Kak stana sega?"
 "Nikfa rabota li si nyamash?"
 "Abe tozi Paco kak te turpi? Az ako bqh do sega da sum ti schupil prustchetata edin po edin ;-)"
 "VNIMAVAJ!!! Visiko naprezhenie!!!"
 "Snoshti edin prawi syshtoto, koeto i ti.. i znaesh li kakvo mu se sluchi? Zaspa, predi da gleda syncho... ;-)"
 "Za teb porno nyama li? Kvo si se zasilil da gledash tuk... ?"
}
 
# Sending notice for /stats o
set o_notice {
 "Kazhi be, tursish li neshto?"
 "vizhdam, vizhdam... Vsichko vizhdam ;-)"
 "Znaesh li che shefa mi e do men i gleda kfi gi vurshish?"
 "Gledaj, gledaj.. na nikogo nyama da kazha"
 "Vyobshte znaesh li kakvo tyrsish.. ili prosto ej taka si pishesh komandichki"
 "Znaesh li, vyzbuzhdash me kato prawish taka (tmi)"
 "Oh, produlzhawaj da go prawish, pochti stignah do orgasm"
 "Predi dwa dni edin napisa syshtata komanda kato teb i oshte go tyrsyat w kiuncite"
 "Aman ot teb, ne ti li pisna da gledash?"
 "Pak li ti? Kakwo interesno ima tuk, che samo gledash?"
 "Horata sa kazali 'Naglosta nyama granici' ama ti prekrachwash granicata na naglostta"
 "Kak stana sega?"
 "Nikfa rabota li si nyamash?"
 "Abe tozi Paco kak te turpi? Az ako bqh do sega da sum ti schupil prustchetata edin po edin ;-)"
 "VNIMAVAJ!!! Visiko naprezhenie!!!"
 "Snoshti edin prawi syshtoto, koeto i ti.. i znaesh li kakvo mu se sluchi? Zaspa, predi da gleda syncho... ;-)"
 "Za teb porno nyama li? Kvo si se zasilil da gledash tuk... ?"
}
proc *raw:cmds {from key arg} {
  global botnick servername ochan klist u_cflood c_kreason c_ktime c_kcount host whatdoing
  if {$from != $servername} { return 0 }  
  if {[lindex $arg 2] == "Oper" && [lindex $arg 3] == "privs"} {
    putquick "STATS c"  
    putquick "STATS v"
    putquick "STATS p"
    putquick "STATS o"
    return 0
  }
  if {[lindex $arg 5] == "connecting:"} {
    set host "{[lindex [split "[lindex $arg 8]" "\[\]"]>-1]}"
    if {[lsearch -glob [string tolower $host] "*is-bg.com*"]>-1} {return 0}
    if {[lsearch -glob [string tolower $host] "*techno-link.com*"]>-1} {return 0}
    if {[lsearch -glob [string tolower $host] "*94.236*"]>-1} {return 0}
    if {[lsearch -glob [string tolower $host] "*devilix.net*"]>-1} {return 0}
    if {![info exists c_kcount($host)]} {
      set c_kcount($host) 0
    }
    incr c_kcount($host)
    if {$c_kcount($host) == [lindex $u_cflood 0]} {
	  putlog "KLINE $c_ktime *@$host :$c_kreason"
      #putquick "KLINE $c_ktime *@$host :$c_kreason"
      return 0
    }
  }
  if {[lindex $arg 5] == "Flooder" && [lindex $arg 4] == "Possible"} {
    set fnick [lindex $arg 5]
    set fhost [lindex $arg 6]
    set onserver [lindex $arg 8]
    set target [lindex $arg 10]
	set whatdoing [lrange $arg 4 end]
	putquick "PRIVMSG $ochan :$whatdoing"
    if {[lsearch -glob [string tolower $host] "*is-bg.com*"]>-1} {return 0}
    if {[lsearch -glob [string tolower $host] "*techno-link.com*"]>-1} {return 0}
    if {[lsearch -glob [string tolower $host] "*94.236*"]>-1} {return 0}
    if {[lsearch -glob [string tolower $host] "*devilix.net*"]>-1} {return 0}
    scan $fhost "%\[^@]@%s" trash uhost
    scan $uhost "%\[^]]]%s" host trash
    if {[regexp -nocase $host $klist]} {
      return 0
    } else {
      set klist "$klist $host"
      timer 10 "remove_kline $host"
    }
    putlog "KLINE 10 *@$host :$fnick $fhost Спри да флудиш и заповядай отново след 10 минути"
  }
  if {[lindex $arg 4] == "Invalid" && [lindex $arg 5] == "username:"} {
    set badident [lindex [split [lindex $arg 7] "()"] 1]
    putquick "KLINE 10 $badident :Смени си идента@ и заповядай отново след 10 минути"
    return 0
  }
  if {[lindex $arg 8] == "triggered" && [lindex $arg 9] == "gline"} {
     set gtxt [lrange $arg 4 end]
     #putquick "PRIVMSG $ochan :$gtxt"
     return 0
  }
  ###### TEMPORARY ######
  if {[lindex $arg 5] == "added" && [lindex $arg 6] == "temporary"} {
    set gwho [lindex $arg 4]
	set gwho1 [lindex $arg 5]
	set gwho2 [lindex $arg 6]
	set gwho3 [lindex $arg 7]
	set gwho4 [lindex $arg 8]
	set gwho5 [lindex $arg 9]
	set gwho6 [lindex $arg 10]
	set gwho7 [lindex $arg 11]
	set gwho8 [lindex $arg 12]
	set gwho9 [lindex $arg 13]
	set gwho10 [lindex $arg 14]
	set gwho11 [lindex $arg 15]
	set gwho12 [lindex $arg 16]
	set gwho13 [lindex $arg 17]
	set gwho14 [lindex $arg 18]
	set gwho15 [lindex $arg 19]
	set gwho16 [lindex $arg 20]
	set gwho17 [lindex $arg 21]
	set gwho18 [lindex $arg 22]
	set gwho19 [lindex $arg 23]
	set gwho20 [lindex $arg 24]
	set gwho21 [lindex $arg 25]
	set gwho22 [lindex $arg 26]
	set gwho23 [lindex $arg 27]
	set gwho24 [lindex $arg 28]
	
    #putquick "PRIVMSG $ochan :$gwho $gwho1 $gwho2 $gwho3 $gwho4 $gwho5 $gwho6 $gwho7 $gwho8 $gwho9 $gwho10 $gwho11 $gwho12 $gwho13 $gwho14 $gwho15 $gwho16 $gwho17 $gwho18 $gwho19 $gwho20 $gwho21 $gwho22 $gwho23 $gwho24"
    return 0
  }
  ###### PERM ######
   if {[lindex $arg 5] == "added" && [lindex $arg 7] == "for"} {
    set Pgwho [lindex $arg 4]
	set Pgwho1 [lindex $arg 5]
	set Pgwho2 [lindex $arg 6]
	set Pgwho3 [lindex $arg 7]
	set Pgwho4 [lindex $arg 8]
	set Pgwho5 [lindex $arg 9]
	set Pgwho6 [lindex $arg 10]
	set Pgwho7 [lindex $arg 11]
	set Pgwho8 [lindex $arg 12]
	set Pgwho9 [lindex $arg 13]
	set Pgwho10 [lindex $arg 14]
	set Pgwho11 [lindex $arg 15]
	set Pgwho12 [lindex $arg 16]
	set Pgwho13 [lindex $arg 17]
	set Pgwho14 [lindex $arg 18]
	set Pgwho15 [lindex $arg 19]
	set Pgwho16 [lindex $arg 20]
	set Pgwho17 [lindex $arg 21]
	set Pgwho18 [lindex $arg 22]
	set Pgwho19 [lindex $arg 23]
	set Pgwho20 [lindex $arg 24]
    #putquick "PRIVMSG $ochan :$Pgwho $Pgwho1 $Pgwho2 $Pgwho3 $Pgwho4 $Pgwho5 $Pgwho6 $Pgwho7 $Pgwho8 $Pgwho9 $Pgwho10 $Pgwho11 $Pgwho12 $Pgwho13 $Pgwho14 $Pgwho15 $Pgwho16 $Pgwho17 $Pgwho18 $Pgwho19 $Pgwho20"
    return 0
  }
  if {[lindex $arg 5] == "Drone" && [lindex $arg 6] == "Flooder"} {
    set dtxt [lrange $arg 4 end]
    putquick "PRIVMSG $ochan :$dtxt"
    return 0
  }
  if {[lindex $arg 10] == "personality" && [lindex $arg 14] == "megalomaniacal"} {
    if {[lindex $arg 4] != $botnick} {
      #putquick "INVITE [lindex $arg 4] $ochan"
    }
  }
}
proc *raw:glinerunresv {from key arg} {
  global botnick servername ochan gwho1 gwho11 gwho21 gwho31 gwho41 gwho51 gwho61 gwho71
  if {[lindex $arg 6] == "removed"} {
  set gwho1 [lindex $arg 4]
  set gwho11 [lindex $arg 5]
  set gwho21 [lindex $arg 6]
  set gwho31 [lindex $arg 7]
  set gwho41 [lindex $arg 8]
  set gwho51 [lindex $arg 9]
  set gwho61 [lindex $arg 10]
  set gwho71 [lindex $arg 11]
  #putquick "PRIVMSG $ochan :$gwho1 $gwho11 $gwho21 $gwho31 $gwho41 $gwho51 $gwho61 $gwho71"
  return 0
  }
}



proc *raw:oper {from key arg} {
  global botnick admtxt ochan
  if {[lindex $arg 7] == "now" && [lindex $arg 10] == "administrator"} {
  if {[lindex $arg 4] == $botnick} { return 0 }
  set admtxt [lrange $arg 4 end]
  putquick "PRIVMSG $ochan :$admtxt"
  return 0
  }
}
proc *raw:add {from key arg} {
  global botnick addtxt ochan
  if {[lindex $arg 5] == "added" && [lindex $arg 6] == "G-Line"} {
  set addtxt [lrange $arg 4 end]
  #putquick "PRIVMSG $ochan :$addtxt"
  return 0
  }
}

proc *raw:trace {from key arg} {
  global botnick tracetxt ochan
  if {[lindex $arg 7] == $botnick} { return 0 }
  if {[lindex $arg 4] == "trace"} {
  set tracetxt [lrange $arg 4 end]
  #putquick "PRIVMSG $ochan :$tracetxt"
  return 0
  }
}

proc *raw:greq {from key arg} {
  global botnick gtxt ochan
  if {[lindex $arg 5] == "requesting" && [lindex $arg 6] == "G-Line"} {
  set gtxt [lrange $arg 4 end]
  #putquick "PRIVMSG $ochan :$gtxt"
  return 0
  }
}

proc *raw:kill {from key arg} {
  global botnick killtxt ochan
  if {[lindex $arg 5] == "KILL" && [lindex $arg 7] == "for"} {
  set killtxt [lrange $arg 4 end]
  putquick "PRIVMSG $ochan :$killtxt"
  return 0
  }
}
proc remove_kline {args} {
  global klist
  if {[regexp -nocase $args $klist] < 1} {return 0}
  set pos [string first $args $klist]
  incr pos -2
  set len [string length $args]
  incr len 3
  set tmp [string range $klist 0 $pos]
  incr pos $len
  set tmp "$tmp [string range $klist $pos end]"
  set klist $tmp
}
proc c_kreset {} {
  global u_cflood c_kcount
  if {[info exists c_kcount]} {
    unset c_kcount
  }
  utimer [lindex $u_cflood 1] c_kreset
}

set u_cflood [split $c_flood :]

if {![string match *c_kreset* [utimers]]} {
  global u_cflood
  utimer [lindex $u_cflood 1] c_kreset
}

proc isnumber {number} {
if {[regexp \[^0-9\] $number]} { return 0 } else { return 1 }
}
timer 20 {putquick "TRACE"}

proc *raw:g {from key arg} {
  global botnick notice rehash rejectcache
  if {[lindex $arg 6] == "removed"} {
  putquick "REHASH rejectcache" 
  }
}

proc *raw:oper {from key arg} {
  global botnick opertxt ochan operator
  if {[lindex $arg 9] == "operator"} {
  set opertxt [lrange $arg 4 end]
  putquick "PRIVMSG $ochan :$opertxt"
  }
}

proc *dcc:thelp {hand idx arg} {
  global botnick
  putdcc $idx " .kill <nick> <reason>"
  putdcc $idx " .kline <time> <hostmask> <reason>"
  putdcc $idx " .unkline <hostmask>"
  putdcc $idx " .gline <time> <hostmask> <reason>"
  putdcc $idx " .ungline <hostmask>"
  putdcc $idx " .dline <hostmask> <reason>"
  putdcc $idx " .undline <hostmask>"
  putdcc $idx " .restart"
  putdcc $idx " .connect <server> <port>"
  putdcc $idx " .squit <server> <reason>"
  putdcc $idx " .rconnect <server> <port> <server>"
  putdcc $idx " .locops <message>"
  putdcc $idx " .wallops <message>"
  putdcc $idx " .operwall <message>"
  putdcc $idx " .srehash <option>"
  putdcc $idx " When no option is given the ircd will rehash the ircd.conf"
  putdcc $idx " Options:"
  putdcc $idx " Will rehash BANS DNS MOTD OMOTD GLINES PGLINES TKLINES TDLINES TXLINES TRESVS REJECTCACHE HELP"
}

set timerehash_setting(timer) "1440"

if {![string match 1.6.* $version]} { putlog "\002TIMEREHASH:\002 \002WARNING:\002 This script is intended to run on eggdrop 1.6.x or later." }
if {[info tclversion] < 8.2} { putlog "\002TIMEREHASH:\002 \002WARNING:\002 This script is intended to run on Tcl Version 8.2 or later." }

if {$timerehash_setting(timer) > 0 && [lsearch -glob [timers] "* timerehash_rehash *"] == -1} { timer $timerehash_setting(timer) timerehash_rehash }

proc timerehash_rehash {} {
	global timerehash_setting
	  putlog "*** Опреснявам цялата конфигурация на сървъра"
      putquick "REHASH DNS"
      putquick "REHASH BANS"
	  putquick "REHASH REJECTCACHE"
	  putquick "REHASH"
      putquick "REHASH MOTD"
	  putquick "REHASH HELP"
      putquick "REHASH OMOTD"
      #putquick "REHASH GLINES"
      #putquick "REHASH PGLINES"
      #putquick "REHASH TKLINES"
      #putquick "REHASH TDLINES"
      #putquick "REHASH TXLINES"
      #putquick "REHASH TRESVS"

	if {[lsearch -glob [timers] "* timerehash_rehash *"] == -1} { timer $timerehash_setting(timer) timerehash_rehash }
}
##############################################################################################
##############################################################################################

putlog "Инсталиран: TCM.tcl"
