# cleanusers.tcl v1.1 (20 February 2000)
# copyright (c) 1999 by slennox <slennox@egghelp.org>
# slennox's eggdrop page - http://www.egghelp.org/
#
# Checks the userlist once a day and removes users who haven't been seen
# for a specified number of days. Can also remove users who don't have a
# password set. Written for iBuMp.
#
# DCC Commands
# .cleanlist   Lists users who haven't been seen for cu_days days. If
#              cu_pass is enabled, this also lists users who don't have a
#              password set. Users with cu_flags are excluded.
# .cleanusers  Deletes users who haven't been seen for cu_days days. If
#              cu_pass is enabled, also deletes users who don't have a
#              password set.
#
# Version History
# v1.0 - Initial release.
# v1.1 - Added option for clearing users who don't have a password set.

# Check the userlist once a day and automatically remove passwordless users
# (if cu_pass is enabled) and users who haven't been seen in cu_days days?
set cu_auto 1

# Remove users who haven't been seen in how many days?
set cu_days 40

# Remove users who don't have a password set?
set cu_pass 1

# Never remove users who have these global flags. This setting can be one
# flag like "n", multiple flags like "nt", or "" to remove regardless of
# flags.
set cu_flags "bnmEPA"

# Whenever the bot removes users automatically, send a note to the users
# specified here containing a list of users that were removed? This setting
# can be one user like "Tom", a list like "Tom Dick", or "" to disable.
set cu_note "dJ_TEDY"


# Don't edit below unless you know what you're doing.

proc cu_clean {min hour day month year} {
  global cu_note
  putlog "cleanusers: scanning userfile.."
  set remlist [cu_list]
  foreach hand $remlist {
    deluser $hand
  }
  if {(($cu_note != "") && ($remlist != ""))} {
    foreach recipient $cu_note {
      if {![validuser $recipient]} {continue}
      sendnote cleanusers $recipient "Removed users: [join $remlist ", "]"
    }
  }
  save
  putlog "cleanusers: removed [join $remlist ", "]"
  return
}

proc cu_dcccleanlist {hand idx arg} {
  global cu_days cu_pass
  putcmdlog "#$hand# cleanlist"
  if {$cu_pass} {
    putidx $idx "Listing passwordless users and users who haven't been seen for $cu_days days.."
  } else {
    putidx $idx "Listing users who haven't been seen for $cu_days days.."
  }
  set remlist [cu_list]
  if {$remlist == ""} {
    putidx $idx "No users found."
  } else {
    putidx $idx "Found [join $remlist ", "]"
  }
  return 0
}

proc cu_dcccleanusers {hand idx arg} {
  global cu_days cu_pass
  putcmdlog "#$hand# cleanusers"
  if {$cu_pass} {
    putidx $idx "Deleting passwordless users and users who haven't been seen for $cu_days days.."
  } else {
    putidx $idx "Deleting users who haven't been seen for $cu_days days.."
  }
  set remlist [cu_list]
  foreach hand $remlist {
    deluser $hand
  }
  if {$remlist == ""} {
    putidx $idx "No users found."
  } else {
    putidx $idx "Removed [join $remlist ", "]"
  }
  return 0
}

proc cu_list {} {
  global cu_days cu_flags cu_pass
  set remlist ""
  foreach hand [userlist] {
    if {(($cu_flags != "") && ([matchattr $hand $cu_flags]))} {continue}
    if {([set laston [lindex [getuser $hand LASTON] 0]] != "" && [expr ([unixtime] - $laston) / 86400] >= $cu_days) || ($cu_pass && [passwdok $hand ""])} {
      lappend remlist $hand
    }
  }
  return $remlist
}

set cu_note [split $cu_note]

bind dcc n cleanlist cu_dcccleanlist
bind dcc n cleanusers cu_dcccleanusers
bind time - "55 23 * * *" cu_clean
if {!$cu_auto} {
  unbind time - "55 23 * * *" cu_clean
}

putlog "Cleanusers v1.1 bY dJ_TEDY Loaded."
