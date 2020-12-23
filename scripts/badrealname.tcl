# .1. What bad realnames should be banned?
set bwhois(list) {
"*p*o*w*e*r*e*d*b*y*n*a*r*c*o*t*i*c*"
"*p*o*w*e*r*e*d*b*y*s*p*a*m*b*u*s*t*e*r*"
"p*o*w*e*r*e*d*"
"*p*r*o*s*t*o*m*a*l*k*a*t*a*"
"Z*a*f*e*i*r*i*s*M*e*l*a*s*"
}

# .2. What bad channels should be banned?
set bwhois(chans) {#footters #mootherss #barrister}

# .3. Specify the ban reason and the ban time (in minutes) for a bad realname:
set bwhois(br) {"Infected droone (Expire: 1h)" 60}

# .4. Specify the ban reason and the ban time (in minutes) for a bad channel:
set bwhois(bc) {"Wrong channel boy!" 60}

# .4. Number of joins in seconds do a delayed whois.
set bwhois(flud) "5:3:10"

#
## ¤ Don't edit past here unless you know TCL! ¤
#

set bwhois(version) "0.1"
setudef flag badwhois

##
# ¤ binds

bind join * * badwhois:join
bind part - * badwhois:part
bind raw - 311 badwhois:check

##
# ¤ whois on join

proc badwhois:join {nick uhost hand chan} {
  global bflud bwhois
  if {![channel get $chan badwhois] || [isbotnick $nick ]} {
    return
  }
  if {![info exists bflud($chan)]} {
    set bflud($chan) 0
  }
  incr bflud($chan)
  utimer [lindex [set bla [split $bwhois(flud) ":"]] 1] [list incr bflud($chan) -1]
  if {$bflud($chan) >= [lindex $bla 0]} {
    puthelp "WHOIS $nick"
    } else {
    utimer [lindex $bla 2] [puthelp "WHOIS $nick"]
  }
  lappend bwhois(whois) "$nick:$chan:*!*@[lindex [split $uhost @] 1]"
}

##
# ¤ realname check

proc badwhois:check {from key txt} {
  global bwhois
  if {![info exists bwhois(whois)]} {
    set bwhois(whois) ""
  }
  if {[isbotnick [set nick [lindex [split $txt] 1]]] || [validuser [nick2hand $nick]]} {
    return
  }
  set realname [stripcodes bcruag [string range [join [lrange [split $txt] 5 end]] 1 end]]
  foreach bla $bwhois(list) {
    if {[string match -nocase $bla $realname]} {
      set position [lsearch $bwhois(whois) "*:[set mask *!*@[lindex $txt 3]]*"]
      if {[botisop [set chan [lindex [set t [split [lindex $bwhois(whois) $position] :]] 1]]]} {
        putquick "KICK $chan $nick :Banned: [lindex $bwhois(br) 0]" -next
      }
      newchanban $chan $mask BadWhois [lindex $bwhois(br) 0] [lindex $bwhois(br) 1]
      set bwhois(whois) [lreplace $bwhois(whois) $position $position]
      break
    }
  }
}

##
proc badwhois:part {nick uhost hand chan msg} {
  global bflud
  if {[isbotnick $nick] && [string match -nocase "*$chan*" [array names bflud]]} {
    array unset bflud $chan
  }
}

putlog "Èíñòàëèðàí: badrealname.tcl"