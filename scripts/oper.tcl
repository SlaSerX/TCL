 set onick "Botimir"
 set opass "lamzo321"
 set oserv "irc.lamzo.com"
 bind raw - 001 oper_mode
 proc oper_mode {from keyw arg} {
   global server oserv onick opass botnick foruser 
   set from [string tolower $from]
   set oserv [string tolower $oserv]
   if {$from == $oserv} {
     putserv "oper $onick $opass"
     putserv "mode $botnick +lyIH-cxkdws"
     set foruser 0
     putlog "Acquire the IRCop atribute on server $from"
   } {
     putlog "Could't acquire the IRCop atribute on server $from"
   }
 }