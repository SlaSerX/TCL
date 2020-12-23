############################################################
#                                                          #
#     bncadmin.tcl by SidneY • IRC.ThE-ZonE.neT:6667       #
#     SidneY@MaiL-ThE-ZonE.neT                             #
#     (c) SidneY 2006                                      #
#                                                          #
############################################################

set service "bncadmin.tcl by SidneY"
set scriptversion "v1.1"

################################################################################################################
#                                                                                                              #
#    B E S C H R E I B U N G :                                                                                 #
#    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                                                                   #
#   - Das folgende Script beinhaltet diverse Bouncer-Befehle, mit denen man einen psyBNC administrieren kann.  #
#                                                                                                              #
#   - Der Channel ist einstellbar, in dem das Script laufen soll.                                              #
#                                                                                                              #
#   - Automatische Übertragung des Passwortes und der benötigten Verbindungsdaten an den geaddeten User.       #
#    (Funktioniert nur, sofern der geaddete BNC-Nick und der IRC-Nick identisch ist).                          #
#                                                                                                              #
#   - Einstellbarer Zugriffslevel für alle Befehle.                                                            #
#                                                                                                              #
#   - Der Bot muss zum Bouncer connected sein und Adminrechte besitzen.                                        #
#                                                                                                              #
#   - Befehle: !bnchelp , !adduser <nick> , ?adduser <nick> , !deluser <nick> , !madmin <nick> ,               #
#              !unadmin <nick> , !pass <nick> <passwort>                                                       #
#                                                                                                              #
################################################################################################################

# Channel in dem die BNC-Commands ausgeführt werden sollen.
set bncchan "#bouncers"

# Port, über den der BNC erreichbar ist.
set bncport "31337"

# Einheitlicher BNC-Ident (Hier MUSS etwas eingetragen werden)
set bncident "\002\0034Bouncer.by.mynetwork.com\002\003"

# Hier bitte deinen Nick oder das Serverteam eintragen.
set grussnick "mynetwork.com-Team"

# IP oder Name des Servers eintragen, über den der BNC erreichbar ist.
set bncserver "server.mynetwork.com"

# IRC-Server, zu dem connectet werden soll.
set ircserver "localhost"

# Port, über den der IRC-Server erreichbar ist.
set ircport "6667"

# Setze hier die Flag derer, die auf die BNC-Commands zugreifen dürfen.     
set botflag "n"

# * v - voice
# * o - op
# * m - master
# * n - owner
# * f - friend
# * p - partyline access


## === SCRIPT === Ab hier bitte nichts verändern, wenn du nicht genau weißt, was du tust ;) === ##

bind pub $::botflag !bnchelp bnchelp_msg
proc bnchelp_msg {nick uhost hand chan arg} {
  if {$::bncchan != $chan} {return 0}
  putquick "NOTICE $nick :\002Folgende Befehle sind möglich\002:"
  putquick "NOTICE $nick :\002!adduser <nick>\002 -- Erstellt einen Bouncer, wenn der User mit diesem Nick online ist."
  putquick "NOTICE $nick :\002?adduser <nick>\002 -- Erstellt einen Bouncer, wenn der User mit diesem Nick offline ist."
  putquick "NOTICE $nick :\002!deluser <nick>\002 -- Löscht den Bouncer des angegebenen Nicknamen."
  putquick "NOTICE $nick :\002!pass <nick> <passwort>\002 -- Ändert das Bouncer-Passwort des Users."
  putquick "NOTICE $nick :\002!madmin <nick>\002 -- Macht den angegebenen User zum Admin."
  putquick "NOTICE $nick :\002!unadmin <nick>\002 -- Nimmt dem angegebenen User die Adminrechte."
  putquick "NOTICE $nick :"
  putquick "NOTICE $nick :\002Hilfedatei von: $::service $::scriptversion\002"
  return 1
}

bind pub $::botflag !adduser adduser_msg
proc adduser_msg {nick uhost hand chan arg} {
  if {[lindex [split $arg] 0] == ""} { puthelp "notice $nick :\002Syntax:\002 !adduser <nick>" ; return 0 }
  if {$::bncchan != $chan} {return 0}
  bind raw -|- 303 bncnick:isonline
  putquick "ISON $arg"
  set ::addnick $arg
  set ::bncadder $nick
  return 1
 }

proc bncnick:isonline {from keyword arg} {
  global botnick
  if {([string match "*$::addnick*" $arg])} {
   putquick "PRIVMSG -psyBNC :adduser $::addnick :$::bncident"
   unbind raw -|- 303 bncnick:isonline
      return 1
    } else {
      putquick "NOTICE $::bncadder :\002\0034$::addnick ist derzeit nicht online und der BNC wurde nicht erstellt!\003\002"
      putquick "NOTICE $::bncadder :Die BNC-Daten wären nicht an $::addnick übertragen worden."
      putquick "NOTICE $::bncadder :Möchtest du den BNC trotzdem erstellen? ---> Tippe: \002?adduser <Nick>\002"
      unbind raw -|- 303 bncnick:isonline
      unset ::addnick; unset ::bncadder
      return 0
    }
  }

bind pub $::botflag ?adduser adduser_omsg
proc adduser_omsg {nick uhost hand chan arg} {
  if {[lindex [split $arg] 0] == ""} { puthelp "notice $nick :\002Syntax:\002 ?adduser <nick>" ; return 0 }
  if {$::bncchan != $chan} {return 0}
  putquick "PRIVMSG -psyBNC :adduser $arg :$::bncident"
  set ::addnick $arg
  set ::bncadder $nick
  return 1
}

bind pub $::botflag !deluser deluser_msg
proc deluser_msg {nick uhost hand chan arg} {
  if {[lindex [split $arg] 0] == ""} { puthelp "notice $nick :\002Syntax:\002 !deluser <nick>" ; return 0 }
  if {$::bncchan != $chan} {return 0}
   putquick "PRIVMSG -psyBNC :deluser $arg"
   putquick "NOTICE $nick :\002Bouncer von $arg gelöscht!\002"
   return 1
}

bind pub $::botflag !madmin madmin_msg
proc madmin_msg {nick uhost hand chan arg} {
  if {[lindex [split $arg] 0] == ""} { puthelp "notice $nick :\002Syntax:\002 !madmin <nick>" ; return 0 }
  if {$::bncchan != $chan} {return 0}
   putquick "PRIVMSG -psyBNC :madmin $arg"
   putquick "NOTICE $nick :\002Du hast soeben $arg zum Bouncer-Admin befördert.\002"
   putquick "NOTICE $nick :\002$arg wurde darüber in Kenntnis gesetzt.\002"
   putquick "NOTICE $arg :\002Du wurdest soeben zum Bouncer-Admin befördert.\002"
   return 1
}

bind pub $::botflag !unadmin unadmin_msg
proc unadmin_msg {nick uhost hand chan arg} {
  if {[lindex [split $arg] 0] == ""} { puthelp "notice $nick :\002Syntax:\002 !unadmin <nick>" ; return 0 }
  if {$::bncchan != $chan} {return 0}
   putquick "PRIVMSG -psyBNC :unadmin $arg"
   putquick "NOTICE $nick :\002Du hast soeben $arg's Adminrechte auf dem Bouncer entfernt.\002"
   putquick "NOTICE $nick :\002$arg wurde darüber in Kenntnis gesetzt.\002"
   putquick "NOTICE $arg :\002Deine Adminrechte auf dem Bouncer sind erloschen.\002"
   return 1
}

bind pub $::botflag !pass pass_msg
proc pass_msg {nick chan uhost hand text} {
  set arg1 [lindex [split $text] 0]
  set arg2 [lrange [split $text] 1 end]
  if {[lindex [split $arg1] 0] == ""} { puthelp "notice $nick :\002Syntax:\002 !pass <nick> <passwort>" ; return 0 }
   putquick "PRIVMSG -psyBNC :password $arg1 :$arg2"
   putquick "NOTICE $arg1 :\002Hallo $arg1, dein Bouncer-Passwort wurde soeben geändert.\002"
   putquick "NOTICE $arg1 :"
   putquick "NOTICE $arg1 :Dein neues Passwort lautet: $arg2"    
   putquick "NOTICE $arg1 :"
   putquick "NOTICE $arg1 :\002Mit freundlicher Empfehlung, $::grussnick\002"
   putquick "NOTICE $nick :\002Bouncer-Passwort für $arg1 geändert!\002"
   putquick "NOTICE $nick :\002Das Passwort lautet: '$arg2'\002"
   putquick "NOTICE $nick :\002Das neue Passwort wurde erfolgreich an $arg1 übermittelt.\002"
   return 1
  }

bind msg - "Neuer" proc:addmsg
proc proc:addmsg {nick uhost hand arg} {
  if { $nick == "-psyBNC" && $uhost == "psyBNC@lam3rz.de" } {
      putquick "PRIVMSG $::bncchan :Bitte warten • \00315• \00314• •\003 Infotext wird übermittelt • \00315• \00314• •\003"
      putquick "NOTICE $::addnick :\002Hallo $::addnick, dein BNC wurde soeben erstellt.\003"
      putquick "NOTICE $::addnick :"
      putquick "NOTICE $::addnick :\002Trage folgende Connect-Daten in deinen IRC-Clienten ein:\002"
      putquick "NOTICE $::addnick :"    
      putquick "NOTICE $::addnick :Server: \002$::bncserver\002"
      putquick "NOTICE $::addnick :Port: \002$::bncport\002"
      putquick "NOTICE $::addnick :Passwort: \002[lindex [split $arg] 5]\002 (Bitte ohne die ' ' )"
      putquick "NOTICE $::addnick :"
      putquick "NOTICE $::addnick :\002Wichtig:\002 Bei deiner E-Mailadresse bitte nur \002$::addnick@\002 eintragen!"
      putquick "NOTICE $::addnick :"
      putquick "NOTICE $::addnick :Nach erfolgreichem Einloggen in den -psyBNC,"
      putquick "NOTICE $::addnick :gib im -psyBNC Fenster: \002addserver $::ircserver:$::ircport DeinNickpasswort\002"
      putquick "NOTICE $::addnick :und anschließend ggf. \002dccenable\002 ein."
      putquick "NOTICE $::addnick :"
      putquick "NOTICE $::addnick :\002Mit freundlicher Empfehlung, $::grussnick\002"
      putquick "NOTICE $::bncadder :\002Bouncer für $::addnick erstellt!\002"
      putquick "NOTICE $::bncadder :\002Das Passwort lautet: [lindex [split $arg] 5]\002"
      putquick "NOTICE $::bncadder :\002Die Verbindungsdaten und das Passwort wurden erfolgreich an $::addnick übermittelt.\002"
      return 1
   }
   return 0
}


putlog "$service $scriptversion wurde erfolgreich geladen!"
