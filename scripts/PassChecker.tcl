######################################################
##
##  Checkpass
##  Version 1.8
##
##  Original script for eggdrop 1.0 by Drago <Drago@Drago.com>
##  Updated and rewritten by Tothwolf <tothwolf@concentric.net>
##

# -----------------------------------------------------------------------------

# [channels] Channels to check when joined.
# "-" - check no channels
# "*" - check all channels 
# "#lamest #eggdrop" - check #lamest and #eggdrop
#
set checkpass-channels "*"

# [0/1] sets a random password for +d or +k users that don't have a password
set checkpass-dk-randpass 1

# -----------------------------------------------------------------------------

#
# No need to change anything below here.
#

set checkpass-ver 1.8

# to be sane...
if {![info exists checkpass-channels]} {set checkpass-channels "*"}
if {![info exists checkpass-dk-randpass]} {set checkpass-dk-randpass 1}
if {![info exists checkpass_delay]} {set checkpass_delay 300}


# allows masters to see who has an empty password
bind dcc m checkpass dcc:checkpass
proc dcc:checkpass {hand idx arg} {
  set count 0
  foreach user [userlist] {
    if {[passwdok $user ""]} {
      append list "$user, "
      incr count 1
    }
  }
  if {$count >= 1} {
    putdcc $idx "Users without a password ($count): [string trimright $list ", "]"
  } else {
    putdcc $idx "All users have a password set."
  }
  return 1
}

# binds checkpass to the listed channels
if {${checkpass-channels} == "*"} {
  bind join - * join:checkpass
} elseif {${checkpass-channels} != "-"} {
  foreach chan ${checkpass-channels} {
    bind join - "$chan *" join:checkpass
  }
}

# checks a user for an empty password on join
proc join:checkpass {nick uhost hand chan} {
  global checkpass_users checkpass-dk-randpass
  if {(![matchattr $hand b]) && ([passwdok $hand ""])} {
    set match [matchattr $hand -dk&-dk $chan]
    if {$match} {
      set checkpass_users([string tolower $hand]) [unixtime]
      putlog "Checkpass: $nick!$uhost ($hand) does not have a password set, sending a notice..."
      utimer 5 "checkpass:notice $nick"
      return 1
    } elseif {($match == 0) && (${checkpass-dk-randpass})} {
      setuser $hand PASS [checkpass:randpass 8]
      return 1
    }
  }
  return 0
}

# annoy people who refuse to set a password
bind time - "* * * * *" time:checkpass:1minute
proc time:checkpass:1minute {min hour day month year} {
  global checkpass-channels
  if {${checkpass-channels} == "-"} {
    return 0
  }
  if {(${checkpass-channels} == "*")} {
    foreach chan [channels] {
      checkpass:user:find $chan
    }
  } else {
    foreach chan ${checkpass-channels} {
      foreach chan2 [channels] {
        if {[string tolower $chan] == [$string tolower $chan2]} {
          checkpass:user:find $chan
        }
      }
    }
  }
  return 1
}

# runs checkpass:user:check and checkpass:user:count once an hour
bind time - "00 * * * *" time:checkpass:1hour
proc time:checkpass:1hour {min hour day month year} {
  checkpass:user:check
  checkpass:user:count
}

# unsets handles in array that are not online, or have a valid password set
proc checkpass:user:check {} {
  global checkpass_users
  foreach hand [array names checkpass_users] {
    set found 0
    foreach chan [channels] {
      set nick [hand2nick $hand $chan]
      if {$nick != ""} {
        set found 1
      }
    }
    if {($found == 0) || (![passwdok $hand ""])} {
      unset checkpass_users([string tolower $hand])
    }
  }
  return 1
}

# count users in userlist that have an empty password, set delay time
proc checkpass:user:count {} {
  global checkpass_delay
  set count 0
  foreach user [userlist -bdk&-dk] {
    if {[passwdok $user ""]} {
      incr count 1
    }
  }
  set delay [expr $count * 60]
  if {$delay < 300} {
    set checkpass_delay 300
  } else {
    set checkpass_delay $delay
  }
  return 1
}

# find users in a given channel that don't have a password set
proc checkpass:user:find {chan} {
  global checkpass_users checkpass_delay checkpass-dk-randpass
  foreach nick [chanlist $chan] {
    set hand [nick2hand $nick $chan]
    if {(![matchattr $hand b]) && ([passwdok $hand ""])} {
      set match [matchattr $hand -dk&-dk $chan]
      if {$match} {
        if {[info exists checkpass_users([string tolower $hand])]} {
          if {[expr [unixtime] - $checkpass_users([string tolower $hand]) >= $checkpass_delay]} {
            set checkpass_users([string tolower $hand]) [unixtime]
            checkpass:notice $nick
            return 1
          } else {
            unset checkpass_users([string tolower $hand])
          }
        } else {
          set checkpass_users([string tolower $hand]) [unixtime]
          checkpass:notice $nick
          return 1
        }
      } elseif {($match == 0) && (${checkpass-dk-randpass})} {
        setuser $hand PASS [checkpass:randpass 8]
        return 1
      }
    }
  }
  return 0
}

# sends a notice about setting a password to the given nick
proc checkpass:notice {nick} {
  global botnick
  putserv "NOTICE $nick :Hey $nick you don't have a password set :P"
  putserv "NOTICE $nick :Get it done now by typing: /msg $botnick pass <password>"
  return 1
}

# returns a random string of a given length
proc checkpass:randpass {length} {
  set count 0
  set chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  set rand ""
  while {$count != $length} {
    append rand [string index $chars [rand 63]]
    incr count 1
  }
  return "$rand"
}

# count users and set delay time
checkpass:user:count

# show if we loaded ok.

putlog "<<< script PassChecker loaded >>>"
