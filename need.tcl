# $Id: need.tcl, eggdrop-1.6.x 2004/5 awyeah@usa.net Exp $

# Begin - Eggdrop Need, ChanServ Auto Need Script v3.35.b (need.tcl)
#       Script Version: v3.35.b
#       Built Date: 1st July 2004, Last Updated: 30th August 2004
#       Copyright © 1999-2004 awyeah (awyeah@usa.net)
#       This TCL script is designed to work with eggdrop v1.5.x or higher

#########################################################################
#                   ChanServ Auto Need Script v3.35.b                   #
#                                                                       #
#                                                                       #
# Author: awyeah                                       30th August 2004 #
# Email: awyeah@usa.net                            Build version 3.35.b #
# Copyright © 2004 awyeah All Rights Reserved    http://www.awyeah.org/ #
#########################################################################
#                                                                       #
# ##############                                                        #
# SCRIPT PURPOSE                                                        #
# ##############                                                        #
#                                                                       #
# This script will react if your eggdrop bot gets deoped, banned, or if #
# a channel has +i, +l or +k modes set, it would make the eggdrop bot   #
# react to all of these triggers seperately using ChanServ commands.    #
#                                                                       #
# The purpose of this script is that it will reop and eggdrop if it     #
# gets deoped, unban it if it gets banned and invite it to channels     #
# where +i, low channel limits (+l) and unknown channel keys (+k)       #
# have been set.                                                        #
#                                                                       #
# This script is a good useful script for your bots own protection as   #
# well as for a channels protection. If the bot gets deoped or banned   #
# it would be for bots own protection, while enforced channel modes     #
# such as invite-only +i, channel limits +l or channel keys +k can be   #
# for channel protection as these modes are rarely set on normal chat   #
# channels.                                                             #
#                                                                       #
#########################################################################
#                                                                       #
# #################                                                     #
# SCRIPT DESCRITION                                                     #
# #################                                                     #
#                                                                       #
# This script will reop and eggdrop if it gets deoped, unban it if it   #
# gets banned and invite it to channels where +i, low channel limits    #
# (+l) and unknown channel keys (+k) have been set.                     #
#                                                                       #
# For all of these 5 functions to work op/unban/invite/limit/key the    #
# bot must have ChanServ access to the channel and should be a channel  #
# operator in the channels access list.                                 #
#                                                                       #
# All of the need-op, need-unban, need-invite, need-limit and need-key  #
# work on bot internal timers and function from a random estimated      #
# delay of 15-30 seconds. So they sometime might not react immediately  #
# to a trigger.                                                         #
#                                                                       #
# Please note that I have set each command seperately so users can      #
# activate each command seperately on channels which they like as some  #
# might not want to use all commands on the channels which they prefer  #
# such as need-op which can be a hassle at times.                       #
#                                                                       #
#########################################################################
#                                                                       #
# ###############                                                       #
# SCRIPT FEATURES                                                       #
# ###############                                                       #
#                                                                       #
# 1. This script has *5* trigger options avaliable with seperate        #
#    channel types to work on. Each trigger option can have *2* types   #
#    of channels settings.                                              #
#    - They can be activated to work on user defined channels.          #
#    - They can be activated to work on all the channels the bot is on. #
#                                                                       #
# 2. The *5* options avaliable are:                                     #
#     - NEED OP (Trigged when the bot is deoped)                        #
#     - NEED UNBAN (Triggered when the bot is banned)                   #
#     - NEED INVITE (Trigged when the bot tries to join a +i channel)   #
#     - NEED LIMIT (Triggered when the bot tries to join a +l channel)  #
#     - NEED KEY (Triggered when the bot tries to join a +k channel)    #
#                                                                       #
# 3. For the NEED-OP command the bot will request to reop itself with   #
#    ChanServ whenever it gets deoped on a channel defined for the      #
#    need-op command. The reop timer will be with an every 20-30 sec    #
#    continuous delay.                                                  #
#                                                                       #
# 4. The NEED-UNBAN command will unban the bot the with the help of     #
#    the ChanServ unban command when ever the bot gets banned on a      #
#    channel and the hostmask matches with the bots userhost. If the    #
#    bot is kicked as well as banned it will rejoin back in the channel #
#    when it is unbanned by ChanServ.                                   #
#                                                                       #
# 5. The NEED-INVITE command will invite the bot to the channels which  #
#    have been set to +i (invite-only) by using the ChanServ invite     #
#    command. A function to remove the invite mode (+i) has also been   #
#    added for choice, if bot owners wish to remove the invite mode     #
#    when the bot rejoins the channel.                                  #
#                                                                       #
# 6. For the NEED-LIMIT command the bot will request ChanServ to invite #
#    itself to the channels where low user limits are set and the bot   #
#    cannot join. After joining a function has been chosen to either    #
#    remove the channel limit or increase it depening upon the bot      #
#    owners will.                                                       #
#                                                                       #
# 7. The NEED-KEY command will do the same as the need-limit command    #
#    by inviting the bot to the channels with help from ChanServ if     #
#    unknown channel keys have been on channels. On rejoin the bot      #
#    will have function to either remove the channel key or replace the #
#    current channel key to a random or user-defined channel key        #
#    depending upon the bot owners wish.                                #
#                                                                       #
#########################################################################
#                                                                       #
# ###################                                                   #
# SCRIPT INSTALLATION                                                   #
# ###################                                                   #
#                                                                       #
# [1] Please unzip zipped file need.zip and place the tcl file need.tcl #
#     file in your eggdrops */scripts* folder along with your other     #
#     tcl scripts.                                                      #
#                                                                       #
# [2] Please add a link at the bottom of your eggdrop's .conf file to   #
#     the path of your script need.tcl, which would be something like:  #
#                                                                       #
#          source scripts/need.tcl                                      #
#                                                                       #
# [3] Save your bot's configuration file                                #
#                                                                       #
# [4] RESTART your eggdrop bot and never let your bot be out of sight!  #
#                                                                       #
#########################################################################
#                                                                       #
# ############                                                          #
# CONTACT INFO                                                          #
# ############                                                          #
#                                                                       #
# - If you have any suggestions, comments, questions or if you want to  #
#   report bugs, please feel free to email me at: awyeah@usa.net        #
#                                                                       #
# - You can contact me on MSN Messenger, on my ID: awyeah@awyeah.org    #
#                                                                       #
# - You can also catch me on IRC (The DALnet Network)                   #
#                                                                       #
#         /server irc.dal.net:6667, Nick: awyeah                        #
#                                                                       #
#########################################################################
#                                                                       #
# ###############                                                       #
# SCRIPT VERSIONS                                                       #
# ###############                                                       #
#                                                                       #
#  v3.35.b - Fixed a bug in the needlimit:remover procedure which was   #
# (30/08/04) calling an undefined local variable in the procedure.      #
#          - Added an option on all need functions to switch them off   #
#            individually if users don't wish to use all of them.       #
#          - Optimized the script to give a faster output by replacing  #
#            'putserv' with 'putquick -next'.                           #
#          - Fixed timer delays to be more appropriate on join times.   #
#          - Removed some unwanted if condition statements and combined #
#            most of them into one for more efficiency.                 #
#          - Removed duplicate procedures in the channel selection      #
#            interface for user-defined channels and all channels by    #
#            combining both into one for all need functions.            #
#          - Removed some putlogs which were put in for testing the     #
#            output of the script and weren't intended to be in the     #
#            final release of the script.                               #
#                                                                       #
#  v2.28.b - Initial release of script.                                 #
# (01/07/04)                                                            #
#                                                                       #
#                                                                       #
# Latest released verions of this script which are updated and modified #
# from time to time can be found on:                                    #
#                                                                       #
#        http://www.egghelp.org/  -  http://www.tclscript.com/          #
#                                                                       #
#########################################################################
#                                                                       #
# #######                                                               #
# CREDITS                                                               #
# #######                                                               #
#                                                                       #
#  - Thanks to the people on forum.egghelp.org for their support.       #
#                                                                       #
#  - Thanks to all my friends who supported me all the way through      #
#    this project and helped me to fix the bugs and errors found.       #
#                                                                       #
#  I hope you really appreciate the work I've done!                     #
#                                                                       #
#                                                                       #
#  ./awyeah                                                             #
#                                                                       #
#########################################################################

##################################################
### Start editing variables from here onwards! ###
##################################################

#---------------------------------------#
#    SETUP NETWORK CHANSERV VARIABLE    #
#---------------------------------------#

#Set your ChanServ service nick here. (This is a case-senstivie setting)
#USAGE: Set the nick of your networks channel service here. For example 'ChanServ'.
#(If your network uses ChanServ and is not DALnet, set this to only 'ChanServ' then)
#(If your network is DALnet, then you do not need to edit this as I have set this to default for DALnet)
set needchanserv "chanserv@services.dal.net"


#------------------------------#
#    SETUP NEED-OP VARIABLES   #
#------------------------------#

### IMPORTANT - PLEASE READ ###
#This is the most important variable in the entire script.

#Please enable this variable if you want your eggdrop bot to always have ops on channels you define for it
#or on all channels its on. The bots internal timer will request ChanServ to reop it after a delay of every
#20-30 secs if it gets deoped. (this is continuous)

#If supposingly the bot is deleted from the ChanServ access list of a channel mentioned in the working channel
#list, then this script will still try to regain ops from ChanServ. It might flood ChanServ as the need-op will
#request ChanServ ops on that channel with a continuous delay timer of 20-30secs and irc operators might akill or
#kline the bot for services flooding. (Please set this wisely!)

#Please enable this setting on channels only which you eggdrop bot has channel ops (ChanServ access) on.
#If it has access on all channels it is on, then only enable the all channels feature, otherwise not.
#If suppose your eggdrop is deleted from any of the ChanServ access lists, then immediately remove it
#immediately from this scripts user defined channels and restart the bot so it doesn't flood services or
#request ops from ChanServ on channels where it doesn't have access, as ChanServ will deny it.

#Set the type of channels on which you would like the 'NEED-OP' script to work on.
#USAGE: [0/1/2] (0=NEED-OP IS OFF, 1=USER DEFINED CHANNELS, 2=ALL CHANNELS)
#Use '0' if you want to disable this option. (The bot will not react if it is deoped)
#Use '1' for 'user defined channels'. (Will make the need-op command work on channels only mentioned by the user)
#Use '2' for 'all the channels' the bot is on. (Will make the need-op command work on all channels the bot is on)
set needoptype "1"

#Set this only if you have enabled the previous setting to '1' (user defined channels). Set here the working
#user defined channels you want the 'need-op' command to work on, if not then leave this setting empty/blank.
#USAGE: set needopchans "#channel1 #channel2 #channel3 #mychannel #yourchannel"
set needopchans "#mychannel"


#---------------------------------#
#    SETUP NEED-UNBAN VARIABLES   #
#---------------------------------#

#Set the type of channels on which you would like the 'NEED-UNBAN' script to work on.
#USAGE: [0/1/2] (0=NEED-UNBAN IS OFF, 1=USER DEFINED CHANNELS, 2=ALL CHANNELS)
#Use '0' if you want to disable this option. (The bot will not unban itself if it is banned)
#Use '1' for 'user defined channels'. (Will make the need-unban command work on channels only mentioned by the user)
#Use '2' for 'all the channels' the bot is on. (Will make the need-unban command work on all channels the bot is on)
set needunbantype "1"

#Set this only if you have enabled the previous setting to '1' (user defined channels). Set here the working
#user defined channels you want the 'need-unban' command to work on, if not then leave this setting empty/blank.
#USAGE: set needunbanchans "#channel1 #channel2 #channel3 #mychannel #yourchannel"
set needunbanchans "#mychannel"


#----------------------------------#
#    SETUP NEED-INVITE VARIABLES   #
#----------------------------------#

#Set the type of channels on which you would like the 'NEED-INVITE' script to work on.
#USAGE: [0/1/2] (0=NEED-INVITE IS OFF, 1=USER DEFINED CHANNELS, 2=ALL CHANNELS)
#Use '0' if you want to disable this option. (The eggdrop will not invite itself if the channel is set to +i)
#Use '1' for 'user defined channels'. (Will make the need-invite command work on channels only mentioned by the user)
#Use '2' for 'all the channels' the bot is on. (Will make the need-invite command work on all channels the bot is on)
set needinvitetype "1"

#Set this only if you have enabled the previous setting to '1' (user defined channels). Set here the working
#user defined channels you want the 'need-invite' command to work on, if not then leave this setting empty/blank.
#USAGE: set needinvitechans "#channel1 #channel2 #channel3 #mychannel #yourchannel"
set needinvitechans "#mychannel"

#Set this if you when the bot rejoins back through the need-invite command, should it should remove the
#invite-only mode (+i) set on the channel to -i.
#USAGE: [0/1] (0=OFF, 1=ON) - (0=DOES NOT REMOVE THE INVITE-ONLY MODE, 1=REMOVES THE INVITE-ONLY MODE)
#If set to '0' the bot will take no action against the +i mode set when it rejoins back. (This setting is disabled)
#If set to '1' the bot will remove the +i set by making it -i, when it rejoins back.
set invitetype "1"


#---------------------------------#
#    SETUP NEED-LIMIT VARIABLES   #
#---------------------------------#

#Set the type of channels on which you would like the 'NEED-LIMIT' script to work on.
#USAGE: [0/1/2] (0=NEED-LIMIT IS OFF, 1=USER DEFINED CHANNELS, 2=ALL CHANNELS)
#Use '0' if you want to disable this option. (The eggdrop will not invite itself if a low channel limit is set)
#Use '1' for 'user defined channels'. (Will make the need-limit command work on channels only mentioned by the user)
#Use '2' for 'all the channels' the bot is on. (Will make the need-limit command work on all channels the bot is on)
set needlimittype "1"

#Set this only if you have enabled the previous setting to '1' (user defined channels). Set here the working
#user defined channels you want the 'need-limit' command to work on, if not then leave this setting empty/blank.
#USAGE: set needlimitchans "#channel1 #channel2 #channel3 #mychannel #yourchannel"
set needlimitchans "#mychannel"

#Set this if you want the bot when it rejoins back through the need-limit command, should it should remove the
#channel-limit mode (+l) or increase the channel limit to a user defined value.
#USAGE: [0/1/2] (0=OFF, 1=REMOVES THE LIMIT, 2=INCREASES THE LIMIT TO A USER-DEFINED VALUE)
#If set to '0' the bot will take no action against the +l mode set when it rejoins back. (This setting is disabled)
#If set to '1' the bot will remove the +l set by making it -l, when it rejoins back.
#If set to '2' the bot will increase the current limit +l value set to a user defined value.
set limittype "1"

#Set this if you have chosen the previous option to '2' (to increase the channel limit). Set this to the limit
#you would like the bot to set after it rejoins the channel.
#USAGE: Use a numerical value which is greater '5 to 10' users from your original channel peak value.
set limitincrease "50"


#-------------------------------#
#    SETUP NEED-KEY VARIABLES   #
#-------------------------------#

#Set the type of channels on which you would like the 'NEED-KEY' script to work on.
#USAGE: [0/1/2] (0=NEED-KEY IS OFF, 1=USER DEFINED CHANNELS, 2=ALL CHANNELS)
#Use '0' if you want to disable this option. (The eggdrop will not invite itself if the channel is set to an unknown key)
#Use '1' for 'user defined channels'. (Will make the need-key command work on channels only mentioned by the user)
#Use '2' for 'all the channels' the bot is on. (Will make the need-key command work on all channels the bot is on)
set needkeytype "1"

#Set this only if you have enabled the previous setting to '1' (user defined channels). Set here the working
#user defined channels you want the 'need-key' command to work on, if not then leave this setting empty/blank.
#USAGE: set needkeychans "#channel1 #channel2 #channel3 #mychannel #yourchannel"
set needkeychans "#mychannel"

#Set this if you want the bot when it rejoins back through the need-key command, should it should remove the
#channel-key mode (+k) or set the channel key to a random or user-defined one.
#USAGE: [0/1/2] (0=OFF, 1=REMOVES THE KEY, 2=REPLACES THE CHANNEL KEY TO A RANDOM/USER-DEFINED ONE)
#If set to '0' the bot will take no action against the +k mode set when it rejoins back. (This setting is disabled)
#If set to '1' the bot will remove the +k set by making it -k, when it rejoins back.
#If set to '2' the bot will replace the current channel key (+k) to a random or user-defined value.
set keytype "1"

#Set this if you have chosen to replace the channel-key to a user-defined key. Set this to the new channel key
#which you would like. (If you want to use random keys, selected from a list of keys set this to "" as empty/blank)
#USAGE: Only use alphabets and numbers, no special characters.
set newkey "elite"

### This setting will only work if you have set the previous variable setting as empty/blank like: "" ###
#Set this if you have chosen to replace the channel-key to a random key, chosen from a list of speicifed keys.
#USAGE: Only use alphabets and numbers, no special characters. Set the channel keys in seperated lines each
#between quotation marks, making the whole list enclosed in braces, as shown.
set newkeys {
"yeahbaby"
"fearme"
"ohmygod"
"bornintheusa"
"iameleet"
}


#--------------------------------------#
#    SETUP NEED FUNCTION DELAY TIMER   #
#--------------------------------------#

#Set this if you have enabled to remove any -i, -l, -k modes or replace them. This setting will cause a
#delay for the eggdrop to join back in the channel after which it will be able to perform the delayed mode
#changing operations as requested. Set a delay time in seconds.
#USAGE: Use a range of '3 - 10' seconds.
set needdelay "3"


###############################################################################
### Don't edit anything else from this point onwards, even if you know tcl! ###
###############################################################################

bind need - "% op" need:op
bind need - "% unban" need:unban
bind need - "% invite" need:invite
bind need - "% limit" need:limit
bind need - "% key" need:key

set needauthor "awyeah (awyeah@usa.net)"
set needscript "ChanServ Auto Need Script v3.35.b"

proc need:op {chan type} {
 global botnick needoptype needopchans
  if {($needoptype == 1) && ([lsearch -exact [split [string tolower $needopchans]] [string tolower $chan]] != -1)} { needop:chans $chan $type }
  if {($needoptype == 2)} { needop:chans $chan $type }
  if {($needoptype != 1) && ($needoptype != 2) || ($needoptype == 0)} { return 0 }
}

proc need:unban {chan type} {
 global botnick needunbantype needunbanchans
  if {($needunbantype == 1) && ([lsearch -exact [split [string tolower $needunbanchans]] [string tolower $chan]] != -1)} { needunban:chans $chan $type }
  if {($needunbantype == 2)} { needunban:chans $chan $type }
  if {($needunbantype != 1) && ($needunbantype != 2) || ($needunbantype == 0)} { return 0 }
}

proc need:invite {chan type} {
 global botnick needinvitetype needinvitechans
  if {($needinvitetype == 1) && ([lsearch -exact [split [string tolower $needinvitechans]] [string tolower $chan]] != -1)} { needinvite:chans $chan $type }
  if {($needinvitetype == 2)} { needinvite:chans $chan $type }
  if {($needinvitetype != 1) && ($needinvitetype != 2) || ($needinvitetype == 0)} { return 0 }
}

proc need:limit {chan type} {
 global botnick needlimittype needlimitchans
  if {($needlimittype == 1) && ([lsearch -exact [split [string tolower $needlimitchans]] [string tolower $chan]] != -1)} { needlimit:chans $chan $type }
  if {($needlimittype == 2)} { needlimit:chans $chan $type }
  if {($needlimittype != 1) && ($needlimittype != 2) || ($needlimittype == 0)} { return 0 }
}

proc need:key {chan type} {
 global botnick needkeytype needkeychans
  if {($needkeytype == 1) && ([lsearch -exact [split [string tolower $needkeychans]] [string tolower $chan]] != -1)} { needkey:chans $chan $type }
  if {($needkeytype == 2)} { needkey:chans $chan $type }
  if {($needkeytype != 1) && ($needkeytype != 2) || ($needkeytype == 0)} { return 0 }
}


proc needop:chans {chan type} {
 global botnick needchanserv
  if {([string equal -nocase $type "op"])} {
   putlog "NEED OP \[[string toupper $chan]\]: Need to regain ops back on $chan."
   putlog "NEED OP \[[string toupper $chan]\]: *REOPPING* myself on $chan with $needchanserv."
   putquick "PRIVMSG $needchanserv :OP $chan $botnick" -next; return 1
   }
}

proc needunban:chans {chan type} {
 global botnick needchanserv
  if {([string equal -nocase $type "unban"])} {
   putlog "NEED UNBAN \[[string toupper $chan]\]: Need to unban myself on $chan."
   putlog "NEED UNBAN \[[string toupper $chan]\]: *UNBANNING* myself on $chan with $needchanserv and rejoining if I was kicked."
   putquick "PRIVMSG $needchanserv :UNBAN $chan $botnick" -next
   utimer 3 "putquick \"JOIN $chan\" -next"; return 1
   }
}

proc needinvite:chans {chan type} {
 global botnick needchanserv
  if {([string equal -nocase $type "invite"])} {
   putlog "NEED INVITE \[[string toupper $chan]\]: Need to invite myself to $chan, because $chan is set to +i."
   putlog "NEED INVITE \[[string toupper $chan]\]: *INVITING* myself to $chan with $needchanserv and rejoining back."
   putquick "PRIVMSG $needchanserv :INVITE $chan $botnick" -next
   utimer 1 "putquick \"JOIN $chan\" -next"
   utimer 3 [list needinvite:remover $chan]; return 1
   }
}

proc needlimit:chans {chan type} {
 global botnick needchanserv
  if {([string equal -nocase $type "limit"])} {
   putlog "NEED LIMIT \[[string toupper $chan]\]: Need to invite myself to $chan, because $chan is set to a low user limit (+l)."
   putlog "NEED LIMIT \[[string toupper $chan]\]: *INVITING* myself to $chan with $needchanserv and rejoining back."
   putquick "PRIVMSG $needchanserv :INVITE $chan $botnick" -next
   utimer 1 "putquick \"JOIN $chan\" -next"
   utimer 3 [list needlimit:remover $chan]; return 1
   }
}

proc needkey:chans {chan type} {
 global botnick needchanserv
  if {([string equal -nocase $type "key"])} {
   putlog "NEED KEY \[[string toupper $chan]\]: Need to invite myself to $chan, because $chan is set to an unknown key (+k)."
   putlog "NEED KEY \[[string toupper $chan]\]: *INVITING* myself to $chan with $needchanserv and rejoining back."
   putquick "PRIVMSG $needchanserv :INVITE $chan $botnick" -next
   utimer 1 "putquick \"JOIN $chan\" -next"
   utimer 3 [list needkey:remover $chan]; return 1
   }
}


proc needinvite:remover {chan} {
 global botnick invitetype needdelay
  if {($needdelay == "") || ($needdelay == "0") || ($needdelay <= 5)} { set needdelay 10 }
  if {($invitetype == 1)} { putlog "NEED INVITE \[[string toupper $chan]\]: *Removing* the +i mode (invite-only) to -i after a delay of $needdelay seconds."
   utimer $needdelay "putquick \"MODE $chan -i\""; return 0 }
   if {($invitetype == "0")} { return 0
    }
}

proc needlimit:remover {chan} {
 global botnick limittype limitincrease needdelay
 if {($limitincrease == "") || ($limitincrease == "0") || ($limitincrease < 1)} { set limitincrease 10 }
 if {($needdelay == "") || ($needdelay == "0") || ($needdelay <= 5)} { set needdelay 10 }; set limitincrease [expr $limitincrease]
  if {($limittype == 1)} { putlog "NEED LIMIT \[[string toupper $chan]\]: *Removing* the +l (channel-limit) on $chan to -l after a delay of $needdelay seconds."
   utimer $needdelay "putquick \"MODE $chan -l\""; return 0 }
   if {($limittype == 2)} { putlog "NEED LIMIT \[[string toupper $chan]\]: *Increasing* the current +l (channel-limit) on $chan from the current limit to $limitincrease after a delay of $needdelay seconds."
    utimer $needdelay "putquick \"MODE $chan +l $limitincrease\""; return 0 }
    if {($limittype == "0")} { return 0
    }
}

proc needkey:remover {chan} {
 global botnick keytype newkey newkeys needdelay
 if {($needdelay == "") || ($needdelay == "0") || ($needdelay <= 5)} { set needdelay 10 }
 if {($newkey == "")} { set newkey [lindex $newkeys [rand [llength $newkeys]]] }
  if {($keytype == 1)} { putlog "NEED KEY \[[string toupper $chan]\]: *Removing* the +k (channel-key) on $chan to -k after a delay of $needdelay seconds."
   utimer $needdelay "putquick \"MODE $chan -k ?\""; return 0 }
   if {($keytype == 2)} { putlog "NEED KEY \[[string toupper $chan]\]: *Replacing* the current +k (channel-key) to '$newkey' after a delay of $needdelay seconds."
    utimer $needdelay "putquick \"MODE $chan +k $newkey\""; return 0 }
    if {($keytype == "0")} { return 0
    }
}


putlog "\[LOADED\] $needscript by \002$needauthor\002"
if {($needoptype == 1)} { set needoplog "*NEED OP* is \002ACTIVE\002 on: \002[string tolower $needopchans]\002" }; if {($needoptype == 2)} { set needoplog "*NEED OP* is \002ACTIVE\002 on: \002All channels\002" }
if {(($needoptype != 1) && ($needoptype != 2)) || ($needoptype == "0")} { set needoplog "*NEED OP* is \002NOT ACTIVE\002 because: \002No channel type has been seletected\002" }
if {($needunbantype == 1)} { set needunbanlog "*NEED UNBAN* is \002ACTIVE\002 on: \002[string tolower $needunbanchans]\002" }; if {($needunbantype == 2)} { set needunbanlog "*NEED UNBAN* is \002ACTIVE\002 on: \002All channels\002" }
if {(($needunbantype != 1) && ($needunbantype != 2)) || ($needunbantype == "0")} { set needunbanlog "*NEED UNBAN* is \002NOT ACTIVE\002 because: \002No channel type has been seletected\002" }
if {($needinvitetype == 1)} { set needinvitelog "*NEED INVITE* is \002ACTIVE\002 on: \002[string tolower $needinvitechans]\002" }; if {($needinvitetype == 2)} { set needinvitelog "*NEED INVITE* is \002ACTIVE\002 on: \002All channels\002" }
if {(($needinvitetype != 1) && ($needinvitetype != 2)) || ($needinvitetype == "0")} { set needinvitelog "*NEED INVITE* is \002NOT ACTIVE\002 because: \002No channel type has been seletected\002" }
if {($needlimittype == 1)} { set needlimitlog "*NEED LIMIT* is \002ACTIVE\002 on: \002[string tolower $needlimitchans]\002" }; if {($needlimittype == 2)} { set needlimitlog "*NEED LIMIT* is \002ACTIVE\002 on: \002All channels\002" }
if {(($needlimittype != 1) && ($needlimittype != 2)) || ($needlimittype == "0")} { set needlimitlog "*NEED LIMIT* is \002NOT ACTIVE\002 because: \002No channel type has been seletected\002" }
if {($needkeytype == 1)} { set needkeylog "*NEED KEY* is \002ACTIVE\002 on: \002[string tolower $needkeychans]\002" }; if {($needkeytype == 2)} { set needkeylog "*NEED KEY* is \002ACTIVE\002 on: \002All channels\002" }
if {(($needkeytype != 1) && ($needkeytype != 2)) || ($needkeytype == "0")} { set needkeylog "*NEED KEY* is \002NOT ACTIVE\002 because: \002No channel type has been seletected\002" }
putlog $needoplog; putlog $needunbanlog; putlog $needinvitelog; putlog $needlimitlog; putlog $needkeylog

return





