################
#### Bira  #####

proc pub_beer {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :����������: !bira <����� ����>"
    putserv "notice $nick :            !biraza <���> <�����>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION ������ ���� ������� $brand �� ���� � � ������� �� $nick\001"
  return 0
}

bind pub - !bira pub_beer

proc pub_beerza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :����������: !bira <����� ����>"
    putserv "notice $nick :            !biraza <���> <�����>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  putserv "PRIVMSG $channel :\001ACTION ������ ���� ������� $brand �� ���� � � ������� �� $koi, $nick �����!\001"
  return 0
}

bind pub - !biraza pub_beerza


################
#### Rakia #####

proc pub_rakia {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :����������: !rakia <����� �����>"
    putserv "notice $nick :            !rakiaza <���> <�����>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION ����� ���� ������ $brand �� ���� � � ������� �� $nick, ���� ���� �� �������� ������� :P\001"
  return 0
}

bind pub - !rakia pub_rakia

proc pub_rakiaza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :����������: !rakia <����� �����>"
    putserv "notice $nick :            !rakiaza <���> <�����>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  putserv "PRIVMSG $channel :\001ACTION ����� ���� ������ $brand �� ���� � � ������� �� $koi, ��� �� �� �����, $nick � ����� �� �� ����� ����� ���\001"
  return 0
}

bind pub - !rakiaza pub_rakiaza



##### MINERALNA ######
proc pub_seltzer {nick uhost hand channel arg} {
  global botnick
  putserv "PRIVMSG $channel :\001ACTION ������ �� $nick ������� ��������� ����\001"
  return 0
}
bind pub - !mineralna  pub_seltzer

proc pub_seltzerza {nick uhost hand channel arg} {
  global botnick
  putserv "PRIVMSG $channel :\001ACTION ���� �� $arg � ������� ��������� ����\001"
  return 0
}
bind pub - !mineralnaza pub_seltzerza


### CIGARI ########
proc pub_cig {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :����������: !cigari <�����>"
    putserv "notice $nick              !cigariza <���> <�����>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION ����� ����� $brand �� ����� � �� ������ �� $nick\001"
  return 0
}
bind pub - !cigari pub_cig
 
proc pub_cigza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :����������: !cigari <�����>"
    putserv "notice $nick              !cigariza <���> <�����>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  putserv "PRIVMSG $channel :\001ACTION ����� ����� $brand �� ����� � �� ������� �� $koi, $nick � ��������� $koi �� ���� �� ����� ���� ���������� ������ ���� ���\001"
  return 0
}
bind pub - !cigariza pub_cigza


#### OGANCHE #######
proc pub_matches {nick uhost hand channel arg} {
  global botnick
  putserv "PRIVMSG $channel :\001ACTION ���� ������ �� $nick �� �� ������ ����� ����������� �� ����\001"  
  return 0
}

proc pub_ogan {nick uhost hand channel arg} {
  global botnick
  putserv "PRIVMSG $channel :\001ACTION ������� ��������� � ���� �� $nick �� ������ �������\001"  
  return 0
}
bind pub - !oganche pub_matches

######## HELPAT #########

bind pub - !bar fun_give-bar
proc fun_give-bar {nick uhost hand chan text} {
 putserv "privmsg $chan :���� � ��������� ���� �� ����"
 putserv "privmsg $chan :������ ����������� �� ���� ��: !bira ; !biraza ; !rakia ; !rakiaza ; !mineralna ; !mineralnaza ; !cigari ; !cigariza ; !vodka ; !vodkaza ; !bsb ; !bsbza ; !kafe ; !kafeza"
 }

#### Bani4ka s Boza #########

proc pub_bsb {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :����������: !bsb"
    putserv "notice $nick :            !bsbza <���>"
    return 0
  }
  set brand [lrange $arg 0 end]
  set koi [lrange $arg 0 0]

if {$arg == ""} {
  putserv "PRIVMSG $channel :\001ACTION ���� �� $nick ���� ����� ������� � ����!\001"
  return 0
  }

  putserv "PRIVMSG $channel :\001ACTION ���� �� $koi ���� ����� ������� � ����, $nick �����\001"
  return 0
}

bind pub - !bsb pub_bsb
bind pub - !bsbza pub_bsb

###### Coffe #######

### Krazimod Corp. ###

proc pub_kafe {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :����������: !kafe <�����>"
    putserv "notice $nick :            !kafe za <���> <�����>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION �������� ������ ���� ������ �� ���� ����� $brand � �� ������� �� $nick\001"
  return 0
}

bind pub - !kafe pub_kafe

proc pub_kafeza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :����������: !kafe <�����>"
    putserv "notice $nick :            !kafeza <���> <����� �����>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  if {$koi == ""} {
                putserv "PRIVMSG $channel :\001ACTION �������� � ������ ���� ������ ���� ����� $brand � 18 ���������, ����� $nick �� ����� ;)\001"
                return 0
                }
  putserv "PRIVMSG $channel :\001ACTION �������� � ������ ���� ������ ���� ����� $brand � �� ������� �� $koi, $nick �����!\001"
  return 0
}

bind pub - !kafeza pub_kafeza

proc pub_vodka {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Izpolzvane: !vodka <�����>"
    putserv "notice $nick :            !vodkaza <���> <�����>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION ����� ���� ������ ����� $brand �� ���� � � ������� �� $nick, ���� �� �� ������� ���� :)\001"
  return 0
}

bind pub - !vodka pub_vodka

proc pub_vodkaza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Izpolzvane: !vodka <�����>"
    putserv "notice $nick :            !vodka za <���> <�����>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  if {$koi == ""} {
                putserv "PRIVMSG $channel :\001ACTION �������� ����� �� $nick �� ��� ������� :D\001"
                return 0
                }
  putserv "PRIVMSG $channel :\001ACTION ����� ���� ������ $brand �� ���� � � ������� �� $koi, ��� �� �� ����� $nick �� �� ������� ��� ����\001"
  return 0
}

bind pub - !vodkaza pub_vodkaza
#################################################################Section Two##############################################
bind pub - !sex fun_give-sex
bind pub - !koz fun_give-bira
bind pub - !love fun_give-love
bind pub - !slap fun_give-udari
bind pub - !slaps fun_give-slaps
bind pub - !fun fun_give-fun

proc fun_give-sex {nick uhost hand chan text} {
 putserv "privmsg $chan :�� $text ... $nick �� �������� ������� ���������� ���� ���� ������� ���-����� ����!"
}

proc fun_give-bira {nick uhost hand chan text} {
 putserv "privmsg $chan :����.. $text ...�� �� �������� �� ����� ����...�� ������, �� $nick ����� � ������ �� ���� ������� � �� �������� �� ���������. ��� �� �� �� ����� ��� �����!"
}

proc fun_give-love {nick uhost hand chan text} {
 putserv "privmsg $chan :���.. $text ����� ���� �� �� ����, �� $nick �� ����� ����������������� ����� :)"
}
proc fun_give-slap {nick uhost hand chan text} {
 putserv "privmsg $chan :\001ACTION �������� $text �������� ��� ��������..."
}
proc fun_give-slaps {nick uhost hand chan text} {
putserv "privmsg $chan  :\001ACTION �� ������� � �������� ���� ��� $text � �� ����� � ������ ����� :P"
}
proc fun_give-fun {nick uhost hand chan text} {
 putserv "privmsg $nick :���� �� �� ����������� � ������ ��� �������� �������:"
 putserv "privmsg $nick :!sex ���� , !koz ����, !love ���� !slaps ���� !slap ����"
}
##########################################################################################################
bind pub - !funhelp fun_give-fhelp
proc fun_give-fhelp {nick uhost hand chan text} {
 putserv "privmsg $nick :���� �� �� ��������� ��� ������������� �: !bar � !fun"
 putserv "privmsg $nick :�� �� ������� ������� ��������: !bomba ����"
 putserv "privmsg $nick :�� �� ������� �� ���� �������� �� ��������� �: !zavurti"
}
putlog "����������: fun.tcl"