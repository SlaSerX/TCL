##########################################################
#              ZmeySoft by MUTI                          #
########################################################## 
set onjoin_msg {
 {
   "9,1Welcome to 8$chan 9$nick"
   "4,1Please don't flood, abuse or advertise or you will get killed/klined/glined. Thank you!"
  
 }
}
set onjoin_chans "*"

bind join - * join_onjoin

putlog "Loaded:OnJoinMSG.tcl"

proc join_onjoin {nick uhost hand chan} {
 global onjoin_msg onjoin_chans botnick
 if {(([lsearch -exact [string tolower $onjoin_chans] [string tolower $chan]] != -1) || ($onjoin_chans == "*")) && (![matchattr $hand b]) && ($nick != $botnick)} {
  set onjoin_temp [lindex $onjoin_msg [rand [llength $onjoin_msg]]]
  foreach msgline $onjoin_temp {
   puthelp "NOTICE $nick :[subst $msgline]"
  }
 }
}
