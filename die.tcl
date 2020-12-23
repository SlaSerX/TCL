############################################################
#Позволяване на команда .die само за един user.            #
############################################################
################################################################
#Pishete botowner-a deto moje samo da .die ili msg .die bota   #
################################################################
set dieowner "SmasHinG"
set pass "SmurfTarGe7"
#########################################################################
#Ot tuka na dolu nqmate rabota .. by  SmasHinG                          #
#########################################################################
unbind msg n die *msg:die
unbind dcc n die *dcc:die
bind dcc n die denied:die
proc denied:die {hand idx text} {
global dieowner pass
          if {$hand==$dieowner } {
          if {$text == ""} {
    putidx $idx "Usage: die <password> \[reason\]"
return 0
}
set chkpass [lindex $text 0]
if {$chkpass == $pass} { 
if {[llength $text] > 1} {
set reason [lrange $text 1 end]
} else {
set reason "Authorized by $hand"
}
die $reason 
return 1
} else {
putdcc $idx "-=Access Denied=-"
sendnote dieowner Client "Opit ot $hand die $chkpass"
 }
}
}



