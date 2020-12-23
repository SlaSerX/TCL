bind msg * mtel msg.mtel
bind msg * globul msg.globul
bind msg * vivacom msg.vivacom
bind msg * help pub.sms
bind msg * sms pub.sms
bind pub * !sms pub.sms

proc pub.sms {nick uhost hand text} {
puthelp "PRIVMSG $nick :Синтаксис: /MSG SMSServ mtel/globul/vivacom <номер> <текст>. Номерата трябва да са без 088, 089 или 087"
puthelp "PRIVMSG $nick :Mtel пример: /msg SMSServ mtel xxxxxxx Zdravei, iskash li da piem kafe dnes?"
puthelp "PRIVMSG $nick :Globul пример: /msg SMSServ globul xxxxxxx Zdravei, iskash li da piem kafe dnes?"
puthelp "PRIVMSG $nick :Vivacom пример: /msg SMSServ vivacom xxxxxxx Zdravei, iskash li da piem kafe dnes?"
puthelp "PRIVMSG $nick :-----------------------------------------"
puthelp "PRIVMSG $nick :ВАЖНО!! Получателя трябва да е активирал услугата mail2sms."
puthelp "PRIVMSG $nick :-----------------------------------------"
puthelp "PRIVMSG $nick :M-tel активация: Отворете http://www.mtel.bg/mail2sms/index.php, въвдете си номера, потвърдете кода и е готово"
puthelp "PRIVMSG $nick :Globul активация: Пратете SMS на номер 1552 в който напишете само: OPEN"
puthelp "PRIVMSG $nick :Vivacom активация: Услугата е активирана по подразбиране"
puthelp "PRIVMSG $nick :-----------------------------------------"
puthelp "PRIVMSG $nick :Внимание!!! УСЛУГАТА НЕ Е АНОНИМНА! Максимален брой символи - 80, минимален брой думи - 3."
}

proc msg.mtel {nick uhost hand text} {
    if {[lindex $text 2] != ""} {
        exec echo $nick [lrange $text 1 end] | mail 35988[lindex $text 0]@sms.mtel.net
        putlog "Пращам SMS до [lindex $text 0]@mtel.net от $nick - [lrange $text 1 end]"
        puthelp "PRIVMSG $nick :Съобщението е изпратено успешно до [lindex $text 0]"
    } else { puthelp "PRIVMSG $nick :Напишете: /msg SMSServ <оператор> <номер> <текст>" }
}

proc msg.globul {nick uhost hand text} {
    if {[lindex $text 2] != ""} {
        exec echo $nick [lrange $text 1 end] | mail 35989[lindex $text 0]@sms.globul.bg
        putlog "Пращам SMS до [lindex $text 0]@globul.bg от $nick - [lrange $text 1 end]"
        puthelp "PRIVMSG $nick :Съобщението е изпратено успешно до [lindex $text 0]"
    } else { puthelp "PRIVMSG $nick :Напишете: /msg SMSServ <оператор> <номер> <текст>" }
}

proc msg.vivacom {nick uhost hand text} {
    if {[lindex $text 2] != ""} {
        exec echo $nick [lrange $text 1 end] | mail 35987[lindex $text 0]@sms.vivacom.bg
        putlog "Пращам SMS до [lindex $text 0]@sms.vivacom.bg от $nick - [lrange $text 1 end]"
        puthelp "PRIVMSG $nick :Съобщението е изпратено успешно до [lindex $text 0]"
    } else { puthelp "PRIVMSG $nick :Напишете: /msg SMSServ <оператор> <номер> <текст>" }
}

putlog "Инсталиран: SMS.tcl"