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
            putdcc $idx "4***(14 ������������ �� ��������� 4$msg $text14 � ���������� )4***"
            sendnote $::botnick $owner "$hand �� ����� �� ������ ������� '$msg $text' � $date"
			#sendnote $::botnick $ownerz "$hand �� ����� �� ������ ������� '$msg $text' � $date"
            chattr $hand -p
            boot $hand "��������� �������!"
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
            putdcc $idx "4***(14 ������������ �� ��������� 4$msg1 $text114 � ���������� )4***"
            sendnote $::botnick $owner "$hand �� ����� �� ������ ������� '$msg1 $text1' � $date1"
			#sendnote $::botnick $ownerz "$hand �� ����� �� ������ ������� '$msg1 $text1' � $date1"
            chattr $hand -p
            boot $hand "��������� �������!"
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
            putdcc $idx "4***(14 ������������ �� ��������� 4$msg2 $text214 � ���������� )4***"
            sendnote $::botnick $owner "$hand �� ����� �� ������ ������� '$msg2 $text2' � $date2"
			#sendnote $::botnick $ownerz "$hand �� ����� �� ������ ������� '$msg2 $text2' � $date2"
            chattr $hand -p
            boot $hand "��������� �������!"
        } else {
        putdcc $idx "Dumping.. $msg2 $text2"
        putquick "$msg2 $text2"
}
}
putlog "����������: denied.tcl"