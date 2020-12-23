# *Description:
#  Filtre l'usage de la commande .msg disponible par la party-line selon
#  des destinataires (par ex, les serivices, channels, etc...).

#####################################################################
## Configuration du Script ##########################################
#####################################################################

# Laisser faire les utilisateurs ayant certains flags :
set nomsg(ignflags) "n"

# Destinataires à filtrer :
set nomsg(filter) {
   "NS"
   "CS"
   "#SweetHell"
}

#####################################################################
#####################################################################
#####################################################################

bind dcc n|n msg nomsg:filter
proc nomsg:filter {hand idx arg} {
global nomsg
set victime [string tolower [lindex $arg 0]]
foreach filter $nomsg(filter) {
   if {($victime == $filter) && ![matchattr $hand $nomsg(ignflags)|]} {
      putdcc $idx "You Don`t Have AutoriZatioN to Use .msg Those NickNames!!"
      return 0
   }
}
putserv "PRIVMSG $victime :[lrange $arg 1 end]"
putdcc $idx "Msg to [lindex $arg 0]: [lrange $arg 1 end]"
return 1
}

putlog "MSG Filter v1.1 by dJ_TEDY Loaded."

