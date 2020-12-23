setudef flag fun
bind pub - !fun2 o6te
bind pub - !sex fun_give-sex
bind pub - !games fun_give-games
bind pub - !sex2 fun_give-sex2
bind pub - !xixi fun_give-xixi
bind pub - !xixi2 fun_give-xixi2
bind pub - !zvezdi fun_give-zvezdi
bind pub - !smqx fun_give-smqx
bind pub - !svadba fun_give-svadba
bind pub - !love3 fun_give-love3
bind pub - !love2 fun_give-love2
bind pub - !biri4ka fun_give-biri4ka
bind pub - !love fun_give-love
bind pub - !{P} fun_give-{P}
bind pub - !rakiq fun_give-rakiq
bind pub - !gu6ka fun_give-gu6ka
bind pub - !fun fun_give-fun
bind pub - !fanta fun_give-fanta
bind pub - !4ai fun_give-4ai
bind pub - !koka-kola fun_give-koka-kola
bind pub - !kiss fun_give-kiss
bind pub - !more fun_give-more
bind pub - !want fun_give-want
bind pub - !pederas fun_give-pederas
bind pub - !lubov fun_give-lubov
bind pub - !svirka fun_give-svirka
bind pub - !kurva fun_give-kurva
bind pub - !roza fun_give-rose
bind pub - dance dance
bind pub - SPECIALITET SPECIALITET
bind pub - kiss kiss
bind pub - tonik tonik
bind pub - meze meze
bind pub - vodaa vodaa
bind pub - obich obich
bind pub - cola cola
bind pub - vodka vodka
bind pub - whiskey whiskey
bind pub - kartofi kartofi
bind pub - tanc tanc
bind pub - !pari pari
bind pub - fanta fanta
bind pub - melba melba
bind pub - oblak oblak
bind pub - sok sok
bind pub - mastika mastika
bind pub - rom rom
bind pub - menta menta
bind pub - plod plod
bind pub - astika astika
bind pub - grozdova grozdova
bind pub - kamenica kamenica
bind pub - keks keks
bind pub - shampansko shmp
bind pub - martini martini
bind pub - voda voda
bind pub - vino vino
bind pub - chai chai
bind pub - cunka cunka
bind pub - love love
bind pub - otpuska otpuska
bind pub - !svadbaza svadbatawe

proc svadbatawe {n u h chan t} {
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
set text [lindex $t 0]
set nick [lindex $t 1]
 putserv "privmsg $chan :$text приемаш ли $nick за свой съпруг и заклеваш ли се да го обичаш в добри и лоши времена.. ?"
 putserv "privmsg $chan :А ти $nick приемаш ли $text за своя съпруга и заклеваш ли се да я обичаш в добри и лоши времена.. ?"
 puthelp "privmsg $chan :Е... Щом е така обявявам ви за съпруг и съпруга и ви пожелавам много щастие, любов и късмет!"
 puthelp "privmsg $chan :Можете да се целунете... ;>"
}}

proc otpuska {n u h c t} {
  if {[lsearch -exact [channel info $c] +fun] != -1} {
if {$t == ""} {return 0}
 putserv "privmsg $c :хей--$t..днес --$n развяваше щастливо два билета за ХАВАЙТЕ с престой в ПАРИЖ -----  романтика -- ааааа -- завиждам ви-- а аз тук ще бачкам"
}}

proc love {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :яяяя ах гледам $n на колене пред  $t...и  реди нещо влюбено."
}}

proc cunka {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
  putserv "privmsg $c :Хей $t ...след малко ще опиташ една сладка целувка от $n !!!!!"
}}

proc chai {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :хей..хей.. $t ... $n ти поднася силен и ароматен чай от 20 билки,събирани по самодивско време от тайно място "
}} 
proc vino {n u h c t } {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :ччееерввееенооо вино сссснощи пих --опаля-- ама остана и за теб  $t..тва хитрото $n  скъта една бутилка 10 годишно мерло и за теб"
}}

proc voda {n u h c t} {
  if {[lsearch -exact [channel info $c] +fun] != -1} {
if {$t == ""} {return 0}
 putserv "privmsg $c :помъква чаша вода и спъвайки се залива $t..сега $n  щете подсуши"
}}

proc martini {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c : --$t..ето ти едно мартини  за сметката на--$n--маслинката обаче не влиза в цената"
}}

proc shmp {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$n.се приближава грациозно към $t .с бутилка Don Bellissimo..-ХАЙДЕ ДА ГО ПИЕМ БЕЗ ЧАШИ"
}}

proc keks {n u h c t } {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$n.е направило невероятен кексче специално за теб $t ето ти едно парче --ДАНО НЕ СИ НА ДИЕТА"
}}

proc kamenica {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :8prasva po tikvata $t s 9Kamenitza i mu kazva da predava kam $n bez da vrashta"
}}

proc grozdova {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$n butva edna Peshterska Grozdova kam $t , kato se nadiva da ne padne pod masata ... predi da si e platil smetkata !!!!!"
}}

proc astika {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$n haresva da probutva Astika na klienti-paralii kato $t !!!!!"
}}

proc plod {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$n посочва кошничката с екзотични плодове на $t ....а бананчето забелено ли да е"
}}

proc menta {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :veselo podmyatka patronche menta i go hvurlya na $t specialno ot $n  :) !!!!!"
}}

proc rom {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$n probutva na  $t edin goliam, izvetrial, no vse oshte stopliasht rom"
}}
 
proc mastika {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :preceniava, che si struva da osvini $t s edna goliama mastika po4erpkata e ot $n !!!!!"
}}

proc sok {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$t ...ето ти едно сокче-КАППИ- от $n ама другия път да внимаваш с алкохола"
}}

proc oblak {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :za da e v sinhron s vremeto navan, $n prigotvia edin oblak na $t !!!!!"
}}
proc melba {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :ponasia edna melba kum $t..  i noseiki ia se cherpi po malko ама налие за сметката на $n !!!!!"
}}
proc fanta {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$t... $n te cherpi fanta sys slamka za da te gleda kak smuchkash ot neq"
}}

proc pari {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$t ... $n burka w djoba ti....i.. neusetno  pribira portmoneto ti.........uhaaaa mnogo pari beeee... shte stignat za qk kupon "
}}

proc tanc {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$t ... $n te kani na taka jelan  baven i chuvstven tanc "
}}

proc kartofi {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$t заповядай пържени картофки, $n черпи  :) !!!!!"
}}
proc whiskey {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :aaa... $t ...eto ti 15god otlejalo whisky  ... specialno ot $n  ama drugiq put butilka ot teb"
}}

proc vodka {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :eee $t ...eto ti butilka vodka ... specialno ot $n  ama vnimavai da nese osvinish"
}}

proc cola {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
  putserv "privmsg $c :$t... $n mukne kym teb dve pepsi-coli s nadejdata za edin priaten razgovor s teb"
}}

proc obich {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :Оооо виждам под масата $n И $t щастливи ,да обсъждат някъв пристен  !!!!!"
}}

proc vodaa {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
  putserv "privmsg $c :тайно и неусетно $n се промъква зад гърба на $t..хоп грациозно го мята в шадравана---дали не е началото на конкурс мокри дрехи-- "
}}

proc meze {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
  putserv "privmsg $c :$n се тътри  към теб $t с едно голямо плато от нарязани филета пъстърмички и суджук ------ а направи място де-----"
}}

proc tonik {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
  putserv "privmsg $c :мммм няма нищо по освежаващо от един тоник-- ето ти един $t ..за сметката на $n."
}}

proc kiss {n u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :$n poglejda....pregrushta i zasmukwa strastno ustnite na $n"
}}

proc SPECIALITET {nick u h c t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
  putserv "privmsg $c :$t... $nick те кани на вечеря с малко храна,оскъдно облекло,свещи,влажен поглед,много нежност,и още нещо..мммммм"
} }

proc dance {nick uhost hand chan t} {
if {$t == ""} {return 0}
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $chan :$t... $nick te kani na strasten i erotichen tanc mmmmm uhaaaaaa "
}}

proc fun_give-rose {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
	putserv "PRIVMSG $chan :$text... $nick ti podarqva edna prekrazna roza :) ---<-'-@"
}}

proc fun_give-sex {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :хей $text ... $nick ти прави доста изгодно предложение за здрав див раздиращ SEX !"
}}

proc fun_give-games {nick uhost hand chan text} {
 if {[lsearch -exact [channel info $chan] +games] != -1} {
 putserv "privmsg $chan :4,1bomba - 14с команда 4!bomba <0nick4> 14вие залагате бомба в user по ваш избор. Той може да я обезвреди като напише 7!reja <8цвят7>"
 putserv "privmsg $chan :!9,1!spin - 7игра на шише"
 putserv "privmsg $chan :4,1!bingo - 0играете бинго"
 putserv "privmsg $chan :8,1!gamble - 9игра в която можете да получите като награда 7BAN,KICK,BAN+KICK OP"
 } { putserv "privmsg $chan :Svurjete se s $::owner i mu kajete da napi6e v kanala \002set +games\002" }
if {$::tgchan == $chan} {
 putserv "privmsg $chan :4•››15 12!start - 9стартирате смесица от игри които се редуват.0,1Не е лоша пробвайте я ;) 4‹‹•"
return 0
}
}
proc fun_give-sex2 {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :хей $text ... $nick ти прави доста изгодно предложение за здрав див раздиращ БОЙ С ВАЗГЛАВНИЦИ ! :Ppp XuXuXuXuXuXuXuXu"
}}

proc fun_give-xixi {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :$nick: $text , мило ела да те шляпна по дупенцето и след това да те цункам да не ми се обидиш щото много си те обичкам ! {P}{P}{P}{P}{P}"
}}

proc fun_give-xixi2 {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :хей $text гледай че $nick те иска в леглото си тази вечер (няма с кой да пие натурален сок :Ppp)"
}}

proc fun_give-zvezdi {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :$text сигурен съм че $nick е готов(a) цял живот да ти сваля звезди стига да го(я) обичаш поне колкото той(тя) теб! (НЕ СЪМ КАЗАЛ ЧЕ НЕМОЖЕ И ПОВЕЧЕ :>)"
}}

proc fun_give-smqx {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :$text да знайш че $nick е толкова ....... че ако те набара някаде и ......."
 putserv "privmsg $chan :Исках да кажа: $text да знайш че $nick е толкова влюбен(а) в теб че ако те набара някаде и сигурно ще те скъса от целувки! (ти да не си помисли друго :Ppp)"
}}

proc fun_give-svadba {nick uhost hand chan text} {
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :$text приемаш ли $nick за свой съпруг и заклеваш ли се да го обичаш в добри и лоши времена.. ?"
 putserv "privmsg $chan :А ти $nick приемаш ли $text за своя съпруга и заклеваш ли се да я обичаш в добри и лоши времена.. ?"
 puthelp "privmsg $chan :Е... Щом е така обявявам ви за съпруг и съпруга и ви пожелавам много щастие, любов и късмет!"
 puthelp "privmsg $chan :Можете да се целунете... ;>"
}}

proc fun_give-love2 {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :$text виждам че $nick е повече от замаян(а) от любов по теб не му(и) разбивай сърцето сърцето! !!!Ще съжеляваш...ГАРАНЦИЯ!!! {} :>"
}}

proc fun_give-biri4ka {nick uhost hand chan text} {
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
if {$text == ""} {return 0}
 putserv "privmsg $chan :ей шшш $text ...да ти замириса на биричка тука...аз гледам $nick държи в ръката си една Загорка и ти я подава. Ако няма да я взимаш дай я насам!"
}}

proc fun_give-love {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :ммм ей $text искам само да ти кажа че $nick много силно влюбен(а) в теб...май ша има свадба :Ppp"
}}

proc fun_give-{P} {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan :$text ,leko te pridurpva $nick kum sebe si i te celuva s cqlata si nejnost!"
}}

proc fun_give-gu6ka {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan :$nick gu6ka $text nejno i kazva 4e iska ne6to ot nego/neq :Pp~ "
}}

proc fun_give-rakiq {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan :$nick tova da ne ti e selska kry4ma we,hodi se nalivai drugade "
}}

proc fun_give-fanta {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan :Нося една Fanta за  $text и я пиша  на сметката на $nick пък после ще се оправиме с него :)"
}}

proc fun_give-love3 {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan :$text,$nick mi kaza 4e te obi4a s cqloto si surce!No se pita dali ti izpitva6 su6toto!???"
}}

proc fun_give-4ai {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan :$nick,sipva 1 toplo 4ai4e na $text {}"
}}

proc fun_give-koka-kola {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan :Нося една количка  за  $text и я пиша  на сметката на $nick пък после ще се оправиме с него :)"
}}

proc fun_give-vodka {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan : $nick,Poru4a 1 golqma Sobieski nqkolko puti na $text"
}}

proc fun_give-more {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan : $text,ima6 predlojenie ot $nick da prekarate edno nezabravimo lqto"
putserv "privmsg $chan : $text samo vie dvamata na MORETO!"
}}

proc fun_give-kiss {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan : $nick dava na $text edna mnogo nejna 13celuvka po vratleto! {}"
}}

proc fun_give-want {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan : $text,$nick te iska tuk i sega,za da ti pokaje cqlata si 13LIUBOV i NEJNOST! 4{5{7{8P3}9}10} "
}}

proc fun_give-pederas {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan : $text,$nick kaza 4e si golqm pederas !!"
}}

proc fun_give-lubov {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan : $nick,kaza 4e e ludo vluben v teb i iska da te 13celune silno i strastno!!"
}}

proc fun_give-svirka {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan : $text,$nick te moli da mu napravi6 edna bojestvena svirka !!"
}}


proc fun_give-kurva {nick uhost hand chan text} {
if {$text == ""} {return 0}
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
putserv "privmsg $chan : $text,$nick kaza 4e ti si edna golqma kurva !!"
}}

proc fun_give-fun {nick uhost hand chan text} {
  if {[lsearch -exact [channel info $chan] +fun] != -1} {
 putserv "privmsg $chan :!sex <nick> , !sex2 <nick> , !xixi <nick> , !xixi2 <nick> , !love <nick> , !love2 <nick>  "
 putserv "privmsg $chan :!love3 <nick> , !zvezdi <nick> , !svadba <nick> , !smqx <nick> , !biri4ka <nick> ,!gu6ka <nick> "
 putserv "privmsg $chan :!{P} <nick> ,!rakiq ,!fanta <nick> , !4ai <nick>, !4bar, !koka-kola <nick> "
 putserv "privmsg $chan :!kiss <nick> ,!more <nick> , !want <nick> ,!pederas <nick> ,!svirka <nick> ,!kurva <nick> !fun2"
}}

proc o6te {n u h c t} {
  if {[lsearch -exact [channel info $c] +fun] != -1} {
 putserv "privmsg $c :dance <nick> , SPECIALITET <nick> , kiss <nick> ,tonik <nick ,meze <nick ,vodaa <nick ,love <nick> , otpuska <nick>"
 putserv "privmsg $c :cola <nick> ,vodka <nick> ,whiskey <nick> ,kartofi <nick> ,tanc <nick> ,!pari <nick>"
 putserv "privmsg $c :fanta <nick> , melba <nick> , oblak <nick> , sok <nick> , mastika <nick> , rom <nick> "
 putserv "privmsg $c :menta <nick> , plod <nick> , astika <nick> , grozdova <nick> , kamenica <nick> , keks <nick>"
 putserv "privmsg $c :shampansko <nick> , martini <nick> , voda <nick> , vino <nick> , chai <nick> , cunka <nick> "
}}
### Krazimod Corp. ###

proc pub_beer {nick uhost hand channel arg} {
  global botnick
  if {[lsearch -exact [channel info $channel] +fun] != -1} {
  if {$arg == ""} {
    putserv "PRIVMSG $channel :Izpolzvane: !bira <kakva bira>"
    putserv "PRIVMSG $channel :            !biraza <koi> <kakva>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION Naliva edna $brand ot bara i ia podnasia na $nick\001"
  return 0
}}

bind pub - !bira pub_beer

proc pub_beerza {nick uhost hand channel arg} {
  global botnick
    if {[lsearch -exact [channel info $channel] +fun] != -1} {
  if {$arg == ""} {
    putserv "PRIVMSG $channel :Izpolzvane: !bira <kakva bira>"
    putserv "PRIVMSG $channel :            !biraza <koi> <kakva>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  putserv "PRIVMSG $channel :\001ACTION Naliva edna studena $brand ot bara i ia podnasia na $koi, $nick cherpi!\001"
  return 0
}}

bind pub - !biraza pub_beerza


#### Rakia #####
proc pub_rakia {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  if {$arg == ""} {
    putserv "PRIVMSG $channel :Izpolzvane: !rakia <kakva rakia>"
    putserv "PRIVMSG $channel :            !rakiaza <koi> <kakva>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION Sipva edna goliama $brand ot bara i ia podnasia na $nick, dano ne se napie samo :)\001"
  return 0
}}

bind pub - !rakia pub_rakia

proc pub_rakiaza {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  if {$arg == ""} {
    putserv "PRIVMSG $channel :Izpolzvane: !rakia <kakva rakia>"
    putserv "PRIVMSG $channel :            !rakiaza <koi> <kakva>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  putserv "PRIVMSG $channel :\001ACTION Sipva edna goliama $brand ot bara i ia podnasia na $koi, ako ne se napie $nick 6te go 4erpi o6te edna\001"
  return 0
}}

bind pub - !rakiaza pub_rakiaza



##### MINERALNA ######
proc pub_seltzer {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  putserv "PRIVMSG $channel :\001ACTION hvyrlia po $nick botilka mineralna voda\001"
  return 0
}}
bind pub - !mineralna pub_seltzer

proc pub_seltzerza {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  putserv "PRIVMSG $channel :\001ACTION 3ashepatva po $arg botilka mineralna voda\001"
  return 0
}}
bind pub - !mineralnaza pub_seltzerza


### CIGARI ########
proc pub_cig {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  if {$arg == ""} {
    putserv "notice $nick         :Izpolzvane: !cigari <kakvi>"
    putserv "notice $nick         !cigariza <koi> <kakvi>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION Vzima paket $brand cigari ot rafta i gi podnasia na $nick\001"
  return 0
}}
bind pub - !cig pub_cig
bind pub - !cigari pub_cig
 
proc pub_cigza {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  if {$arg == ""} {
    putserv "PRIVMSG $channel :Izpolzvane: !cigari <kakvi>"
    putserv "PRIVMSG $channel              !cigariza <koi> <kakvi>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  putserv "PRIVMSG $channel :\001ACTION Vzima paket $brand cigari ot rafta i gi podnasia na $koi, $nick e pri4inata $koi da moje da poeme taka neobhodimiat mu pushek\001"
  return 0
}}
bind pub - !cigza pub_cigza
bind pub - !cigariza pub_cigza


#### OGANCHE #######
proc pub_matches {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  putserv "PRIVMSG $channel :\001ACTION Dava oganche na $nick za da otaloji nikotinovia si glad\001"  
  return 0
}}

proc pub_ogan {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  putserv "PRIVMSG $channel :\001ACTION Izvajda gorelkata i dava na $nick da zapali cigara\001"  
  return 0
}}

bind pub - !ogan pub_ogan
bind pub - !oganche pub_matches

######## HELPAT #########

proc pub_bar {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
    putserv "PRIVMSG $channel :V nashia lubim i skromen bar imame: !bira, !rakia, !mineralna, !cigari, !vodka, !bsb"
    putserv "PRIVMSG $channel :                      !!! NOVO !!! Ve4e imame i Caffe Mashina opitaite !kafe "
  return 0
}}

bind pub - !bar pub_bar


#### Bani4ka s Boza #########

proc pub_bsb {nick uhost hand channel arg} {
  global botnick
  if {$arg == "?"} {
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
    putserv "PRIVMSG $channel :Izpolzvane: !bsb"
    putserv "PRIVMSG $channel :            !bsbza <koi>"
    return 0
  }
  set brand [lrange $arg 0 end]
  set koi [lrange $arg 0 0]

if {$arg == ""} {
  putserv "PRIVMSG $channel :\001ACTION Nosi na $nick edna topla bani4ka s boza!\001"
  return 0
  }

  putserv "PRIVMSG $channel :\001ACTION Nosi na $koi edna topla bani4ka s boza, $nick cherpi\001"
  return 0
}}

bind pub - !bsb pub_bsb
bind pub - !bsbza pub_bsb

###### Coffe #######

### Krazimod Corp. ###

proc pub_kafe {nick uhost hand channel arg} {
  global botnick
  if {$arg == ""} {
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
    putserv "PRIVMSG $channel :Izpolzvane: !kafe <marka>"
    putserv "PRIVMSG $channel :            !kafeza <koi> <marka marka>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION Prigotvq na novata Caffe Mashina edno toplo $brand i go podnasia na $nick\001"
  return 0
}}

bind pub - !kafe pub_kafe

proc pub_kafeza {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  if {$arg == ""} {
    putserv "notice $nick :Izpolzvane: !kafe <marka>"
    putserv "notice $nick :            !kafeza <koi> <kakva marka>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  if {$koi == "Banned"} {
                putserv "PRIVMSG $channel :\001ACTION Prigotvq na novata Caffe Mashina edno toplo $brand s 18 zaharcheta kakto Banned go obicha:-)\001"
                return 0
                }
  putserv "PRIVMSG $channel :\001ACTION Prigotvq na novata Caffe Mashina edno toplo $brand i go podnasia na $koi, $nick cherpi!\001"
  return 0
}}

bind pub - !kafeza pub_kafeza

proc pub_vodka {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  if {$arg == ""} {
    putserv "PRIVMSG $channel :Izpolzvane: !vodka <kakva>"
    putserv "PRIVMSG $channel :            !vodkaza <koi> <kakva>"
    return 0
  }
  set brand [lrange $arg 0 end]
  putserv "PRIVMSG $channel :\001ACTION Sipva edna goliama vodka $brand ot bara i ia podnasia na $nick, dano ne se napie samo :)\001"
  return 0
}}

bind pub - !vodka pub_vodka

proc pub_vodkaza {nick uhost hand channel arg} {
  global botnick
      if {[lsearch -exact [channel info $channel] +fun] != -1} {
  if {$arg == ""} {
    putserv "PRIVMSG $channel :Izpolzvane: !vodka <kakva>"
    putserv "PRIVMSG $channel :            !vodkaza <koi> <kakva>"
    return 0
  }
  set brand [lrange $arg 1 end]
  set koi [lrange $arg 0 0]
  if {$koi == "Banned"} {
                putserv "PRIVMSG $channel :\001ACTION sajalqva mnogo no V3S0 ne pie ALKOHOL :-)\001"
                return 0
                }
  putserv "PRIVMSG $channel :\001ACTION Sipva edna goliama $brand ot bara i ia podnasia na $koi, ako ne se napie $nick 6te go 4erpi o6te edna\001"
  return 0
}}

bind pub - !vodkaza pub_vodkaza


bind pub - !funs prc_fns
proc prc_fns {n u h c t} {
  if {[lsearch -exact [channel info $c] +fun] != -1} {
set funs {
"No idea:No eyed deer (сляп елен)"
"that`s the way she is :Тъй ще е тя"
"It does not matter! :Това не прави метър!"
"Путевидение :Минижуп"
"Виолета :Виола, която свири само през лятото"
"Доцент :Човек, който си харчи всичките пари"
"Килиманджаро :Човек, който яде килими"
"ул. Петко Славейков :Калдаръм Петко чурулик"
"Лебедово езеро :Гьол патак, бир парче мюзик от ефенди Чайковски"
"Корабокрушенец :Човек, който превозва круши с кораби."
"Хороскоп :Човек, който скопява хората, които играят на хоро."
"Авантюрист :Човек, който обича всичко да е на аванта."
"what are you want be :какво искаш бе"
"Гладиатор :Човек, който глади с радиатор"
"самосвал :Човек които сам се сваля!"
"Hungry bear don't play bugy-bugy! :Гладна мечка хоро не играе!"
"Крокодил :Грозна жена"
"Нимфоман :Педераст"
"Какво е курабийка? :Жена, която бие мъжа си!"
"Клептоман :Човек, който има дарбата да намира неща преди хората да са ги изгубили"
"To my first love :До моето първо либе !"
"My grandmother's bushes :Бабини ти трънкини !!!"
"Расист :Човек облечен с расо.Човек, който се кланя на египетския бог Ра."
"клизма :Да повърнеш през гъз."
"курва :такава дето се ебе по много (мечтата на всеки мъж)"
"DDR :Да го духат ромите !!!!!" 
"БТК :Барам - Тъпи - Кучки "
"Jonny Walker !! :Иване, върви си !!"
"Багер :Германска баба"
}
set randmsg [subst [lindex $funs [rand [llength $funs]]]]
putserv "privmsg $c :$randmsg"
}}

bind pub - !biser prc_bs
proc prc_bs {n u h c t} {
  if {[lsearch -exact [channel info $c] +fun] != -1} {
set bs {
"Хубу, че са ми заглъхнали ушите и не чувам толкова силно!"
"Мръсното на жената, започва с 'п', по средата 'т', и завършва на 'ка'? Престилка."
"Стърчи, виси и капе, с три букви, по средата 'у'? Душ."
"Какво е пръднята? Опит на гъзът да запее."
"Какво е оригнятаa? Пръдня сбъркала пътя."
"Голям, червен, клати се и се празни? Автобус 'Икарус'. "
"Какво ще се получи, като влязат няколко монахини в басейн? компот от сливи."
"Кой човешки орган може да се увеличи до три пъти? Зеницата."
"Какво е долен, ляв педал? Амбриаж."
"Какво свързва: удавен мъж, изгорял хляб и бременна жена? Късно изваден."
"Как е пенсионер на немски? Исхабен-хуй."
"Как е пенсионер на унгарски? Хептен-мекечек."
"Как е на турски телевизор? Сеир-сандък.Как е на турски футболист? Топ-серсемин."
"Как е на турски алпинист? Баир-будала. "
"Как е на турски парашутист? Чадър-бабаит."
"Как е на турски лебедово езеро? Юрдек-гьол."
"Как е на турски касетофон? Джангър-сандък."
"Как е пчела на унгарски? Бере-мед."
"Как е оса на унгарски? Не-бере-мед."
"Как е търтей на унгарски? Ебе-не-бере-мед."
"Как е на китайски съпруга? Чат пат чук ( чу ма )."
"Как е на китайски любовница? Бая чук."
"Как е на китайски съпруг? Ах мак ( мух льо )."
"Как е на китайски любовник? Ах пак."
"Какво е егоизъм? * Да пръднеш под чаршафа и сам да си го дишаш * "
"Кой мъж е оптимист? * Този, който преди среща си смазва ципа на панталона * "
"Как се казва на български кавалер? * Кавалджия * "
"Защо кучетата си ближат мъдете? * Защото могат * "
"Кое е по-голямо от путката и хуя? * Путката-като кажеш 'путка си майна' * "
"Каква е приликата между корковата тапа и мъдите? * И двете се мъчат да влязат и не могат * "
"Секса е като бриджа - ако нямаш добър партньор ти трябва добра ръка..."
"Ще изляза след като разходя леглото и оправя кучето."
"Най-яките сайтове са в интернет - каза един познат.С две думи-нямам думи .....с една-хич!!!"
"Танцът е вертикален израз на хоризонтално желание."
"Преди се разтваряха гащите, за да се види задника, сега се разтваря задника, за да се видят гащите."
"Преди се разтваряха гащите, за да се види задника, сега се разтваря задника, за да се видят гащите."
"...малката му кожена кукла се изпъна напред, като видя отражението на задника си в огледалото..."
"Всяко защо има своето ебал ли съм го."
"Има жени, които твърдят, че всички мъже са еднакви.Не е ли това твърде богат опит??"
"Работата е в наши ръце.Положението е напълно самозадоволително. "
"Най-шантавото е когато овцата снесе яйце, от което се излюпи крава с говорен дефект."
"По-добре аз отколкото комарът - поне на сутринта няма да я сърби."
"Който не знае какво му е, нека види къде му е и ако не го намери - това му е! "
"Сговорни сестри публичен дом издигат!"
"Най-съкрушителното нещо в живота е майка ви да пръдне на родителска среща."
"Който се смее последен, изглежда най-бавно загрява за какво става дума."
"Моля ви, не рисувайте голи жени по стените.Целият се изпонатроших!"
"Дали червеят изпитва удоволствие когато прави онова на ябълката...?"
"- Една Fanta ечемик моля? - Но такава няма! - Такова, де - Бира!"
"...и специален поздрав за всички са Metallica с парчето Nothing else maters или Ти вече не си ми майка..."
" Tursi se Muj, krasiv, s hubava kola, hubav zadnik, 4udesen v legloto, mil i grizoven.. Znam 4e ne si ti, no ako poznava6 niakoi takav, dai mu nomera mi. "
"Ti si moiata du6a, ti si zvezdata koiato ozariava moiata no6t obi4.... 4akai malko, tova e gre6en nomer! "
"Kogato ne6tata ne varviat, i tugata e izpulnila sarceto ti, kogato salzite napirat v o4ite ti, samo mi kazi, i 6te doida pri teb. Az prodavam salfetki "
"Kak da durzi6 idiot v naprezenie? 6te ti kaza utre"
"Zashto si zad kompiutara kato trqbva da si pred nego?"
"Sintezirajki pantomimikata na paradoksalnata antropologia i baziraiki se na solidna fundamentalna praktika shte buda kratuk-YAJ MI KURA"
"Мъж без дръшка:say zashto muzete sa kato chetka za zubi?Zashtoto sa bezpolezni bez druzka "
"Zashto muzete imat krivi kraka? Zashtoto vsichki vazni neshta sa v skobi."
"Shtom Adam i Eva sa bili tolkova hubavi, zashto ima tolkova grozni hora kato teb?"
"Ne moga da qm sutrin, za6tot te obi4am, ne moga da iam na obiad, za6tot te obi4am, ne moga da iam ve4er, za6tot te obi4am. Ne moga da spia no6tem za6toto ISKAM DA IAM!"
"Iskam te,iskam te. Iskam da te zamykna v krevata,da te macha i izpotia,da tetresa dokato sym v teb i tialoto ti da gori.Obi4am te-Ve4no twoi GRIP"
"6to e to dulgo i tunko, pokrito s koja i samo gospod znae v kolko dupki e bilo?"
"Hey sexy kakvo 6te kazesh za edin no6ten, buen, mrusen, neistov, strasten, nekontroliruem boi s vazglavnici?"
"Policiata izdirva zapodozrian koito e duhovit, umen i krasiv.Ti si ve4e eliminiran ot turseneto, no kude da se skria az?"
"trqbva da ti kaja ne6to mnogo tajno prosto ne znam kak da zapo4na, dumite za nego ne stigat, bolkata ot 4utoto ne moje da se prijevee - dqdo mraz ne sa6testvuva"
"Ti me izpolzvash! Razmazvash me, podmokriash me, ma4kash me, darpash me dokato zadovolish sebe si. Posle me zahvarliash prosto taka. Tova e sadbata na edna cigara "
"Dnes e deniat...Toi idva samo vednush...zashtoto utre...veche ne e dnes...nasladi se na zivota...tova e vuzmozno...no go napravi dnes...zashtoto dnes e deniat..."
"Kogato izberesh da ne pravish izbor, pravish izbor, zashtoto izbirash da ne izbirash"
"Svetlinata e po-burza ot zvuka, zashtoto izglezdash inteligenten predi da zapochnesh da govorish"
"Kakva e razlikata mezdu zenata i hladilnika? Hladilnika ne plache, kogato v nego ima meso"
"Stiga chesa tez maduri golemi kat shamanduri udari mu dva shamara stiga si go bara Sopolite da iztechat kaisiite da oblekchat stiga si mu bil shamari che glavata mu zapari "
"Sex is like nokia -connecting people like Nike -just do it Like Pepsi -ask for more Like Samsung -everyone is invated and like me -TO GOOD TO BE TRUE!"
"Chui bez tebe az ne moga.Navsiakude s mene az te vodia. Lapam te v usta i te vurtia taka,taka-dokato razbera 4e si prosto 4etka za ysta!!! "
"Vecher se promakvash tiho v moita staia! tarsish tvoeto miasto po moeto golo tialo i kogato go namerish jadno go zasmucvash -SHIBAN KOMAR!!! "
"Az biah na 15 a toi na 25.beshe me strah znaeh che shte boli. toi go izvadi i az usetih che iztrypvam. posle poteche kryv.Nikoga dosega ne mi biaha vadili zub!"
"Ima goresht sex, barz sex, luа sex, gushkasht sex, nejen sex, grupov sex, a za hora kato teb niama SEX."
"predstavi si che si na dunato na okena i ne ti stiga vuzduha a tashacite mi sa kislorodni butilki zatova mi lapni kura i dishai. Ne se smei shte se udavish."
"lijesh me a az se raztapiam.darjish me v razete si a az te tzapam lapash me a az svarshvam v ustata ti...Delta vrah na sladoleda!!! "
"Snosti pak ne me ostavi da spia chustvah te v sania mi Prisastvieto ti be machitelno Ostavi sledite si varhu men! Utre ste te ubia proklet komar!"
"Snoshti te tursih navsiakade. Iskah da te osetia varhu moeto golo tialo, iskash da vliaza v teb, iskah da pochustvam aromata ti, no kade beshe ti ...moia glupava pijamo"
"Beshe mi toplo i priatno! Pipah go, galeh go,iskah go, stiskah go dokato poteche biala technost. Za parvi put v zivota si doiah krava "
"Biah gola.Rozoviat mu tzviat mnogo me vazbudi.Dopriah ustni do nego i zapochna da se ugolemiava pipah go galeh go dokato prokletia balon ne se spuka!!!"
"Аko nepoznat muj podaryava cvetya-tova e IMPULS, a kogato nepoznata jena pushka v telefonnata vi slushalka tova sa 12 impulsa na minuta !"
"Prez tozi vek e na moda da imash malka KOLA i malak GSM.No ne se otchaivai.Shte doide i modata na malkite PISHKI! Togava i ti shte se FUKASH!"
"Predstavi si che si na dunato na okena i ne ti stiga vuzduha a tashacite mi sa kislorodni butilki zatova mi lapni kura i dishai. Ne se smei shte se udavish."
"Neka da e zima suh sudjuk da ima dva badjaka beli i cici naprasteli sniag da prevaliava i huy korav da stava vino i rakia putka arabia neka da e haerliq!"
"Tvoite ochi prekrasni izpalvat me s misli nai ujasni,no shte izpalnia az edinstvenata ti mechta da ti go nabia v gaza!"
"Kato dokosna tvoia vrat,kato dopra moite ustni s tvoite i osetia tvoia sok v men.....Ah kolko mi lipsvash lubimo shishe - vodka FINLANDIA!"
"Tova lice,tova prekrasno izluchvane,tazi plenitelna usmivka,tazi inteligentnost,tezi dve pleniavashti ochi...No stiga tolkova za men,ti kak si?"
"Sex is like nokia -connecting people like Nike -just do it Like Pepsi -ask for more Like Samsung -everyone is invated and like me -TO GOOD TO BE TRUE! "
"Sexa e kato matematika- pribavqsh legloto,izvajdash drehite,razdelqsh krakata i se umnojavash. !"
"Trudno e da si penis.Imash glava, no ne i mozuk, sliapo oko, dwama ot susedite ti sa tashaci, drugia e zadnik a nai-dobriq ti priqtel e p...a!"
"Tih vetrec mi vee slabinite struk treva me botzka po gaza, kleknal neide iz varbite tihi4ko sera, sera. Gaza si s rozi zakichi, nasranoto da ne lichi!"
"Да еба маъка ти,докато е в мензис!!!"
}
set randmsg [subst [lindex $bs [rand [llength $bs]]]]
putserv "privmsg $c :$randmsg"
}}

putlog "Fun TCL !!!"