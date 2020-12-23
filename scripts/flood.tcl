# Settings
# Channels where you want RepeatPro active (quoted list, spaces between channelnames)
set rp_channels "#gyuvetch"

# Small repeat flood, kick on repeats:seconds
set rp_kflood 5:5
# Small repeat flood kick reasons
set rp_kreason {
  "Kopele shto ne se pospresh a??"
  "ospokoi sa i pak ela..."
  "Flooooooooooooooooooooooooooood"
  "A sq de ?"
}

# Large repeat flood, kick-ban on repeats:seconds
set rp_bflood 5:5
# Large repeat flood kick-ban reasons
set rp_breason {
  "Prou. Prou. Prou. Prou. Prou"
}

# Spam repeat flood, kick on repeats:seconds
set rp_sflood 5:5
# Spam repeat flood kick reasons
set rp_sreason {
  "N O  R e p e a t"
}

# Set the string length for spam-type text (lines of text shorter than this
# will not be counted by the 'spam' type repeat detector)
set rp_slength 40

# Repeat offences, ban on two repeat floods from a particular host within
# how many seconds
set rp_mtime 300
# Length of time in minutes to ban large repeat flooders and repeat
# offenders
set rp_btime 30
# Repeat offences ban reasons
set rp_mreason {
  "bla bla bla ... nqkaf tap reason"
}


##### DON'T edit anything below this line unless you know what you're doing #####

proc rp_pubmsg {nick uhost hand chan text} {
  global botnick rp_count rp_scount rp_bflood rp_breason rp_btime rp_kflood rp_kreason rp_sflood rp_slength rp_sreason rp_channels
  set uhost [string tolower $uhost]
  set chan [string tolower $chan]
  set trimtext [string tolower $text]
  set text [trimctrl $trimtext]
  if {[lsearch -exact $rp_channels $chan] == -1} {return 0}
  if {$nick == $botnick} {return 0}
  if {[matchattr $hand f|f $chan]} {return 0}

  lappend rp_count($uhost:$chan:$text) 1
  utimer [lindex $rp_bflood 1] "expire rp_count($uhost:$chan:$text)"

  if {[string length $text] > $rp_slength} {
    lappend rp_scount($uhost:$chan:$text) 1
    utimer [lindex $rp_sflood 1] "expire rp_scount($uhost:$chan:$text)"
  }

  if {[llength $rp_count($uhost:$chan:$text)] == [lindex $rp_bflood 0]} {
    if {[botisop $chan] && [onchan $nick $chan]} {
      putserv "KICK $chan $nick :[rand_reason rp_breason]"
    }
    newchanban $chan [wild_banmask $uhost] RepeatPro [rand_reason rp_kreason] $rp_btime
    return 0
  }

  if {[llength $rp_count($uhost:$chan:$text)] == [lindex $rp_kflood 0]} {
    rp_mhost $nick $uhost $chan
    if {[botisop $chan] && [onchan $nick $chan]} {
      putserv "KICK $chan $nick :[rand_reason rp_kreason]"
    }
    return 0
  }

  if {[info exists rp_scount($uhost:$chan:$text)]} {
    if {[llength $rp_scount($uhost:$chan:$text)] == [lindex $rp_sflood 0]} {
      rp_mhost $nick $uhost $chan
      if {[botisop $chan] && [onchan $nick $chan]} {
        putserv "KICK $chan $nick :[rand_reason rp_sreason]"
      }
      return 0
    }
  }
}

proc rp_pubact {nick uhost hand dest key arg} {
  rp_pubmsg $nick $uhost $hand $dest $arg
}

proc rp_pubnotc {from keyword arg} {
  set nick [lindex [split $from !] 0]
  set chan [string tolower [lindex [split $arg] 0]]
  if {![validchan $chan] || ![onchan $nick $chan]} {return 0}
  set uhost [getchanhost $nick $chan]
  set hand [nick2hand $nick $chan]
  set text [join [lrange [split $arg] 1 end]]
  rp_pubmsg $nick $uhost $hand $chan $text
}

proc rp_mhost {nick uhost chan} {
  global rp_btime rp_mhosts rp_mreason rp_mtime
  if {![info exists rp_mhosts($chan)]} {
    set rp_mhosts($chan) ""
  }
  if {[lsearch -exact $rp_mhosts($chan) $uhost] != -1} {
    newchanban $chan [wild_banmask $uhost] RepeatPro [rand_reason rp_mreason] $rp_btime
  } else {
    lappend rp_mhosts($chan) $uhost
    utimer $rp_mtime "rp_mhostreset $chan"
  }
}

proc rp_mhostreset {chan} {
  global rp_mhosts
  set rp_mhosts($chan) [lrange rp_mhosts($chan) 1 end]
}

proc trimctrl {text} { 
  # 1) Remove any ^B, ^R, ^U control characters from the text
  regsub -all {[]} $text "" text

  # 2) Remove any ^K colour control characters along with their formatting numeric codes
  regsub -all {..,..|..,.|.,..|.,.|..|.|} $text "" text

  # 3) Remove any non-alphanumeric characters
  regsub -all {[^!-ÿ]} $text "" text

  # 4) Handle special Tcl characters
  regsub -all {\;} $text "\xa1" text
  regsub -all {\\} $text "\xa5" text
  regsub -all {\[} $text "\xa6" text
  regsub -all {\$} $text "\xa7" text
  
  # 5) Return contents
  set finaltext $text
  return $finaltext
}

proc expire var_exp {
  upvar $var_exp var_pointer
  if {[llength $var_pointer] > 1} {
    set var_pointer [lrange $var_pointer 1 end]
  } else {
    unset var_pointer
  }
}

proc rand_reason var_rand {
  upvar $var_rand rand_pointer
  set rand_reason [lindex $rand_pointer [rand [llength $rand_pointer]]]
  return $rand_reason
}

proc wild_banmask {uhost} {
  set wildhost [lindex [split [maskhost [lindex [split $uhost @] 1]] @] 1]
  regsub {\~} [lindex [split $uhost @] 0] "" wilduser
  set w_bmask *!*$wilduser@$wildhost
  return $w_bmask
}

set rp_channels [string tolower $rp_channels]
set rp_kflood [split $rp_kflood :]
set rp_bflood [split $rp_bflood :]
set rp_sflood [split $rp_sflood :]

bind pubm - * rp_pubmsg
bind ctcp - ACTION rp_pubact
bind raw - NOTICE rp_pubnotc
