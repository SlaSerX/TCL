# bitchxpack.tcl v1.50 (21 October 1999)
# copyright © 1999 by slennox <slennox@egghelp.org>
# slennox's eggdrop page - http://www.egghelp.org/
#
# BitchX CTCP and AWAY simulator with built-in CTCP flood protection.
#
# Simulates BitchX 75p1+ and 75p3+ CTCP replies. The version is randomly
# selected on startup. Note that this script doesn't replace the CTCP
# module - the CTCP module must be loaded for it to work.
#
# DCC command .bitchx (for global +m/n/t users) displays basic info about
# current script status.
#
# This script was originally based on bitchxpack.tcl by DeathHand.

# Flood protection setting in number:seconds:disable format. By default, if
# the bot receives 5 CTCPs in 30 seconds, it will stop responding to all
# CTCPs for 120 seconds.
set bx_flood 5:30:120

# Simulate BitchX AWAY mode? 1 to enable, 0 to disable.
set bx_away 1


# Don't edit below unless you know what you're doing.

proc bx_ctcp {nick uhost hand dest key arg} {
  global bx_flood bx_flooded bx_floodqueue bx_jointime bx_machine bx_onestack bx_system bx_version bx_whoami realname
  if {$bx_flooded} {return 1}
  incr bx_floodqueue
  utimer [lindex $bx_flood 1] {incr bx_floodqueue -1}
  if {$bx_floodqueue >= [lindex $bx_flood 0]} {
    set bx_flooded 1
    utimer [lindex $bx_flood 2] {set bx_flooded 0}
    putlog "bitchx: CTCP flood detected - stopped responding to CTCPs for [lindex $bx_flood 2] seconds."
    return 1
  }
  if {$bx_onestack} {return 1}
  set bx_onestack 1
  utimer 2 {set bx_onestack 0}
  switch -exact -- $key {
    "CLIENTINFO" {
      set bxcmd [string toupper $arg]
      switch -exact -- $bxcmd {
        "" {putserv "NOTICE $nick :\001CLIENTINFO SED UTC ACTION DCC CDCC BDCC XDCC VERSION CLIENTINFO USERINFO ERRMSG FINGER TIME PING ECHO INVITE WHOAMI OP OPS UNBAN IDENT XLINK UPTIME  :Use CLIENTINFO <COMMAND> to get more specific information\001"}
        "SED" {putserv "NOTICE $nick :\001CLIENTINFO SED contains simple_encrypted_data\001"}
        "UTC" {putserv "NOTICE $nick :\001CLIENTINFO UTC substitutes the local timezone\001"}
        "ACTION" {putserv "NOTICE $nick :\001CLIENTINFO ACTION contains action descriptions for atmosphere\001"}
        "DCC" {putserv "NOTICE $nick :\001CLIENTINFO DCC requests a direct_client_connection\001"}
        "CDCC" {putserv "NOTICE $nick :\001CLIENTINFO CDCC checks cdcc info for you\001"}
        "BDCC" {putserv "NOTICE $nick :\001CLIENTINFO BDCC checks cdcc info for you\001"}
        "XDCC" {putserv "NOTICE $nick :\001CLIENTINFO XDCC checks cdcc info for you\001"}
        "VERSION" {putserv "NOTICE $nick :\001CLIENTINFO VERSION shows client type, version and environment\001"}
        "CLIENTINFO" {putserv "NOTICE $nick :\001CLIENTINFO CLIENTINFO gives information about available CTCP commands\001"}
        "USERINFO" {putserv "NOTICE $nick :\001CLIENTINFO USERINFO returns user settable information\001"}
        "ERRMSG" {putserv "NOTICE $nick :\001CLIENTINFO ERRMSG returns error messages\001"}
        "FINGER" {putserv "NOTICE $nick :\001CLIENTINFO FINGER shows real name, login name and idle time of user\001"}
        "TIME" {putserv "NOTICE $nick :\001CLIENTINFO TIME tells you the time on the user's host\001"}
        "PING" {putserv "NOTICE $nick :\001CLIENTINFO PING returns the arguments it receives\001"}
        "ECHO" {putserv "NOTICE $nick :\001CLIENTINFO ECHO returns the arguments it receives\001"}
        "INVITE" {putserv "NOTICE $nick :\001CLIENTINFO INVITE invite to channel specified\001"}
        "WHOAMI" {putserv "NOTICE $nick :\001CLIENTINFO WHOAMI user list information\001"}
        "OP" {putserv "NOTICE $nick :\001CLIENTINFO OP ops the person if on userlist\001"}
        "OPS" {putserv "NOTICE $nick :\001CLIENTINFO OPS ops the person if on userlist\001"}
        "UNBAN" {putserv "NOTICE $nick :\001CLIENTINFO UNBAN unbans the person from channel\001"}
        "IDENT" {putserv "NOTICE $nick :\001CLIENTINFO IDENT change userhost of userlist\001"}
        "XLINK" {putserv "NOTICE $nick :\001CLIENTINFO XLINK x-filez rule\001"}
        "UPTIME" {putserv "NOTICE $nick :\001CLIENTINFO UPTIME my uptime\001"}
        "default" {putserv "NOTICE $nick :\001ERRMSG CLIENTINFO: $arg is not a valid function\001"}
      }
      return 1
    }
    "VERSION" {
      putserv "NOTICE $nick :\001VERSION \002BitchX-$bx_version\002 by dJ_TEDY \002-\002 $bx_system :\002 Keep it to yourself!\002\001"
      return 1
    }
    "USERINFO" {
      putserv "NOTICE $nick :\001USERINFO \001"
      return 1
    }
    "FINGER" {
      putserv "NOTICE $nick :\001FINGER $realname ($bx_whoami@$bx_machine) Idle [expr [unixtime] - $bx_jointime] seconds\001"
      return 1
    }
    "PING" {
      putserv "NOTICE $nick :\001PING $arg\001"
      return 1
    }
    "ECHO" {
      if {[validchan $dest]} {return 1}
      putserv "NOTICE $nick :\001ECHO [string range $arg 0 59]\001"
      return 1
    }
    "ERRMSG" {
      if {[validchan $dest]} {return 1}
      putserv "NOTICE $nick :\001ERRMSG [string range $arg 0 59]\001"
      return 1
    }
    "INVITE" {
      if {(($arg == "") || ([validchan $dest]))} {return 1}
      set chanarg [lindex [split $arg] 0]
      if {((($bx_version == "75p1+") && ([string trim [string index $chanarg 0] "#+&"] == "")) || (($bx_version == "75p3+") && ([string trim [string index $chanarg 0] "#+&!"] == "")))} {
        if {[validchan $chanarg]} {
          putserv "NOTICE $nick :\002BitchX\002: Access Denied"
        } else {
          putserv "NOTICE $nick :\002BitchX\002: I'm not on that channel"
        }
      }
      return 1
    }
    "WHOAMI" {
      if {[validchan $dest]} {return 1}
      putserv "NOTICE $nick :\002BitchX\002: Access Denied"
      return 1
    }
    "OP" -
    "OPS" {
      if {(($arg == "") || ([validchan $dest]))} {return 1}
      putserv "NOTICE $nick :\002BitchX\002: I'm not on [lindex [split $arg] 0], or I'm not opped"
      return 1
    }
    "UNBAN" {
      if {(($arg == "") || ([validchan $dest]))} {return 1}
      if {[validchan [lindex [split $arg] 0]]} {
        putserv "NOTICE $nick :\002BitchX\002: Access Denied"
      } else {
        putserv "NOTICE $nick :\002BitchX\002: I'm not on that channel"
      }
      return 1
    }
  }
  return 0
}

proc bx_serverjoin {from keyword arg} {
  global botnick bx_jointime bx_isaway
  set bx_jointime [unixtime]
  set bx_isaway 0
  return 0
}

proc bx_away {} {
  global bx_jointime bx_isaway
  if {!$bx_isaway} {
    puthelp "AWAY :is away: (Auto-Away after 10 mins) \[\002BX\002-MsgLog [lindex {On Off} [rand 2]]\]"
    set bx_isaway 1
  } else {
    puthelp "AWAY"
    set bx_isaway 0
    set bx_jointime [unixtime]
  }
  if {![string match *bx_away* [timers]]} {
    timer [expr [rand 300] + 10] bx_away
  }
  return 0
}

proc bx_dccbitchx {hand idx arg} {
  global bx_away bx_flood bx_isaway bx_ver bx_version
  putcmdlog "#$hand# bitchx"
  putidx $idx "bitchxpack.tcl $bx_ver by slennox"
  putidx $idx "Currently simulating BitchX-$bx_version."
  if {[string match *bx_away* [timers]]} {
    if {$bx_isaway} {
      putidx $idx "Simulating AWAY mode (currently set away)."
    } else {
      putidx $idx "Simulating AWAY mode (currently not away)."
    }
  } else {
    putidx $idx "Not simulating AWAY mode."
  }
  putidx $idx "Flood is [lindex $bx_flood 0] CTCPs in [lindex $bx_flood 1] seconds (disable for [lindex $bx_flood 2] seconds)."
  return 0
}

set bx_flood [split $bx_flood :]
if {![info exists bx_flooded]} {
  set bx_flooded 0
}
if {![info exists bx_floodqueue]} {
  set bx_floodqueue 0
}
if {![info exists bx_onestack]} {
  set bx_onestack 0
}
if {![info exists bx_version]} {
  set bx_version [lindex {75p1+ 75p3+} [rand 2]]
}
set bx_jointime [unixtime]
set bx_system "*IX"
set bx_whoami $username
set bx_machine ""
catch {set bx_system [exec uname -s -r]}
catch {set bx_whoami [exec id -un]}
catch {set bx_machine [exec uname -n]}

if {$bx_away} {
  if {![info exists bx_isaway]} {
    set bx_isaway 0
  }
  if {![string match *bx_away* [timers]]} {
    timer [expr [rand 300] + 10] bx_away
  }
}

set bx_ver "v1.50"

if {$numversion >= 1032500} {
  set ctcp-mode 0
}

bind ctcp - CLIENTINFO bx_ctcp
bind ctcp - USERINFO bx_ctcp
bind ctcp - VERSION bx_ctcp
bind ctcp - FINGER bx_ctcp
bind ctcp - ERRMSG bx_ctcp
bind ctcp - ECHO bx_ctcp
bind ctcp - INVITE bx_ctcp
bind ctcp - WHOAMI bx_ctcp
bind ctcp - OP bx_ctcp
bind ctcp - OPS bx_ctcp
bind ctcp - UNBAN bx_ctcp
bind ctcp - PING bx_ctcp
bind ctcp - TIME bx_ctcp
bind dcc mnt bitchx bx_dccbitchx
bind raw - 001 bx_serverjoin

putlog "BitchX-Pack $bx_ver by dJ_TEDY Loaded."
