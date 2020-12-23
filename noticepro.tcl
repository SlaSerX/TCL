# ###########
# DESCRIPTION
# ###########
# 
# Protection Script for Channel Notice & Notice Flood.
# Bans those channel users who do channel notice, Op/Voice Exemption, Optional Banmask, multiple channel lock system to protect channel from same repeating offence.
#
# ########
# FEATURES
# ########
# 
# You can set channel lock modes, bansmask type, multiple modes (+mi/+mr) etc. depends on your channel situation,
# By default, this script will ban those who do mass-notice with the lock (+m) time of 5 seconds.
# you can change the settings as per your desire which is suitable for your channel.
#
########################
#- Channel Activation -#
########################

# DCC/Partyline :  n|n .chanset   Use .chanset to activate the protections for the particular channel or not.
#       Example : .chanset #mychan1 +noticepro
#                 .chanset #mychan2 -noticepro


###############
#- Lock Mode -#
###############

# Set channel modes which you want to be used for locking in channel notice,
# Leave blank "" if you dont like to set modes.
set notice(lock) "rj"

##############
#- BAN Type -#
##############

# Set the banmask type to use in banning the IPs  
# Currently BAN Type is set to 1 (*!*@some.domain.com),
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
set npro_btype 3

###############
#- Lock Time -#
###############

# Set time period (in seconds), How much time it takes to do unlock after the channel notice.
set notice(unlock) 10

#####################
#- Kick/BAN Reason -#
#####################

# Set kick/ban reason here.
set notice(reason) "Channel Notice Detected."

#####################
#- Voice Exemption -#
#####################

# Voice Immune [0/1]:Set to 1 if you want to protect users who are voiced when they notice channel,
# -OR- Set to 0 to punish everyone who notice the channel.
# (NOTE: This script does not kick any Operator(s).)
set notice(vxmpt) 1

###############
#- BAN Time -#
###############

# Set time period (in minutes), How much time it takes to unban punished user.
set notice(ub) 120

########################################################
#- Don't edit below unless you know what you're doing -#
########################################################

setudef flag noticepro
bind NOTC - * notice
proc notice {nick uhost hand text chan} {
   global notice botnick
   if {($chan == $botnick)} {return 0}
   if {![validchan $chan]} {
      return 0
   }
   if {![channel get $chan noticepro]} { return 0 }
   if {($notice(vxmpt) == 1) && [isvoice $nick $chan]} { return 0 }
   if {[isbotnick $nick] || ![botisop $chan] || [isop $nick $chan] || [matchattr $hand b] || [matchattr $hand f|f $chan] || [matchattr $hand mo|mo $chan]} {
      return
   }
   set banmask [npro:banmask $uhost $nick]
   putquick "MODE $chan +$notice(lock)b $banmask"
   putserv "KICK $chan $nick :$notice(reason)"
   utimer $notice(unlock) [list putquick "MODE $chan -$notice(lock)"]
   timer $notice(ub) [list putserv "MODE $chan -b $banmask"]
}

proc npro:banmask {uhost nick} {
 global npro_btype
  switch -- $npro_btype {
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

putlog "Channel Notice Protection Loaded"


