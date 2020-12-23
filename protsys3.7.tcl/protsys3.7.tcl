
      #############################################
      #  prosys3.7 by DuRanDaL <sgb@ismennt.is>   #
      # Copyright 1997-1999. All rights reserved. #
      #############################################


##################### Informations ##########################
#                                                           #
# Note: '+f' user are kick (and banns if set) for deoping,  #
#       kicking or banning a protected user. If you want    #
#       to change this change that set the exception flag   #
#       to "f" (not F) that will skip global and chan '+f'  #
#       users for deoping, kicking or banning a protuser.   #
#       (not recommend)                                     #
#                                                           #
# Note: Bots (+b) and masters (+m|+m) are skipped for       #
#       deoping, kicking or banning a protected user.       #
#       If you don't like that bots are skipped than you    #
#       really must want a bot war. There for I don't       #
#       recommend that you change this.                     #
#       (don't ask why)                                     #
#                                                           #
# Note: This script do not protect master or owner unless   #
#       they are '+P' (not '+p') I don't recommend that     #
#       you give a none bot or a master/owner user +P       #
#       unless giving them a exception flag too.            #
#       But, if you want it to just protect user with +n    #
#       or +m flag you can change the protection flag       #
#       to "n" or "m" (not 'N' or "M") note that '+n' user  #
#       are in included in the "m" flag so by using "m" you #
#       are protecting all of yours owners/master chan or   #
#       global if they are just a chan master on chan #lame #
#       e.g. - they will only by protect on chan #lame      #
#                                                           #
# Note: One other thing I want you to know                  #
#       I won't take any responsiblities ... ok ?À          #
#       If it kick and deops your ops or someshit           #
#       or just gets you K-lined !!                         #
#                                                           #
#       Now you can use this script as you like.            #
#                                                           #
######################## End info ###########################

########################## History ############################
#                                                             #
#  Copyright DuRanDaL@IRCnet 1997-1999. All rights reserved.  #
#                                                             #
# Revision History:                                           #
#   Version 3.7 by DuRanDaL: [01.21.97] More speed            #
#   Version 3.6 by DuRanDaL: [01.16.97] Many litle bugs fixed #
#   Version 3.5 by DuRanDaL: [01.15.97] No more notes,        #
#                                       added +7 console flag #
#   Version 3.3 by DuRanDaL: [01.15.97] More set choices      #
#                                       added for settings    #
#                                       bugs fixed            #
#   Version 3.2 by DuRanDaL: [01.14.97] Bug in ban            #
#                                       protectison fixed     #
#   Version 3.1 by DuRanDaL: [01.14.97] Self ban protectison  #
#   Version 3.0 by DuRanDaL: [01.14.97] Added ban protectison #
#   Version 2.1 by DuRanDaL: [01.14.97] Bugs fixed            #
#   Version 2.0 by DuRanDaL: [01.14.97] More self protectison #
#   Version 1.8 by DuRanDaL: [01.14.97] Bugs fixed            #
#   Version 1.7 by DuRanDaL: [01.14.97] Bugs fixed            #
#   Version 1.6 by DuRanDaL: [01.14.97] Bugs fixed            #
#   Version 1.5 by DuRanDaL: [01.14.97] Added chanflag suport #
#                                       (for 1.3.X)           #
#   Version 1.2 by DuRanDaL: [01.13.99] Bugs fixed            #
#   Version 1.1 by DuRanDaL: [01.13.99] Bugs fixed            #
#   Version 1.0 by DuRanDaL: [01.13.99] The script was        #
#                                       rewirten from:        #
#                                       protuser10a-mbti.tcl  #
#                                       by The |mmortaL       #
#                                                             #
###############################################################

######################## PROTECT SYSTEM SETTINGS ##################
#                                                                 #
# The flag you want to use to protect users ?À (A-Z or userflag)  #
set protflag "P";                                                 #
#                                                                 #
# How long the ban for deoping a protected user ?À ("0" = Off)    #
set deoptime "15";                                                #
#                                                                 #
# How long the ban for kicking a protected user ?À ("0" = Off)    #
set kicktime "20";                                                #
#                                                                 #
# How long the ban for banning a protected user ?À ("0" = Off)    #
set banstime "60";                                                #
#                                                                 #
# Flag for exceptions other than m|m and bot ?À (A-Z or userflag) #
set exceflag "E";                                                 #
#                                                                 #
# Msg user informing him how to get his ops back (0/1) ?À         #
set msgeuser "1";                                                 #
#                                                                 #
# If you want to log every thing protsys                          #
# does uncomment the this line out. (recommend)                   #
#                                                                 #
#logfile 7 * "/path/to/log/protsys.log";                          #
#                                                                 #
######################### END OF SYSTEM SETTINGS ##################

######### BINDS ##############
bind mode - *-o* protsys:deop
bind kick - * protsys:kick
bind mode - *+b* protsys:ban
bind chon - * protsys:console
######### BINDS ##############

### Set prot sys console #####
proc protsys:console { hand idx } {
	set chan [lindex [console $idx] 0]
	if {[matchattr $hand m|m]} { console $idx +1 }
	return 0
}
#### End of set console ######

######### Prot deop ##########
proc protsys:deop {nick host hand chan mdechg dnick} {
global botnick protflag exceflag deoptime msgeuser
 if {([matchattr $hand m|m $chan]) || ([matchattr $hand $exceflag|$exceflag]) || ([matchattr $hand b])} {return 0}
 if {[string tolower $nick] == [string tolower $botnick]} {return 0}
  if {[string tolower $dnick] == [string tolower $botnick]} {
   if {[validuser $hand]} {
    if {[matchattr $hand |o $chan]} {
     putserv "PRIVMSG $nick :You have lost your op on $chan for that !!"
     chattr $hand |-ao+d $chan
     if {$msgeuser} {putserv "PRIVMSG $nick :If you want your op back please talk to one of my masters. Masters on channel $chan are now: [chanlist $chan m|m]"}
     if {![string match "$deoptime" "0"]} {newchanban $chan [maskhost $host] Protsys "Deoped me !! [ctime [unixtime]] - $deoptime min ban." $deoptime}
     putloglev 7 * "Protectison system: $nick!$host !$hand! deoped me on $chan !!"
     return 0
     } else {
     chattr $hand |-ao+d $chan
     if {![string match "$deoptime" "0"]} {newchanban $chan [maskhost $host] Protsys "Deoped me !! [ctime [unixtime]] - $deoptime min ban." $deoptime}
     putloglev 7 * "Protectison system: $nick!$host !$hand! deoped me on $chan !!"
     return 0
     }
  }
   if {![string match "$deoptime" "0"]} {newchanban $chan [maskhost $host] Protsys "Deoped me !! [ctime [unixtime]] - $deoptime min ban." $deoptime}
   putloglev 7 * "Protectison system: $nick!$host !$hand! deoped me on $chan !!"
   return 0
 }
 if {![matchattr [nick2hand $dnick $chan] $protflag|$protflag $chan]} {return 0}
 if {[string tolower $dnick] == [string tolower $nick]} {return 0}
 if {[botisop $chan]} {
   pushmode $chan -o $nick 
   pushmode $chan +o $dnick
   if {![string match "$deoptime" "0"]} {pushmode $chan +b [maskhost $host]}
   flushmode $chan
     if {[matchattr $hand |o $chan]} {
       chattr $hand |-ao+d $chan
       putserv "KICK $chan $nick :Do NOT deop $dnick !! - You have lost your op on $chan for that !!"
       if {$msgeuser} {putserv "PRIVMSG $nick :If you want your op back please talk to one of my masters. Masters on channel $chan are now: [chanlist $chan m|m]"}
     } else {
       if {[validuser $hand]} {
       chattr $hand |-ao+d $chan
       }
       putserv "KICK $chan $nick :Do NOT deop $dnick !! - $deoptime min shitlist."
       if {![string match "$deoptime" "0"]} {newchanban $chan [maskhost $host] Protsys "Deoped [nick2hand $dnick $chan] [ctime [unixtime]] - $deoptime min ban." $deoptime}
     }
 }
putloglev 7 * "Protectison system: $nick!$host !$hand! deoped $dnick![getchanhost $dnick $chan] ![nick2hand $dnick $chan]! on channel $chan !!"
return 0
}
######### End proc deop ####

######### Prot kick ##########
proc protsys:kick {nick host hand chan knick reason} {
global botnick protflag exceflag kicktime msgeuser
 if {([matchattr $hand m|m $chan]) || ([matchattr $hand $exceflag|$exceflag]) || ([matchattr $hand b])} {return 0}
 if {[string tolower $nick] == [string tolower $botnick]} {return 0}
  if {[string tolower $botnick] == [string tolower $knick]} {
   if {[validuser $hand]} {
    if {[matchattr $hand |o $chan]} {putserv "PRIVMSG $nick :You have lost your op on $chan for that !!"}
     chattr $hand |-ao+d $chan
     if {$msgeuser} {putserv "PRIVMSG $nick :If you want your op back please talk to one of my masters. Masters on channel $chan are now: [chanlist $chan m|m]"}
     if {![string match "$kicktime" "0"]} {newchanban $chan [maskhost $host] Protsys "Kicked [nick2hand $knick $chan] [ctime [unixtime]] - $kicktime min ban." $kicktime}
     putloglev 7 * "Protectison system: $nick!$host !$hand! kicked me off $chan reason: $reason"
     return 0
     } else {
     chattr $hand |-ao+d $chan
     if {![string match "$kicktime" "0"]} {newchanban $chan [maskhost $host] Protsys "Kicked me !! [nick2hand $knick $chan] [ctime [unixtime]] - $kicktime min ban." $kicktime}
     putloglev 7 * "Protectison system: $nick!$host !$hand! kicked me off $chan reason: $reason"
     return 0
     }
   if {![string match "$kicktime" "0"]} {newchanban $chan [maskhost $host] Protsys "Kicked me !! [ctime [unixtime]] - $kicktime min ban." $kicktime}
   putloglev 7 * "Protectison system: $nick!$host !$hand! kicked me off $chan reason: $reason"
   return 0
 }
 if {![matchattr [nick2hand $knick $chan] $protflag|$protflag $chan]} {return 0}
 if {[string tolower $knick] == [string tolower $nick]} {return 0}
 if {[botisop $chan]} {
   pushmode $chan -o $nick
   if {![string match "$kicktime" "0"]} {pushmode $chan +b [maskhost $host]}
   flushmode $chan
     if {[matchattr $hand |o $chan]} {
       chattr $hand |-ao+d $chan
       putserv "KICK $chan $nick :Do NOT Kick $knick !! - You have lost your op on $chan for that !!"
       if {$msgeuser} {putserv "PRIVMSG $nick :If you want your op back please talk to one of my masters. Masters on channel $chan are now: [chanlist $chan m|m]"}
     } else {
       if {[validuser $hand]} {
       chattr $hand |-ao+d $chan
       }
       putserv "KICK $chan $nick :Do NOT Kick $knick !! - $kicktime min shitlist."
       if {![string match "$kicktime" "0"]} {newchanban $chan [maskhost $host] Protsys "Kicked [nick2hand $knick $chan] [ctime [unixtime]] - $kicktime min ban." $kicktime}
     }
 }
putloglev 7 * "Protectison system: $nick!$host !$hand! kicked $knick![getchanhost $knick $chan] ![nick2hand $knick $chan]! off channel $chan reason: $reason"
}
######### End proc kick ####

######### Prot ban ##########
proc protsys:ban {nick host hand chan mdechg ban} {
global botnick botname protflag  exceflag banstime msgeuser
 if {([matchattr $hand m|m $chan]) || ([matchattr $hand $exceflag|$exceflag]) || ([matchattr $hand b])} {return 0}
 if {[string tolower $nick] == [string tolower $botnick]} {return 0}
   if {[string match "$ban" "$botname"]} {
    pushmode $chan -o $nick
    putserv "MODE $chan -b $ban"
    if {![string match "$banstime" "0"]} {pushmode $chan +b [maskhost $host]}
    flushmode $chan
     if {[matchattr $hand |o $chan]} {
       chattr $hand |-ao+d $chan
       putserv "KICK $chan $nick :Do NOT ban me !! - You have lost your op on $chan for that !!"
       if {$msgeuser} {putserv "PRIVMSG $nick :If you want your op back please talk to one of my masters. Masters on channel $chan are now: [chanlist $chan m|m]"}
     } else {
       if {[validuser $hand]} {chattr $hand |-ao+d $chan}
       putserv "KICK $chan $nick :Do NOT ban me !! - $banstime min shitlist."
       if {![string match "$banstime" "0"]} {newchanban $chan [maskhost $host] Protsys "Banned me [ctime [unixtime]] - $banstime min ban." $banstime}
     }
    putloglev 7 * "Protectison system: $nick!$host !$hand! banned me on $chan !!"
  }
 set pnicks [chanlist $chan $protflag|$protflag]
  foreach pnick $pnicks {
   if {[string match "$ban" "$pnick![getchanhost $pnick $chan]"]} {
    pushmode $chan -o $nick
    pushmode $chan -b $ban
    if {![string match "$banstime" "0"]} {pushmode $chan +b [maskhost $host]}
    flushmode $chan
     if {[matchattr $hand |o $chan]} {
       chattr $hand |-ao+d $chan
       putserv "KICK $chan $nick :Do NOT ban $pnick !! - You have lost your op on $chan for that !!"
       if {$msgeuser} {putserv "PRIVMSG $nick :If you want your op back please talk to one of my masters. Masters on channel $chan are now: [chanlist $chan m|m]"}
     } else {
       if {[validuser $hand]} {chattr $hand |-ao+d $chan}
       putserv "KICK $chan $nick :Do NOT ban $pnick !! - $banstime min shitlist."
       if {![string match "$banstime" "0"]} {newchanban $chan [maskhost $host] Protsys "Banned [nick2hand $pnick $chan] [ctime [unixtime]] - $banstime min ban." $banstime}
     }
    putloglev 7 * "Protectison system: $nick!$host !$hand! banned $pnick![getchanhost $pnick $chan] ![nick2hand $pnick $chan]!on channel $chan !!"
  }
 }
}
######### End proc ban #####

putlog "Protsys v3.7 by DuRanDaL initialized..."
