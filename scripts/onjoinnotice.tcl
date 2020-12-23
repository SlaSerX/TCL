set onjoin_msg {
 {
  "Welcome To #ruse"
  
 }
}
set onjoin_chans "#ruse"

bind join - * join_onjoin

putlog "Notice Message by demon"

proc join_onjoin {nick uhost hand chan} {
 global onjoin_msg onjoin_chans botnick
 if {(([lsearch -exact [string tolower $onjoin_chans] [string tolower $chan]] != -1) || ($onjoin_chans == "*")) && (![matchattr $hand b]) && ($nick != $botnick)} {
  set onjoin_temp [lindex $onjoin_msg [rand [llength $onjoin_msg]]]
  foreach msgline $onjoin_temp {
   puthelp "NOTICE $nick :[subst $msgline]"
  }
 }
}
