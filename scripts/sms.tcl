bind msg * mtel msg.mtel
bind msg * globul msg.globul
bind msg * vivacom msg.vivacom
bind msg * help pub.sms
bind msg * sms pub.sms
bind pub * !sms pub.sms

proc pub.sms {nick uhost hand text} {
puthelp "PRIVMSG $nick :���������: /MSG SMSServ mtel/globul/vivacom <�����> <�����>. �������� ������ �� �� ��� 088, 089 ��� 087"
puthelp "PRIVMSG $nick :Mtel ������: /msg SMSServ mtel xxxxxxx Zdravei, iskash li da piem kafe dnes?"
puthelp "PRIVMSG $nick :Globul ������: /msg SMSServ globul xxxxxxx Zdravei, iskash li da piem kafe dnes?"
puthelp "PRIVMSG $nick :Vivacom ������: /msg SMSServ vivacom xxxxxxx Zdravei, iskash li da piem kafe dnes?"
puthelp "PRIVMSG $nick :-----------------------------------------"
puthelp "PRIVMSG $nick :�����!! ���������� ������ �� � ��������� �������� mail2sms."
puthelp "PRIVMSG $nick :-----------------------------------------"
puthelp "PRIVMSG $nick :M-tel ���������: �������� http://www.mtel.bg/mail2sms/index.php, ������� �� ������, ���������� ���� � � ������"
puthelp "PRIVMSG $nick :Globul ���������: ������� SMS �� ����� 1552 � ����� �������� ����: OPEN"
puthelp "PRIVMSG $nick :Vivacom ���������: �������� � ���������� �� ������������"
puthelp "PRIVMSG $nick :-----------------------------------------"
puthelp "PRIVMSG $nick :��������!!! �������� �� � ��������! ���������� ���� ������� - 80, ��������� ���� ���� - 3."
}

proc msg.mtel {nick uhost hand text} {
    if {[lindex $text 2] != ""} {
        exec echo $nick [lrange $text 1 end] | mail 35988[lindex $text 0]@sms.mtel.net
        putlog "������ SMS �� [lindex $text 0]@mtel.net �� $nick - [lrange $text 1 end]"
        puthelp "PRIVMSG $nick :����������� � ��������� ������� �� [lindex $text 0]"
    } else { puthelp "PRIVMSG $nick :��������: /msg SMSServ <��������> <�����> <�����>" }
}

proc msg.globul {nick uhost hand text} {
    if {[lindex $text 2] != ""} {
        exec echo $nick [lrange $text 1 end] | mail 35989[lindex $text 0]@sms.globul.bg
        putlog "������ SMS �� [lindex $text 0]@globul.bg �� $nick - [lrange $text 1 end]"
        puthelp "PRIVMSG $nick :����������� � ��������� ������� �� [lindex $text 0]"
    } else { puthelp "PRIVMSG $nick :��������: /msg SMSServ <��������> <�����> <�����>" }
}

proc msg.vivacom {nick uhost hand text} {
    if {[lindex $text 2] != ""} {
        exec echo $nick [lrange $text 1 end] | mail 35987[lindex $text 0]@sms.vivacom.bg
        putlog "������ SMS �� [lindex $text 0]@sms.vivacom.bg �� $nick - [lrange $text 1 end]"
        puthelp "PRIVMSG $nick :����������� � ��������� ������� �� [lindex $text 0]"
    } else { puthelp "PRIVMSG $nick :��������: /msg SMSServ <��������> <�����> <�����>" }
}

putlog "����������: SMS.tcl"