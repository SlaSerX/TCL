bind pubm - "*join #*" pub_dont_invite
bind pubm - "*/join*" pub_dont_invite
bind pubm - "*go*" pub_dont_invite
bind pubm - "*goto*" pub_dont_invite
bind pubm - "*come*" pub_dont_invite
bind pubm - "*join*" pub_dont_invite
bind pubm - "*#*" pub_dont_invite

proc pub_dont_invite {nick host handle channel arg} {
global botnick
if {![isop $botnick $channel]} {return 0}
if {[isop $nick $channel]} {
return 1
}
set n2hand [nick2hand $nick $channel]
if { [matchattr $n2hand b] || [matchattr $n2hand n]} {
return 1
}
if [regexp -nocase dcc $nick] {return 0}
set banmask "*!*[string trimleft [maskhost [getchanhost $nick $channel]] *!]"
set targmask "*!*[string trimleft $banmask *!]"
set ban $targmask
putserv "mode $channel +b $ban"
putserv "mode $channel +m"
putserv "mode $channel +r"
putserv "Kick $channel $nick :\002 No invites"

return 1
}

putlog "adver.tcl By Ultimate loaded mustafa84@usa.net "
