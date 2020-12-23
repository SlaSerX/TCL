set onjoin_msg {
 {
  "psihi tuka kvo iskash"
  
 }
}
set onjoin_chans "#kanala-ti"

bind join - * join_onjoin

#putlog "Onjoin.tcl by vissy loaded"

proc join_onjoin {nick uhost hand chan} {
 global onjoin_msg onjoin_chans botnick
 if {(([lsearch -exact [string tolower $onjoin_chans] [string tolower $chan]] != -1) || ($onjoin_chans == "*")) && (![matchattr $hand b]) && ($nick != $botnick)} {
  set onjoin_temp [lindex $onjoin_msg [rand [llength $onjoin_msg]]]
  foreach msgline $onjoin_temp {
   puthelp "PRIVMSG $nick :[subst $msgline]"
  }
 }
}
