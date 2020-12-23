set onjoin_msg "Welcome to #IRC And Have a Nice Chat All ;p)"
bind join - * join_onjoin
proc join_onjoin {nick uhost hand chan} {
 global onjoin_msg botnick
 puthelp "NOTICE $nick :$onjoin_msg"
}


