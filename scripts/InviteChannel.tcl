##################################################################
# TCL InviteChannel by Kiril Georgiev a.k.a Arkadietz            #
# email: <Arkadietz@yahoo.com>                                   #
##################################################################
bind pubm - "#*#*" pub_dont_invite
bind pubm - "*#*#*" pub_dont_invite
bind pubm - "#*#*#*" pub_dont_invite
bind pubm - "*#*#*#*" pub_dont_invite
bind pubm - "#* #*" pub_dont_invite
bind pubm - "*#* #*" pub_dont_invite
bind pubm - "#* #* #*" pub_dont_invite
bind pubm - "*#* #* #*" pub_dont_invite
bind pubm - "#* *#*" pub_dont_invite
bind pubm - "*#* *#*" pub_dont_invite
bind pubm - "#* *#* *#*" pub_dont_invite
bind pubm - "*#* *#* *#*" pub_dont_invite
bind pubm - "#* * #*" pub_dont_invite
bind pubm - "#* * *#*" pub_dont_invite
bind pubm - "*#* * #*" pub_dont_invite
bind pubm - "*#* * *#*" pub_dont_invite
bind pubm - "#* * #* * #*" pub_dont_invite
bind pubm - "#* * *#* *#*" pub_dont_invite
bind pubm - "*#* * #* * #*" pub_dont_invite
bind pubm - "*#* * *#* *#*" pub_dont_invite
bind pubm - "*/join #*" pub_dont_invite
bind pubm - "*join #*" pub_dont_invite
bind pubm - "*join* #*" pub_dont_invite
bind pubm - "*/join" pub_dont_invite
bind pubm - "*/join*" pub_dont_invite
bind pubm - "*/j0in #*" pub_dont_invite
bind pubm - "*j0in #*" pub_dont_invite
bind pubm - "*/j0in" pub_dont_invite
bind pubm - "*/j0in*" pub_dont_invite
bind pubm - "*/j #*" pub_dont_invite
bind pubm - "*/j* #*" pub_dont_invite
bind pubm - "*/j* * #*" pub_dont_invite
bind pubm - "*join#*" pub_dont_invite
bind pubm - "*join*#*" pub_dont_invite
bind pubm - "*j0|n#*" pub_dont_invite
bind pubm - "*j0|n*#*" pub_dont_invite
bind pubm - "*j0in#*" pub_dont_invite
bind pubm - "*j0in*#*" pub_dont_invite
bind pubm - "*jo|n#*" pub_dont_invite
bind pubm - "*jo|n*#*" pub_dont_invite
bind pubm - "*join to * * #*" pub_dont_invite
bind pubm - "*join to your #*" pub_dont_invite
bind pubm - "*join to your * #*" pub_dont_invite
bind pubm - "*go * #*" pub_dont_invite
bind pubm - "*to #*" pub_dont_invite
bind pubm - "*come *#*" pub_dont_invite
bind pubm - "*come to #*" pub_dont_invite
bind pubm - "*come to* #*" pub_dont_invite
bind pubm - "*come #*" pub_dont_invite
bind pubm - "*come /j" pub_dont_invite
bind pubm - "*come /join" pub_dont_invite
bind pubm - "*come to /j" pub_dont_invite
bind pubm - "*come to /join" pub_dont_invite
bind pubm - "*come /join #*" pub_dont_invite
bind pubm - "*come *join #*" pub_dont_invite
bind pubm - "*cometo #*" pub_dont_invite
bind pubm - "*cometo* #*" pub_dont_invite
bind pubm - "*cometo /j" pub_dont_invite
bind pubm - "*cometo /join" pub_dont_invite
bind pubm - "*cometo /j" pub_dont_invite
bind pubm - "*cometo /join" pub_dont_invite
bind pubm - "*come join* #*" pub_dont_invite
bind pubm - "*come * join* #*" pub_dont_invite
bind pubm - "*come join my* http://" pub_dont_invite
bind pubm - "*come join my* #*" pub_dont_invite
bind pubm - "*come * join my* #*" pub_dont_invite

proc pub_dont_invite {nick host handle channel arg} {
global botnick
if {![isop $botnick $channel]} {return 0}
if {[isop $nick $channel]} {
return 0
}
set n2hand [nick2hand $nick $channel]
if {([matchattr $n2hand m] || [matchattr $n2hand p]  || [matchattr $n2hand b] || [matchattr $n2hand n] || [matchattr $n2hand f])} {
return 0
}
if [regexp -nocase dcc $nick] {return 0}
set banmask "*!*[string trimleft [maskhost [getchanhost $nick $channel]] *!]"
set targmask "*!*[string trimleft $banmask *!]"
set ban $targmask

pushmode $channel +b $ban
putserv "kick $channel $nick :\002 $nick - $targmask Reklamata v $channel se zaplashta!"
return 1
}
putlog "TCL | Invite Channel"
