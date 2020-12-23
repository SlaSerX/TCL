#         Script : Kick Commentor v1.00 by David Proper (Dr. Nibble [DrN])
#                  Copyright 2001 Radical Computer Systems
#                             All Rights Reserved
#
#       Testing
#      Platforms : Linux 2.2.16
#                  Eggdrop v1.6.2
#            And : SunOS 5.8
#                  Eggdrop v1.5.4
#
#    Description : Kick Commentor spits out a random text line in the
#                  channel when someone gets kicked.
#
#        History : 05/27/2001 - First Release
#
#
#   Future Plans : Fix Bugs. :)
#
# Author Contact :     Email - DProper@bigfoot.com
#                  Home Page - http://home.earthlink.net/~daproper
#                        IRC - Nick: DrN  UnderNet/DALnet
#
# Chaotix.Net is currentlly offline. Should return no later then Jan 1st, 2002
#
#   Radical Computer Systems - http://www.chaotix.net/rcs/
# To subscribe to the RCS mailing list: mail majordomo@chaotix.net and in
#  BODY of message, type  subscribe rcs-list
#
#  Feel free to Email me any suggestions/bug reports/etc.
# 
# You are free to use this TCL/script as long as:
#  1) You don't remove or change author credit
#  2) You don't release it in modified form. (Only the original)
# 
# If you have a "too cool" modification, send it to me and it'll be
# included in the official release. (With your credit)
#
# Commands Added:
#  Where     F CMD       F CMD         F CMD        F CMD
#  -------   - --------- - ----------- - ---------- - --------- - -------
#  Public:   N/A
#     MSG:   N/A
#     DCC:   N/A
#
# Public Matching: N/A
#

#\
# |##### NOTE: Anything on the Chaotix.Net domain is currently offline
# |#####       until we move. (Wife's in college, taking all our money)
# |#####       Email me at dproper@bigfoot.com if you want to help.
#/

# Publics is for another script of mine that allows you to turn off
# channel stuff like this. Uncomment the next line if not running it.
set publics 1

set kickedmsgs {
 {Toia $target i bez tfa ne go haresfax :)}
 {\001ACTION Gleda kak $target izlita ot kanala :)\001}
 {Hahahahaha bye bye $target! :Ppp}
 {YrrT.smuuukni smukacha $nick}
 {sh $nick mai mai sha zemish nagradata za Kick na godinata.}
 {Da padat drehi i zadrujki da naritame $target in the ass :)}
 {mm $nick ave ti shto pak biesh decata ve???}
 {Hey, $nick mnogo ritash dneska.}
 {Pyrdi na uhoto na $target ..}
 {$nick tochno taka.. sloji mu go na $target otzad}
 {Ohooo $target ...slojiha li ti go w ustichkata.}
 {Hey, $nick mnogo ritash dneska.}
 {$nick : Drupni sa na edna strana.}
}
set kickedver "v1.00"

bind kick - * watchkicked
proc watchkicked {nick uh hand chan target reason} {
global botnick publics kickedmsgs
if {$publics == 0} {return 0}
set outmsg ""
set ltext [string tolower [lindex $reason 0]]
if {([matchattr $hand b] != 0)} {return 1}

if {$target == $botnick} {putserv "PRIVMSG $nick :Ya, fuck you too bitch."
                         } else {
                                 set outmsg [lindex $kickedmsgs [rand [llength $kickedmsgs]]]
                                }
if {($outmsg != "")} {
                      regsub {\$nick} $outmsg $nick outmsg
                      regsub {\$target} $outmsg $target outmsg
                      regsub {\$chan} $outmsg $chan outmsg
                      regsub {\\001} $outmsg \001 outmsg
                      regsub {\\001} $outmsg \001 outmsg
                      regsub {\\002} $outmsg \002 outmsg
                      regsub {\\002} $outmsg \002 outmsg
                      putserv "privmsg $chan :$outmsg"
                     }
}

putlog "Kick Commentor $kickedver bY dJ_TEDY Loaded."

