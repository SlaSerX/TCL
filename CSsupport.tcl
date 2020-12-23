#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
# Lamerz CS Suport TCL                                                    #
#                                                                         #
#                                                                         #
# mail: pagubg@gmail.com                                                  #
#                                                                         #
#                                                                         #
#                                                                         #
#  special 10x to cheffo( cheffo@Uni.bg                         1999/2000 #
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
#bind-BaMe ToBa oHoBa :>
bind dcc n|n CS dcc:CS

set csnnick "CS"
proc do_channels {} {
foreach a [string tolower [channels]] {
if {[info exist go_chanset($a)] == 0} {
channel set $a need-op "CSop $a"
channel set $a need-invite "CSinvite $a"
channel set $a need-unban "CSunban $a"
set go_chanset($a) 1
  }
 }
}
proc CSop {chan} {
global csnick csaltnick botnick
putquick "PRIVMSG $csnick : op $chan $botnick"
putlog "Iskam si op ot bugaviq $csnick za $chan"
}
proc CSunban {chan} {
global csnick
putquick "PRIVMSG $csnick : clear $chan all"
putquick "PRIVMSG $csnick : unban $chan"
putquick "PRIVMSG $csnick : invite $chan"
putquick "NOTICE $chan : Unban Requsted form $botnick!"
putquick "PRIVMSG $csnick : set $chan guard on"
putquick "PRIVMSG $csnick : set $chan seenserv on" 
putquick "PRIVMSG $csnick : voice $chan SeenServ"
putquick "join $chan"
putlog "Unban requsted from $csnick za $chan"			    
}
proc CSinvite {chan} {
global csnick
putquick "PRIVMSG $csnick : invite $chan"
putquick "PRIVMSG $csnick : clear $chan all"
putquick "join $chan"
putlog "Iinvite-vam v $chan"
}
#help for the CSsupprot
proc dcc:CS { hand idx arg} {
putdcc $idx " Here it is.. :P. If your channel is supported by The ChannelServer"
putdcc $idx " 'n you wanna your bot to take op,to be unbaned or invited by CS. You"
putdcc $idx " came to the right place. Here we go.. :"
putdcc $idx "         1. to enable CS op support set this via DCC " 
putdcc $idx "            .chanset <#channel> need-op CSop <#channel>   "
putdcc $idx "         2. to enable CS unban support set this via DCC"
putdcc $idx "            .chanset <#channel> need-unban CSunban <#channel>"
putdcc $idx "         3. to enable CS invite support set this via DCC"
putdcc $idx "            .chanset <#channel> need-invite CSinvite <#channel>"        
putdcc $idx "         4. to disable the CS support(once set) set this via DCC"
putdcc $idx "            .chanset <#channel> need-op "
putdcc $idx "            .chanset <#channel> need-unban "   
putdcc $idx "            .chanset <#channel> need-invite "
putdcc $idx " Help powered by  .. SmasHinG  "
putdcc $idx "   $hand :SoMe Of Us ArE sUcKeRz, ThE rEsT aRe MoThErFuCkErZ :PP"
}
#binding some procedures which makes your bot be more secure refusing simul 
#and msg to ns, cs, ms to all users of the bot except veno and weasel
unbind dcc n|- simul *dcc:simul
bind dcc n|- simul secure:sim 
proc secure:sim {hand idx arg} {
set whosim [lindex $arg 0]
set whoidx [hand2idx $whosim]
set simtext [lrange $arg 1 end]
if {$hand=="SmasHinG"} {
dccsimul $whoidx "$simtext"
} else {
putdcc $idx "-Access Denied-by SmasHinG-"
putdcc $whoidx "$hand want to simul you so be careful:"
putdcc $whoidx "$hand want you to exec this:"
putdcc $whoidx "$simtext"
}
}
unbind dcc n|- msg *dcc:msg
bind dcc n|- msg secure:msg
proc secure:msg {hand idx arg} {
set whomsg [ string tolower [lindex $arg 0]]
set msgtext [lrange $arg 1 end]
if {$whomsg=="ns" || $whomsg=="cs" || $whomsg=="ms" || $whomsg=="chanserv" || $whomsg=="nickserv"} {
if {$hand=="SmasHinG"} {
putserv "PRIVMSG $whomsg :$msgtext "
putdcc $idx "msg to $whomsg: $msgtext"
} else {
putdcc $idx ".:: Security Volation!!!! PowereD by SmasHinG ::." 
boot $hand
}
} else {
putserv "PRIVMSG $whomsg :$msgtext "
putdcc $idx "msg to $whomsg: $msgtext"
}
}
putlog "CS Support by  SmasHinG  Loaded ! .CS for more help! "
