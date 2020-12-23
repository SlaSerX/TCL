################## Main Script Config. #############################
set trigger "!" 
set helpcmd "help"
set dkick "odi obikoli malko nqkade iz grada"
################## End of Main Script Config ####################### 
 
################## Swear Kick Config. ##############################
# [0/1] Set this if you want swearkick enabled. (if set to 0, ignore all other swearkick configs)
set swearkick 1
# What access does a user need to bypass the swearkick?
set swearmode "+o"
# Set default SwearKick reason.
set sweareason "Get Out of City"
# Set Channels for SwearKick to be active in.
set skchans "#"
#set skchans "#Channel2"
#set skchans "#Channel3"
#set skchans "#Channel4"
################# End of SwearKick Config. #########################  

################# DONT TOUCH ANYTHING BELOW HERE ###################
# Global Settings
set _ohver_ "1.3"
set _ohcn_ "beta"

# Aliases (DO NOT REMOVE ANY ALIASES! THE SCRIPT DEPENDS ON THEM!)
proc char {} {
  global trigger
  return $trigger
}
proc helpcmd {} {
  global helpcmd
  return $helpcmd
}

# Bindings - Wow theres alot of em.
bind pub o|o "[char]op" pub_op
bind pub o|o "[char]deop" pub_deop
bind pub o|o "[char]hop" pub_halfop
bind pub o|o "[char]hdeop" pub_halfdeop
bind pub o|o "[char]voice" pub_voice
bind pub o|o "[char]devoice" pub_devoice
bind pub - "[char]version" pub_version
bind pub o|o "[char]kbn" pub_kbn
bind pub o|o "[char]kb" pub_kb
bind pub o|o "[char]k" pub_k
bind pub o|o "[char]pb" pub_pb
bind pub o|o "[char]topic" pub_topic
bind pub o|o "[char]ban" pub_ban
bind pub o|o "[char]unban" pub_unban
bind pub o|o "[char]listbans" pub_listban
bind pub - "[char][helpcmd]" pub_help
bind pub o|o "[char]addpb" pub_addpb
bind pub m|m "[char]chanmode" pub_chanmode
bind pub m|m "[char]adduser" pub_adduser
bind pub m|m "[char]deluser" pub_deluser
bind pub m|m "[char]addhost" pub_addhost
bind pub m|m "[char]delhost" pub_delhost
bind pub m|m "[char]chattr" pub_chattr
bind pub m|m "[char]restart" pub_restart
bind pub m|m "[char]rehash" pub_rehash
bind pub - "[char]status" pub_status
bind pub -|"[char]info" pub_info
bind pub o|o "[char]invite" pub_invite

####################### Auto Configure Section ######################
#putlog "Auto-Configurator for OpHelp - v$_ohver_ by SmasHinG"
#putlog "Checking and Finding System..."
if {[string match "*linux*" [string tolower [unames]]] == 1} {
   set ohsys "[unames] - The choice of the GNU generation"
}
if {[string match "*bsd*" [string tolower [unames]]] == 1} {
   set ohsys "[unames] - BSD RuLZ!"
}
if {([string match "*sun*" [string tolower [unames]]] == 1) || ([string match "*solaris*" [string tolower [unames]]] == 
1)} {
   set ohsys "[unames] - Nai-posle UNIX!"
}
if {[string match "*cygnus*" [string tolower [unames]]] == 1} {
   set ohsys "[unames] - Eggdrops sa syzdadeni za UNIX, a ne za skapaniq Windows"
}
#putlog "$ohsys"
#putlog "Finding Eggdrop Version..."
#putlog "[lindex $version 0]"
if {$numversion < 1030000} {
   putlog "Vnimanie! OpHelp e syzdaden za botove s versiq 1.3.0 nagore! Inache moje da imate problemi."
}
#putlog "Command Trigger = [char]"
#putlog "Help Komanda = [char][helpcmd]"
#putlog "OpHelp Versiq: $_ohver_"
#putlog "OpHelp Master: $_ohcn_"
########################### Main Section ############################
# [char][helpcmd]
proc pub_help {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
     return 0
  }
  global _ohver_ _ohcn_
  set chkarg [lindex $arg 0]
  if {$chkarg == ""} {
     putserv "NOTICE $user :\002OpHelp - v$_ohver_\[$_ohcn_\]\002by \002SmasHinG\002 <SmasHinG@LanGame.OrG>."
     putserv "NOTICE $user :Kategorii."
     putserv "NOTICE $user : \002[char][helpcmd] user\002 - Spisyk s komandi za Potrebiteli"
     putserv "NOTICE $user : \002[char][helpcmd] op\002 - Spisyk s komandi za Operatori"
     putserv "NOTICE $user : \002[char][helpcmd] master\002 - Spisyk s komandi za Masters i Owners"
     putserv "NOTICE $user :Mojete da poluchite poveche informaciq kato napishete [char]komanda -help"
     return 0
     }
  if {$chkarg == "user"} {
     putserv "NOTICE $user :\002\[Potrebitelski Komandi\]\002"
     putserv "NOTICE $user :  \002[char]ping\002 - Proverka na lag-a."
     putserv "NOTICE $user :  \002[char]status\002 - Dai info za bota"
     putserv "NOTICE $user :  \002[char]version\002 - Pokaji versiqta na scripta v kanala."
     putserv "NOTICE $user :  \002[char]info\002 - Zadai info na potrebitel. [char]info none - Iztrii info na potrebitel."
     return 0
     }
  if {$chkarg == "op"} {   
     putserv "NOTICE $user :\[Operatorski Komandi\]"
     putserv "NOTICE $user :  \002[char]op \[nick\]\002 - \002[char]deop \[nick\]\002 - \002[char]voice \[nick\]\002 - \002[char]devoice \[nick\]\002"
     putserv "NOTICE $user :  \002[char]topic <topic>\002"
     putserv "NOTICE $user :  \002[char]k <nick> \[reason\]\002 - \002[char]kb <nick> \[reason\]\002 - \002[char]pb <nick> \[reason\]\002"
     putserv "NOTICE $user :  \002[char]ban <mask>\002 - \002[char]listbans \[all\]\002 - \002[char]unban <mask>\002 - \002[char]addpb <mask> \[reason\]\002"
     putserv "NOTICE $user :  \002[char]addhost <handle> <newhost>\002 - \002[char]delhost <handle> <host>\002 - \002[char]invite <user>\002"
     return 0
     }
  if {$chkarg == "master"} {
     putserv "NOTICE $user :\[Masterski i Ownerski Komandi\]"
     putserv "NOTICE $user : \002[char]adduser <username> <hostmask> \[op/master/owner\]\002 - Dobavi potrebitel kato Op/Master/Owner"
     putserv "NOTICE $user : \002[char]deluser <handle>\002 - Iztrii potrebitel."
     putserv "NOTICE $user : \002[char]chattr <handle> <attr>\002 - Zadai flagove na potrebitel."
     putserv "NOTICE $user : \002[char]rehash\002 - Rehash na bot-a."
     putserv "NOTICE $user : \002[char]restart\002 - Restart na bot-a."
     return 0
  }
}

# [char]op
proc pub_op {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
     return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]op Help\]"
     putserv "NOTICE $user :Usage: [char]op \[nick\]"
     putserv "NOTICE $user :Give a user Ops."
     return 0
  }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan +o :$user"
     putlog "$chan: Giving $user Ops"
     return 0   
     } 
  set opuser [lindex $arg 0]
  if {[onchan $opuser $chan] == 0} {
     putserv "PRIVMSG $chan :$opuser is not in the channel."
     return 0 
     }
  putserv "MODE $chan +o :$opuser"
  putlog "$chan: Giving $opuser Ops by request of $user\[$hand\]"
}

# [char]deop
proc pub_deop {user uhost hand chan arg} {
 if {[check $uhost $user] == 0} {
     return 0
 }
 if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]deop Help\]"
     putserv "NOTICE $user :Usage: [char]deop \[nick\]"
     putserv "NOTICE $user :Deop a user in a channel."
     return 0
     }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan -o :$user"
     putlog "$chan: Taking Ops away from $user"
     return 0
     }
  set dopuser [lindex $arg 0]
  if {[onchan $dopuser $chan] == 0} {
     putserv "PRIVMSG $chan :$dopuser is not in the channel."
     return 0
     }
  putserv "MODE $chan -o :$dopuser"
  putlog "$chan: Taking Ops away from $dopuser by request of $user"
}

# [char]hop
proc pub_hop {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
     return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]hop Help\]"
     putserv "NOTICE $user :Usage: [char]op \[nick\]"
     putserv "NOTICE $user :Give a user HalfOps."
     return 0
  }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan +h :$user"
     putlog "$chan: Giving $user HalfOps"
     return 0   
     } 
  set opuser [lindex $arg 0]
  if {[onchan $opuser $chan] == 0} {
     putserv "PRIVMSG $chan :$opuser is not in the channel."
     return 0 
     }
  putserv "MODE $chan +h :$opuser"
  putlog "$chan: Giving $opuser HalfOps by request of $user\[$hand\]"
}

# [char]dehop
proc pub_dehop {user uhost hand chan arg} {
 if {[check $uhost $user] == 0} {
     return 0
 }
 if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]deop Help\]"
     putserv "NOTICE $user :Usage: [char]hdeop \[nick\]"
     putserv "NOTICE $user :Deop a user in a channel."
     return 0
     }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan -h :$user"
     putlog "$chan: Taking HalfOps away from $user"
     return 0
     }
  set dopuser [lindex $arg 0]
  if {[onchan $dopuser $chan] == 0} {
     putserv "PRIVMSG $chan :$dopuser is not in the channel."
     return 0
     }
  putserv "MODE $chan -h :$dopuser"
  putlog "$chan: Taking halfOps away from $dopuser by request of $user"
}

# [char]voice
proc pub_voice {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]voice Help\]"
     putserv "NOTICE $user :Usage: [char]voice \[nick\]"
     putserv "NOTICE $user :Voice a user."
     return 0
     }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan +v :$user"
     putlog "$chan: Giving $user Voice"
     return 0
     }
  set voiceuser [lindex $arg 0]
  if {[onchan $voiceuser $chan] == 0} {
     putserv "PRIVMSG $chan :$voiceuser is not in the channel."
     return 0
     }
  putserv "MODE $chan +v :$voiceuser"
  putlog "$chan: Giving $voiceuser Voice by request of $user"
}

# [char]devoice
proc pub_devoice {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]devoice Help\]"
     putserv "NOTICE $user :Usage: [char]devoice \[nick\]"
     putserv "NOTICE $user :Will take voices away from a person"
     return 0
     }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan -v :$user"
     putlog "$chan: Taking Voice away from $user"
     return 0
     }
 set dvoiceuser [lindex $arg 0]
  if {[onchan $dvoiceuser $chan] == 0} {
     putserv "PRIVMSG $chan :$dvoiceuser is not in the channel."
     return 0
     }
  putserv "MODE $chan -v :$dvoiceuser"
  putlog "$chan: Taking Voice away from $dvoiceuser by request of $user"
}

# [char]kb 
proc pub_kb {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  global botnick dkick
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]kb Help\]"
     putserv "NOTICE $user :Usage: [char]kb <nick> \[reason\]"
     putserv "NOTICE $user :KickBan a user."
     return 0
     }
  if {[lindex $arg 0] == ""} {   
     putserv "PRIVMSG $chan :Usage: [char]kb <nick> \[reason\]"
     return 0
     }
  set kbuser [string tolower [lindex $arg 0]]
  set chkuser [nick2hand $kbuser $chan]
  if {$kbuser == [string tolower $botnick]} {
     putserv "PRIVMSG $chan :I'm not that stupid."
     return 0
     }
  if {[matchattr $chkuser +m] == 1} {
     putserv "PRIVMSG $chan :I dont think so."
     return 0
     }
  if {[onchan $kbuser $chan] == 0} {
     putserv "PRIVMSG $chan :$kbuser is not in the channel."
     return 0
     }
  set reason [lrange $arg 1 end]
  set host "$kbuser![getchanhost $kbuser $chan]"
  set mask [maskhost $host]
  putserv "MODE $chan +b $mask"
  if {$reason == ""} {
     putserv "KICK $chan $kbuser :$dkick"
     putlog "$chan: KickBan by $user\[$hand\]: $chan \[$kbuser\]$mask $dkick"
     return 0
     }
  putserv "KICK $chan $kbuser :$reason"
  putlog "$chan: KickBan by $user\[$hand\]: $chan \[$kbuser\]$mask $reason"
  return 0
}

# [char]kbn
proc pub_kbn {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  global botnick dkick
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]kbn Help\]"
     putserv "NOTICE $user :Usage: [char]kbn <nick> \[reason\]"
     putserv "NOTICE $user :KickBan a user."
     return 0
     }
  if {[lindex $arg 0] == ""} {   
     putserv "PRIVMSG $chan :Usage: [char]kbn <nick> \[reason\]"
     return 0
     }
  set kbuser [string tolower [lindex $arg 0]]
  set chkuser [nick2hand $kbuser $chan]
  if {$kbuser == [string tolower $botnick]} {
     putserv "PRIVMSG $chan :I'm not that stupid."
     return 0
     }
  if {[matchattr $chkuser +m] == 1} {
     putserv "PRIVMSG $chan :I dont think so."
     return 0
     }
  if {[onchan $kbuser $chan] == 0} {
     putserv "PRIVMSG $chan :$kbuser is not in the channel."
     return 0
     }
  set reason [lrange $arg 1 end]
  set host "$kbuser![getchanhost $kbuser $chan]"
  set mask [maskhost $nick]
  putserv "MODE $chan +b $nick"
  if {$reason == ""} {
     putserv "KICK $chan $kbuser :$dkick"
     putlog "$chan: KickBan by $user\[$hand\]: $chan \[$kbuser\]$mask $dkick"
     return 0
     }
  putserv "KICK $chan $kbuser :$reason"
  putlog "$chan: KickBan by $user\[$hand\]: $chan \[$kbuser\]$mask $reason"
  return 0
}

# [char]k
proc pub_k {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  global botnick dkick
  set kuser [string tolower [lindex $arg 0]]
  set reason [lrange $arg 1 end]
  set chkuser [nick2hand $kuser $chan]
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]k Help\]"
     putserv "NOTICE $user :Usage: [char]k <nick> \[reason\]"
     putserv "NOTICE $user :Kicks a user."
     return 0
     }
  if {[lrange $arg 0 end] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]k <nick> \[reason\]"
     return 0
     }
  if {$kuser == [string tolower $botnick]} {
     putserv "PRIVMSG $chan :I don't like kicking myself."
     return 0
     }
  if {[matchattr $chkuser +m] == 1} {
     putserv "PRIVMSG $chan :I dont think so."
     return 0
     }
  if {$reason == ""} {
     putserv "KICK $chan $kuser :$dkick"
     putlog "$chan: Kicking $kuser by request of $user for: $dkick"
     return 0
     }
  putserv "KICK $chan $kuser :$reason"
  putlog "$chan: Kicking $kuser by request of $user for: $reason"
}

# [char]topic
proc pub_topic {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  set topic [lrange $arg 0 end]
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]topic Help\]"
     putserv "NOTICE $user :Usage: [char]topic <topic>"
     putserv "NOTICE $user :Changes Topic."
     return 0
     }
  putserv "TOPIC $chan :$topic"
  putlog "$chan: Changing topic too \"$topic\" by request of $user\[$hand\]"
}

# [char]pb 
proc pub_pb {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  global botnick dkick
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]pb Help\]"
     putserv "NOTICE $user :[char]pb <nick> \[reason\]"
     putserv "NOTICE $user :PermBans a user."
     return 0
     }
  if {[lindex $arg 0] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]pb <nick> \[reason\]"
     return 0
     }
  set pbuser [string tolower [lindex $arg 0]]
  set chkuser [nick2hand $pbuser $chan]
  if {$pbuser == [string tolower $botnick]} {
     putserv "PRIVMSG $chan :I'm not that stupid."
     return 0
     }
  if {[matchattr $chkuser +m] == 1} {
     putserv "PRIVMSG $chan :I dont think so."
     return 0
     }
  if {[onchan $pbuser $chan] == 0} {
     putserv "PRIVMSG $chan :$pbuser is not in the channel."
     return 0
     }
  set reason [lrange $arg 1 end]
  set host "$pbuser![getchanhost $pbuser $chan]"
  set mask [maskhost $host]
  putserv "PRIVMSG $chan :\002PermBan Set On:\002 $host"
  putserv "MODE $chan +b :$mask"
  if {$reason == ""} {
     putserv "KICK $chan $pbuser :$dkick"
     putlog "$chan: New PermBan added by $user\[$hand\]: $chan \[$pbuser\]$mask $dkick"
     newchanban $chan $mask $hand $dkick 0
     return 0
     }
  putserv "KICK $chan $pbuser :$reason"
  putlog "$chan: New PermBan added by $user\[$hand\]: $chan \[$pbuser\]$mask $reason"
  newchanban $chan $mask $hand $reason 0
  return 0
}

# [char]ban
proc pub_ban {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  global botname dkick
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]ban Help\]"
     putserv "NOTICE $user :Usage: [char]ban <mask> \[reason\]"
     putserv "NOTICE $user :Bans a mask."
     return 0
     }
  set ban [lindex $arg 0]
  set reason [lrange $arg 1 end]
  if {$ban == [maskhost $botname]} {
     putserv "PRIVMSG $chan :I'm not going to ban my host."
     return 0
     }
  if {$ban == ""} {
     putserv "PRIVMSG $chan :Usage: [char]ban <mask> [reason]"
     return 0
     }
  if {$reason == ""} {
     newchanban $chan $ban $hand $dkick
     putlog "$chan: Banning $ban by request of $user"
     return 0
  }
  newchanban $chan $ban $hand $reason
  putlog "$chan: Banning $ban by request of $user"
  return 0
}

# [char]unban
proc pub_unban {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]unban Help\]"
     putserv "NOTICE $user :Usage: [char]unban <mask>"
     putserv "NOTICE $user :UnBans a mask."
     return 0
     }
  set unban [lindex $arg 0]
  if {$unban == ""} {
     putserv "PRIVMSG $chan :Usage: [char]unban <mask>"
     }
  putserv "MODE $chan -b :$unban"
  putlog "$chan: UnBanning $unban by request of $user"
}

# [char]addpb
proc pub_addpb {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  global dkick botname
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]addpb Help\]"
     putserv "NOTICE $user :Usage: [char]addpb <mask> \[reason\]"
     putserv "NOTICE $user :Adds a mask too the PermBan list."
     return 0
     }
  set mask [lindex $arg 0]
  set reason [lrange $arg 1 end]
  if {[lrange $arg 0 end] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]addpb <mask> \[reason\]"
     return 0
     }
  if {$mask == [maskhost $botname]} {
     putserv "PRIVMSG $chan :I'm not going to PermBan my host."
     return 0
     }
  if {$reason == ""} {
     putserv "PRIVMSG $chan :Setting $mask as \002Permban\002."
     newchanban $chan $mask $hand $dkick 0
     putlog "$chan: New PermBan added by $user\[$hand\]: $mask"
     return 0
     }
  putserv "PRIVMSG $chan :Setting $mask as Permban with reason: $reason"
  newchanban $chan $mask $hand $reason 0   
  putlog "$chan: New Permban added by $user\[$hand\]: $mask"
  return 0
}

# [char]chanmode
proc pub_chanmode {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]chanmode Help\]"
     putserv "NOTICE $user :Usage: [char]chanmode <mode> \[modearg\]"
     putserv "NOTICE $user :Change channel modes."
     return 0
     }
  set mode [lindex $arg 0]
  set modearg [lrange $arg 1 end]
  if {[lrange $arg 0 end] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]chanmode <mode> \[modearg\]"
     return 0
     }
  if {$modearg == ""} {
     putlog "$chan: Setting $chan mode to $mode by request of $user"
     putserv "MODE $chan $mode"
     return 0
     }
  putlog "$chan: Setting $chan mode to $mode by request of $user"
  putserv "MODE $chan $mode :$modearg"
  return 0
}

# [char]adduser
proc pub_adduser {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]adduser Help\]"
     putserv "NOTICE $user :Usage: [char]adduser <username> \[op/master/owner\]"
     putserv "NOTICE $user :Adds a use as a Op/Master/Owner"
     return 0
     }
  set username [lindex $arg 0]
  set host [lindex $arg 1]
  set access [string tolower [lindex $arg 2]]
  if {[string length $username] > 9} {
     putserv "PRIVMSG $chan :Username is to large."
     return 0
     }
  if {$access == "normal"} {
     if {[matchattr $user +o] == 0} {
        putserv "PRIVMSG $chan :You must have \002Op\002 access to add somoeone as a \002Normal User\002."
        return 0
        }
     }
     putserv "PRIVMSG $chan :Adding $username as a \002Normal User\002."
  if {$access == "op"} {
     if {[matchattr $user +m] == 0} {
        putserv "PRIVMSG $chan :You must have \002Master\002 access to add someone as a \002Op\002."
        return 0
        }
     putserv "PRIVMSG $chan :Adding $username as a \002Op\002."
     adduser $username $host
     chattr $username +oO
     return 0
     }
  if {$access == "master"} {
     if {[matchattr $user +n] == 0} {
        putserv "PRIVMSG $chan :You must have \002Owner\002 Access to add someone as a \002Master\002."
        return 0
        }
     putserv "PRIVMSG $chan :Adding $username as a \002Master\002."
     adduser $username $host
     chattr $username +m
     return 0
     }
  if {$access == "owner"} {
     if {[matchattr $user +n] == 0} {
        putserv "PRIVMSG $chan :You must have \002Owner\002 Access to add someone as a \002Owner\002."
        return 0
        }
     putserv "PRIVMSG $chan :Adding $username as a \002Owner\002."
     adduser $username $host
     chattr $username +n
     return 0
     }
  putserv "PRIVMSG $chan :Usage: [char]adduser <username> <hostmask> \[op/master/owner\]"
  return 0
}

# [char]version
proc pub_version {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  global skchans swearkick _ohver_ _ohcn_ botnick
   if {$swearkick == 1} {
      foreach i $skchans {
         if {$chan == $i} {
            putserv "PRIVMSG $chan :I am running \002OpHelp - 
v$_ohver_\[$_ohcn_\]\002 with \002SwearKick\[Enabled\]\002 by 
\002SmasHinG\002 <SmasHinG@LanGame.OrG>. Pishi [char][helpcmd] za spisyk s komandi."
            return 0
            }
         }
      }
  putserv "PRIVMSG $chan :I am running \002OpHelp - 
v$_ohver_\[$_ohcn_\]\002 with \002SwearKick\[Disabled\]\002 by 
\002SmasHinG\002 <SmasHinG@LanGame.OrG>. Pishi [char][helpcmd] za spisyk 
s 
komandi."
  return 0
}

# [char]status
proc pub_status {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  global botname botnick server version uptime admin ohsys
  putserv "NOTICE $user :$botnick Status:"
  putserv "NOTICE $user :Baza danni na bota: Vsichko: [countusers] Operatori: [llength [userlist +o]] Masters: [llength [userlist +m]]"
  putserv "NOTICE $user :               Owners: [llength [userlist +n]] Bot:[llength [userlist +b]]"
  if {[matchattr $hand +n] == 1} {
    putserv "NOTICE $user :Ti si: Owner"
    }
  if {[matchattr $hand +m] == 1} {
    putserv "NOTICE $user :Ti si: Master"
    }
  if {[matchattr $hand +o] == 1} {
    putserv "NOTICE $user :Ti si: Operator"
    }
  putserv "NOTICE $user :Kanali, v koito e bota: ([llength [channels]]) [channels]"
  putserv "NOTICE $user :Broi botove v BotNet-a: [expr [llength [bots]] + 1]"
  putserv "NOTICE $user :Server: $server"
  putserv "NOTICE $user :Sobstvenik: $admin"
  putserv "NOTICE $user :Bot Nick: $botname"
  putserv "NOTICE $user :Bot Versiq: [lindex $version 0]"
  putserv "NOTICE $user :Bota e na liniq ot: [ctime $uptime]"
  putserv "NOTICE $user :Data i chas: [ctime [unixtime]]"
  putserv "NOTICE $user :Operacionna sistema: $ohsys"
}

# [char]deluser
proc pub_deluser {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]deluser Help\]"
     putserv "NOTICE $user :Usage: [char]deluser <handle>"
     putserv "NOTICE $user :Deletes a handle from database."
     return 0
     }
  set deluser [lindex $arg 0]
  if {[matchattr $deluser +n] == 1} {
     putserv "PRIVMSG $chan :Owners can only be removed from \002DCC\002 or \002Telnet\002, This prevents spoofers from 
removing them."
     return 0
     }
  if {[matchattr $deluser +m] == 1} {
     putserv "PRIVMSG $chan :Masters can only be removed from \002DCC\002 or \002Telnet\002, This prevents spoofers 
from removing them."
     return 0
     }
  if {[lrange $arg 0 end] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]deluser <handle>"
     return 0
     }
  if {[validuser $deluser] == 0} {
     putserv "PRIVMSG $chan :User does not exist in Database."
     return 0
     }
  putserv "PRIVMSG $chan :Removing $deluser from User Database."
  putlog "Removing $deluser by request of $user\[$hand\]"
  deluser $deluser
  return 0
}

# [char]addhost
proc pub_addhost {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     notice "\[[char]addhost Help\]"
     notice "Usage: [char]addhost <handle> <newhost>"
     notice "Adds a host too a handle."
     return 0
     }
  set hhand [lindex $arg 0]
  set newhost [lrange $arg 1 end]
  if {[validuser $hhand] == 0} {
     putserv "PRIVMSG $chan :User does not exist in Database."
     return 0
     }
  if {[lrange $arg 0 end] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]addhost <handle> <newhost>"
     return 0
     }
  if {[lindex $arg 1] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]addhost <handle> <newhost>"
     return 0
     }
  if {[matchattr $hhand +n] == 1} {
     if {[matchattr $hand +n] == 0} {
        putserv "PRIVMSG $chan :Only Owners may add hosts too other Owners."
        return 0
        }
     }
  if {[matchattr $hhand +m] == 1} {
     if {[matchattr $hand +m] == 1} {
        putserv "PRIVMSG $chan :Adding host $newhost to $hhand"
        putlog "Adding host $newhost to $hhand by request of $user\[$hand\]"
        setuser $hhand HOSTS $newhost
        return 0
        }
     putserv "PRIVMSG $chan :Only Masters and Owners may add hosts too other Masters."
     return 0
     }
  putlog "Adding host $newhost to $hhand by request of $user\[$hand\]"
  putserv "PRIVMSG $chan :Adding host $newhost to $hhand"
  setuser $hhand HOSTS $newhost
  return 0
}

# [char]delhost
proc pub_delhost {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]delhost Help\]"
     putserv "NOTICE $user :Usage: [char]delhost <handle> <host>"
     putserv "NOTICE $user :Delete a host from a handle."
     return 0
     }
  set hhand [lindex $arg 0]
  set delhost [lrange $arg 1 end]
  if {[lrange $arg 0 end] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]delhost <handle> <host>"
     return 0
     }
  if {[lrange $arg 1 end] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]delhost <handle> <host>"
     return 0
     }
  if {[validuser $hhand] == 0} {
     putserv "User does not exist in Database."
     return 0
     }
  if {[matchattr $hhand +n] == 1} {
     if {[matchattr $hand +n] == 0} {
        putserv "PRIVMSG $chan :Only Owners may remove hosts of other Owners."
        return 0
        }
     }
  if {[matchattr $hhand +m] == 1} {
     if {[matchattr $hand +m] == 1} {
        putserv "PRIVMSG $chan :Removing host $delhost from $hhand"
        putlog "Removing host $delhost from $hhand by request of $user\[$hand\]"
        delhost $hhand $delhost
        return 0
        }
     putserv "PRIVMSG $chan :Only Masters and Owners may remove hosts of other Masters."
     return 0
     }
  putserv "PRIVMSG $chan :Removing host $delhost from $hhand"
  putlog "Removing host $delhost from $hhand by request of $user\[$hand\]"
  delhost $hhand $delhost
  return 0
}

# [char]chattr
proc pub_chattr {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]chattr Help\]"
     putserv "NOTICE $user :Usage: [char]chattr <handle> <attr>"
     putserv "NOTICE $user :Change a handle's attr."
     return 0
     }
  set hhand [lindex $arg 0]
  set attr [lindex $arg 1]
  if {[validuser $hhand] == 0} {
     putserv "PRIVMSG $chan :User is not in my userfile."
     return 0
     }
  if {[matchattr $hand +n] == 1} {
     putserv "PRIVMSG $chan :Changing $hhand attr to $attr."
     putlog "Changing $hhand attr to $attr."
     chattr $hhand $attr
     return 0
     }
  if {[matchattr $hand +m] == 1} {
     if {[matchattr $hhand +n] == 1} {
        putserv "PRIVMSG $chan :You cannot change a Owners attr."
        return 0
        }
     if {[matchattr $hhand +m] == 1} {
        putserv "PRIVMSG $chan :You cannot change a Masters attr."
        return 0
        }
     putserv "PRIVMSG $chan :Changing $hhand attr to $attr."
     putlog "Changing $hhand attr to $attr."
     chattr $hhand $attr
     return 0
     }
  return 0    
}

# [char]rehash
proc pub_rehash {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  putserv "PRIVMSG $chan :Rehashing....."
  putlog "$user\[$hand\] is rehashing the bot..."
  rehash
  return 0
}
  
# [char]restart
proc pub_restart {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  putserv "PRIVMSG $chan :Restarting..."
  putlog "$user\[$hand\] is restarting the bot..."
  utimer 2 restart
  return 0
}
     
# [char]listbans [all]
proc pub_listban {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]listbans Help\]"
     putserv "NOTICE $user :Usage: [char]listbans \[all\]"
     putserv "NOTICE $user :List Bans."
     return 0
     }
  set chkarg [lindex $arg 0]
  if {$chkarg == ""} {
     if {[banlist $chan] == ""} {
        putserv "PRIVMSG $chan :There are currently no bans for $chan. Type \"[char]listbans all\" for a list of global 
bans."
        return 0
        }
     putserv "PRIVMSG $chan :Bans for $chan"
     foreach lb [banlist $chan] {
       set lbban [lindex $lb 0]
       set lbreason [lindex $lb 1]
       set lbset [ctime [lindex $lb 3]]
       set lbby [lindex $lb 5]
       putserv "PRIVMSG $chan :$lbban ($lbreason) - Date Set: $lbset - Set by: $lbby"
       }
     putserv "PRIVMSG $chan :Type \"[char]listbans all\" for a list of global bans."
     return 0
     }
  if {$chkarg == "all"} {
     if {[banlist] == ""} {
        putserv "PRIVMSG $chan :There are currently no global bans set in the bot."
        return 0
        }
     putserv "PRIVMSG $chan :Global Bans."
     foreach lbg [banlist] {
       set lbgban [lindex $lbg 0]
       set lbgreason [lindex $lbg 1]
       set lbgset [ctime [lindex $lbg 3]]
       set lbgby [lindex $lbg 5]
       putserv "PRIVMSG $chan :$lbgban ($lbgreason) - Date Set: $lbgset - Set By: $lbgby"
       }
     return 0
     }
  putserv "PRIVMSG $chan :Usage: [char]listbans \[all\]"
  return 0
}

# [char]info
proc pub_info {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  global botnick
  if {[validuser $hand] == 0} {
     putserv "PRIVMSG $chan :Nepoznat potrebitel! Predstavi se kato napishesh \002/msg $botnick hello\002 ili ako si dobaven veche pishi \002/msg $botnick ident parolata_ti\002"
     return 0
     }
  if {[lrange $arg 0 end] == ""} {
     if {[getchaninfo $hand $chan] == ""} {
        putserv "PRIVMSG $chan :Info line not set in $chan"
        return 0
        }
     putserv "PRIVMSG $chan :Your Current Infoline: \002[getchaninfo $hand $chan]\002"
     return 0
     }
  if {[string tolower [lrange $arg 0 end]] == "none"} {
     setchaninfo $hand $chan ""
     putserv "PRIVMSG $chan :Removed info line for $user in $chan"
     return 0
     }
  putserv "PRIVMSG $chan :Added new info line: \002[lrange $arg 0 end]\002"
  setchaninfo $hand $chan "[lrange $arg 0 end]"
  return 0
}
     
proc pub_invite {user uhost hand chan arg} {
  if {[check $uhost $user] == 0} {
      return 0
  }
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]invite Help\]"
     putserv "NOTICE $user :Usage: [char]invite <user>"
     putserv "NOTICE $user :Invite user to channel."
     return 0
     }
 if {[lrange $arg 0 end] == ""} {
     putserv "PRIVMSG $chan :Usage: [char]invite <user>"
     return 0
     }
  if {[onchan [lindex $arg 0] $chan] == 1} {
     putserv "PRIVMSG $chan :User is already on the channel."
     return 0
     }
  putserv "PRIVMSG $chan :Inviting [lindex $arg 0] to the channel."
  putserv "INVITE [lindex $arg 0] $chan"
  return 0
}

######################## End of Main Section #################################

######################## Swear Kick Section ##################################
# SwearKick is part of OpHelper, but is worked on as a seperate project.
# since i never do use the swearkick for my channels i never really take
# time too work on it much. I have taken the time during the development of
# OpHelper1.8 to update and enhance the SwearKick to work for bots in Multi
# channels, If you have any requests or bug reports on SwearKick or OpHelper
# please send them too roadx@linux.damn.st, Thanks and Enjoy :)
# Adding a swear word. Adding a swearword is very simple, just add this too
# the bind listings: bind pubm - "*swearword*" pub_swear
# Replace 'swearword' with the real swearword.

# Bindings for SwearKick.
#bind pubm - "*fuck*" pub_swear
#bind pubm - "*shit*" pub_swear
#bind pubm - "kyr*" pub_swear
#bind pubm - "*bitch*" pub_swear
#bind pubm - "*putka*" pub_swear
#bind pubm - "*gey*" pub_swear
#bind pubm - "*hui*" pub_swear
#bind pubm - "*huq*" pub_swear
#bind pubm - "*pussy*" pub_swear
#bind pubm - "*pedal*" pub_swear
#bind pubm - "*ebi*" pub_swear
#bind pubm - "*eba*" pub_swear


# Actual SwearKick Script
proc pub_swear {user uhost hand chan arg} {
  global swearkick swearmode sweareason skchans
  if {$swearkick == 1} {
     foreach i $skchans {
        if {$chan == $i} {
           if {[matchattr $hand $swearmode] == 1} {
              putserv "PRIVMSG $chan :\001ACTION Slaps $user upside the head \002\"Meri Si Prikazkite ;)\"\002\001"
              return 0
              }
#           putlog "$chan: SwearWord detected by $user."
#           putserv "PRIVMSG $chan :\002SwearWord detected! Kicking $user\002"
           putserv "KICK $chan $user :$sweareason"
           }
        }
     }
  }
####################### End of Swear Kick Section ###########################

set file "scripts/.hosts"
set howmm 3
set howmt 1
set index "Primeren hosts file, forma: <host> <kolko puti e kazal nesto> <koga go e kazal vav forma unixtime>"

set fh [open $file w]
puts $fh "$index"
close $fh

proc check {uhost nick} {
    global file index howmm
    set success 0
    set write 1
    set host [lindex [split $uhost @] 1]
    set hostf [open $file r]
    set hostfd [open ${file}.tmp w]
    set nosay 0
    while {![eof $hostf]} {
        set chast [gets $hostf]
        if {$chast == $index} {
            # Good The file seems goody =)
        } elseif {[lindex [split $chast " "] 0] == $host} {
            set howm [lindex [split $chast " "] 1]
	    if {$howm >= $howmm} {
	        puthelp "NOTICE $nick :kopeleee shto ne se pospresh, tui da ne e mandra"
		set nosay 1
		set write 0
		set success 0
	    } else {
		set success 1
	        set chastn "$host [expr $howm + 1] [unixtime]"
	    }
        }
        if {$success == 1} {
	    puts $hostfd $chastn
            set success 0
            set write 0
        } else {
            if {$chast != ""} {
                puts $hostfd $chast
            }
        }
    }
    if {$write == 1} {
        puts $hostfd "$host 1 [unixtime]"
        close $hostfd
        close $hostf
        file rename -force ${file}.tmp $file
	return 1
    }
    if {$nosay == 0} {
        close $hostfd
        close $hostf
        file rename -force ${file}.tmp $file
	return 1
    }
    close $hostfd
    close $hostf
    file rename -force ${file}.tmp $file
    return 0
    return 1
}

timer 2 checkrem

proc checkrem {} {
    global file index howmt
    set goon 0
    set hostf [open $file r]
    set hostfd [open ${file}.tmp w]
    while {![eof $hostf]} {
        set chast [gets $hostf]
        if {$chast == $index} {
            # Good The File Seems Goody =)
            set goon 1
        } else {
            if {$chast != ""} {
                set time [lindex [split $chast " "] 2]
                if {[expr [expr [unixtime] - $time] * 10] > [expr $howmt * 60]} {
                    set goon 0
                } else {
                    set goon 1
                }
            } else {
                set goon 0
            }
        }
        if {$goon == 1} {
            puts $hostfd $chast
        }
    }
    close $hostfd
    close $hostf
    file rename -force ${file}.tmp $file
    timer 2 checkrem
}

putlog "==> loaded Public commands edit by City Team<=="
