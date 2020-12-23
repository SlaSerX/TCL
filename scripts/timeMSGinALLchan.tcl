## През колко време (в минути) бота ще пуска малоумното MSG
set dmsg_time "60"

## Какви да са малоумните MSG-и
set dmsgs  {
"Slushaite ni online na adress: http://RadioErotic.it.cx ili si poruchaite pozdrav na nashiq skype radio.erotic, v nashia sait, kakto i v IRC s komanda !pz pozdrava. Vseki den ot 12 do 15 chasa i vecher ot 20 do 3 v polunosht"
}

timer $dmsg_time sdmsg

### msg
proc sdmsg {} {
  global dmsgs dmsg_time sag
      foreach chan [channels] {
        putquick "PRIVMSG $chan :[lindex $dmsgs [rand [llength $dmsgs]]]"
      }
      timer $dmsg_time sdmsg
}

#unbind dcc n|n restart *dcc:restart
#unbind dcc n|n rehash *dcc:rehash