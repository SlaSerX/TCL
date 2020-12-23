#Denied MSG
#Dobawete (set ownerz "nick") vyv conf-a na bota za 2ri owner

unbind dcc o|o msg *dcc:msg
bind dcc n|n msg denied:msg
proc denied:msg {hand idx arg} {   
       global owner ownerz owners
       set date ([strftime %T14@%d.%m.%Y])
       set msg [string tolower [lindex $arg 0]]
       set text [lrange $arg 1 end]
          if { ( $hand != $owner ) && ( $hand != $ownerz ) && ( $hand != $owners) } {
            putdcc $idx "4***(14 Използването на командата 4$msg $text14 е ограничено )4***"
            sendnote $::botnick $owner "$hand се опита да ползва команда '$msg $text' в $date"
			#sendnote $::botnick $ownerz "$hand се опита да ползва команда '$msg $text' в $date"
            chattr $hand -p
            boot $hand "Забранена команда!"
        } else {
        putquick "PRIVMSG $msg :$text"
        putdcc $idx "msg to $msg: $text"
}
}
#Denied BOOT
unbind dcc N boot *dcc:boot
bind dcc n|n boot dcc:boot
proc dcc:boot {hand idx arg} {   
       global owner ownerz
	   set date1 ([strftime %T14@%d.%m.%Y])
       set msg1 [string tolower [lindex $arg 0]]
       set text1 [lrange $arg 1 end]
          if { ( $hand != $owner ) && ( $hand != $ownerz ) } {	   
            putdcc $idx "4***(14 Използването на командата 4$msg1 $text114 е ограничено )4***"
            sendnote $::botnick $owner "$hand се опита да ползва команда '$msg1 $text1' в $date1"
			#sendnote $::botnick $ownerz "$hand се опита да ползва команда '$msg1 $text1' в $date1"
            chattr $hand -p
            boot $hand "Забранена команда!"
        } else {
		putdcc $idx "4****15 Booting 4$msg1 with reason:4 $text1"
        boot $msg1 $text1
}
}
#Denied DUMP
unbind dcc n|n dump *dcc:dump
bind dcc n|n dump dcc:dump
proc dcc:dump {hand idx arg} {   
       global owner ownerz
	   set date2 ([strftime %T14@%d.%m.%Y])
       set msg2 [string tolower [lindex $arg 0]]
       set text2 [lrange $arg 1 end]
          if { ( $hand != $owner ) && ( $hand != $ownerz ) } {   
            putdcc $idx "4***(14 Използването на командата 4$msg2 $text214 е ограничено )4***"
            sendnote $::botnick $owner "$hand се опита да ползва команда '$msg2 $text2' в $date2"
			#sendnote $::botnick $ownerz "$hand се опита да ползва команда '$msg2 $text2' в $date2"
            chattr $hand -p
            boot $hand "Забранена команда!"
        } else {
        putdcc $idx "Dumping.. $msg2 $text2"
        putquick "$msg2 $text2"
}
}
putlog "Инсталиран: denied.tcl"