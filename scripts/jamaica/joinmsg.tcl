#####################################################################
#####################################################################
##         Joinmsg.tcl By AnJin < gani@abv.bg >                    ##
#####################################################################
#####################################################################

bind join - * sayinfo 

# Strings
set info_owner {
"0,1My God just came in..."
"13,1Hello my OWNER"
"11,1I like bitches like you..."
"7,1I greet you my owner"
"8,1Welcome my owner"
"15,1Fuck me my owner!"
"9,1Most Great"
"0,1nice shoes, wanna fuck ?"
"0,1Lol...my owner just joined the channel"
}
set info_localowner {
    "Lol...my local owner just joined the channel"
    "Welcome localowner of mine.."
    "Hi sweety {}"
}
set info_master {
    "15,1Oh...My MASTER"
    "15,1I'm gonna be quiet my master"
    "15,1Don't hit me my master"
    "15,1Master detected"
    "15,1Jedi Master"
    "15,1Welcome my MastA"
    "15,1I love you untill The end of The World"
    "15,1Fuck you niggA, cuZ I Can!"
}
set info_friend {
    "11,1Ou, my friend :)"
    "11,1Sweety"
    "11,1You're the BEST"
    "11,1My friendship with you is not over yet!"
    "11,1FUCK me Baby {}"
    "11,10ooo0o0o0, Whats UP?"
    "11,1WazAAaaAAaaAaaAaaAAaAaAaaAAA?"
    "11,1I like bitches like you..."
    "11,1What's UP niggA?"
    "11,1Lick my Ass bitch!"
    "11,1Hello, Wanna fuck?"
    "11,1I'm watching you..."
    "11,1Can I fuck you?"
    "11,1Hosla Bad MathaFucka"
    "11,1Who's your daddy now?"
    "11,1Blow ME..."
    "11,1Eat my pussy..."
}
set info_oper {
    "You simple oper, watch out !"
    "Operator detected!"
    "You gonna lose your flags if you do something bad!"
}
set info_loser {
    "9(12...and thank you for playing9)"
    "9(12...and don't come back9)"
    "9,0(12Barai Mecha!!!9)"
}

##############################
proc sayinfo { nick host handle chan } {
   global botnick
   if { $nick != $botnick } {
       if {[matchattr $handle n]} {
           putserv "PRIVMSG $chan :9(15$nick4) 9,1(15+n12)"
       } elseif {[matchattr $handle |n $chan]} {
           putserv "PRIVMSG $chan :9(15$nick4) 9,1(15+n12)"
       } elseif {[matchattr $handle m]} {
           putserv "PRIVMSG $chan :9(12$nick4) 9,1(12+m4)"
       } elseif {[matchattr $handle |m $chan]} {
           putserv "PRIVMSG $chan :9(12$nick4) 9,1(12+m4)"
       } elseif {[matchattr $handle f]} {
           putserv "PRIVMSG $chan :9(13$nick9) 9,1(7+f9)"
       } elseif {[matchattr $handle |f $chan]} {
           putserv "PRIVMSG $chan :9(13$nick9) 9,1(7+f9)"
       } elseif {[matchattr $handle o]} {
           putserv "PRIVMSG $chan :9(8$nick9) 9,1(8+o9)"
       } elseif {[matchattr $handle |o $chan]} {
           putserv "PRIVMSG $chan :9(8$nick9) 9,1(8+o9)"
       }
   }
}

# random(s)

proc rand_owner {nick} {
     global info_owner
     set result [lindex $info_owner [rand [llength $info_owner]]]
     return "$result"
}
proc rand_localowner {nick} {
     global info_localowner
     set result [lindex $info_localowner [rand [llength $info_localowner]]]
     return "$result"
}
proc rand_master {nick} {
     global info_master
     set result [lindex $info_master [rand [llength $info_master]]]
     return "$result"
}
proc rand_friend {nick} {
     global info_friend
     set result [lindex $info_friend [rand [llength $info_friend]]]
     return "$result"
}
proc rand_oper {nick} {
     global info_oper
     set result [lindex $info_oper [rand [llength $info_oper]]]
     return "$result"
}
proc rand_loser {nick} {
     global info_loser
     set result [lindex $info_loser [rand [llength $info_loser]]]
     return "$result"
}
#putlog "13,1joinmsg.tcl 15By 11Jah9 LoadeD"
