
######################## PROTECT SYSTEM SETTINGS ##################
#                                                                 #
# The flag you want to use to protect users ?À (A-Z or userflag)  #
set protflag "P";                                                 #
#                                                                 #
# How long the ban for deoping a protected user ?À ("0" = Off)    #
set deoptime "10";                                                #
#                                                                 #
# How long the ban for kicking a protected user ?À ("0" = Off)    #
set kicktime "15";                                                #
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
#logfile 7 * "/logs/protsys.log";                                 #
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
     if {![string match "$deoptime" "0"]} {newchanban $chan $nick!*@* Protsys "Deoped me !! [ctime [unixtime]] - $deoptime min ban." $deoptime}
     putloglev 7 * "Protectison system: $nick!$host !$hand! deoped me on $chan !!"
     return 0
     } else {
     chattr $hand |-ao+d $chan
     if {![string match "$deoptime" "0"]} {newchanban $chan $nick!*@* Protsys "Deoped me !! [ctime [unixtime]] - $deoptime min ban." $deoptime}
     putloglev 7 * "Protectison system: $nick!$host !$hand! deoped me on $chan !!"
     return 0
     }
  }
   if {![string match "$deoptime" "0"]} {newchanban $chan $nick!*@* Protsys "Deoped me !! [ctime [unixtime]] - $deoptime min ban." $deoptime}
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
       if {![string match "$deoptime" "0"]} {newchanban $chan $nick!*@* Protsys "Deoped [nick2hand $dnick $chan] [ctime [unixtime]] - $deoptime min ban." $deoptime}
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
     if {![string match "$kicktime" "0"]} {newchanban $chan $nick!*@* Protsys "Kicked [nick2hand $knick $chan] [ctime [unixtime]] - $kicktime min ban." $kicktime}
     putloglev 7 * "Protectison system: $nick!$host !$hand! kicked me off $chan reason: $reason"
     return 0
     } else {
     chattr $hand |-ao+d $chan
     if {![string match "$kicktime" "0"]} {newchanban $chan $nick!*@* Protsys "Kicked me !! [nick2hand $knick $chan] [ctime [unixtime]] - $kicktime min ban." $kicktime}
     putloglev 7 * "Protectison system: $nick!$host !$hand! kicked me off $chan reason: $reason"
     return 0
     }
   if {![string match "$kicktime" "0"]} {newchanban $chan $nick!*@* Protsys "Kicked me !! [ctime [unixtime]] - $kicktime min ban." $kicktime}
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
       if {![string match "$kicktime" "0"]} {newchanban $chan $nick!*@* Protsys "Kicked [nick2hand $knick $chan] [ctime [unixtime]] - $kicktime min ban." $kicktime}
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
       if {![string match "$banstime" "0"]} {newchanban $chan $nick!*@* Protsys "Banned me [ctime [unixtime]] - $banstime min ban." $banstime}
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
       if {![string match "$banstime" "0"]} {newchanban $chan $nick!*@* Protsys "Banned [nick2hand $pnick $chan] [ctime [unixtime]] - $banstime min ban." $banstime}
     }
    putloglev 7 * "Protectison system: $nick!$host !$hand! banned $pnick![getchanhost $pnick $chan] ![nick2hand $pnick $chan]!on channel $chan !!"
  }
 }
}
######### End proc ban #####

putlog "Protsys v3.7 bY dJ_TEDY Loaded."