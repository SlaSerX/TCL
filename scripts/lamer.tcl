# What is this?
#
#            Lamer.tcl V1.6 [01.12.2001] tested on 1.6.x
#          by acenoid ace@clan-octagon.de & IRCnet #eggdrop
#
# Greetings to Shasta, Sup, Johoho and all other folks @ #eggdrop!
#
# Overview / Installation
#
# This small TCL kicksbans specified users on command to prevent
# them from autorejoining.
#
# Usage:    PUB    !lamer <nick1> <nick2> <...>
#           MSG    !lamer <#channel> <nick1> <nick2> <...> 
#
# To install the script simply put the following line into your 
# eggdrop.conf file: "source scripts/lamer.tcl" and copy lamer.tcl to 
# /path/to/eggdrop/scripts on your shell. Rehash the bot to load
# the script.
#
# Please send me comments, flames, suggestions and questions if you 
# have any. Tell me if you think that this tcl is useful. Give me 
# credit, if you use the code or any parts of it in your tcl.
#
# Known Bugs / Limitations / Planned
#
# o Kick reason probably not visible if other bots on the channel
#   have "enforce bans" enabled.
#
# Disclaimer
#
# You agree to use this script at your own risk.
#
# Configuration

# What Channels should I work on? Ex. #octagon #eggdrop 
# Leave empty to enable on all channels the bot is on.
set lmrchn ""

# How long (in minutes) do you want to ban offender(s)
# (default 2)
set lmrbt "2"

# Flags of users who are protected (default "bomn|omn")
set lmrflg "bomn|omn"

# Kick-Reason
set lmrrsn "Lamers are not welcome here!"

# Announce Cleanup in the channel? (default 0)
set lmrtlk "0"

# And what do we want to tell them?
# Note: Announce must be 1 for this.
set lmrtxt "Processing..."

# Enable logging? (default 0)
set lmrlog "0"

## End of the configuration. ##

set lmr(version) "V1.6"
set lmr(rdate) "Sat 01 Dec 01"

bind pub o|o !lamer lmr:kb
bind msg o|o !lamer lmr:mkb

proc lmr:kb {nick uhost hand chan who} {
   global lmrbt lmrchn lmrflg lmrrsn lmrtlk lmrtxt lmrlog botnick
   if {(($lmrchn == "") || ([lsearch -exact $lmrchn [string tolower $chan]] != -1)) } {
      if {[botisop $chan] && [isop $nick $chan]} {
         if { $who != "" } {
            if { $lmrtlk == "1" } { putserv "PRIVMSG $chan $lmrtxt" -next}
            foreach targets $who {   
               set bwho [nick2hand $targets $chan]
               set bmatch [matchattr $bwho $lmrflg $chan]
               set bonchan [onchan $targets $chan]
               if { [string tolower $targets] != [string tolower $botnick] && $bmatch != "1" && $bonchan == "1" } { 
                  if { $lmrtlk == "1" } { putserv "PRIVMSG $chan $lmrtxt" -next; incr lmrtlk}
                  set bhost [getchanhost $targets $chan]
                  putserv "MODE $chan +b *!$bhost"
                  newchanban $chan *!$bhost $nick lmr-ban $lmrbt
                  putkick $chan $targets $lmrrsn
               }
            }
            if { $lmrtlk >= "1" } { set lmrtlk "1" }            
            if { $lmrlog == "1" } { putlog "LMR: called by $nick ($hand) on $chan. ($who)" }
         }
      }
   }
}
proc lmr:mkb {nick uhost hand mwho} {
   global lmrbt lmrchn lmrflg lmrrsn lmrtlk lmrtxt lmrlog botnick
   set chan [lindex $mwho 0]
   set who [lrange $mwho 1 end]
   if {(($lmrchn == "") || ([lsearch -exact $lmrchn [string tolower $chan]] != -1)) } {
      if {[botisop $chan] && [isop $nick $chan]} {
         if { $who != "" } {
            foreach targets $who {   
               set bwho [nick2hand $targets $chan]
               set bmatch [matchattr $bwho $lmrflg $chan]
               set bonchan [onchan $targets $chan]
               if { [string tolower $targets] != [string tolower $botnick] && $bmatch != "1" && $bonchan == "1" } { 
                  if { $lmrtlk == "1" } { putserv "PRIVMSG $chan $lmrtxt" -next; incr lmrtlk}
                  set bhost [getchanhost $targets $chan]
                  putserv "MODE $chan +b *!$bhost"
                  newchanban $chan *!$bhost $nick lmr-ban $lmrbt
                  putkick $chan $targets $lmrrsn
               }
            }
            if { $lmrtlk >= "1" } { set lmrtlk "1" }
            if { $lmrlog == "1" } { putlog "LMR: called by $nick ($hand) on $chan. ($who)" }
         }
      }
   }
}
putlog "LMR: Lamer.tcl $lmr(version) - $lmr(rdate) by acenoid (ace@clan-octagon.de) loaded sucessfully."

# Version History
# 01.12. V1.6
#        * now announcing only if someone will be banned (helps
#          to prevent channel floods)
#        * you must have op now to use public and msg commands
#        * tiny bug in the ban proc fixed
# 25.11. V1.5
#        * ensured that the ban is made first
#        + Logging can be turned on/off now
#        + We can define a kick reason now
#        + msg-command added
#        + Possible to announce clean-up in channel
# 24.11. V1.0
#        * initial release