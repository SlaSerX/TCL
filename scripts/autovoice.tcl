##############################################
# Autovoice.tcl 0.1 by KuNgFo0 (#eggfaq@efnet)
#
# Set the next line as the nickname string you want to autovoice
# Examples:
#  set autovoice_nick "*xdcc"  -> for nicks that end with "xdcc"
#  set autovoice_nick "*xdcc*" -> for nicks that contain "xdcc" anywhere
#  set autovoice_nick "xdcc*"  -> for nicks that begin with "xdcc"
#  set autovoice_nick "*"      -> for all nicks
set autovoice_nick "*"
set autohop_nick "*XDCC*"
set autohop1_nick "*Syntax*"
# Set the next line as the channels you want to run in
set autovoice_chans "#ruse"

bind join - * join_autovoice

putlog "Инсталиран: AutoVoice.tcl"

proc join_autovoice {nick uhost hand chan} {
 global autovoice_nick autovoice_chans botnick
 if {(([lsearch -exact [string tolower $autovoice_chans] [string tolower $chan]] != -1) || ($autovoice_chans == "*")) && ([string match [string tolower $autovoice_nick] [string tolower $nick]]) && ($nick != $botnick)} {
  pushmode $chan +v $nick
 }
 if {(([lsearch -exact [string tolower $autovoice_chans] [string tolower $chan]] != -1) || ($autovoice_chans == "*")) && ([string match [string tolower $autohop_nick] [string tolower $nick]]) && ($nick != $botnick)} {
  pushmode $chan +h $nick
 }            
 if {(([lsearch -exact [string tolower $autovoice_chans] [string tolower $chan]] != -1) || ($autovoice_chans == "*")) && ([string match [string tolower $autohop1_nick] [string tolower $nick]]) && ($nick != $botnick)} {
  pushmode $chan +h $nick
 }    
}




