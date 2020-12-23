##########################################################################
# OpControl.tcl by ShakE <shake@abv.bg>		                         #
##########################################################################
# Tozi tcl e napisan ot mene, s mnogo pove4e komandi ot ostanalite i nema#
# nujda ot "auth" za da gi izpolzvate. Napravil sam mnogo kratki komandi #
# za po burza i lesna namesa primerno pri takeover.Eto NEKOI ot komandite#
# !op !dop !v !dev !k !kb !b !+ban !-ban !sav !rehash !+user !+bot !+host#
# Napi6i v kanala ili na private !help i 6te ti izkara vsi4ki komandi. 	 #
##########################################################################
# Ako imate nqkakvi vaprosi, predlojenia ili kritiki posetete foruma na	 #
# http://shake.hit.bg i pi6ete tam!                                      #
##########################################################################
bind pub -|- !ip pub_help
proc pub_help {nick uhost hand chan txt} {
  if {[llength $txt]<1} {
    putlog "\-=|$nick|=- \ #($chan)# !ip"
    putserv "privmsg $chan :Server IP Adress: 79.124.67.6:27013"
  }
#  putlog "\-=|$nick|=- \ #($chan)# failed !ip $txt"
}
putlog "OpControl.tcl by ShakE - get more tcl from http://shake.hit.bg"
