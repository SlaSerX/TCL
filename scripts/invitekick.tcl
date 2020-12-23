##################################################################
#Tova e mnogo po dobar tcl za invite ot drugite koito ste vigdali#  
#ne sym siguren che napulno                                      # 
#bachka no kakto znaete vseki tcl si ima bugove...               #
##################################################################
bind pubm - "*j #*" pub_dont_invite
bind pubm - "*/join*" pub_dont_invite
bind pubm - "*go* #*" pub_dont_invite
bind pubm - "*goto #*" pub_dont_invite
bind pubm - "*come *#*" pub_dont_invite
bind pubm - "*join #*" pub_dont_invite
bind pubm - "*j* #*" pub_dont_invite
bind pubm - "*ela* #*" pub_dont_invite
bind pubm - "*elate*#*" pub_dont_invite
bind pubm - "*elate*" pub_dont_invite

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
putserv "KICK $channel $nick :\002Inviter..Detected..Banned!"
return 1
}
putlog "invite.tcl by Banned loaded  "