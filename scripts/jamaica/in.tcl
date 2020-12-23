# Kick/ban reason (channel msg)
set antipub(mreason) "12Invite!"

# Kick/ban reason (channel notice)
set antipub(nreason) "12Notice Detect"

# Kick/ban reason (private notice)
set antipub(nreas0n) "12Invite!"

# Kick/ban reason (channel ctcp)
set antipub(creason) "12Invite!"

# Kick/ban reason (private ctcp)
set antipub(creas0n) "12Invite!"

# Kick/ban reason (private msg)
set antipub(preason) "12Spam"

# Kick/ban reason (actions)
set antipub(areason) "12Invite!"

# Kick/ban reason (spam)
set antipub(sreason) "12Spam"

# Skip flag (eg. users who won't get kicked/banned for invite)
set antipub(skipflag) "f|f"

# Skip bots? (0: no, 1: yes)
set antipub(skipbots) "1"

# Skip warning notice (empty for none)
set antipub(warning) ""

# Ban time (minutes, 0 for permanent ban)
set antipub(bantime) "300"

# Ban type (1: nick!*@*, 2: *!*user@host, 3: *!*@host.domain, 4: *!*@*.domain)
set antipub(bantype) "3"

# Subnet length for IPv6 addresses (only for bantype 3 & 4)
set antipub(ipv6ban) "48"

# Notice check type (0: skip, 1: check, 2: direct kick)
set antipub(notice) "2"

# CTCP check type (0: skip, 1: check, 2: direct kick)
set antipub(ctcp) "2"

# Private msg check type (0: skip, 1: check)
set antipub(pmsg) "1"

# Action check type (0: skip, 1: check)
set antipub(action) "1"

# Spam checking (0: disable, 1: enable)
set antipub(spam) "1"

# Spam words
set antipub(words) {
  "*#*"
  "*/server*"
  "*/j*"
}

##############################################################################
# main code : you'd better not touch below unless you know what you're doing #
##############################################################################

# Some binds
bind pubm - * antipub:pubm
bind notc - * antipub:notc
bind ctcp - * antipub:ctcp
bind msgm - * antipub:msgm

# Check function for channel messages
proc antipub:pubm {nick uhost hand chan arg} {
  global antipub
  set user [lindex [split $uhost "@"] 0]
  set host [lindex [split $uhost "@"] 1]
  antipub:check $nick $user $host $hand $chan $arg $antipub(mreason)
}

# Check function for notices (both channel and private)
proc antipub:notc {nick uhost hand arg {dest ""}} {
  global botnick antipub
  if {$dest == ""} {set dest $botnick}
  set user [lindex [split $uhost "@"] 0]
  set host [lindex [split $uhost "@"] 1]
  if {$antipub(notice) == "2"} {
    if {[string tolower $dest] == [string tolower $botnick]} {
      antipub:check $nick $user $host $hand - $arg $antipub(nreas0n)
    } else {
      antipub:ban $nick $user $host $hand $dest $antipub(nreason)
    }
  } elseif {$antipub(notice) == "1"} {
    if {[string tolower $dest] == [string tolower $botnick]} {
      antipub:check $nick $user $host $hand - $arg $antipub(nreason)
    } else {
      antipub:check $nick $user $host $hand $dest $arg $antipub(nreason)
    }
  }
}

# Check function for CTCPs and actions (both channel and private)
proc antipub:ctcp {nick uhost hand dest key {arg ""}} {
  global botnick antipub
  set user [lindex [split $uhost "@"] 0]
  set host [lindex [split $uhost "@"] 1]
  if {[string tolower $key] == "action"} {
    if {$antipub(action) == "1"} {
      if {[string tolower $dest] == [string tolower $botnick]} {
        antipub:check $nick $user $host $hand - "$arg" $antipub(areason)
      } else {
        antipub:check $nick $user $host $hand $dest "$arg" $antipub(areason)
      }
    }
  } else {
    if {$antipub(ctcp) == "2"} {
      if {[string tolower $dest] == [string tolower $botnick]} {
        antipub:check $nick $user $host $hand - "$key $arg" $antipub(creas0n)
      } else {
        antipub:ban $nick $user $host $hand $dest $antipub(creason)
      }
    } elseif {$antipub(ctcp) == "1"} {
      if {[string tolower $dest] == [string tolower $botnick]} {
        antipub:check $nick $user $host $hand - "$key $arg" $antipub(creason)
      } else {
        antipub:check $nick $user $host $hand $dest "$key $arg" $antipub(creason)
      }
    }
  }
}

# Check function for private messages
proc antipub:msgm {nick uhost hand arg} {
  global botnick antipub
  set user [lindex [split $uhost "@"] 0]
  set host [lindex [split $uhost "@"] 1]
  if {$antipub(pmsg) == "1"} {
    antipub:check $nick $user $host $hand - $arg $antipub(preason)
  }
}

# Color/bold/underline/reverse/etc strip function
proc antipub:strip {arg} {
  set txt $arg
  set txt [regsub -all "\[\]\[0-9\]\[,0-9\]\[,0-9\]\[0-9\]\[0-9\]" $txt ""]
  set txt [regsub -all "\[\]\[0-9\]\[,0-9\]\[,0-9\]\[0-9\]" $txt ""]
  set txt [regsub -all "\[\]\[0-9\]\[,0-9\]\[,0-9\]" $txt ""]
  set txt [regsub -all "\[\]\[0-9\]\[,0-9\]" $txt ""]
  set txt [regsub -all "\[\]\[0-9\]" $txt ""]
  set txt [regsub -all "\[\]" $txt ""]
  return $txt
}

# Main check function
proc antipub:check {nick user host hand chan arg reason} {
  global antipub
  set txt [antipub:strip $arg]
  if {[string match "*#*" $txt]} {
    if {$chan == "-"} {
      antipub:ban $nick $user $host $hand $chan $reason
    } else {
      foreach w $txt {
        if {[string match "*#*" $w]} {
          if {[string tolower $w] != [string tolower $chan]} {
            antipub:ban $nick $user $host $hand $chan $reason
            return 0
          }
        }
      }
    }
  }
  if {$antipub(spam) == "1"} {
    foreach w $antipub(words) {
      if {[string match -nocase $w $txt]} {
        antipub:ban $nick $user $host $hand $chan $antipub(sreason)
        return 0
      }
    }
  }
}

# Law enforcement ;)
proc antipub:ban {nick user host hand chan reason} {
  global antipub botnick
  if {$chan == "-"} {
    if {[matchattr $hand $antipub(skipflag)]} {
      if {[string length $antipub(warning)] >= 1} {
        puthelp "NOTICE $nick :$antipub(warning)"
        return 0
      }
    } else {
      if {($antipub(skipbots) == "1") && ([matchattr $hand b])} {return 0}
      #newchanban [antipub:maskban $nick $user $host] "AntiPUB.TCL" $reason $antipub(bantime)
      #putserv "MODE $chan +b $host"
      newban *!*@$host flood $reason 30
      #putserv "KICK $chan $nick :$reason"
    }
  } else {
    if {[matchattr $hand $antipub(skipflag)]} {
      if {[string length $antipub(warning)] >= 1} {
        puthelp "NOTICE $nick :$antipub(warning)"
        return 0
      }
    } else {
      if {($antipub(skipbots) == "1") && ([matchattr $hand b])} {return 0}
      #putserv "MODE $chan +b $host"
      #putserv "KICK $chan $nick :$reason"
      newban *!*@$host flood $reason 30
      #putserv "MODE $chan +b [antipub:maskban $nick $user $host] "AntiPUB.TCL" $reason
    }
  }
}

# IPv6 ban-mask helper
proc antipub:maskipv6ban {host} {
  global antipub
  set result ""
  for {set i 0} {$i < [lindex [split [expr $antipub(ipv6ban) / 16] "."] 0]} {incr i} {
    append result [lindex [split $host ":"] $i]:
  }
  return $result*
}

# Ban-mask function
proc antipub:maskban {nick user host} {
  global antipub
  if {$antipub(bantype) == "1"} {
    return "$nick!*@*"
  }
  if {$antipub(bantype) == "2"} {
    set u [regsub "~" $user ""]
    return "*!*$u@$host"
  }
  if {$antipub(bantype) == "3"} {
    if {[string match *:* $host]} {
      return *!*@[antipub:maskipv6ban $host]
    }
    return "*!*@$host"
  }
  if {[string match *:* $host]} {
    return *!*@[antipub:maskipv6ban $host]
  }
  if {![regexp \[^0-9\].\[^0-9\].\[^0-9\].\[^0-9\] $host]} {
    return *!*@[join [lrange [split $host "."] 0 2] "."].*
  }
  if {[llength [split $host "."]] > 2} {
    return *!*@*.[join [lrange [split $host "."] [expr [llength [split $host "."]] - 2] end] "."]
  } else {
    return *!*@$host
  }
}
