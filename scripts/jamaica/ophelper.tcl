################## Main Script Config. #############################
# Set trigger for commands. Trigger is what u use at the beginner of a command, Ex: !op ! is the trigger
set trigger "!" 
# Set name of help command. (reason for this setting is because theres many scripts that use !help and could cause conflicts)
set helpcmd "h"
# Set default kick reason. (this goes for all commands that kick someone)
set dkick "12-= Amin =-"
################## End of Main Script Config ####################### 
 
################## Swear Kick Config. ##############################
# [0/1] Set this if you want swearkick enabled. (if set to 0, ignore all other swearkick configs)
set swearkick 0
# What access does a user need to bypass the swearkick?
set swearmode "+f"
# Set default SwearKick reason.
set sweareason "12-= CENZURA =-"
# Set Channels for SwearKick to be active in.
set skchans "#Jamaica"
################# End of SwearKick Config. #########################  

################# DONT TOUCH ANYTHING BELOW HERE ###################
# Global Settings
set _ohver_ "2.0.1"
set _ohcn_ "Cobra"

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
bind pub o|o "[char]o" pub_op
bind pub o|o "[char]d" pub_deop
bind pub o|o "[char]v" pub_voice
bind pub o|o "[char]dv" pub_devoice
bind pub o|o "[char]kb" pub_kb
bind pub o|o "[char]k" pub_k
bind pub o|o "[char]pb" pub_pb
bind pub o|o "[char]t" pub_topic
bind pub o|o "[char]b" pub_ban
bind pub o|o "[char]unb" pub_unban
bind pub -|- "[char][helpcmd]" pub_help
bind pub o|o "[char]m" pub_chanmode
bind pub m|m "[char]+u" pub_adduser
bind pub m|m "[char]-u" pub_deluser
bind pub m|m "[char]+h" pub_addhost
bind pub m|m "[char]-h" pub_delhost
bind pub m|m "[char]c" pub_chattr
bind pub m|m "[char]res" pub_restart
bind pub m|m "[char]r" pub_rehash
bind pub m|m "[char]s" pub_save
bind pub n|n "[char]cop" pub_cop
bind pub n|n "[char]cb"  pub_cban
bind pub n|n "[char]call" pub_call
bind pub - "[char]status" pub_status
bind pub - "[char]ping" pub_ping
bind ctcr - PING ping_reply
bind ctcp - PING ping_resp
bind pub -|- "[char]info" pub_info
bind pub -|- "[char]invite" pub_invite

####################### Auto Configure Section ######################
if {[string match "*linux*" [string tolower [unames]]] == 1} {
   set ohsys "[unames] - The choice of the GNU generation"
}
if {[string match "*bsd*" [string tolower [unames]]] == 1} {
   set ohsys "[unames] - BSD..... Kick Ass!"
}
if {([string match "*sun*" [string tolower [unames]]] == 1) || ([string match "*solaris*" [string tolower [unames]]] == 1)} {
   set ohsys "[unames] - Atleast its UNIX!"
}
if {[string match "*cygnus*" [string tolower [unames]]] == 1} {
   set ohsys "[unames] - hmm... Eggdrops were made for a UNIX System, not a crappy Windows System"
}
putlog "$ohsys"
if {$numversion < 1030000} {
}

########################### Main Section ############################
# [char][helpcmd]
proc pub_help {user uhost hand chan arg} {
  global _ohver_ _ohcn_
  set chkarg [lindex $arg 0]
  if {$chkarg == ""} {
     putserv "notice $user : 4PuB.TCL-v2.0.1 8(11CrazyBitch8)4 by eMCu 8<9eMCu4@9linux.damn.st8>"
     putserv "notice $user :3-= Help Menu =-"
     putserv "notice $user :10-= .o - OP =-"
     putserv "notice $user :10-= .d - DEOP =-"
     putserv "notice $user :10-= .v - VOICE =-"
     putserv "notice $user :10-= .dv - DEVOICE =-"
     putserv "notice $user :10-= .k - KICK =-"
     putserv "notice $user :10-= .b - BAN =-"
     putserv "notice $user :10-= .kb - KICKBAN =-"
     putserv "notice $user :10-= .unb - UNBAN =-"
     putserv "notice $user :3-= End Of Help Menu =-"
     return 0
     }
}

#Clear

proc pub_cop {nick uhost hand chan text} {
 putserv "privmsg CS :clear $chan ops"
 putserv "privmsg $chan :9-=( Clear all OPS )=-"
}

proc pub_cban {nick uhost hand chan text} {
 putserv "privmsg CS :clear $chan bans"
 putserv "privmsg $chan :9-=( Clear all BANS9 )=-"
}

proc pub_call {nick uhost hand chan text} {
 putserv "privmsg CS :clear $chan all"
 putserv "privmsg $chan :9-=( Clear All )=-"
}

# [char]op
proc pub_op {user uhost hand chan arg} {
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]op Help\]"
     putserv "NOTICE $user :Usage: [char]op \[nick\]"
     putserv "NOTICE $user :Give a user Ops."
     return 0
     }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan +o :$user"
     putserv "PRIVMSG $chan :11-= Done =-"
     return 0   
     } 
  set opuser [lindex $arg 0]
  if {[onchan $opuser $chan] == 0} {
     putserv "PRIVMSG $chan :8-=9(4 $opuser is not in the channel. 9)8=-"
     return 0 
     }
  putserv "MODE $chan +o :$opuser"
}

# [char]deop
proc pub_deop {user uhost hand chan arg} {
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]deop Help\]"
     putserv "NOTICE $user :Usage: [char]deop \[nick\]"
     putserv "NOTICE $user :Deop a user in a channel."
     return 0
     }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan -o :$user"
     putserv "PRIVMSG $chan :11-= Done =-"
     return 0
     }
  set dopuser [lindex $arg 0]
  if {[onchan $dopuser $chan] == 0} {
     putserv "PRIVMSG $chan :8-=9(4 $dopuser is not in the channel. 9)8=-"
     return 0
     }
  putserv "MODE $chan -o :$dopuser"
}

# [char]voice
proc pub_voice {user uhost hand chan arg} {
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]voice Help\]"
     putserv "NOTICE $user :Usage: [char]voice \[nick\]"
     putserv "NOTICE $user :Voice a user."
     return 0
     }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan +v :$user"
     putserv "PRIVMSG $chan :11-= Done =-"
     return 0
     }
  set voiceuser [lindex $arg 0]
  if {[onchan $voiceuser $chan] == 0} {
     putserv "PRIVMSG $chan :8-=9(4 $voiceuser is not in the channel. 9)8=-"
     return 0
     }
  putserv "MODE $chan +v :$voiceuser"
}

# [char]devoice
proc pub_devoice {user uhost hand chan arg} {
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]devoice Help\]"
     putserv "NOTICE $user :Usage: [char]devoice \[nick\]"
     putserv "NOTICE $user :Will take voices away from a person"
     return 0
     }
  if {[lindex $arg 0] == ""} {
     putserv "MODE $chan -v :$user"
     putserv "PRIVMSG $chan :11-= Done =-"
     return 0
     }
 set dvoiceuser [lindex $arg 0]
  if {[onchan $dvoiceuser $chan] == 0} {
     putserv "PRIVMSG $chan :8-=9(4 $dvoiceuser is not in the channel. 9)8=-"
     return 0
     }
  putserv "MODE $chan -v :$dvoiceuser"
}

# [char]kb 
proc pub_kb {user uhost hand chan arg} {
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
     putserv "PRIVMSG $chan :13-= Stupido?! =-"
     return 0
     }
  if {[matchattr $chkuser +m] == 1} {
     putserv "PRIVMSG $chan :13-= I don't think so! =-"
     return 0
     }
  if {[onchan $kbuser $chan] == 0} {
     putserv "PRIVMSG $chan :8-=9(4 $kbuser is not in the channel. 9)8=-"
     return 0
     }
  set reason [lrange $arg 1 end]
  set host "$kbuser![getchanhost $kbuser $chan]"
  set mask [maskhost $host]
  putserv "PRIVMSG $chan :3-=11 Banned:4 $kbuser 3=-"
  putserv "MODE $chan +b :$mask"
  if {$reason == ""} {
     putserv "KICK $chan $kbuser :$dkick"
     return 0
     }
  putserv "KICK $chan $kbuser :$reason"
  return 0
}

# [char]k
proc pub_k {user uhost hand chan arg} {
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
     putserv "PRIVMSG $chan :13-= I don't think so! =-"
     return 0
     }
  if {[matchattr $chkuser +m] == 1} {
     putserv "PRIVMSG $chan :13-= Stupido! =-"
     return 0
     }
  if {$reason == ""} {
     putserv "KICK $chan $kuser :$dkick"
     return 0
     }
  putserv "KICK $chan $kuser :$reason"
}

# [char]topic
proc pub_topic {user uhost hand chan arg} {
  set topic [lrange $arg 0 end]
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]topic Help\]"
     putserv "NOTICE $user :Usage: [char]topic <topic>"
     putserv "NOTICE $user :Changes Topic."
     return 0
     }
  putserv "TOPIC $chan :$topic"
}

# [char]pb 
proc pub_pb {user uhost hand chan arg} {
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
     putserv "PRIVMSG $chan :13-= Stupido? =-"
     return 0
     }
  if {[matchattr $chkuser +m] == 1} {
     putserv "PRIVMSG $chan :13-= I don't think so! =-"
     return 0
     }
  if {[onchan $pbuser $chan] == 0} {
     putserv "PRIVMSG $chan :8-=9(4 $pbuser is not in the channel. 9)8=-"
     return 0
     }
  set reason [lrange $arg 1 end]
  set host "$pbuser![getchanhost $pbuser $chan]"
  set mask [maskhost $host]
  putserv "PRIVMSG $chan :11PermBan Set On:3 $host "
  putserv "MODE $chan +b :$mask"
  if {$reason == ""} {
     putserv "KICK $chan $pbuser :$dkick"
     newchanban $chan $mask $hand $dkick 0
     return 0
     }
  putserv "KICK $chan $pbuser :$reason"
  newchanban $chan $mask $hand $reason 0
  return 0
}

# [char]ban
proc pub_ban {user uhost hand chan arg} {
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
     putserv "PRIVMSG $chan :13-= Stupido? =-"
     return 0
     }
  if {$ban == ""} {
     putserv "PRIVMSG $chan :Usage: [char]ban <mask> [reason]"
     return 0
     }
  if {$reason == ""} {
     newchanban $chan $ban $hand $dkick
     return 0
  }
  newchanban $chan $ban $hand $reason
  return 0
}

# [char]unban
proc pub_unban {user uhost hand chan arg} {
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
}

# [char]chanmode
proc pub_chanmode {user uhost hand chan arg} {
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
     putserv "MODE $chan $mode"
     return 0
     }
  putserv "MODE $chan $mode :$modearg"
  return 0
}

# [char]adduser
proc pub_adduser {user uhost hand chan arg} {
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
     putserv "PRIVMSG $chan :13-= Username is to large. =-"
     return 0
     }
  if {$access == "normal"} {
     if {[matchattr $user +o] == 0} {
        putserv "PRIVMSG $chan :3-=15 Only OWNERS can add hosts to other OPERS3 =-"
        return 0
        }
     }
     putserv "PRIVMSG $chan :9-=(3 Added 9(11 $username 9)3 as a 9(11 Normal User 9)=-"
  if {$access == "op"} {
     if {[matchattr $user +m] == 0} {
        putserv "PRIVMSG $chan :3-=15 Only MASTERS can add hosts to other OPERS3 =-"
        return 0
        }
     putserv "PRIVMSG $chan :9-=(3 Added 9(11 $username 9)3 as a 9(11 Op 9)=-"
     adduser $username $host
     chattr $username -|+o $chan
     return 0
     }
  if {$access == "master"} {
     if {[matchattr $user +n] == 0} {
        putserv "PRIVMSG $chan :3-=15 Only OWNERS can add hosts to other MASTERS3 =-"
        return 0
        }
     putserv "PRIVMSG $chan :9-=(3 Added 9(11 $username 9)3 as a 9(11 Master 9)=-"
     adduser $username $host
     chattr $username +m
     return 0
     }
  if {$access == "owner"} {
     if {[matchattr $user +n] == 0} {
        putserv "PRIVMSG $chan :3-=15 Only OWNERS can add hosts to other OWNERS3 =-"
        return 0
        }
     putserv "PRIVMSG $chan :9-=(3 Added 9(11 $username 9)3 as a 9(11 Owner 9)=-"
     adduser $username $host
     chattr $username +n
     return 0
     }
  putserv "PRIVMSG $chan :Usage: [char]adduser <username> <hostmask> \[op/master/owner\]"
  return 0
}

# [char]status
proc pub_status {user uhost hand chan arg} {
  global botname botnick server version uptime admin ohsys
  putserv "NOTICE $user :$botnick Status:"
  putserv "NOTICE $user :User Database: Total:[countusers] Op:[llength [userlist +o]] Master:[llength [userlist +m]]"
  putserv "NOTICE $user :               Owner:[llength [userlist +n]] Bot:[llength [userlist +b]]"
  if {[matchattr $hand +n] == 1} {
    putserv "NOTICE $user :Your Status: Owner"
    }
  if {[matchattr $hand +m] == 1} {
    putserv "NOTICE $user :Your Status: Master"
    }
  if {[matchattr $hand +o] == 1} {
    putserv "NOTICE $user :Your Status: Op"
    }
  putserv "NOTICE $user :Current Channels: ([llength [channels]]) [channels]"
  putserv "NOTICE $user :Number of bots on BotNet: [expr [llength [bots]] + 1]"
  putserv "NOTICE $user :Server: $server"
  putserv "NOTICE $user :BotOwner: $admin"
  putserv "NOTICE $user :Botname: $botname"
  putserv "NOTICE $user :Bot Version: [lindex $version 0]"
  putserv "NOTICE $user :Bot Has Been Up Since: [ctime $uptime]"
  putserv "NOTICE $user :Current Time: [ctime [unixtime]]"
  putserv "NOTICE $user :System Bot Is On: $ohsys"
}

# [char]deluser
proc pub_deluser {user uhost hand chan arg} {
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]deluser Help\]"
     putserv "NOTICE $user :Usage: [char]deluser <handle>"
     putserv "NOTICE $user :Deletes a handle from database."
     return 0
     }
  set deluser [lindex $arg 0]
  if {[matchattr $deluser +n] == 1} {
     return 0
     }
  if {[matchattr $deluser +m] == 1} {
     return 0
     }
  if {[lrange $arg 0 end] == ""} {
     return 0
     }
  if {[validuser $deluser] == 0} {
     return 0
     }
  deluser $deluser
  return 0
}

# [char]addhost
proc pub_addhost {user uhost hand chan arg} {
  if {[lindex $arg 0] == "-help"} {
     notice "\[[char]addhost Help\]"
     notice "Usage: [char]addhost <handle> <newhost>"
     notice "Adds a host too a handle."
     return 0
     }
  set hhand [lindex $arg 0]
  set newhost [lrange $arg 1 end]
  if {[validuser $hhand] == 0} {
     putserv "PRIVMSG $chan :3-=15 User does not exist in DataBase.3 =-"
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
        putserv "PRIVMSG $chan :3-=15 Only OWNERS can add hosts to OWNERS3 =-"
        return 0
        }
     }
  if {[matchattr $hhand +m] == 1} {
     if {[matchattr $hand +m] == 1} {
        putserv "PRIVMSG $chan :8-=9(8 Added 9(4 $newhost 9)8 to 9(4 $hhand 9)8=-"
        setuser $hhand HOSTS $newhost
        return 0
        }
     putserv "PRIVMSG $chan :3-=15 Only OWNERS can add hosts to MASTERS3 =-"
     return 0
     }
  putserv "PRIVMSG $chan :9-=(3 Added 9(11 $newhost 9)3 as a 9(11 $hhand 9)=-"
  setuser $hhand HOSTS $newhost
  return 0
}

# [char]delhost
proc pub_delhost {user uhost hand chan arg} {
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
        putserv "PRIVMSG $chan :9-=(3 Remove 9(11 $delhost 9)3 from 9(11 $hhand 9)=-"
        delhost $hhand $delhost
        return 0
        }
     putserv "PRIVMSG $chan :3-=15 Only OWNERS can remove hosts from MASTERS3 =-"
     return 0
     }
  putserv "PRIVMSG $chan :9-=(3 Remove 9(11 $delhost 9)3 from 9(11 $hhand 9)=-"
  delhost $hhand $delhost
  return 0
}

# [char]chattr
proc pub_chattr {user uhost hand chan arg} {
  if {[lindex $arg 0] == "-help"} {
     putserv "NOTICE $user :\[[char]chattr Help\]"
     putserv "NOTICE $user :Usage: [char]chattr <handle> <attr>"
     putserv "NOTICE $user :Change a handle's attr."
     return 0
     }
  set hhand [lindex $arg 0]
  set attr [lindex $arg 1]
  if {[validuser $hhand] == 0} {
     putserv "PRIVMSG $chan :3-=15 User does not exist in DataBase.3 =-"
     return 0
     }
  if {[matchattr $hand +n] == 1} {
     putserv "PRIVMSG $chan :3-=11 Set to:3 $hhand 11mode:3 $attr 11=-"
     chattr $hhand $attr
     return 0
     }
  if {[matchattr $hand +m] == 1} {
     if {[matchattr $hhand +n] == 1} {
        putserv "PRIVMSG $chan :12-= I don't think so! =-"
        return 0
        }
     if {[matchattr $hhand +m] == 1} {
        putserv "PRIVMSG $chan :12-= I don't think so! =-"
        return 0
        }
     putserv "PRIVMSG $chan :3-=11 Set to:3 $hhand 11mode:3 $attr 11=-"
     chattr $hhand $attr
     return 0
     }
  return 0    
}

# [char]rehash
proc pub_rehash {user uhost hand chan arg} {
  putserv "PRIVMSG $chan :3-=(11 Rehashing please wait! 3)=-"
  rehash
  return 0
}

# [char]save
proc pub_save {user uhost hand chan arg} {
  putserv "PRIVMSG $chan :9-=( Save all.. )=-"
  save
  return 0
}
  
# [char]restart
proc pub_restart {user uhost hand chan arg} {
  putserv "PRIVMSG $chan :3-=(11 Restarting please wait! 3)=-"
  utimer 2 restart
  return 0
}
     
# [char]info
proc pub_info {user uhost hand chan arg} {
  global botnick
  if {[validuser $hand] == 0} {
     putserv "PRIVMSG $chan :Unknown user, Please introduce yourself to me by typing \002/msg $botnick hello\002 or if you are already in my user database type \002/msg $botnick ident yourpassword\002"
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
bind pubm - "*fuck*" pub_swear
bind pubm - "*shit*" pub_swear
bind pubm - "*ass*" pub_swear
bind pubm - "*bitch*" pub_swear
bind pubm - "*slut*" pub_swear
bind pubm - "*cunt*" pub_swear
bind pubm - "*bastard*" pub_swear
bind pubm - "*tit*" pub_swear
bind pubm - "*pussy*" pub_swear
bind pubm - "*cock*" pub_swear
bind pubm - "*blowjob*" pub_swear
bind pubm - "*clit*" pub_swear
bind pubm - "*damn*" pub_swear

# Actual SwearKick Script
proc pub_swear {user uhost hand chan arg} {
  global swearkick swearmode sweareason skchans
  if {$swearkick == 1} {
     foreach i $skchans {
        if {$chan == $i} {
           if {[matchattr $hand $swearmode] == 1} {
              putserv "PRIVMSG $chan :12-= CENZURA =-"
              return 0
              }
           putserv "KICK $chan $user :$sweareason"
           }
        }
     }
  }
####################### End of Swear Kick Section ###########################

####################### PING Section ########################################
set good {
  "Nothing to worry about :)"
  "Wow, I wish I could have 31337 lag like you,"
  "Not bad :)"
  "bah,"
  "10, 9, 8, 7, 6, 5, 4, 3, 2, 1....."
  "----------->"
}
set mid {
  "Could be better,"
  "Ive seen alot better,"
  "Not too good, if it stays like this you should change servers,"
  "HAH, your lag sucks,"
  "Not very good :/"
}
set bad {
  "Jeez, Switch Servers QUICK! your lag is"
  "HAHAH, your lag totally sucks,"
  "Thank god i dont have lag that bad,"
  "Your so far behind us that i cant cant even see you,"
  "thats the suckest lag ive ever seen,"
}
proc pub_ping {nick uhost hand chan arg} {
  putserv "PRIVMSG $nick :\001PING [unixtime]\001"
  putlog "[char]ping received from $nick"
  return 0
}

proc ping_reply {nick uhost hand dest key arg} {
  global bad mid good
  if {$key == "PING"} {
     set endd [unixtime]
     set lagg [expr $endd - $arg]
     if {$lagg > "30"} {
        putserv "NOTICE $nick :[lindex $bad [rand [llength $bad]]] $lagg seconds"
        putlog "$nick is lagged by $lagg secs"
        return 0
        }
     if {$lagg > "15"} {
        putserv "NOTICE $nick :[lindex $mid [rand [llength $mid]]] $lagg seconds" 
        putlog "$nick is lagged by $lagg secs"
        return 0
        }
     putserv "NOTICE $nick :[lindex $good [rand [llength $good]]] $lagg seconds"
     putlog "$nick is lagged by $lagg secs"
     return 0
     }
  return 0
}

proc ping_resp {nick uhost hand botnick key arg} {
  global _ohver_ _ohcn_
  if {$key == "PING"} {
     return 0
     }
  return 0
}
####################### End of PING Section #################################
#putlog "Ophelper-v$_ohver_\[$_ohcn_\] by Roadman. is loaded..."

