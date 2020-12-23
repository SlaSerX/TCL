  #################################################################  
 ################################################################### 
####                   Public Commands TCL                       ####
###                            by                                 ###
###                          OrBoS                                ###
###                       for contacts:                           ###
####       orbos@mail.bg and #Weakness at UniBG irc Network      ####
 ################################################################### 
  #################################################################  
                                                                     
                                                                     
                                                                     
#####################################################################
##  info  ###########################################################
#####################################################################
###                                                               ###
##  Всички нужни публични команди във вариант с представка ! и .   ##
##  тези които имат няколко начина на изписване със сигурност ги   ##
##  има в пълния вариант и по-използваните съкращения ...          ##
##  няма "auth" и има сравнително добър HELP                       ##
###                                                               ###
#####################################################################
#################################################################### 
                                                                     
#####################################################################
##  op  #############################################################
#################################################################### 

bind pub o|o .op pub_op
bind pub o|o !op pub_op
proc pub_op {nick uhost hand chan txt} {
  if {$txt == ""} {
    putserv "mode $chan +o $nick"
    return 0
  }
  if {![onchan $txt $chan]} {
    putserv "notice $nick :$txt is not on $chan"
    return 0
  }
  putserv "mode $chan +o $txt"
}

#####################################################################
##  deop  ###########################################################
#################################################################### 

bind pub o|o .dop pub_deop
bind pub o|o !dop pub_deop
bind pub o|o .deop pub_deop
bind pub o|o !deop pub_deop
proc pub_deop {nick uhost hand chan txt} {
  if {$txt == ""} {
    putserv "mode $chan -o $nick"
    return 0
  }
  if {![onchan $txt $chan]} {
    putserv "notice $nick :$txt is not on $chan"
    return 0
  }
  putserv "mode $chan -o $txt"
}

#####################################################################
##  voice  ##########################################################
#################################################################### 

bind pub o|o .v pub_voice
bind pub o|o !v pub_voice
bind pub o|o .voice pub_voice
bind pub o|o !voice pub_voice
proc pub_voice {nick uhost hand chan txt} {
  if {$txt == ""} {
    putserv "mode $chan +v $nick"
    return 0
  }
  if {![onchan $txt $chan]} {
    putserv "notice $nick :$txt is not on $chan"
    return 0
  }
  putserv "mode $chan +v $txt"
}

#####################################################################
##  devoice  ########################################################
#################################################################### 

bind pub o|o .dev pub_devoice
bind pub o|o !dev pub_devoice
bind pub o|o .devoice pub_devoice
bind pub o|o !devoice pub_devoice
proc pub_devoice {nick uhost hand chan txt} {
  if {$txt == ""} {
    putserv "mode $chan -v $nick"
    return 0
  }
  if {![onchan $txt $chan]} {
    putserv "notice $nick :$txt is not on $chan"
    return 0
  }
  putserv "mode $chan -v $txt"
}

#####################################################################
##  kick  ###########################################################
#################################################################### 

bind pub o|o .k pub_kick
bind pub o|o !k pub_kick
bind pub o|o .kick pub_kick
bind pub o|o !kick pub_kick
proc pub_kick {nick uhost hand chan txt} {
  set opc_knick [lindex $txt 0]
  set opc_kreason [lrange $txt 1 end]
  if {![onchan $opc_knick $chan]} {
    putserv "notice $nick :$opc_knick is not on $chan"
    return 0
  }
  if {$opc_kreason == ""} {
    putserv "kick $chan $opc_knick :Requested by $nick"
    return 0
  }
  putserv "kick $chan $opc_knick :$opc_kreason"
}

#####################################################################
##  kban  ###########################################################
#################################################################### 

bind pub o|o .kb pub_kickban
bind pub o|o !kb pub_kickban
bind pub o|o .kban pub_kickban
bind pub o|o !kban pub_kickban
proc pub_kickban {nick uhost hand chan txt} {
  set opc_knick [lindex $txt 0]
  set opc_kreason [lrange $txt 1 end]
  if {![onchan $opc_knick $chan]} {
    putserv "notice $nick :$opc_knick is not on $chan"
    return 0
  }
  if {$opc_kreason == ""} {
    set opc_uhost [getchanhost $opc_knick $chan]
    set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
    set opc_bmask "*!*[string trimleft $opc_tmask *!]"
    putserv "mode $chan +b $opc_bmask"
    putserv "kick $chan $opc_knick :Requested by $nick"
    return 0
  }
  set opc_uhost [getchanhost $opc_knick $chan]
  set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
  set opc_bmask "*!*[string trimleft $opc_tmask *!]"
  putserv "mode $chan +b $opc_bmask"
  putserv "kick $chan $opc_knick :$opc_kreason"
}

#####################################################################
##  ban  ############################################################
#################################################################### 

bind pub o|o .b pub_ban
bind pub o|o !b pub_ban
bind pub o|o .ban pub_ban
bind pub o|o !ban pub_ban
proc pub_ban {nick uhost hand chan txt} {
  if {[onchan $txt $chan]} {
    set opc_uhost [getchanhost $txt $chan]
    set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
    set opc_bmask "*!*[string trimleft $opc_tmask *!]"
    putserv "mode $chan +b $opc_bmask"
    return 0
  }
  putserv "mode $chan +b $txt"
}

#####################################################################
##  unban  ##########################################################
#################################################################### 

bind pub o|o .ub pub_unban
bind pub o|o !ub pub_unban
bind pub o|o .unban pub_unban
bind pub o|o !unban pub_unban
proc pub_unban {nick uhost hand chan txt} {
  putserv "MODE $chan -b $txt"
}

#####################################################################
##  mode  ###########################################################
#################################################################### 

bind pub m .mode pub_mode
bind pub m !mode pub_mode
proc pub_mode {nick uhost hand chan txt} {
  putserv "mode $chan $txt"
}

#####################################################################
##  topic  ##########################################################
#################################################################### 

bind pub p .topic pub_topic
bind pub p !topic pub_topic
proc pub_topic {nick uhost hand chan txt} {
  putserv "topic $chan :$txt"
}

#####################################################################
##  time  ###########################################################
#################################################################### 

bind pub - .time pub_time
bind pub - !time pub_time
proc pub_time {nick uhost hand chan txt} {
putserv "PRIVMSG $chan :[ctime [unixtime]]"
}

#####################################################################
##  global ban  #####################################################
#################################################################### 

bind pub o|o .+ban pub_+ban
bind pub o|o !+ban pub_+ban
proc pub_+ban {nick uhost hand chan txt} {
  set opc_bmask [lindex $txt 0]
  set opc_breason [lrange $txt 1 end]
  if {$opc_breason == ""} {
    newban $opc_bmask $hand "Requested by $nick ($hand)"
    putserv "notice $nick :Added $opc_bmask to bot bans list"
    return 0
  }
  newban $opc_bmask $hand $opc_breason
  putserv "notice $nick :Added $opc_bmask to bot bans list with reason $opc_breason"
}

bind pub o|o .-ban pub_-ban
bind pub o|o !-ban pub_-ban
proc pub_-ban {nick uhost hand chan txt} {
  putserv "notice $nick :Removing $txt from bot global ban list..."
  killban $txt
}

bind pub o|o .bans pub_bans
bind pub o|o !bans pub_bans
proc pub_bans {nick uhost hand chan txt} {
  putserv "notice $nick :Listing bans..."
  foreach opc_tmpban [banlist] {
    putserv "notice $nick :$opc_tmpban"
  }
  putserv "notice $nick :End of bans list"
}

#####################################################################
##  reset bans  #####################################################
#################################################################### 

bind pub m .cb pub_clearbans
bind pub m !cb pub_clearbans
bind pub m .clearb pub_clearbans
bind pub m !clearb pub_clearbans
bind pub m .cban pub_clearbans
bind pub m !cban pub_clearbans
proc pub_clearbans {nick uhost hand chan txt} {
  putserv "notice $nick :Reseting bans on $chan..."
  resetbans $chan
}

#####################################################################
##  stats  ##########################################################
#################################################################### 

bind pub o|o .stats pub_status
bind pub o|o !stats pub_status
proc pub_status {nick uhost hand chan txt} {
  global server botname version
  putserv "privmsg $nick :\002Bot statistics:\002" 
  putserv "privmsg $nick :User records: [countusers]"
  putserv "privmsg $nick :My channels: [channels]"
  putserv "privmsg $nick :Linked bots: [bots]"
  putserv "privmsg $nick :My date: [date]"
  putserv "privmsg $nick :My time: [time]"
  putserv "privmsg $nick :My operating system: [unames]"
  putserv "privmsg $nick :Server: $server"
  putserv "privmsg $nick :My host: $botname"
  putserv "privmsg $nick :Eggdrop version: [lindex $version 0]"
}

#####################################################################
##  help  ###########################################################
#################################################################### 

bind pub p .help pub_help
bind pub p !help pub_help
proc pub_help {nick uhost hand chan txt} {
  if {[llength $txt]<11} {
    putserv "privmsg $nick :Help Menu"
    putserv "privmsg $nick :!op <nick> - ops \002nick\002"
    putserv "privmsg $nick :!deop <nick> - deops \002nick\002"
    putserv "privmsg $nick :!ban <nick/host> - bans a \002nick/host\002"
    putserv "privmsg $nick :!kick <nick> \[reason]\ - kicks a \002nick\002"
    putserv "privmsg $nick :!kban <nick> \[reason]\ - kick and bans a \002nick\002"
    putserv "privmsg $nick :!topic <text> - changes the channel topic"
    putserv "privmsg $nick :!unban <host> - unbans \002host\002 from channel"
    putserv "privmsg $nick :!voice <nick> - gives \002nick\002 voice"
    putserv "privmsg $nick :!devoice <nick> - takes away \002nick\002's voice"
    putserv "privmsg $nick :!time - gives you the date and time"
    putserv "privmsg $nick :!stats - gives you some statistics"
    putserv "privmsg $nick :!+ban <hostmask> \[reason]\ - adds global ban on bot"
    putserv "privmsg $nick :!-ban <hostmask> - removes global ban from bot"
    putserv "privmsg $nick :!bans - gives you a banlist for global & channel bans"
    putserv "privmsg $nick :!mode <mode change> - changes a mode setting on the channel"
    putserv "privmsg $nick :End"
    return 0
  }
}

putlog "TCL | Public Commands"

#####################################################################
##  End  ############################################################
#################################################################### 
######                                                               
###                                                                  
#!                                                                   

