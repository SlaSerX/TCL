##############0whers.tcl by ^GeNeRaLa^ s pomo6ta na  #######################
#############      Za bagove ili predlojeniq lest@mail.bg     #########################
##########################################################################################



bind pub n|n !+owner pub_addop
proc pub_addop {nick uhost hand chan usr} {
  global botnick
  adduser $usr $usr!*@*
  chattr $usr +n
  setuser $usr xtra Added "by $hand as $usr ([strftime %Y-%m-%d@%H:%M])"
  putserv "notice $usr :Току що беше адднат в мен от $nick Settni си паролата с /msg $botnick pass parolata"
  putserv "notice $nick :$usr е адднат в мен +n"
  putlog "\-=|$nick|=- \ #($chan)# !+owner $usr"
}


bind pub n|n !+master pub_addo
proc pub_addo {nick uhost hand chan usr} {
  global botnick
  adduser $usr $usr!*@*
  chattr $usr +m
  setuser $usr xtra Added "by $hand as $usr ([strftime %Y-%m-%d@%H:%M])"
  putserv "notice $usr :Ти беше адднат с +m от $nick Моля settni си паролата с: /msg $botnick pass <password>"
  putserv "notice $nick :$usr е адднат в мен +m "
  putlog "\-=|$nick|=- \ #($chan)# !addop $usr"
}


bind pub n|n !+user pub_tc
proc pub_tc {nick uhost hand chan usr} {
  global botnick
  adduser $usr $usr!*@*
  chattr $usr +fhop
  setuser $usr xtra Added "by $hand as $usr ([strftime %Y-%m-%d@%H:%M])"
  putserv "notice $usr : Ти беше адднат с +fhop от $nick Моля settni си паролата с: /msg $botnick pass <password>"
  putserv "notice $nick :$usr е адднат в мен +fhop"
  putlog "\-=|$nick|=- \ #($chan)# !addop $usr"
}


bind pub n|n !-owner pub_sd
proc pub_sd {nick uhost hand chan usr} {
  global botnick
  adduser $usr $usr!*@*
  chattr $usr -n
  setuser $usr xtra Added "by $hand as $usr ([strftime %Y-%m-%d@%H:%M])"
  putserv "notice $usr : Делнат си в мен от $nick сажалявам"
  putserv "notice $nick : Делнах $usr от мен"
  putlog "\-=|$nick|=- \ #($chan)# !addop $usr"
}

bind pub n|n !-master pub_xa
proc pub_xa {nick uhost hand chan usr} {
  global botnick
  adduser $usr $usr!*@*
  chattr $usr -m
  setuser $usr xtra Added "by $hand as $usr ([strftime %Y-%m-%d@%H:%M])"
  putserv "notice $usr : Делнат си в мен от $nick сажалявам"
  putserv "notice $nick : Делнах $usr от мен"
  putlog "\-=|$nick|=- \ #($chan)# !addop $usr"
}


bind pub n|n !-use pub_sa
proc pub_sa {nick uhost hand chan usr} {
  global botnick
  adduser $usr $usr!*@*
  chattr $usr -fhop
  setuser $usr xtra Added "by $hand as $usr ([strftime %Y-%m-%d@%H:%M])"
  putserv "notice $usr : Делнат си в мен от $nick сажалявам"
  putserv "notice $nick :Делнах $usr от мен "
  putlog "\-=|$nick|=- \ #($chan)# !addop $usr"
}

Putlog "0wners.tcl by ^GeNeRaLa^ Loaded with help by MIRCinfo team"

