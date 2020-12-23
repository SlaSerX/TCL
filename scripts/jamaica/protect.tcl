## Protect TCL.
## Awtor: Woo-Hoo (spermto@abv.bg)
## Molq wsqkakwi zabelejki, komentari, greshki da se report-vat na tozi
## email. Predwaretilno blagodarq.
##
## Pro4etete komentarite po-dolu, nqma da sa wi izlishni.
##


## Ako stojnostta e 1, dejstwiq srestu botowe nqma da se predpriemat.
## (Prepory4itelna stojnost 1)
set Protect(ExcludeBots) 1

## Ako stojnostta e 1, dejstwiq srestu CS nqma da se predpriemat.
## (Prepory4itelna stojnost 1)
set Protect(ProtectCS) 1

## Ako stojnostta e razli4na ot "", dejstwiq srestu hora, koito
## imat tezi flagowe, nqma da se predprieme.
## Pri addwane na hostowe, molq addwajte gi ne ot wida *!*@*.
## (Prepory4itelna stojnost n|n)
set Protect(ExemptFlags) "n|n"

## Ako stojnostta e 1, dejstwiqta ste se izpylnqt momentalno
## bez queue, no towa ne winagi ste dowede do jelaniq rezultat...
## Moje da se polu4at dwojni DEOPs, BANs etc...
## (Prepory4itelna stojnost 0)
set Protect(ExtremelyFast) 1

bind kick - * proc_kicked
proc proc_kicked {nick uhost hand chan target reason} {
  global Protect

  if {$Protect(ExcludeBots) == 1 && [matchattr $hand b]} {
    return
  }

  if {$hand != "*" && [matchattr $hand Protect(ExemptFlags) $chan]} {
    return
  }

  if {$Protect(ProtectCS) == 1 && [string tolower $nick] == "cs"} {
    return
  }

  if {[isbotnick $target] == 1} {
    punish $nick $uhost $hand $chan
  }
}

bind mode - * how_could_u
proc how_could_u {nick uhost hand chan modech victim} {
  global botname Protect

  if {$modech != "+b"} {
    return
  }

  if {$Protect(ExcludeBots) == 1 && [matchattr $hand b]} {
    return
  }

  if {$hand != "*" && [matchattr $hand Protect(ExemptFlags) $chan]} {
    return
  }

  if {$Protect(ProtectCS) == 1 && [string tolower $nick] == "cs"} {
    return
  }

  if {[string match -nocase $victim $botname]} {
    punish $nick $uhost $hand $chan
  }
}

proc punish {nick uhost hand chan} {
  global botnick Protect

  regsub {~} $uhost {} uhost

  if {$hand != "*"} {
    deluser $hand
  }

  putquick "PRIVMSG CS :access $chan del $nick"

  if {$hand != "*" && [string tolower $hand] != [string tolower $nick]} {
    putquick "PRIVMSG CS :access $chan del $hand"
  }

  if {[string match *@* $uhost]} {
    putquick "PRIVMSG CS :akick $chan add $nick!*@* 12-= Amin! =-"
  } else {
    putquick "PRIVMSG CS :akick $chan add $uhost!*@* 12-= Amin! =-"
  }

  putquick "PRIVMSG CS :clear $chan all"
  newban $nick!*@* $botnick "12-= Amin! =-" 0

  if {[string match *@* $uhost]} {
    adduser $nick *!*$uhost
  } else {
    adduser $nick $uhost!*@*
  }

  chattr $nick +dk
  chpass $nick [rand 10000]
  setuser $nick XTRA "12-= Barai Mecha! =-"
  putquick "JOIN $chan"
  putlog "Punishing \002$nick\002."

  if {$Protect(ExtremelyFast) == 1 && [botonchan $chan] == 1 && [botisop $chan] == 1} {
    putquick "MODE $chan -o $nick"
    putquick "MODE $chan +b $nick!*@*"
    putquick "KICK $chan $nick :12-= Amin! =-"
  }
}


#putlog "protect @ mc"