#### History ###
# # # Who - what
# 1.0 Pulse - initial release
# 1.1 Pulse - added: option to turn on script locally, type of punishment, type of banmask
#
# # #
###

# Settings

# Chans where the script is supposed to work. "" means all chans where bot is oppeed.
# if you wanna enable script in certain chans set chanz "#channel1 #channel2"
set chanz "#LanGame"

# Punishment method
# 1 - kick 2 - server ban 3 - local ban, 4 - global ban

set punishm "3"

# Kick Reason

set kickr "Don't use channel notice, \002only\002 channel ops(@)/voices(+) can use it."

# Ban type
# I guess it's enough ;)
# 1 - *!*@host.domain
# 2 - *!ident@host.domain
# 3 - *!*ident@host.domain
# 4 - *!ident@*
# 5 - *!*ident@*
# 6 - nick!*@*
# 7 - nick!ident@*
# 8 - nick!ident@host.doamin
# 9 - nick!*ident@host.domain
# 10 - nick!*@host

set bantype "1"

# Ban reason
set banr "Notice Messages kam kanala sa zabraneni edinstveno ops(@)/voices(+) mogat da go izpolzvat (30min.Ban)"

# Ban time in mins, 0 = perm ban, will be used only if you set punishm to 3 or 4
set btime "30"

bind NOTC - * NoticeBan

proc NoticeBan {nick uhost handle text dest} {
global botnick punishm kickr banr btime chanz bantype
if {(![validchan $dest]) || (![botisop $dest])} { return 0 }
if {[matchattr $nick mo|mo $dest] || [isop $nick $dest] || [isvoice $nick $dest] || [matchattr $nick o|o $dest]} {return 0} 
if {([isbotnick $nick]) || ([string tolower $nick] == "chanserv") || (![onchan $nick $dest])} {return 0} 
if {($chanz != "") && ([lsearch -exact [split [string tolower $chanz]] [string tolower $dest]] == -1)} {return 0} 
if {$punishm != "1"} {
switch -- $bantype { 
1 { set banmask "*!*@[lindex [split $uhost @] 1]" }
2 { set banmask "*!$uhost" }
3 { set banmask "*!*$uhost" }
4 { set banmask "*![lindex [split $uhost @] 0]@*" }
5 { set banmask "*!*[lindex [split $uhost @] 0]@*" }
6 { set banmask "$nick!*@*" } 
7 { set banmask "$nick![lindex [split $uhost @] 0]@*" }
8 { set banmask "$nick!$uhost" }
9 { set banmask "$nick!*$uhost" } 
10 { set banmask "$nick!*@[lindex [split $uhost @] 1]" } 
default { set banmask "*!*@[lindex [split $uhost @] 1]" }
return $banmask 
 }
}
if {$punishm == "1"} { 
putserv "KICK $dest $nick :$kickr"
}
if {$punishm == "2"} {
putserv "MODE $dest +b $banmask"
putserv "KICK $dest $nick :$kickr"
}
if {$punishm == "3"} {
newchanban "$dest" "$banmask" "NoticeBan" "$banr by (\002$nick\002!$uhost)" "$btime" 
putserv "KICK $dest $nick :$kickr"
}
if {$punishm == "4"} {
newban "$banmask" "NoticeBan" "$banr by (\002$nick\002!$uhost)" "$btime" 
putserv "KICK $dest $nick :$kickr"
}
return 1
  }

  
putlog "Loaded NotiecBan.tcl"