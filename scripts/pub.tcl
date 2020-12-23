bind pub o|o .o pubop
bind pub o|o .op pubop
bind pub o|o .@ pubop
bind pub o|o .gore pubop
bind pub o|o !o pubop
bind pub o|o !op pubop
bind pub o|o !@ pubop
bind pub o|o !gore pubop

bind pub o|o .-o pubdeop
bind pub o|o .-@ pubdeop
bind pub o|o .deop pubdeop
bind pub o|o .dop pubdeop
bind pub o|o .dolu pubdeop
bind pub o|o !-@ pubdeop
bind pub o|o !deop pubdeop
bind pub o|o !dop pubdeop
bind pub o|o !-o pubdeop
bind pub o|o !dolu pubdeop

bind pub ov|ov .v pubvoice
bind pub ov|ov .voice pubvoice
bind pub ov|ov !v pubvoice
bind pub ov|ov !voice pubvoice

bind pub ov|ov .-v pubdevoice
bind pub ov|ov !-v pubdevoice
bind pub ov|ov .devoice pubdevoice
bind pub ov|ov !devoice pubdevoice
bind pub ov|ov .dv pubdevoice
bind pub ov|ov !dv pubdevoice

bind pub o|o .ub pubunban
bind pub o|o .-b pubunban
bind pub o|o .unban pubunban
bind pub o|o .-ban pubunban
bind pub o|o !ub pubunban
bind pub o|o !-b pubunban
bind pub o|o !unban pubunban
bind pub o|o !-ban pubunban

bind pub m|m .cb pubclearbans
bind pub m|m .clbans pubclearbans
bind pub m|m .clearbans pubclearbans
bind pub m|m .clban pubclearbans
bind pub m|m !cb pubclearbans
bind pub m|m !clearbans pubclearbans
bind pub m|m !clbans pubclearbans
bind pub m|m !clban pubclearbans

bind pub o|o .topic pubtopic
bind pub o|o !topic pubtopic

bind pub o .uptime pubuptime
bind pub o !uptime pubuptime

bind pub m .rehash pubrehash
bind pub m !rehash pubrehash

bind pub n .reload pubreload
bind pub n !reload pubreload

bind pub m|m .save pubsave
bind pub m|m !save pubsave

bind pub - .time pubtime
bind pub - !time pubtime

bind pub m .mode pubmode
bind pub m .chanmode pubmode
bind pub m !mode pubmode
bind pub m !chanmode pubmode

bind pub p .bots pubbots
bind pub p !bots pubbots

bind pub o|o .kb pub_kickban
bind pub o|o .bk pub_kickban
bind pub o|o !bk pub_kickban
bind pub o|o !kb pub_kickban

bind pub o|o .b pub_ban
bind pub o|o .ban pub_ban
bind pub o|o !b pub_ban
bind pub o|o !ban pub_ban

bind pub o|o .k pub_kick
bind pub o|o .kick pub_kick
bind pub o|o !k pub_kick
bind pub o|o !kick pub_kick

bind pub o|o .b pub_ban
bind pub o|o .ban pub_ban
bind pub o|o !b pub_ban
bind pub o|o !ban pub_ban

bind pub o|o .status pubstatus
bind pub o|o .stat pubstatus
bind pub o|o !stat pubstatus
bind pub o|o !status pubstatus

proc pubop {nick host hand chan arg} {

 split $arg
 if {[llength $arg] == 0} {
 putserv "MODE $chan +o $nick"
 
 putlog "$nick@$chan op $chan"
	} else {

 split $arg
 if {[llength $arg] == 1} { set mode "+o" }

 if {[llength $arg] == 2} { set mode "+oo" }

 if {[llength $arg] == 3} { set mode "+ooo" }

 if {[llength $arg] == 4} { set mode "+oooo" }

 putserv "MODE $chan $mode $arg"
 
 putlog "$nick@$chan op $chan $arg"
	}
}

proc pubdeop {nick host hand chan arg} {
global botnick
if {[llength $arg] == 0} {
pushmode $chan -o $nick
putlog "$nick@$chan deop $chan"
return 0
} else {
foreach a [split $arg] {
if {([string match $botnick $a]) || ([matchattr [nick2hand $a] +b])} { 
putserv "PRIVMSG $chan : $nick ne moe barash botue :D" 
continue
 }
pushmode $chan -o $a
}
}
return 0 
}

proc pubvoice {nick uhost hand chan arg} {
 split $arg
 if {[llength $arg] == 0} {
 putserv "MODE $chan +v $nick"
 
 putlog "$nick@$chan voice $chan"
	} else {

 split $arg
 if {[llength $arg] == 1} { set mode "+v" }

 if {[llength $arg] == 2} { set mode "+vv" }

 if {[llength $arg] == 3} { set mode "+vvv" }

 if {[llength $arg] == 4} { set mode "+vvvv" }

 putserv "MODE $chan $mode $arg"
 
 putlog "$nick@$chan voice $chan $arg"
	}
}

proc pubdevoice {nick uhost hand chan arg} {
 split $arg
 if {[llength $arg] == 0} {
 putserv "MODE $chan -v $nick"
 
 putlog "$nick@$chan devoice $chan"
	} else {

 split $arg
 if {[llength $arg] == 1} { set mode "-v" }

 if {[llength $arg] == 2} { set mode "-vv" }

 if {[llength $arg] == 3} { set mode "-vvv" }

 if {[llength $arg] == 4} { set mode "-vvvv" }

 putserv "MODE $chan $mode $arg"
 
 putlog "$nick@$chan devoice $chan $arg"
	}
}

proc pubunban {nick uhost hand chan txt} {
    if {[onchan $txt $chan]} {
    set opc_uhost [getchanhost $txt $chan]
    set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
    set opc_bmask "*!*[string trimleft $opc_tmask *!]"
    putquick "mode $chan -b $opc_bmask"
    putlog "$nick@$chan unban $opc_bmask"
    return 0
  }
  putquick "mode $chan -b $txt"
  putlog "$nick@$chan unban $txt"
} 

proc pubclearbans {nick uhost hand chan txt} {
  putquick "privmsg $chan :Reseting bans on $chan..."
  putlog "$nick@$chan cb"
  resetbans $chan
} 

proc pubtopic {nick uhost hand chan arg} {
  putserv "topic $chan :$arg"
  putlog "$nick@$chan topic $chan $arg"
} 

proc pubtime {nick uhost hand chan arg} {
 putserv "privmsg $chan :[ctime [unixtime]]"
 putlog "$nick@$chan time $chan"
} 

proc pubuptime {nick uhost hand chan arg} {
 putserv "privmsg $chan :Mashine Uptime [string trim [exec uptime]]"
 putlog "$nick@$chan Mashine Uptime $chan"
}

proc pubrehash {nick uhost hand chan arg} {
rehash
putquick "privmsg $chan :Successfully rehashing."
} 
  
proc pubsave {nick uhost hand chan arg} {
save
putquick "privmsg $chan :Saving user file..."
} 

proc pubreload {bla blabla blablabla chan arg} {
reload
putquick "privmsg $chan :Successfully reloading my userfile."
} 

proc pubmode {nick uhost hand chan txt} {
  putquick "mode $chan $txt"
  putlog "$nick@$chan mode $txt"
} 

proc pubbots {nick uhost hand chan txt} {
  putlog "$nick@$chan bots"
  putquick "privmsg $chan :Bots: [bots]"
  putquick "privmsg $chan :Total: [llength [bots]]" 
} 

proc pubstatus {user uhost hand chan arg} {
  global botname botnick server version uptime admin
  putserv "privmsg $chan :User Database: Total:[countusers] Op:[llength [userlist +o]] Master:[llength [userlist +m]] Owner:[llength [userlist +n]] Bot:[llength [userlist +b]]"
  putserv "privmsg $chan :Number of bots on BotNet: [expr [llength [bots]] + 1]"
}

proc pub_kickban {nick uhost hand chan txt} {
  set opc_knick [lindex $txt 0]
  set opc_kreason [lrange $txt 1 end]
  if {[onchan $opc_knick $chan] == 0} {
    putquick "privmsg $chan :$opc_knick is not on $chan"
    return 0
  }
  if {[ispermowner $opc_knick]} {
    putquick "PRIVMSG $chan :$nick... tova vse pak e $opc_knick :]"
    putquick "kick $chan $nick :.. eban :D"
    return -1
  }  
  if {[matchattr $opc_knick +b]} {
    putquick "PRIVMSG $chan :$nick ne moe barash botue :D"
    return -1
  } 
  if {[matchattr $opc_knick +n]} {
    putquick "PRIVMSG $chan :$nick +n e... ne mislq che trqq da go kickash :D"
    return -1
  }
  if {$opc_kreason == ""} {
    set opc_uhost [getchanhost $opc_knick $chan]
    set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
    set opc_bmask "*!*[string trimleft $opc_tmask *!]"
    putquick "mode $chan +b $opc_bmask"
    putquick "kick $chan $opc_knick :$nick"
    putlog "$nick@$chan kb $opc_knick"
    return 0
  }
  set opc_uhost [getchanhost $opc_knick $chan]
  set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
  set opc_bmask "*!*[string trimleft $opc_tmask *!]"
  putquick "mode $chan +b $opc_bmask"
  putquick "kick $chan $opc_knick :$opc_kreason"
  putlog "$nick@$chan kb $opc_knick $opc_kreason"
} 

proc pub_kick {nick uhost hand chan txt} {
  set opc_knick [lindex $txt 0]
  set kreason [lrange $txt 1 end] 
  if {[onchan $opc_knick $chan] == 0} {
    putquick "privmsg $chan :$opc_knick is not on $chan"
    putlog "$nick@$chan failed kick $opc_knick"
    return 0
  } 
  if {[ispermowner $opc_knick]} {
    putquick "PRIVMSG $chan :$nick... tova vse pak e $opc_knick :]"
    putquick "kick $chan $nick :.. eban :D"
    return -1
  }  
  if {[matchattr $opc_knick +b]} {
    putquick "PRIVMSG $chan :$nick ne moe barash botue :D"
    return -1
  } 
  if {[matchattr $opc_knick +n]} {
    putquick "PRIVMSG $chan :$nick +n e... ne mislq che trqq da go kickash :D"
    return -1
  }
  if {$kreason == ""} {
    putquick "kick $chan $opc_knick :$nick"
    putlog "$nick@$chan kick $opc_knick"
  }
  putquick "kick $chan $opc_knick :$kreason"
  putlog "$nick@$chan kick $opc_knick $kreason"
} 

proc pub_ban {nick uhost hand chan txt} {
    if {[onchan $txt $chan]} {
    set opc_uhost [getchanhost $txt $chan]
    set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
    set opc_bmask "*!*[string trimleft $opc_tmask *!]"
    putquick "mode $chan +b $opc_bmask"
    putlog "$nick@$chan ban $opc_bmask"
    return 0
  }
  putquick "mode $chan +b $txt"
  putlog "$nick@$chan ban $txt"
} 