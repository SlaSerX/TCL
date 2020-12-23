#--------------------------------------------------------------------------------------------------------------------#
#                                 ANTI MASS JOIN / JOIN FLOOD PROTECTION SCRIPT BY RANA USMAN                        #
#--------------------------------------------------------------------------------------------------------------------#

#  AUTHOR :  RANA USMAN
## EMAIL  :  coolguy_rusman@yahoo.com , usmanrana33@hotmail.com
## URL    :  www.ranausman.tk , www.airevision.tk
# VERSION :  1
# If you have any suggesstion about my script kindly let me know i will be glad to look forward :)

###############
# DESCRIPTION #
###############
#Assalam O Aleikum n Hiya :) again ok i have written this script cuz i havent found any good mass join protection yet.There 
#are different join/part protection available but not a sinlge MASSJOIN / JOIN FLOOD protection.Simply what this script do
#is it will stop the heavy amout of clones joining your channel for flood n for more protection it changes the modes of the 
#channel to the Modes specified by you in configuration section.More it will gonna ban the flooding clone's IP n you have 
#both options for banning stick ban n Simple chan ban :))

########################
# HOW TO ENABLE SCRIPT #
########################
#PartyLine : (While Your in DCC chat with bot the place where you give commands like .+chan #chan is called partyline)
#In Bots Partline simple give the following command --> .chanset #channelname flood-join joins:seconds 
#Example : .chanset #yourchannel flood-join 4:6 <-- bot will detect if 4 clone joins in 6 seconds ::) ( 0:0 to disable )

###########################
#= CONFIGURATION SECTION =#
###########################
## Set the Lock Modes 
# Bot will change channel mode to the modes you will specify below in case the bot will detect join flood
# To Disable Mode change set it to "" 
set joinlockmodes "mr"

## Set the banmask type to use in banning the join floods
# Currently BAN Type is set to 1 (*!*@any.domain.com),
# BAN Types are given below;
# 1 - *!*@some.domain.com 
# 2 - *!*@*.domain.com
# 3 - *!*ident@some.domain.com
# 4 - *!*ident@*.domain.com
# 5 - *!*ident*@some.domain.com
# 6 - *nick*!*@*.domain.com
# 7 - *nick*!*@some.domain.com
# 8 - nick!ident@some.domain.com
# 9 - nick!ident@*.host.com
set bantype "1"

## Set the time in seconds to Unlock Modes 
# The Bot will Unlock the channel after the specified time you will set below
set unlocktime "600"

## Set The Punish Type
# Set it to '1' if you want to add the Ban for joinflood in bots list.By doing it Bot will ban the IP everytime when the 
# clone will join the channel even if it is unbanned from channel OR Simply a stick ban
# Set it to '2' for a simple channel Ban :) :: RECOMMENDED ::
set joinpunish "2"

## Set the reason you want to give while kicking 
set jreason "Mass Join Flood"

###########################
# CONFIGURATION ENDS HERE #
###########################

#--------------------------------------------------------------------------------------------------------------------#
#  SCRIPT STARTS FROM HERE.YOU CAN MAKE MODIFICATIONS AT UR OWN RISK, I DONT RESTRICT YOU TO NOT TO TOUCH THE CODE!  #
#--------------------------------------------------------------------------------------------------------------------#

bind flud - join joinflood:RanaUsman
proc joinflood:RanaUsman {nick uhost hand type chan} {
global joinlockmodes banmask unlocktime joinpunish jreason botnick
if {![botisop $chan] || [matchattr $hand of]} { return 0 }
set banmask [joinpart:banmask $uhost $nick]
if {($joinpunish == 1)} { 
putquick "MODE $chan +$joinlockmodes"
newchanban $chan $banmask $botnick $jreason
putquick "KICK $chan $nick :$jreason"
utimer $unlocktime [list putquick "MODE $chan -$joinlockmodes"]
}
if {($joinpunish == 2)} { 
putquick "MODE $chan +$joinlockmodes"
putquick "MODE $chan +b $banmask"
putquick "KICK $chan $nick :$jreason"
utimer $unlocktime [list putquick "MODE $chan -$joinlockmodes"]
 }
}
proc joinpart:banmask {uhost nick} {
 global bantype
  switch -- $bantype {
   1 { set banmask "*!*@[lindex [split $uhost @] 1]" }
   2 { set banmask "*!*@[lindex [split [maskhost $uhost] "@"] 1]" }
   3 { set banmask "*!*$uhost" }
   4 { set banmask "*!*[lindex [split [maskhost $uhost] "!"] 1]" }
   5 { set banmask "*!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]" }
   6 { set banmask "*$nick*!*@[lindex [split [maskhost $uhost] "@"] 1]" }
   7 { set banmask "*$nick*!*@[lindex [split $uhost "@"] 1]" }
   8 { set banmask "$nick![lindex [split $uhost "@"] 0]@[lindex [split $uhost @] 1]" }
   9 { set banmask "$nick![lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]" }
   default { set banmask "*!*@[lindex [split $uhost @] 1]" }
   return $banmask
  }
}
#-------------------------------------------------------------------------------------------------------------------------#
putlog "\002ANTI MASS JOIN/JOIN FLOOD PROTECTION BY Renso \002"
#-------------------------------------------------------------------------------------------------------------------------#