################
#### Bira  #####

proc pub_beer {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Използване: !bira <каква бира>"
    putserv "notice $nick :            !biraza <кой> <каква>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION налива една студена $brand от бара и я поднася на $nick\001"
  return 0
}

bind pub - !bira pub_beer

proc pub_beerza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Използване: !bira <каква бира>"
    putserv "notice $nick :            !biraza <кой> <каква>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  putserv "PRIVMSG $channel :\001ACTION налива една студена $brand от бара и я поднася на $koi, $nick черпи!\001"
  return 0
}

bind pub - !biraza pub_beerza


################
#### Rakia #####

proc pub_rakia {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Използване: !rakia <каква ракия>"
    putserv "notice $nick :            !rakiaza <кой> <каква>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION сипва една голяма $brand от бара и я поднася на $nick, дано само не преплете кънките :P\001"
  return 0
}

bind pub - !rakia pub_rakia

proc pub_rakiaza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Използване: !rakia <каква ракия>"
    putserv "notice $nick :            !rakiaza <кой> <каква>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  putserv "PRIVMSG $channel :\001ACTION сипва една голяма $brand от бара и я поднася на $koi, ако не се напие, $nick е готов да го напой черпи още\001"
  return 0
}

bind pub - !rakiaza pub_rakiaza



##### MINERALNA ######
proc pub_seltzer {nick uhost hand channel arg} {
  global botnick
  putserv "PRIVMSG $channel :\001ACTION хвърля по $nick бутилка минерална вода\001"
  return 0
}
bind pub - !mineralna  pub_seltzer

proc pub_seltzerza {nick uhost hand channel arg} {
  global botnick
  putserv "PRIVMSG $channel :\001ACTION цели по $arg с бутилка минерална вода\001"
  return 0
}
bind pub - !mineralnaza pub_seltzerza


### CIGARI ########
proc pub_cig {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Използване: !cigari <какви>"
    putserv "notice $nick              !cigariza <кой> <какви>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION взема пакет $brand от рафта и ги подава на $nick\001"
  return 0
}
bind pub - !cigari pub_cig
 
proc pub_cigza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Използване: !cigari <какви>"
    putserv "notice $nick              !cigariza <кой> <какви>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  putserv "PRIVMSG $channel :\001ACTION взема пакет $brand от рафта и го поднася на $koi, $nick е причината $koi да може да поеме така необходима глътка свеж дим\001"
  return 0
}
bind pub - !cigariza pub_cigza


#### OGANCHE #######
proc pub_matches {nick uhost hand channel arg} {
  global botnick
  putserv "PRIVMSG $channel :\001ACTION дава огънче на $nick за да отложи малко никотиновия си глас\001"  
  return 0
}

proc pub_ogan {nick uhost hand channel arg} {
  global botnick
  putserv "PRIVMSG $channel :\001ACTION изважда горелката и дава на $nick да запали цигарка\001"  
  return 0
}
bind pub - !oganche pub_matches

######## HELPAT #########

bind pub - !bar fun_give-bar
proc fun_give-bar {nick uhost hand chan text} {
 putserv "privmsg $chan :Това е помощното меню за бара"
 putserv "privmsg $chan :Вашите възможности за него са: !bira ; !biraza ; !rakia ; !rakiaza ; !mineralna ; !mineralnaza ; !cigari ; !cigariza ; !vodka ; !vodkaza ; !bsb ; !bsbza ; !kafe ; !kafeza"
 }

#### Bani4ka s Boza #########

proc pub_bsb {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Използване: !bsb"
    putserv "notice $nick :            !bsbza <кой>"
    return 0
  }
  set brand [lrange $arg 0 end]
  set koi [lrange $arg 0 0]

if {$arg == ""} {
  putserv "PRIVMSG $channel :\001ACTION носи на $nick една топла баничка с боза!\001"
  return 0
  }

  putserv "PRIVMSG $channel :\001ACTION носи на $koi една топла баничка с боза, $nick черпи\001"
  return 0
}

bind pub - !bsb pub_bsb
bind pub - !bsbza pub_bsb

###### Coffe #######

### Krazimod Corp. ###

proc pub_kafe {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Използване: !kafe <марка>"
    putserv "notice $nick :            !kafe za <кой> <марка>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION приготвя новата кафе машина за едно топло $brand и го поднася на $nick\001"
  return 0
}

bind pub - !kafe pub_kafe

proc pub_kafeza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Използване: !kafe <марка>"
    putserv "notice $nick :            !kafeza <кой> <каква марка>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  if {$koi == ""} {
                putserv "PRIVMSG $channel :\001ACTION приготвя с новата кафе машина едно топло $brand с 18 захарчета, както $nick го обича ;)\001"
                return 0
                }
  putserv "PRIVMSG $channel :\001ACTION приготвя с новата кафе машина едно топло $brand и го поднася на $koi, $nick черпи!\001"
  return 0
}

bind pub - !kafeza pub_kafeza

proc pub_vodka {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Izpolzvane: !vodka <каква>"
    putserv "notice $nick :            !vodkaza <кой> <каква>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION сипва една голяма водка $brand от бара и я поднася на $nick, дано не се нафирка само :)\001"
  return 0
}

bind pub - !vodka pub_vodka

proc pub_vodkaza {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
    putserv "notice $nick :Izpolzvane: !vodka <каква>"
    putserv "notice $nick :            !vodka za <кой> <каква>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  if {$koi == ""} {
                putserv "PRIVMSG $channel :\001ACTION съжалява много но $nick НЕ ПИЕ алкохол :D\001"
                return 0
                }
  putserv "PRIVMSG $channel :\001ACTION сипва една голяма $brand от бара и я поднася на $koi, ако не се напие $nick ще го почерпи още една\001"
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
 putserv "privmsg $chan :Ей $text ... $nick ти предлага няколко свършвания след като правите най-дивия СЕКС!"
}

proc fun_give-bira {nick uhost hand chan text} {
 putserv "privmsg $chan :Шшшш.. $text ...да ти замириса на козче тука...аз гледам, че $nick държи в ръката си една двайска и те приканва да завъртите. Ако не ти се пафка дай насам!"
}

proc fun_give-love {nick uhost hand chan text} {
 putserv "privmsg $chan :Ммм.. $text искам само да ти кажа, че $nick те обича ТОООООООООООЛКОВА много :)"
}
proc fun_give-slap {nick uhost hand chan text} {
 putserv "privmsg $chan :\001ACTION пошляпва $text ритмично зад вратлето..."
}
proc fun_give-slaps {nick uhost hand chan text} {
putserv "privmsg $chan  :\001ACTION се засилва с железния стол към $text и го шибва в кухата тиква :P"
}
proc fun_give-fun {nick uhost hand chan text} {
 putserv "privmsg $nick :Може да се позабавляте в канала със следните команди:"
 putserv "privmsg $nick :!sex ника , !koz ника, !love ника !slaps ника !slap ника"
}
##########################################################################################################
bind pub - !funhelp fun_give-fhelp
proc fun_give-fhelp {nick uhost hand chan text} {
 putserv "privmsg $nick :Може да се почерпите или позабавлявате с: !bar и !fun"
 putserv "privmsg $nick :За да пуснете бомбата напишете: !bomba ника"
 putserv "privmsg $nick :За да играете на шише напишете го завъртете с: !zavurti"
}
putlog "Инсталиран: fun.tcl"