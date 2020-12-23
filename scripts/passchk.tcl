#passchk.tcl by Bass @ undernet.  7/98
#This script ensures that all passwords set contain both letters and numbers,
#  are at least 6 chars long, and are dissimilar from the handle.
#It also cleans out old non-'+bnmo' entries, as well as entries w/o passwords.
#It also makes sure users who join the channel have a password set.
#
#This script is intendend to improve security as well as keep the userfile ordered.
#Note that previously set passwords are not checked for security.
#
#Note (1/99): the bweed portion requires eggdrop1.3.x
#
#bass@shell.lazerlink.net

bind msg -|- pass msg:passchk 
bind dcc - newpass dcc:passchk
bind dcc - chpass dcc:passchk2
proc msg:passchk {nick uhost hand args} {
  if {$hand == "*"} {return 0}
  set args [join $args]
  if {![passwdok $hand [lindex $args 0]]} {puthelp "notice $nick :Password incorrect."} {
    passchk $hand [lindex $args 1] 0 "$nick $uhost $hand $args"
  }
  return 0
}
proc dcc:passchk {hand idx args} {
  passchk $hand [lindex $args 0] 1 "$hand $idx $args"
}
proc dcc:passchk2 {hand idx args} {
  set args [join $args]
  if {![validuser [lindex $args 0]] || [lindex $args 1] == ""} {*dcc:chpass $hand $idx $args} {
    passchk [lindex $args 0] [lindex $args 1] 2 "$hand $idx $args"
  }
}
proc passchk {hand pass targ args} {
  set pass [string trim $pass " "]
  set args [join $args]
  if {[string trim $pass "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] == "" || [string trim $pass "0123456789"] == ""} {set reply "Password must contain both numbers and letters."} {set reply ""}
  if {[string length $pass] < 6} {set reply "$reply  Password must be at least 6 chars long."}
  set i [expr [string length $pass] - 3]
  while {$i >= 0} {
    if {[string match *[string range [string tolower $pass] $i [expr $i + 2]]* [string tolower $hand]]} {set reply "$reply  Password is too similar to handle." ; break}
    incr i -1
  }
  if {$reply != ""} {
    set reply "$reply  Try again." 
    if {$targ != 2} {putlog "$hand failed to select a secure password...  notifying user to try again."}
  }
  set reply [string trimleft $reply " "]
  switch $targ {
    0 {if {$reply == ""} {*msg:pass [lindex $args 0] [lindex $args 1] [lindex $args 2] [lrange $args 3 4]} {puthelp "notice [lindex $args 0] :$reply"} }
    1 {if {$reply == ""} {*dcc:newpass [lindex $args 0] [lindex $args 1] [lindex $args 2]} {putidx [lindex $args 1] "$reply"} }
    2 {if {$reply == ""} {*dcc:chpass [lindex $args 0] [lindex $args 1] [lrange $args 2 3]} {putidx [lindex $args 1] "$reply"} }
  }
}
bind dcc n|- bweed bweed
bind time - "9 21 * * *" bweed_timed
proc bweed_timed {a b c d e} {bweed * * "45 7"}
proc bweed {hand idx args} {
  set ulist [userlist -bnmo&-nmo]
  putlog "bweed running... currently [llength $ulist] users ([llength [userlist]] total)."
  set days [lindex [join $args] 0]
  set nopass [lindex [join $args] 1]
  if {$days == ""} {set days 45 ; set nopass 14} elseif {$nopass == ""} {set nopass 14}
  if {$days <= 7} {putlog "Delete ppl who haven't even been gone a week?  I don't think so." ; set days 45}
  foreach item $ulist {
    if {![validuser $item]} {putlog "No such user: $item" ; continue}
    if {[getuser $item laston] == ""} {continue}
    set time [expr ([unixtime] - [lindex [getuser $item laston] 0]) / 86400]
    if {($time > $days) || (($time > $nopass) && [passwdok $item ""])} {deluser $item}
  }
  putlog "bweed done.  currently [llength [userlist -bnmo&-nmo]] ([llength [userlist]] total)."
}
bind join -|- * join:chkpass
proc join:chkpass {nick uhost hand chan} {
  global botnick
  if {[passwdok $hand ""]} {
    putlog "$nick ($hand) does not have a password set.  Notifying $nick."
    puthelp "notice $nick :You don't have a password set.  If you don't have a password set after 5 days, you will be deleted from the userfile.  Please set one now by typing: /msg $botnick pass <password>"
  }
}
