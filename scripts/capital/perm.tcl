unbind dcc n|n msg *dcc:msg
bind dcc  n msg denied:msg
bind filt n ".su*" dcc_su
bind filt n ".die*" dcc_die
bind filt n ".viewtcl*" dcc_viewtcl
bind filt n ".loadtcl*" dcc_loadtcl
bind filt n ".unloadtcl*" dcc_unloadtcl
bind filt n ".dump*" dcc_dump
bind dcc  - umatch dcc_umatch
bind filt n ".chatt* * *" dcc_chattr
bind filt n ".+chan*" dcc_chan

proc ownercheck {checkhand} {
 global owner
 foreach i [split $owner " ,"] {
  if {[string tolower $i] == [string tolower $checkhand]} { return 1 }
  }
 return 0
}


proc denied:msg {hand idx arg} {
    set msg [string tolower [lindex $arg 0]]
    set text [lrange $arg 1 end]
        if {$msg=="ns" || $msg=="cs" } {
        if {([ownercheck [idx2hand $idx]]) } {
   putserv "PRIVMSG $msg :$text"
   putdcc $idx "msg to $msg: $text"
    } else {
putdcc $idx "Access Denied !" 
      }
    } else {
putserv "PRIVMSG $msg :$text "
putdcc $idx "msg to $msg: $text"
  }
}

proc dcc_umatch {hand idx arg} {
 if {[string tolower [lindex $arg 0]] == "help"} {
  putdcc $idx "Polzvai: usermatch \[flags\] \[#channel\]"
 } else {
  if {[lindex $arg 0] != ""} {
   set flags [lindex $arg 0]
   if {[lindex $arg 1] != ""} {
    set chan [lindex $arg 1]
    if {![validchan $chan]} {
     putdcc $idx "Greshka: Nqma takav kanal"
     return 0
    }
    if {[string match *|* $flags]} { set flags [lindex [split $flags |] 0]&[lindex [split $flags |] 1] } \
    else { set flags "&$flags" }
    set userlist [userlist $flags $chan]
   } else { set userlist [userlist $flags] }
  } else { set userlist [userlist] }
  putdcc $idx "Tarsene..."
  set i2 0
  foreach i $userlist {
   if {[passwdok $i ""]} { putdcc $idx "$i +[chattr $i] : Has no password set yet" } \
   else { putdcc $idx "$i +[chattr $i]" }
   incr i2
  }
  putdcc $idx "Found $i2 match(s) out of [countusers] users"
 }
 return 1
}

proc dcc_chattr {idx arg} {
global nick owner
 if {(![string match [string tolower [lindex $arg 0]]* ".chattr"]) || ([ownercheck [idx2hand $idx]]) || (![string match *n* [lindex $arg 2]])} {
  return $arg
 } else {
  foreach i [split $owner " ,"] {
  sendnote $nick $i "[idx2hand $idx] se e opital da sloji/premahne \"n\" flag na [lindex $arg 1]" }
  putlog "[idx2hand $idx] se opitva da sloji/premahne \"n\" flag na [lindex $arg 1]"
  putdcc $idx "Samo Permanent Owners imat pravo da slagat/premahvat \"n\" flag ."
  putdcc $idx "Access Denied !"
  return
 }
}

proc dcc_su {idx arg} {
global nick owner
 if {(![string match [string tolower [lindex $arg 0]]* ".su"]) || ([ownercheck [idx2hand $idx]])} {
  return $arg
 } else {
  foreach i [split $owner " ,"] {
  sendnote $nick $i "[idx2hand $idx] se e opitval da \".su\" [lindex $arg 1]" }
  putlog "[idx2hand $idx] se opitva da \".su\" [lindex $arg 1]"
  putdcc $idx "Access Denied !"
  return
 }
}

proc dcc_die {idx arg} {
global nick owner
 if {(![string match [string tolower [lindex $arg 0]]* ".die"]) || ([ownercheck [idx2hand $idx]])} {
  return $arg
 } else {
  foreach i [split $owner " ,"] {
  sendnote $nick $i "[idx2hand $idx] se e opital da die $nick" }
  putlog "[idx2hand $idx] se opitva da die $nick"
  putdcc $idx "Access Denied !"
  return
 }
}

proc dcc_viewtcl {idx arg} {
global nick owner
 if {(![string match [string tolower [lindex $arg 0]]* ".viewtcl"]) || ([ownercheck [idx2hand $idx]])} {
  return $arg
 } else {
  foreach i [split $owner " ,"] {
  sendnote $nick $i "[idx2hand $idx] se e opital da gledka kwi tcl`s ima $nick" }
  putlog "[idx2hand $idx] se opitva da gledka kwi tcl`s ima $nick"
  putdcc $idx "Access Denied !"
  return
 }
}

proc dcc_loadtcl {idx arg} {
global nick owner
 if {(![string match [string tolower [lindex $arg 0]]* ".loadtcl"]) || ([ownercheck [idx2hand $idx]])} {
  return $arg
 } else {
  foreach i [split $owner " ,"] {
  sendnote $nick $i "[idx2hand $idx] se e opital da loadwa tcl`s ima $nick" }
  putlog "[idx2hand $idx] se opitva da loadwa tcl`s na $nick"
  putdcc $idx "Access Denied !"
  return
 }
}

proc dcc_unloadtcl {idx arg} {
global nick owner
 if {(![string match [string tolower [lindex $arg 0]]* ".unloadtcl"]) || ([ownercheck [idx2hand $idx]])} {
  return $arg
 } else {
  foreach i [split $owner " ,"] {
  sendnote $nick $i "[idx2hand $idx] se e opital da unloadwa tcl`s ima $nick" }
  putlog "[idx2hand $idx] se opitva da unloadwa tcl`s na $nick"
  putdcc $idx "Access Denied !"
  return
 }
}

proc dcc_dump {idx arg} {
global nick owner
 if {(![string match [string tolower [lindex $arg 0]]* ".dump"]) || ([ownercheck [idx2hand $idx]])} {
  return $arg
 } else {
  foreach i [split $owner " ,"] {
  sendnote $nick $i "[idx2hand $idx] se e opital da dump v $nick" }
  putlog "[idx2hand $idx] se opitva da dump v $nick"
  putdcc $idx "Access Denied !"
  return
 }
}

proc dcc_chan {idx arg} {
global nick owner
 if {(![string match [string tolower [lindex $arg 0]]* ".+chan"]) || ([ownercheck [idx2hand $idx]])} {
  return $arg
 } else {
  foreach i [split $owner " ,"] {
  sendnote $nick $i "[idx2hand $idx] se e opitval da vkara $nick v kanal [lindex $arg 1]" }
  putdcc $idx "Za da vkarash $nick v [lindex $arg 1] se obarni za pomost kam permanent owner !"
  putdcc $idx "Access Denied !"
  return
 }
}

putlog "Loaded:perm.tcl"

