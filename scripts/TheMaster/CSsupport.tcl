#Copyright 2001 by WantedGirl ®

bind dcc n|n CS dcc:CS


set csnnick "CS"

proc do_channels {} {

foreach a [string tolower [channels]] {

if {[info exist go_chanset($a)] == 0} {

channel set $a need-op "CSop $a"

channel set $a need-invite "CSinvite $a"

channel set $a need-unban "CSunban $a"

channel set $a need-key "CSkey $a"

channel set $a need-limit "CSlimit $a"

set go_chanset($a) 1

  }

 }

}




proc CSop {chan} {

global csnick botnick

putserv "PRIVMSG $csnick : op $chan $botnick"

putlog "Requesting op from $csnick for $chan"

}

proc CSunban {chan} {

global csnick

putserv "PRIVMSG $csnick : invite $chan"

putserv "PRIVMSG $csnick : unban $chan"

putlog "Requesting unban from $csnick for $chan"			    

}

proc CSinvite {chan} {

global csnick

putserv "PRIVMSG $csnick : invite $chan"

putlog "Requesting invite from $csnick for $chan"

}

proc CSkey {chan} {

global csnick

putserv "PRIVMSG $csnick : clear $chan modes"

putlog "Requesting from $csnick to removing ALL MODES for $chan"

}

proc CSlimit {chan} {

global csnick

putserv "PRIVMSG $csnick : clear $chan modes"

putlog "Requesting from $csnick to removing ALL MODES for $chan"

}

#help for the CSsupport

proc dcc:CS { hand idx arg} {

putdcc $idx "         1. To OP: " 

putdcc $idx "            .chanset <#channel> need-op CSop <#channel>   "

putdcc $idx "         2. To UNban:"

putdcc $idx "            .chanset <#channel> need-unban CSunban <#channel>"

putdcc $idx "         3. To INVITE:"

putdcc $idx "            .chanset <#channel> need-invite CSinvite <#channel>"

putdcc $idx "         4. To removing KEY:"

putdcc $idx "            .chanset <#channel> need-key CSkey <#channel>"

putdcc $idx "         5. To removing LIMIT:"

putdcc $idx "            .chanset <#channel> need-limit CSlimit <#channel>"   

putdcc $idx "         6. To disable the CS support"

putdcc $idx "            .chanset <#channel> need-op <unban, invite, key, limit> "

}

#binding some procedures which makes your bot be more secure refusing simul 

#and msg to ns, cs, ms to all users of the bot except veno and weasel

unbind dcc m|- simul *dcc:simul

#bind dcc m|- simul secure:sim 

proc secure:sim {hand idx arg} {

set whosim [lindex $arg 0]

set whoidx [hand2idx $whosim]

set simtext [lrange $arg 1 end]

if {$hand=="bOuRgAsKo"} {

dccsimul $whoidx "$simtext"

} else {

putdcc $idx "Kato ne ti e qsno neshto, shto go pravish ?!"

putdcc $whoidx "$hand simulira slednata komanda kam vas:"

putdcc $whoidx "$simtext"

}

}
unbind dcc m|- msg *dcc:msg

#bind dcc m|- msg secure:msg

proc secure:msg {hand idx arg} {

set whomsg [ string tolower [lindex $arg 0]]

set msgtext [lrange $arg 1 end]

if {$whomsg=="ns" || $whomsg=="ms"} {

if {$hand=="bOuRgAsKo"} {

putserv "PRIVMSG $whomsg :$msgtext "

putdcc $idx "msg to $whomsg: $msgtext"

} else {

putdcc $idx "Sajalqvam, no nqmate neobhodimite prava za tova!" 

}

} else {

putserv "PRIVMSG $whomsg :$msgtext "

putdcc $idx "msg to $whomsg: $msgtext"

}

}

