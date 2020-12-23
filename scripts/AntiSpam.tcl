##############################################################################
# 1. mIRC bug                                                               ##
##############################################################################
# update na bogus nicks po internet                                         ##
##################################### SAN ####################################
# identi/ircnames?                                                          ##
# update po internet na bogus nicks moje i identi i ircnames (San?)         ##
##############################################################################
##############################################################################

###############################################################################
############################### Obsti Nastrojki ###############################
### Checker
## Opisanie:  Dali botyt e checker ili e guard. Razlikata m/u dwata tipa
##            moje da widite po-gore.
##
## Stojnosti: 0 = Guard
##            1 = Checker
##
## Poqsnenie: Ne mojete da polzwate edin TCL-a za dwa bota ediniq, ot kojto
##            da e Checker, a drugiq Guard. (? :))
###
set AntiSpam(Checker) 0

### ExemptFlags
## Opisanie:  Potrebiteli s takiwa flagowe, nqma da bydat s4itani za spameri.
##
## Stojnosti: Flag (prepory4wa se da e f ili n)
##
## Poqsnenie: Ostawete go prazno, ako iskate da nqma izkliucheniq (taka
##            moje da postradate dori i wie...)
###
set AntiSpam(ExemptFlags) "f|f"

### ExemptHosts
## Opisanie:  Potrebiteli ot dadenite hostowe, nqma da bydat s4itani za
##            spammeri.
##
## Stojnosti: Host
##
## Poqsnenie: Mojete da izpolzwate * i ?. Dobre e tuk da opishete hostowete
##            na washiqt dostaw4ik ili golqma LAN mreja.
###
set AntiSpam(ExemptHosts) {
    *psycho.kuzelnet.org
}

### Public
## Opisanie:  Dali da se lowi public spama.
##
## Stojnosti: 0 = Da ne se lowi
##            1 = Da se lowi (prepory4itelna)
##
## Poqsnenie: Towa sa /MSG syobsteniq praten kym kanala.
###
set AntiSpamCheck(Public) 1

### Message
## Opisanie:  Dali da se lowi spama na private.
##
## Stojnosti: 0 = Da ne se lowi
##            1 = Da se lowi (prepory4itelna)
##
## Poqsnenie: Towa sa /MSG syobsteniq praten kym bota.
###
set AntiSpamCheck(Message) 1
# Dopylnenie kym gornata opciq. Ako tq e wkliuchena i dolnata opciq e
# wkliuchena, togawa botyt wi ste nakaje wseki potrebitel, kojto prawi
# dcc send kym bota (towa e polezno pri send na files ot virii, dcc ataki
# ili dcc exploits).
set AntiSpamCheck(DCCSendReal) 1

### Notice
## Opisanie:  Dali da se lowi spama na notice kym bota.
##
## Stojnosti: 0 = Da ne se lowi
##            1 = Da se lowi (prepory4itelna)
##
## Poqsnenie: Towa sa /NOTICE syobsteniq praten kym bota.
###
set AntiSpamCheck(Notice) 1

### Quit
## Opisanie:  Dali da se lowi spama w quit syobsteniqta.
##
## Stojnosti: 0 = Da ne se lowi
##            1 = Da se lowi (prepory4itelna)
##
## Poqsnenie: /QUIT <Reason>. Stawa wypros to4no za tozi <Reason>.
###
set AntiSpamCheck(Quit) 0

### CTCP
## Opisanie:  Dali da se lowi spama w ctcp syobsteniqta.
##
## Stojnosti: 0 = Da ne se lowi
##            1 = Da se lowi (prepory4itelna)
##
## Poqsnenie: Towa wkliuchwa i /me. Stawa wyprosa za syobsteniq ot roda na
##            /CTCP $chan Syobstenie i za /me.
###
set AntiSpamCheck(CTCP) 1
# Dopylnenie kym gornata opciq. Ako tq e wkliuchena i dolnata opciq e
# wkliuchena, togawa botyt wi ste nakaje wseki potrebitel, kojto prawi
# dcc send kym bota (towa e polezno pri send na files ot virii, dcc ataki 
# ili dcc exploits).
set AntiSpamCheck(DCCSend) 1

### CTCR
## Opisanie:  Dali da se lowi spama w ctcp otgoworite.
##
## Stojnosti: 0 = Da ne se lowi
##            1 = Da se lowi (prepory4itelna)
###
set AntiSpamCheck(CTCR) 0

### Topic
## Opisanie:  Dali da se lowi spama w topic-a pri smqna na topic-a.
##
## Stojnosti: 0 = Da ne se lowi (prepory4itelna)
##            1 = Da se lowi
##
## Poqsnenie: /TOPIC #chan <Nowiq topic>. Ako ima spam w <Nowiq topic> da
##            se predpriemat dejstwiq. Malko e nelepo spored men... ;)
###
set AntiSpamCheck(Topic) 0

### Kick
## Opisanie:  Dali da se lowi spama w kick reason-a.
##
## Stojnosti: 0 = Da ne se lowi (prepory4itelna)
##            1 = Da se lowi
##
## Poqsnenie: /KICK #chan <nick> <Reason>. Ako ima spam w <Reason> da
##            se predpriemat dejstwiq. Malko e nelepo spored men... ;)
###
set AntiSpamCheck(Kick) 0

### Invite
## Opisanie:  Dali da se s4ita za spam /INVITE #kanal <bota>.
##
## Stojnosti: 0 = Da ne se lowi
##            1 = Da se lowi (prepory4itelna)
##
## Poqsnenie: Nikoj ne bi trqbwalo da prawi towa, oswen inviter-ite? ;)
###
set AntiSpamCheck(Invite) 0

### Global
## Opisanie:  Frazi ili dumi, spored koito ste se s4ita, 4e ima invite.
##            Towa waji za wsi4ki widowe flood.
##
## Stojnosti: String
##
## Poqsnenie: Stringowete TRQBWA da bydat obgradeni w *, za da se tyrsi
##            sywpadenie w tzqloto izre4enie.
###
set AntiSpam(Global) {
    {*www*}
    {*http*}
    {*#*}
	{*.bg*}
	{*.com*}
	{*.net*}
	{*.org*}
	{*.info*}
	{*.eu*}
}

### Public
## Opisanie:  Frazi ili dumi, spored koito ste se s4ita, 4e ima invite.
##            Towa waji samo za publi4niq spam.
##
## Stojnosti: String
##
## Poqsnenie: Stringowete TRQBWA da bydat obgradeni w *, za da se tyrsi
##            sywpadenie w tzqloto izre4enie.
###
set AntiSpam(Public) {
    {*www*}
    {*http*}
    {*#*}
	{*.bg*}
	{*.com*}
	{*.net*}
	{*.org*}
	{*.info*}
	{*.eu*}
}

### Message
## Opisanie:  Frazi ili dumi, spored koito ste se s4ita, 4e ima invite.
##            Towa waji samo za private spam-a (kym bota).
##
## Stojnosti: String
##
## Poqsnenie: Stringowete TRQBWA da bydat obgradeni w *, za da se tyrsi
##            sywpadenie w tzqloto izre4enie.
###
set AntiSpam(Message) {
    {*www*}
    {*http*}
    {*#*}
	{*.bg*}
	{*.com*}
	{*.net*}
	{*.org*}
	{*.info*}
	{*.eu*}
}

### Notice
## Opisanie:  Frazi ili dumi, spored koito ste se s4ita, 4e ima invite.
##            Towa waji samo za notice spam-a kym bota.
##
## Stojnosti: String
##
## Poqsnenie: Stringowete TRQBWA da bydat obgradeni w *, za da se tyrsi
##            sywpadenie w tzqloto izre4enie.
###
set AntiSpam(Notice) {
    {*www*}
    {*http*}
    {*#*}
	{*.bg*}
	{*.com*}
	{*.net*}
	{*.org*}
	{*.info*}
	{*.eu*}
}

### Quit
## Opisanie:  Frazi ili dumi, spored koito ste se s4ita, 4e ima invite.
##            Towa waji samo za spam pri /quit reaso-a.
##
## Stojnosti: String
##
## Poqsnenie: Stringowete TRQBWA da bydat obgradeni w *, za da se tyrsi
##            sywpadenie w tzqloto izre4enie.
###
set AntiSpam(Quit) {
    {*www*}
    {*http*}
    {*#*}
	{*.bg*}
	{*.com*}
	{*.net*}
	{*.org*}
	{*.info*}
	{*.eu*}
}

### CTCP
## Opisanie:  Frazi ili dumi, spored koito ste se s4ita, 4e ima invite.
##            Towa waji samo za spam w /CTCP syobsteniqta i /me syobsteniqta.
##
## Stojnosti: String
##
## Poqsnenie: Stringowete TRQBWA da bydat obgradeni w *, za da se tyrsi
##            sywpadenie w tzqloto izre4enie.
###
set AntiSpam(CTCP) {
    {*www*}
    {*http*}
    {*#*}
	{*.bg*}
	{*.com*}
	{*.net*}
	{*.org*}
	{*.info*}
	{*.eu*}
}

### CTCR
## Opisanie:  Frazi ili dumi, spored koito ste se s4ita, 4e ima invite.
##            Towa waji samo za spam pri syobsteniqta praten kato otgowor na
##            /CTCP.
##
## Stojnosti: String
##
## Poqsnenie: Stringowete TRQBWA da bydat obgradeni w *, za da se tyrsi
##            sywpadenie w tzqloto izre4enie.
###
set AntiSpam(CTCR) {
    {*www*}
    {*http*}
    {*#*}
	{*.bg*}
	{*.com*}
	{*.net*}
	{*.org*}
	{*.info*}
	{*.eu*}
}

### Topic
## Opisanie:  Frazi ili dumi, spored koito ste se s4ita, 4e ima invite.
##            Towa waji samo za spam pri /topic.
##
## Stojnosti: String
##
## Poqsnenie: Stringowete TRQBWA da bydat obgradeni w *, za da se tyrsi
##            sywpadenie w tzqloto izre4enie.
###
set AntiSpam(Topic) {
  {*Take*Over*}
}

### Kick
## Opisanie:  Frazi ili dumi, spored koito ste se s4ita, 4e ima invite.
##            Towa waji samo za spam pri /kick reason-a.
##
## Stojnosti: String
##
## Poqsnenie: Stringowete TRQBWA da bydat obgradeni w *, za da se tyrsi
##            sywpadenie w tzqloto izre4enie.
###
set AntiSpam(Kick) {
  {*Take*Over*}
  {*Mass*}
}

### DelAddedUser
## Opisanie:  Ako systestwuwa potrebitel w bota wi, kojto sywpada s 4oweka,
##            kojto spami, da se trie li ot bota tozi potrebitel.
##
## Stojnosti: 0 = ne (prepory4itelna)
##            1 = da
##
## Poqsnenie: Po-dobre da ne wkliuchwate towa, oswen ako ne iskate da se
##            sybudite nqkoj den bez potrebiteli ;)
###
set AntiSpam(DelAddedUser) 0

### Reason
## Opisanie:  Syobstenieto, s koeto ste byde kicknat potrebitelq, kogato se
##            zase4e spam ot negowa strana.
##
## Stojnosti: String
##
## Poqsnenie: \$type e tipa spam, a \[AntiSpam:NowDate\] wrysta datata i 4asa,
##            kogato towa e stanalo.
###
set AntiSpam(Reason) "Засякох (14\$type spam) от теб във (\[AntiSpam:NowDate\]г)"

### BanLast
## Opisanie:  Kolko minuti da trae bana na spamera.
##
## Stojnosti: 0 = zawinagi
##            R = w minuti
###
set AntiSpam(BanLast) 10

### BanSticky
## Opisanie:  Dali banat da e sticky ili ne (dali banat da stoi postoqnno w
##            kanala, da e postoqnno slojen w kanala).
##
## Stojnosti: 1 = da
##            0 = ne (prepory4itelna)
##
## Poqsnenie: Ban listata wi moje da stane dosta golqma, ako wsi4ki banowe
##            sa sticky.
###
set AntiSpam(BanSticky) 1

### BanType
## Opisanie:  Kak to4no da se nakazwa potrebitelq.
##
## Stojnosti: 1 = nick!*@*
##            2 = nick*!*@*
##            3 = *nick*!*@*
##            4 = *!ident@*
##            5 = *!*ident@*
##            6 = *!*ident*@*
##            7 = *!*ident@*.host.com
##            8 = *!ident@*.host.com
##            9 = *!*ident*@*.host.com
##            10 = *!ident@some.host.com
##            11 = *!*ident@some.host.com
##            12 = *!*ident*@some.host.com
##            13 = nick!*@*.host.com
##            14 = nick*!*@*.host.com
##            15 = *nick*!*@*.host.com
##            16 = nick*!*@some.host.com
##            17 = *nick*!*@some.host.com
##            18 = nick!*@some.host.com
##            19 = *!*@*.host.com
##            20 = *!*@some.host.com
##            21 = nick!ident@some.host.com
##            22 = nick*!*ident@some.host.com
##            23 = *nick*!*ident@some.host.com
##            24 = nick!*ident@some.host.com
##            25 = nick*!ident@some.host.com
##            26 = *nick*!ident@some.host.com
##            27 = n?c?!i?e?t@s?m?.h?s?.c?m
##            28 = nick*!*ident*@some.host.com
##            29 = *nick*!*ident*@some.host.com
##            30 = nick!*ident*@some.host.com
##            31 = nick*!*ident@*.host.com
##            32 = *nick*!*ident@*.host.com
##            33 = nick!*ident@*.host.com
##            34 = nick*!ident@*.host.com
##            35 = *nick*!ident@*.host.com
##            36 = nick!ident@*.host.com
##            37 = nick*!*ident*@*.host.com
##            38 = *nick*!*ident*@*.host.com
##            39 = nick!*ident*@*.host.com
##            40 = n?c?!*i?e?t@*.host.com
##            41 = n?c?!i?e?t@some.host.com
##            42 = n?c?!*i?e?t@some.host.com
##            43 = n?c?!*ident@*.host.com
##            44 = n?c?!ident@some.host.com
##            45 = n?c?!*ident@some.host.com
##            46 = nick!*i?e?t@*.host.com
##            47 = nick!i?e?t@some.host.com
##            48 = nick!*i?e?t@some.host.com
##
## Poqsnenie: Ne sym slojil n?c?* | *n?c?* | *n?c? | *i?e?t*, zastoto sa dosta
##            opasni. Ako mislite, 4e biha wi swyrshili rabota, pratete mi
##            edno pismo.
###
set AntiSpam(BanType) "2"

### PunishType
## Opisanie:  Kak to4no da se nakazwa potrebitelq.
##
## Stojnosti: d = deop
##            b = ban
##            k = kick
##
## Poqsnenie: Moje da kombinirate flagowete.
###
set AntiSpam(PunishType) "dbk"

### StripTilda
## Opisanie:  Dali da se maha tildata (~) ot ident-a na potrebitelq (winagi).
##
## Stojnosti: 0 = ne
##            1 = da (prepory4itelno)
###
set AntiSpam(StripTilda) 1

### BogusNickF
## Opisanie:  Fajlyt kydeto se pishat bogus nicko-vete.
##
## Stojnosti: String
##
## Poqsnenie: Towa ne wi byrka mnogo mojete da go ostawite taka.
###
set AntiSpam(BogusNickF) "BGfile.txt"

### BogusFlagsAdd
## Opisanie:  Koj ste moje da polzwa !addbogus komandata.
##
## Stojnosti: Flag
##
## Poqsnenie: !addbogus = Dobawq bogus nick kym BogusNickF
###
set AntiSpam(BogusFlagsAdd) "N"

### BogusFlagsDel
## Opisanie:  Koj ste moje da polzwa !delbogus komandata.
##
## Stojnosti: Flag
##
## Poqsnenie: !delbogus = Iztriwa bogus nick ot BogusNickF
###
set AntiSpam(BogusFlagsDel) "N"

### BogusFlagsList
## Opisanie:  Koj ste moje da polzwa !listbogus komandata.
##
## Stojnosti: Flag
##
## Poqsnenie: !listbogus = Pokazwa wsi4ki bogus nickowe.
###
set AntiSpam(BogusFlagsList) "-|-"
########################## Kraj Na Obstite Nastrojki ##########################
###############################################################################
###############################################################################
############################ Nastrojki Za Checker #############################
### AnswerOnMsg
## Opisanie:  Dali botyt da otgowarq na syobsteniq na private. Towa obsto wzeto
##            se prawi, zastoto nqkoi spammer botowe iziskwat otgowor na
##            private i 4ak sled towa puskat spama.
##
## Stojnosti: 0 = Da ne se otgowarq.
##            1 = Otgowarq se, no samo checker-a da prawi towa.
##            2 = Otgowarq se, no samo guard-a da prawi towa.
##            3 = Otgowarq se, nezawisimo dali sme guard ili checker.
##
## Poqsnenie: Razlikata m/u guard i checker glawno e 4astta za Cycle i
##            predawaneto na spamma na drugite botowe.
###
set AntiSpam(AnswerOnMsg) 1

### CycleTime
## Opisanie:  Prez kolko minuti bota ste cirkulira kanala.
##
## Stojnosti: R = w minuti
##
## Poqsnenie: Stojnostta moje da warira ot 1 do 60.
###
set AntiSpam(CycleTime) 5

### Cycle
## Opisanie:  W koi kanali ste cirkulira bota
##
## Stojnosti: Kanal
###
set AntiSpam(Cycle) {
  #Kanal1
  #BTV
}

### Cycle
## Opisanie:  Botyt ste stoi tolkowa sekundi izwyn kanala i sled towa
##            ste wleze w nego.
##
## Stojnosti: R = sekundi
##
## Poqsnenie: Stojnostta trqbwa da e po-malka ot CycleTime*60
###
set AntiSpam(Wait) 20

### AnnounceMethod
## Opisanie:  Po kakyw na4in bota da syobsti za spam-a.
##
## Stojnosti: 0 = putallbots (na wsi4ki linknati botowe)
##            1 = msg (4rez /MSG bot-a)
##            2 = putbot (na botowete ot SayTo)
##
## Poqsnenie: Syobstenieto se kriptira s AllBotsKey.
###
set AntiSpam(AnnounceMethod) 1

### SayTo
## Opisanie:  Botyt ste syobsti samo na tezi botowe spam-a, ako AnnounceMethod
##            e razli4en ot 0.
##
## Stojnosti: Nick_Na_Bot
###
set AntiSpam(SayTo) {
  MyBoy
}

### AllBotsKey
## Opisanie:  S kakyw kliuch da se kriptira syobstenieto. Kriptatziqta se prawi
##            s tzel ne wseki bot da moje da izpolzwa informaciqta, koqto
##            mu se podawa, oswen ako nqma systiq kliuch kato nas.
##
## Stojnosti: Kliuch
###
set AntiSpam(AllBotsKey) "LordsOfRings"

### ChangeNicks
## Opisanie:  Na kakwi psewdonimi da si smenq nick-a bota.
##
## Stojnosti: Nick_Na_Bot
##
## Poqsnenie: Tuk trqbwa da se dobawi i istinskiq botnick na bota.
###
set AntiSpam(ChangeNicks) {
    Johny
    Walker_
    Wiskey
    Miskey
}

### ChangeAlgo
## Opisanie:  Algoritymyt, po kojto da se smenqt psewdonimite.
##
## Stojnosti: 1 = proizwolen izbor na psewdonim ot dadanite
##            2 = 4rez minawane na wsi4ki psewdonimi edin po edin kato se
##                po4ne ot pyrwiq
##
## Poqsnenie: Ako ste slojili w ChangeNicks ot 2 do 5 psewdonima golqma
##            weroqtnost ima smenqneto na psewdonimite pri algoritym edno
##            ne winagi da dowede do jelaniq rezultat (da stane powtarqne sys
##            segashniq psewdonim). Algoritym dwe e netestwan.
###
set AntiSpam(ChangeAlgo) 2

### ChangeWhen
## Opisanie:  Kolko wreme sled kato izleze bota ot kanala da si smeni
##            psewdonima.
##
## Stojnosti: R = sekundi
##
## Poqsnenie: Stojnostta ne trqbwa da nadwishawa Wait stojnostta.
###
set AntiSpam(ChangeWhen) 0

### ChangeNick
## Opisanie:  Dali bota da si smenq nick-a ili ne.
##
## Stojnosti: 1 = Smenqj nick-a
##            0 = Ne smenqj nick-a
###
set AntiSpam(ChangeNick) 1
######################## Kraj Na Nastrojki Za Checker #########################
###############################################################################
########################### Developerski Nastrojki ############################
###############################################################################
### Version
## Opisanie:  Tekusta wersiq na scripta.
##
## Stojnosti: String
###
set AntiSpam(Version) "0.0b"

### BogusNickFTmp
## Opisanie:  Temp fajl za bogus nickovete, kogato se triqt ot nego nickove.
##
## Stojnosti: String
###
set AntiSpam(BogusNickFTmp) "BGfile.tmp"

if {![file exists $AntiSpam(BogusNickF)]} {
  set fh [open $AntiSpam(BogusNickF) w]
  puts -nonewline $fh ""
  close $fh
}

if {[expr $AntiSpam(CycleTime) * 60] <= $AntiSpam(Wait)} {
  putlog "*** Can't load AntiSpam v$AntiSpam(Version) - CycleTime must be greater than Wait."
  return 0
}

######## Uncomment this or not ??
#if {[expr ($AntiSpam(Wait) / 2)] < $AntiSpam(ChangeWhen)} {
#  putlog "*** Can't load AntiSpam v$AntiSpam(Version) - Wait/2 must be greater than ChangeWhen."
#  return 0
#}
####################### Kraj Na Developerski Nastrojki ########################
###############################################################################
############################# Bogus Nick Sistema ##############################
###############################################################################
proc AntiSpam:IsBogus {nick} {
  global AntiSpam

  set fh [open $AntiSpam(BogusNickF) r]
  while {![eof $fh]} {
    set line [gets $fh]
    if {[string match -nocase $line $nick]} {
       return 1
       close $fh
    }
  }

  close $fh
  return 0
}

bind nick - * AntiSpam:NickChange
proc AntiSpam:NickChange {nick uhost hand chan newnick} {
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $hand $host $chan] == 1} {
    return 0
  }

  if {[AntiSpam:IsExempt $newnick $hand $host $chan] == 1} {
    return 0
  }

  if {[AntiSpam:IsBogus $newnick] == 1} {
    AntiSpam:Punish $newnick $uhost "" "Bogus Nick"
    return 0
  }
}

bind join - * AntiSpam:JoinParse
proc AntiSpam:JoinParse {nick uhost hand chan} {
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $hand $host $chan] == 1} {
    return 0
  }

  if {[AntiSpam:IsBogus $nick] == 1} {
    AntiSpam:Punish $nick $uhost "" "Bogus Nick"
    return 0
  }
}

bind pub $AntiSpam(BogusFlagsDel) !delbogus AntiSpam:BogusDel
proc AntiSpam:BogusDel {nick uhost hand chan arg} {
  global AntiSpam
  set arg [split $arg]
  if {[lindex $arg 0] == ""} {
    putquick "PRIVMSG $chan :Usage: !delbogus <wildnick>"
    return 0
  }

  set newnick [lindex $arg 0]
  set i 0
  set fh [open $AntiSpam(BogusNickF) r]
  set fhw [open $AntiSpam(BogusNickFTmp) w]
  while {![eof $fh]} {
    set line [gets $fh]
    if {$line != "" && [string tolower $newnick] == [string tolower $line]} {
      set i 1
    } else {
      ## Just in case IMHO
      if {$line != ""} {
        puts $fhw $line
      }
    }
  }

  close $fh
  close $fhw

  if {$i == 0} {
    putquick "PRIVMSG $chan :Nick not found."
  }

  file rename -force $AntiSpam(BogusNickFTmp) $AntiSpam(BogusNickF)
  putquick "PRIVMSG $chan :$newnick успешно изтрит."
}

bind pub $AntiSpam(BogusFlagsAdd) !addbogus AntiSpam:BogusAdd
proc AntiSpam:BogusAdd {nick uhost hand chan arg} {
  global AntiSpam
  set arg [split $arg]
  if {[lindex $arg 0] == ""} {
    putquick "PRIVMSG $chan :Използвайте: !addbogus <хостмаск>"
    return 0
  }

  set newnick [lindex $arg 0]
  set fh [open $AntiSpam(BogusNickF) r]
  while {![eof $fh]} {
    set line [gets $fh]
    if {$line != "" && [string match -nocase $line $newnick]} {
      putquick "PRIVMSG $chan :Този хостмаск вече съществува"
      return 0
    }
  }

  close $fh

  set fh [open $AntiSpam(BogusNickF) a]
  puts $fh $newnick
  close $fh
  putquick "PRIVMSG $chan :$newnick е добавен в карцера."
  return 0
}

bind pub $AntiSpam(BogusFlagsList) !listbogus AntiSpam:BogusList
proc AntiSpam:BogusList {nick uhost hand chan arg} {
  global AntiSpam
  set added ""
  set arg [split $arg]
  set wild [lindex $arg 0]
  set p 0

  set fh [open $AntiSpam(BogusNickF) r]
  while {![eof $fh]} {
    set line [gets $fh]
    if {$line != "" && ($wild == "" || [string match -nocase *$wild* $line])} {
      lappend added $line
      incr p
    }
  }

  if {$added == ""} {
    putquick "PRIVMSG $chan :Няма намерени записи."
    close $fh
    return 0
  }

  ## Gotta output this per 400 symbols. Know why?:)
  set i 0
  set j 0
  while {$i < [llength $added]} {
    incr i
    if {[string length [join [lrange $added $j $i] ", "]] > 400} {
      if {$j == 0} {
        putquick "PRIVMSG $chan :В карцера са: [join [lrange $added $j $i] ", "]"
      } else {
        putquick "PRIVMSG $chan :[join [lrange $added $j $i] ", "]"
      }
      set j [expr $i + 1]
    }
  }

  if {$j != $i} {
    if {$j == 0} {
      putquick "PRIVMSG $chan :В карцера са: [join [lrange $added $j $i] ", "]"
    } else {
      putquick "PRIVMSG $chan :[join [lrange $added $j $i] ", "]"
    }
  }

  putquick "PRIVMSG $chan :Намерени резултати: $p"
  close $fh
  return 0
}
######################### Kraj Na Bogus Nick Sistema ##########################
###############################################################################
############################## Priemane Na Spama ##############################
###############################################################################
bind bot - AS AntiSpam:DecryptBot
proc AntiSpam:DecryptBot {frombot command arg} {
  AntiSpam:DecryptMsg $frombot "botnet" "" $arg
  return 0
}

bind msgm - * AntiSpam:DecryptMsg
proc AntiSpam:DecryptMsg {nick uhost hand arg} {
  global AntiSpam

  set DecryptMsg [split [decrypt $AntiSpam(AllBotsKey) $arg] " "]

  if {[lindex $DecryptMsg 0] != "spammer"} {
    return 0
  }

  set SpamNick [lindex $DecryptMsg 2]
  set SpamIdent [lindex $DecryptMsg 3]
  set SpamHost [lindex $DecryptMsg 4]
  set SpamType [lindex $DecryptMsg 5]

  if {[AntiSpam:IsExempt $SpamNick $SpamNick $SpamHost ""] == 1} {
    return 0
  }

  putlog "Got spam from $nick!$uhost - $SpamNick!$SpamIdent@$SpamHost, type - $SpamType"
  AntiSpam:Punish $SpamNick $SpamIdent@$SpamHost "" $SpamType
}
########################## Kraj Na Priemane Na Spama ##########################
###############################################################################
################################ Cycle Sistema ################################
###############################################################################
if {$AntiSpam(Checker) == 1} {
  for {set i 0} {$i < 60} {set i [expr $i + $AntiSpam(CycleTime)]} {
    if {$i < 10} { set count "0$i" } else { set count $i }
    bind time - "$count * * * *" SpamCycle
  }
}

proc SpamCycle {min hour day mon year} {
  global AntiSpam altnick

  if {$AntiSpam(ChangeNick) == 1} {
    if {$AntiSpam(ChangeAlgo) == 1} {
      set newnick [lindex $AntiSpam(ChangeNicks) [rand [llength $AntiSpam(ChangeNicks)]]]
    } elseif {$AntiSpam(ChangeAlgo) == 2} {
      if {[info exists AntiSpam(Position)] == 0} {
        set AntiSpam(Position) 0
      }

      if {[llength $AntiSpam(ChangeNicks)] <= $AntiSpam(Position)} {
        set AntiSpam(Position) 0
      }

      set newnick [lindex $AntiSpam(ChangeNicks) $AntiSpam(Position)]
      incr AntiSpam(Position)
    }

    set altnick $newnick
    if {[lsearch [utimers] [list *putquick* *NICK*]] == -1} {
      utimer $AntiSpam(ChangeWhen) [list putquick "NICK $newnick"]
    }
  }

  foreach chan $AntiSpam(Cycle) {
    if {[validchan $chan] == 1 && [botonchan $chan] == 1} {
      channel set $chan +inactive
      if {[string match *[list channel set $chan]* [utimers]] == 0} {
        utimer $AntiSpam(Wait) [list channel set $chan -inactive]
      }
    }
  }

  return 1
}
########################### Kraj Na Cycle Sistema #############################
###############################################################################
############################# Guard & Spam Lowene #############################
###############################################################################
if {[info exists AntiSpamCheck(Public)] == 1 && $AntiSpamCheck(Public) == 1} {
  bind pubm - * AntiSpam:Public
}

if {[info exists AntiSpamCheck(Message)] == 1 && $AntiSpamCheck(Message) == 1} {
  bind msgm - * AntiSpam:Message
}

if {[info exists AntiSpamCheck(Notice)] == 1 && $AntiSpamCheck(Notice) == 1} {
  bind notc - * AntiSpam:Notice
}

if {[info exists AntiSpamCheck(Quit)] == 1 && $AntiSpamCheck(Quit) == 1} {
  bind sign - * AntiSpam:Quit
}

if {[info exists AntiSpamCheck(CTCP)] == 1 && $AntiSpamCheck(CTCP) == 1} {
  bind ctcp - * AntiSpam:CTCP
}

if {[info exists AntiSpamCheck(CTCR)] == 1 && $AntiSpamCheck(CTCR) == 1} {
  bind ctcr - * AntiSpam:CTCR
}

if {[info exists AntiSpamCheck(Topic)] == 1 && $AntiSpamCheck(Topic) == 1} {
  bind topc - * AntiSpam:Topic
}

if {[info exists AntiSpamCheck(Kick)] == 1 && $AntiSpamCheck(Kick) == 1} {
  bind kick - * AntiSpam:Kick
}

if {[info exists AntiSpamCheck(Invite)] == 1 && $AntiSpamCheck(Invite) == 1} {
  bind raw - INVITE AntiSpam:Invite
}

proc AntiSpam:Invite {from keyword arg} {
  set nick [lindex [split $from !] 0]
  set uhost [lindex [split $from !] 1]
  set chan [lindex [split $arg :] 1]
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $nick $host $chan] == 1} {
    return 0
  }

  AntiSpam:Punish $nick $uhost $nick Invite
  return 0
}

proc AntiSpam:Message {nick uhost hand arg} {
  global AntiSpam AntiSpamCheck

  set host [lindex [split $uhost @] 1]

  if {$arg == "Hello, dude!"} {
    return 0
  }

  if {[AntiSpam:IsExempt $nick $hand $host ""] == 1} {
    return 0
  }

  if {$AntiSpamCheck(DCCSendReal) == 1 && [string tolower [string range $arg 0 8]] == "\001dcc send"} {
    AntiSpam:Punish $nick $uhost $hand DCC_Exploit
    return 0
  }

  if {$AntiSpam(AnswerOnMsg) == 3 ||
     ($AntiSpam(AnswerOnMsg) == 2 && $AntiSpam(Checker) == 0) ||
     ($AntiSpam(AnswerOnMsg) == 1 && $AntiSpam(Checker) == 1)} {
    putquick "PRIVMSG $nick :Hello, dude!"
  }

  if {[AntiSpam:IsSpam Message $arg] == 0} {
    return 0
  }

  AntiSpam:Punish $nick $uhost $hand Message
  return 0
}

proc AntiSpam:Notice {nick uhost hand arg dest} {
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $hand $host [expr {[isbotnick $dest] == 1 ? "" : $dest}]] == 1} {
    return 0
  }

  if {[AntiSpam:IsSpam Notice $arg] == 0} {
    return 0
  }

  AntiSpam:Punish $nick $uhost $hand Notice
  return 0
}

proc AntiSpam:Kick {nick uhost hand chan target arg} {
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $hand $host $chan] == 1} {
    return 0
  }

  if {[AntiSpam:IsSpam Kick $arg] == 0} {
    return 0
  }

  AntiSpam:Punish $nick $uhost $hand Kick
  return 0
}

proc AntiSpam:Quit {nick uhost hand chan arg} {
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $hand $host $chan] == 1} {
    return 0
  }

  if {[AntiSpam:IsSpam Quit $arg] == 0} {
    return 0
  }

  AntiSpam:Punish $nick $uhost $hand Quit
  return 0
}

proc AntiSpam:CTCR {nick uhost hand dest keyword arg} {
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $hand $host [expr {[isbotnick $dest] == 1 ? "" : $dest}]] == 1} {
    return 0
  }

  if {[AntiSpam:IsSpam CTCR $arg] == 0 && [AntiSpam:IsSpam CTCR $keyword] == 0} {
    return 0
  }

  AntiSpam:Punish $nick $uhost $hand "CTCP Reply"
  return 0
}

proc AntiSpam:CTCP {nick uhost hand dest keyword arg} {
  global AntiSpamCheck
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $hand $host [expr {[isbotnick $dest] == 1 ? "" : $dest}]] == 1} {
    return 0
  }

  if {$AntiSpamCheck(DCCSend) && ([string toupper $keyword] == "DCC" && [string toupper [lindex [split $arg " "] 0]] == "SEND")} {
    AntiSpam:Punish $nick $uhost $hand "DCC_Exploit"
    return 0
  }

  if {([AntiSpam:IsSpam CTCP $arg] == 0 && [AntiSpam:IsSpam CTCP $keyword] == 0)} {
    return 0
  }

  AntiSpam:Punish $nick $uhost $hand CTCP/ACTION
  return 0
}

proc AntiSpam:Topic {nick uhost hand chan arg} {
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $hand $host $chan] == 1} {
    return 0
  }

  if {[AntiSpam:IsSpam Topic $arg] == 0} {
    return 0
  }

  AntiSpam:Punish $nick $uhost $hand Topic
  return 0
}

proc AntiSpam:Public {nick uhost hand chan arg} {
  set host [lindex [split $uhost @] 1]

  if {[AntiSpam:IsExempt $nick $hand $host $chan] == 1} {
    return 0
  }

  if {[AntiSpam:IsSpam Public $arg] == 0} {
    return 0
  }

  AntiSpam:Punish $nick $uhost $hand Public
  return 0
}
######################### Kraj Na Guard & Spam Lowene #########################
###############################################################################
################################ Misc Commands ################################
###############################################################################
proc AntiSpam:Punish {nick uhost hand type} {
  global AntiSpam botnick botname

  if {[isbotnick $nick]} {
    return 0
  }

  set ident [lindex [split $uhost @] 0]
  set host [lindex [split $uhost @] 1]

  if {$ident == "" || $ident == "*" || $nick == "*" || $nick == "" || $host == "" || $host == "*"} {
    return 0
  }

  if {$hand != "*" && $hand != "" && $AntiSpam(DelAddedUser) == 1} {
    deluser $hand
  }

  set ban [AntiSpam:MakeBan $nick [expr {$AntiSpam(StripTilda) == 1 ? [string trimleft $ident ~] : $ident}] $host]

  if {[string match $ban $botname] == 0} {
    newban $ban $botnick [subst $AntiSpam(Reason)] $AntiSpam(BanLast) [expr {$AntiSpam(BanSticky) == 1 ? "sticky" : "none"}]
  }

  if {$AntiSpam(Checker) == 1} {
    set SayMsg "spammer - $nick $ident $host $type"
    if {$AntiSpam(AnnounceMethod) == 1} {
      foreach SayBot $AntiSpam(SayTo) {
        putquick "PRIVMSG $SayBot :[encrypt $AntiSpam(AllBotsKey) $SayMsg]"
      }
    } elseif {$AntiSpam(AnnounceMethod) == 0} {
      putallbots "AS [encrypt $AntiSpam(AllBotsKey) $SayMsg]"
    } elseif {$AntiSpam(AnnounceMethod) == 2} {
      foreach SayBot $AntiSpam(SayTo) {
        if {[islinked $SayBot]} {
          putbot $SayBot "AS [encrypt $AntiSpam(AllBotsKey) $SayMsg]"
	}
      }
    }
  }

  foreach chan [channels] {
    if {[onchan $nick $chan] == 1} {
      foreach char [split $AntiSpam(PunishType) ""] {
        if {$char == "k"} {
	  AntiSpam:KickNick $nick $chan $type
	} elseif {$char == "b"} {
          if {[string match $ban $botname] == 0} {
   	    AntiSpam:BanNick $ban $chan
	  }
	} elseif {$char == "d"} {
	  AntiSpam:DeopNick $nick $chan
	}
      }
    }
  }

  return 1
}

proc AntiSpam:DeopNick {nick chan} {
  if {$chan == "" || $nick == ""} {
    return 0
  }

  if {[validchan $chan] == 1 && [botonchan $chan] == 1 && [botisop $chan] == 1} {
    #putquick "mode $chan -o $nick"
    return 1
  }

  return 0
}

proc AntiSpam:KickNick {nick chan type} {
  global AntiSpam

  if {$chan == "" || $nick == ""} {
    return 0
  }

  if {[validchan $chan] == 1 && [botonchan $chan] == 1 && [botisop $chan] == 1} {
  putquick "mode $chan +b $ban"
  putquick "kick $chan $nick [subst $AntiSpam(Reason)]"
    return 1
  }

  return 0
}

proc AntiSpam:BanNick {ban chan} {
  if {$chan == "" || $ban == "*!*@*" || $ban == ""} {
    return 0
  }

  if {[validchan $chan] == 1 && [botonchan $chan] == 1 && [botisop $chan] == 1} {
    putquick "kick $chan $nick [subst $AntiSpam(Reason)]"
    putquick "mode $chan +b $ban"
    return 1
  }

  return 0
}

proc AntiSpam:NowDate {} {
  # 01 Feb 2004 11:01 PM
  return [strftime "%T14@%d.%m.%Y"]
}

proc AntiSpam:IsSpam {type arg} {
  global AntiSpam

  if {$arg == ""} {
    return 0
  }

  set arg [strip:all $arg]

  if {[info exists AntiSpam(Global)] == 1} {
    foreach ExString $AntiSpam(Global) {
      if {[string match -nocase $ExString $arg] == 1} {
        return 1
      }
    }
  }

  if {[info exists AntiSpam($type)] == 1} {
    foreach ExString $AntiSpam($type) {
      if {[string match -nocase $ExString $arg] == 1} {
        return 1
      }
    }
  }

  return 0
}

proc AntiSpam:IsExempt {nick hand host chan} {
  global AntiSpam

  if {[AntiSpam:IsExemptHost $host] == 1} {
    return 1
  }

  if {[isbotnick $nick]} {
    return 1
  }

  if {$hand == "*" || $hand == ""} {
    return 0
  }

  if {$AntiSpam(ExemptFlags) == ""} {
    return 0
  }

  if {[matchattr $hand $AntiSpam(ExemptFlags) $chan] == 1} {
    return 1
  }

  return 0
}

proc AntiSpam:IsExemptHost {host} {
  global AntiSpam

  if {$host == ""} {
    return 0
  }

  if {[info exists AntiSpam(ExemptHosts)] == 1} {
    foreach ExHost $AntiSpam(ExemptHosts) {
      if {[string match -nocase $ExHost $host] == 1} {
        return 1
      }
    }
  }

  return 0
}

proc AntiSpam:MakeBan {nick ident host} {
  global AntiSpam

  if {$AntiSpam(BanType) == 1} {
    return $nick!*@*
  }

  if {$AntiSpam(BanType) == 2} {
    return $nick*!*@*
  }

  if {$AntiSpam(BanType) == 3} {
    return *$nick*!*@*
  }

  if {$AntiSpam(BanType) == 4} {
    return *!$ident@*
  }

  if {$AntiSpam(BanType) == 5} {
    set ident [string trimleft $ident ~]
    return *!*$ident@*
  }

  if {$AntiSpam(BanType) == 6} {
    set ident [string trimleft $ident ~]
    return *!*$ident*@*
  }

  if {$AntiSpam(BanType) == 7} {
    set ident [string trimleft $ident ~]
    return [maskhost *$ident@$host]
  }

  if {$AntiSpam(BanType) == 8} {
    return [maskhost $ident@$host]
  }

  if {$AntiSpam(BanType) == 9} {
    set ident [string trimleft $ident ~]
    return [maskhost *$ident*@$host]
  }

  if {$AntiSpam(BanType) == 10} {
    return *!$ident@$host
  }

  if {$AntiSpam(BanType) == 11} {
    set ident [string trimleft $ident ~]
    return *!*$ident@$host
  }

  if {$AntiSpam(BanType) == 12} {
    set ident [string trimleft $ident ~]
    return *!*$ident*@$host
  }

  if {$AntiSpam(BanType) == 13} {
    return $nick!*@[lindex [split [maskhost $host] @] 1]
  }

  if {$AntiSpam(BanType) == 14} {
    return $nick*!*@[lindex [split [maskhost $host] @] 1]
  }

  if {$AntiSpam(BanType) == 15} {
    return *$nick*!*@[lindex [split [maskhost $host] @] 1]
  }

  if {$AntiSpam(BanType) == 16} {
    return $nick*!*@$host
  }

  if {$AntiSpam(BanType) == 17} {
    return *$nick*!*@$host
  }

  if {$AntiSpam(BanType) == 18} {
    return $nick!*@$host
  }

  if {$AntiSpam(BanType) == 19} {
    return *!*@[lindex [split [maskhost $host] @] 1]
  }

  if {$AntiSpam(BanType) == 20} {
    return *!*@$host
  }

  if {$AntiSpam(BanType) == 21} {
    return $nick!$ident@$host
  }

  if {$AntiSpam(BanType) == 22} {
    set ident [string trimleft $ident ~]
    return $nick*!*$ident@$host
  }

  if {$AntiSpam(BanType) == 23} {
    set ident [string trimleft $ident ~]
    return *$nick*!*$ident@$host
  }

  if {$AntiSpam(BanType) == 24} {
    set ident [string trimleft $ident ~]
    return $nick!*$ident@$host
  }

  if {$AntiSpam(BanType) == 25} {
    return $nick*!$ident@$host
  }

  if {$AntiSpam(BanType) == 26} {
    return *$nick*!$ident@$host
  }

  if {$AntiSpam(BanType) == 27} {
    return [AntiSpam:QMark $nick]![AntiSpam:QMark $ident]@[AntiSpam:QMark $host]
  }

  if {$AntiSpam(BanType) == 28} {
    set ident [string trimleft $ident ~]
    return $nick*!*$ident*@$host
  }

  if {$AntiSpam(BanType) == 29} {
    set ident [string trimleft $ident ~]
    return *$nick*!*$ident*@$host
  }

  if {$AntiSpam(BanType) == 30} {
    set ident [string trimleft $ident ~]
    return $nick!*$ident*@$host
  }

  if {$AntiSpam(BanType) == 31} {
    set ident [string trimleft $ident ~]
    return $nick*![lindex [split [maskhost *$ident@$host] !] 1]
  }

  if {$AntiSpam(BanType) == 32} {
    set ident [string trimleft $ident ~]
    return *$nick*![lindex [split [maskhost *$ident@$host] !] 1]
  }

  if {$AntiSpam(BanType) == 33} {
    set ident [string trimleft $ident ~]
    return $nick![lindex [split [maskhost *$ident@$host] !] 1]
  }

  if {$AntiSpam(BanType) == 34} {
    return $nick*![lindex [split [maskhost $ident@$host] !] 1]
  }

  if {$AntiSpam(BanType) == 35} {
    return *$nick*![lindex [split [maskhost $ident@$host] !] 1]
  }

  if {$AntiSpam(BanType) == 36} {
    return $nick![lindex [split [maskhost $ident@$host] !] 1]
  }

  if {$AntiSpam(BanType) == 37} {
    set ident [string trimleft $ident ~]
    return $nick*![lindex [split [maskhost *$ident*@$host] !] 1]
  }

  if {$AntiSpam(BanType) == 38} {
    set ident [string trimleft $ident ~]
    return *$nick*![lindex [split [maskhost *$ident*@$host] !] 1]
  }

  if {$AntiSpam(BanType) == 39} {
    set ident [string trimleft $ident ~]
    return $nick![lindex [split [maskhost *$ident*@$host] !] 1]
  }

  if {$AntiSpam(BanType) == 40} {
    set ident [string trimleft $ident ~]
    return [AntiSpam:QMark $nick]!*[AntiSpam:QMark $ident]@[lindex [split [maskhost $host] @] 1]
  }

  if {$AntiSpam(BanType) == 41} {
    return [AntiSpam:QMark $nick]![AntiSpam:QMark $ident]@$host
  }

  if {$AntiSpam(BanType) == 42} {
    set ident [string trimleft $ident ~]
    return [AntiSpam:QMark $nick]!*[AntiSpam:QMark $ident]@$host
  }

  if {$AntiSpam(BanType) == 43} {
    set ident [string trimleft $ident ~]
    return [AntiSpam:QMark $nick]!*$ident@[lindex [split [maskhost $host] @] 1]
  }

  if {$AntiSpam(BanType) == 44} {
    return [AntiSpam:QMark $nick]!$ident@$host
  }

  if {$AntiSpam(BanType) == 45} {
    set ident [string trimleft $ident ~]
    return [AntiSpam:QMark $nick]!*$ident@$host
  }

  if {$AntiSpam(BanType) == 46} {
    set ident [string trimleft $ident ~]
    return $nick!*[AntiSpam:QMark $ident]@[lindex [split [maskhost $host] @] 1]
  }

  if {$AntiSpam(BanType) == 47} {
    return $nick![AntiSpam:QMark $ident]@$host
  }

  if {$AntiSpam(BanType) == 48} {
    set ident [string trimleft $ident ~]
    return $nick!*[AntiSpam:QMark $ident]@$host
  }

  return $nick!$ident@$host
}

proc AntiSpam:QMark {x {y ""}} {
  set num 0
  for {set i 0} {$i < [string length $x]} {incr i} {
    switch -- [string index $x $i] {
      "." {append y .}
      "*" {append y *}
      default {append y [expr {[incr num] % 2 == 0 ? [string index $x $i] : "?"}]}
    }
  }
  return $y
}

proc strip:color {string} {
  regsub -all \003\[0-9\]{1,2}(,\[0-9\]{1,2})? $string {} string
  return $string
}

proc strip:bold {string} {
  regsub -all \002 $string {} string
  return $string
}

proc strip:underline {string} {
  regsub -all \037 $string {} string
  return $string
}

proc strip:all {string} {
  return [strip:color [strip:bold [strip:underline $string]]]
}

proc AntiSpam:CopyRight {} {
  global AntiSpam
  putlog "Инсталиран: AntiSpam.tcl"
}

proc AntiSpam:Init {} {
  global AntiSpam keep-nick

  if {$AntiSpam(Checker) == 1} {
    foreach chan $AntiSpam(Cycle) {
      if {[validchan $chan] == 0} {
        channel add $chan
      }
    }

    savechannels
    set keep-nick 0
  }
}
############################ Kraj Na Misc Commands ############################
###############################################################################

AntiSpam:Init
AntiSpam:CopyRight


