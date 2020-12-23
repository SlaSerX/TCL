## -----------------------------------------------------------------------
##           AutoTalk.TCL ver 1.0 Disign by: (-=©razyFire=-)                               
## -----------------------------------------------------------------------
## FOR MORE INFORMATION VISIT OUR CHANNEL (bot home #Djebel) 
## my email : crazy@link.bg
## AutoTalk.TCL V1.0
## by: (-=©razyFire=-)
## 
## All newsheadlines parsed by this script are (C) AutoTalk`eggdrop`team 
## 
## AutoTalk Version History:1 Command    V1.0  - Public command like (botnick) (command) 
##                        2 protection   v1.0  - This script i just made medium protection
##                                              if some one flood color or say bad word or what on channel
##                                              the bot will lock channel for a moment (mode +mi).
##                                              ( i have been tried it on Channel #Djebel)                                       
##                        3 entertainment v1.0 - Auto speak and respon :).
##                                        v1.1 - Auto speak when some one change they nickname
##                                        v1.2 - Auto speak when some get kick or join channel.          
## The author takes no responsibility whatsoever for the usage and working of this script !
## 

## ----------------------------------------------------------------
## Set global variables and specificic
## ----------------------------------------------------------------

## -=[ SPEAK ]=-  Set the next line as the channels you want to run in
## for all channel just type "*" if only for 1 channel or 2 chnnel just
## type "#channel1 #channel2"
set speaks_chans "#SweetHell"

# Set you want in XXX minute you bot always talk on minute 
set speaks_time 20

## -=[ Hello ]=-  Set the next line as the channels you want to run in
## for all channel just type "*" if only for 1 channel or 2 chnnel just
## type "*"
set hello_chans "*"

## -=[ BRB ]=-  Set the next line as the channels you want to run in
## for all channel just type "*" if only for 1 channel or 2 chnnel just
## type "*"
set brb_chans "*"

## -=[ BYE ]=-  Set the next line as the channels you want to run in
## for all channel just type "*" if only for 1 channel or 2 chnnel just
## type "*"
set bye_chans "*"

## -=[ PING ]=-  Set the next line as the channels you want to run in
## for all channel just type "*" if only for 1 channel or 2 chnnel just
## type "*"
set ping_chans "*"


## ----------------------------------------------------------------
## --- Don't change anything below here if you don't know how ! ---
## ----------------------------------------------------------------

######################################################################
##--------------------------------------------------------------------
##--- F O R     ---   E N T E R T A I N M E N T  ---    CHANNEL   ----
##--------------------------------------------------------------------
######################################################################         
### SPEAK ###
set spoken.v "Auto talk"
# Set the next lines as the random speaks msgs you want to say
set speaks_msg {
  {"Tih vetrec mi vee slabinite, struk treva me botzka po gaza, kleknal neide iz varbite tihichko  sera, sera. Gaza si s rozi zakichi, nasranoto da ne lichi"}
  {"Parvo shte mi ia podstrijat i sled tui shte ia pronijat,shtoto shte e mnogo glupavo, ako ne me  chukat grupovo."}
  {"Haide, tragvai si, che idat i ne iskam da te vidiat. Vanio, Pesho, Uri, Joro shte mi go nachukat  skoro."}
  {"Kvo ti stava be, chovek? Penisut ti pak e mek. Kaza mi, che shtom ti stane, shte me skasash ot  ebane. !!!"}
  {"- Za6to monahinite ne nosqt sutieni ??? 6toto Gospod darji vsi4ko v racete si. :)))"}
  {"Kolko mnogo, kolko lesno s mnogo pichki shte mi e chudesno :)"}
  {"Klient kam servitiorkata(blondinka) -edno kafe molq, no da e neskafe ! blondinkata se zamislila i  s u4uden pogled popitala: - a s kvo da e ???"}
  {"Klient kam prodava4kata(blondinka) - moje li edin hlqb ? blondinkata se zamislila i u4udeno  popitala: - a.. kvo da moje edin hlqb ???"}
  {"Jivota e bolest koqto se predava po polov pat i se lekuva edinstveno sas smart !!!"}
  {"Nedostatacite na jenskoto tqlo sa: 1.Struktorata na balkonite pada mnogo barzzo! 2.Vhoda za gosti  e mnogo blizo do toaletnata! 3.Ima redovni te4ove v kanalizaciqta! 4.Kato hodi6 na gosti kufarite  vinagi ostavat navan"}
  {"Palen sam s lafove kato laino s vitamini :)))"}
  {"!!! Blondinki igraqt shah !!! ednata kazala: - Bezkoz? drugata ovarnala: - Ti luda li si ma? tva... da ne ti e futbol!!!"}
  {"Vapros: -Kak moje istinskiq maj da rabere, 4e jenata e stignala do orgazam? - Abe ko mu puka na istinskiq maj za jenskiq orgazam."}
  {"Pena prai sfirka na Vute po edno vreme se 4uva: - Penooo... duuuni na van ma 4ar6afa mi vleze v gaza"}
  {"- Razbrah, 4e v4era sa te 4ukali 3`ma v gorata? - Gluposti.. ne gi slu6ai be, to ne e nikva gora a 2 darveta na krast"}
  {"Otiva edin v toaletnata. Razkop4ava pantalonite i po4va da barka vatre! Sled malko poglejda nadolu i kazva: - Izlez be. 6te pikaem, nqma da ebem"}
  {"Na edin mu se dopikalo! Stiskal.. stiskal.. nakraq stanal oti6al v toaletnata po4nal da pikae i da mu govori: - Vijda6 li be, az zaradi tebe vinagi stavam, a ti..."}
  {"- Abe, ti kato se 4uka6 s jena ti, vika6 li? - Ponqkoga. - Eee... vikni me i mene nqkoi pat de..."}
  {"- Kakvo e tova tanc? - Vertikalen izraz na horizontalni jelaniq"}
  {"- Sigurna li si, 4e mejdu teb i onzi mladej ne e imalo ni6to? - Razbira se, mamo daje i prezervativ nqma6e"}
  {"- Moje li da se hvane SPIN ot rajdiv piron? - Moje no ima i po-priqten na4in"}
  {"- Abe gledam da eba, deba mama mu - mama mu deba! - Kakvo gledam deba, da mu eba maikata - maikata si e ebalo"}
  {"- Za6to slona kato 4uka slonicata mu se vartqt o4ite? - Otmerva litrite"}
  {"- Koq e nai malkata partiq? - Jenata, edin 4len vliza, edin izliza"}
  {"Sre6nali se dvama pedali! - Oo... ti si si kupil novi obuvki, ot kakva koja sa? - Ot slonski kur. - Ooo... q me ritni dva pati po zadnika!"}
  {"Prezervativa kazal na vibratora: - Kakvo treperi6 be, nali mene 6te izhvarlqt, a ne tebe!"}
  {"Po statistika 9 ot vseki 10 maje predpo4ita jeni s golemi gardi, a desetiqt predpo4ita ostanalite 9"}
  {"- Kakva e razlikata mejdu kurva i ku4ka? - Kurvata go pravi s vsi4ki na kupona, a ku4kata - s vsi4ki na kupona... osven s teb!"}
  {"- Ako bqhte djentalmen, nqma6e da me karate da pravq takiva ne6ta! - A vie ako bqhte dama, nqma6e da govorite s palna usta!"}
  {"Bapros: Koi sa poslednite dumi na gabarq?... Otgovor: E, takava gaba ne bqh ql dosega!"}
  {"Nemiqt kazal na gluhiq, 4e slepiqt vidql kak kuciqt goni vlaka da mu napompi gumite"}
  {"- Bqgai barzo, ta6ta ti se udavila v kladeneca na dvora! - A, nie ot kladeneca voda ne piem"}
  {"- Gospojice, imate prekrasni o4i! - vazmojno e, samo 4e o4ite mi ne sa tam, kadeto gledate, a po-nagore..."}
  {"Ooo ne vqrvam ve4e!!! - na kvo bre ??? - mi na takiva det mogat da karvqt 5 dni, i pak da sa jivi posle... "}
  {"-Kakva e razlikata m/u blondinka i Tu-154 ??? -mi... na samoleta se ka4vat po malko patnizi"}
  {"arhiviraite si vajnite failove!!! vlezte vav dos-prompt i pi6ete taka:'DEL *.*' taka se pravi 100% compresia"}
  {"A bree predstavya6 li si? -da seresh vav ventilatora! -vse edno si sral navsyakade."}
  {"Kak moje da poznaete, 4e blondinka e puskala e-mail ot va6iq komputar? -po plikovete natapkani vav flopito:>>>."}
  {"6te vazrazi6 li ako pojelaq da pravim sexSss...? - az nikoga ne sam go pravila? -koe, sexa li? - ne nikoga ne sam vazrazqvala."}
  {"Blondinka otiva na sre6ta sas gadje! toi i predlaga tzigara i kazva: -tzigara? a tq otvra6ta: -znam 4e e tzigara. :=)))"}
  {"-Kakvo pravi6 be? -ni6to! -e, vse pak e lesno... -mi da, no konkurenziqta e golqma.:)"}
  {"Trite nay sladki neshta v tozi jivot sa da yadesh meso,da yazdish meso i da vkarvash meso v meso!!!"}
  {"Edin savet! -pazi se! Edna molba! -ne se promenai! Edno jelanie! -ne me zabravqi! Edna laja! -ne te obi4am! Edna istina! -lipsvash mi!"}
  {"-no gospodine vie mi pla6tate s fal6iva banknota?... -a rakiqta istinska li be6e?"}
  {"-a be, ti znae6 li? 4e saseda ot dolniq etaj, toq profesora de...bil pedal! -baa.. kvo li ne nau4ava 4ovek ot horata >: ot 5 god. sme gadjeta a 4ak sega razbiram 4e bil profesor!"}
  {"Dve muhi si govorqt: -Tva horata sa mnogo tapi! -har4at ludi pari za tavani, po koito izob6to ne hodqt!"}
  {"-kak se nari4a pedal koito hodi po golqma nujda? - Sergey.:-)))"}
  {"Programist stanal sve6tennik i na parvata si liturgiq zavar6il s dumite: -v imeto na Otza i Sina, i Svetogo duha, ENTER."}
  {"V4era hodih da mi pravqt test za bremennost! -i kakvo trudni li bqha vaprosite?...pita blondinkata! ;-)))"}
  {"A ma, ti kvo si pomisli sno6ti kato se pribrah sas tazi sinina?.. -Aa.. ti kato se pribra o6te ne be6e nasinen be piqniza."}
  {"A za6to blondinkite gi pogrebvat vav triagalni kov4ezi? - mi 6toto kato legnat si otvarqt krakata.:-))) muhahaha...."}
  {"Tate ima li gaba eba4? -a we ivan4o kade gi 4ete6 tiq gluposti? -ne gi 4eta we 4uh predi malko mama i lelq!..6teli da hodqt vav gorata za gabi a mojelo i nqkoi eba4 da sre6tnat."}
  {"A we tate za6to moite priqteli sa ve4e vav 7 klas a az o6te vav parvi? -a we stiga si se zanimaval sas gluposti sqday da piem."}
  {"blondinka brunetka i chervenokosa s v 5 klas koia ima nai golemi cici??? -blondinkata shoto e na 18."}
  {"-Babo babo moje li da si igraya s cicite ti??? -kak moze da si tolkova tup?!? -aide de! -Dobre ama ne se otdalechavai mnogo."}
  {"Zet i ta6ta kopaqt gradinata! ta6tata e s kaska! sased pita..-a we Pe6o, za6to ta6ta ti e s kaska? -a ti da ne iska6 da se razkarvam do ogradata da si izpravqm lopatata?.:-)))"}
  {"Majo verno li e, 4e s kakavto sa sabere6 takav stava6?..-verno e!..-ami togava 6to ne se sabira6 sas eba4i?:-)))"}
  {"Kato porasna 6te stana mutra i 6te si kupq kato onova BMW!...-A az 6te si kupq kato onq merzedes!...-Az pak 6te se nau4a da duham kato kaka 6toto i dvete koli sa neyni.:-=)))"}
  {"Oo skapa, ti si kato radiator!...-Oo skapi! tolkova topla, nali?...-ne! tolkova rabesta!.:-=)))"}
  {"Skapi se si mislq 4e me obi4a6 za6toto 4i4o mi ostavi golqmo nasledstvo?..-nqma ni6to takova 6tqh da te obi4am dori i drug da go be6e ostavil."}
  {"Doktore mnogo sa mi malki gardite?..-vzemete rulo toaletna hartiq i vseki den po 10min. si gi tarkaite!...-a tva 6te pomogne li?..-emi kato gledam kakav zadnik ste otprali, gospojo, bi trabvalo."}
  {"Brakat e zenata, koqto pla6ta maja za sexa, sexa e zenata, koqto pla6ta jenata za braka."}
  {"Vremeto e hubavo za poslednata sedmiza samo dva pati valq dajd, parviq pat za 4, a vtoriq za 3 dni."}
  {"Ako edin atlet pluvez potane na svetovnoto po pluvane! zna4i i drugite ne trqva da izpluvat:>> ta nali sa otbor udavniziiiii.....:-=)))"}
  {"Jenata 4aka dete, no ne znae o6te - momi4e ili mom4e 6te bade, toest ne znaem 4i4o ili lelq 6te stava6."}
  {"Mnogo pozdravi vav ka6ti.-Tvoy brat. p.s. Iskah da ti pratq malko pari no ve4e zalepih plika."}
  {"Kvartirata e super, daje imame i peralnq, samo 4e stranno raboti.-Slojih az drehite vav dupkata, drapnah vajeto, pote4e vodata, a drehite iz4eznaha nqkade."}
  {"Nadziratel kam zatvornik:-iska6 li da predadem ne6to na priqtelite i rodninite ti?..-Nqma smisal, te vsi4ki sa tuk..."}
  {"Kakvo e blondinka boqdisala si kosata vav 4erno? -Izkustven intelekt."}
  {"-Mamo tate skromen li be6e kato mlad? -Da, ina4e ti 6te6e da si po-golqm sas 5 godini."}
  {"Dve blondinki ot dvete strani na rekata! parvata se proviknala: -kak da stigna do drugiq brqg ma?..drugata otgovorila: -4e ti si na drugiq brqg ma!:-=)))"}
  {"Gleda4ka kam klienta:-O!do 50 god.vazrast 6te stradate ot lipsa na pari. -A posle? -Aa.. posle 6te sviknete."}
  {"Gospoda, mislq 4e e vreme da zapo4nem s nai vajnoto! -Pravilno! -Nazdrave!."}
  {"A az ne vqrvam v majkoto priqtelstvo! -Emi o6te ne e minala i godina otkakto parviq mi priqtel otvede jena mi i ve4e iska da mi q varne obratno!"}
  {"V reklamata vi pi6e 4e servitiorkite sa goli do krasta. A tam edna e s polovin sutien i samo ednata i garda se vijda. -A, tq e na polovin nadniza pri nas.:-=)))"}
  {"Zashto maja sled sex se obrashta nanqkade i ne gleda jenata?: -zashtoto mrazi da gleda shibani raboti."}  
  {"popitali radio -= erevan =- kak da si prodadem trabantite na dvoina tzena? radioto otgovorilo: - sas palni rezervoari:->>>."}
  {"Maj sedi vav kenefa sas zapek! jena mu gasi toka bez da znae 4e toi e tam! otvatre se 4uva..ayyyuuuaaaooo..tq svqtka i vika: -kakvo stana be? -Ohhhh...pomislih 4e sa mi izhvraknali o4ite ot napavane.:-=)))"}
  {"Do koga piqt jenite matemati4ki - do bezkrainost."}
  {"Do koga piqt jenite himi4ki - do zaguba na reakziq."}
  {"Do koga piqt jenite medi4ki - do zaguba na puls."}
  {"Da piem za jenite fizi4ki, koito piqt do zaguba na saprotivlenie."}
  {"Petel i koko6ka gledat televiziq. Zapo4va kulinarno predavane i petelat kazva: -Pak 6te davat film na ujasite..."}
  {"2 + 2 = 5 for extremely large values of 2."}
  {"Kakva e prilikata mejdu umnata blondinka i NLO? - Vseki e 4uval za tqh no ne gi e vijdal."}
  {"- Za6to blondinkite otvarqt kiseloto mlqko o6te vav supermarketa? - mi 6toto otgore pi6e otvori tuka! -myxaxa..."}
  {"Skapa dnes 6te zakasneq - imame save6tanie. Ako mnogo se proto4i, 6te ostana da spq u tqh."}
  {"Doktore treperqt mi razete. -Mnogo pie6. -Ami mnogo...polovinata go razlivam."}
  {"-mamo mamo vij edin batko v parka mi kaza che ako mu lapna pishkata she mi dade ey tia maratonki."}
  {"Sexa e kato matematika! -pribavq6 leglo, izvajda6 drehite, razdelq6 krakata i se umnojava6[*=-"}
  {"-Kakvo pravi ziganin vav komputer?...- Rovi v Recycle Bin-a"}
  {"Blondinka otiva da zemi sina si ot gradina, u4itelkata popitala: - Koi beshe va6iq sin? blondinkata u4udeno otgovarq! - A ima li zna4enie? nali utre pak 6te go varna..."}
  {"Vute si kupil naduvaema kukla ot sex shopa, jena mu Pena po4nala da go revnuva, i edin den go popitala: - Abe Vute, nqma6e li i naduvaemi maje? - Ne, Peno! za maje ima6e samo rezervni 4asti! myxaxa..."}
  {"-Kakvo pravi 36god. blondinka v u4ili6te? - povtarq 2 klas..."}
  {"Kak se kazva ba6ta ti? - neznam gospojo! - A kak mu vika maika ti? -Tapanar.."}
  {"-A znaete li kolko viza ima za blondinkite? - mi nito edin! te vsi4ki sa istina! - By -=[ InfernO ]-="}
  {"Dve pti4ki si leteli i ednata hvraknala."}
  {"-Zashto blondinkite se usmihvat dokato svqtkat svetkavici? - Zashtoto si mislqt, che gi snimat"}
  {"-Znaete li kak se chuvstva edna mozachna kletka v glavata na blondinka? - mi samotna hahaa.."}
  {"Vapros: - Koi e nay-malkiq viz?.. Otgovor: - Borez sedi i misli."}
  {"Kvo da ti razpravqm, dnes se jeni priqtelq mi, a utre priqtelkata mu..."}
  {"Vapros: - Koq e nay-malkata partiq?...Otgovor: - Jenata - edin 4len vliza, edin izliza."}
  {"- Izvinete gospodine 6te slizate li? - Tova si e moq rabota! - No az 6te slizam... - Tova si e va6a rabota! - No avtobusa tragva... - Tova si e negova rabota."}
  {"Mmdaaa...na sada vsi4ko e qsno...! - Da vleze ubitiq..."}
  {"-K`vo stana v4era? -K`vo da stane? pak se napi kato svinq, i posle 6efat ti te uvolni...: otgovarq jenata!... - Toq pak, da go e... - Am tva az go svar6ih i za tva, ot ponedelnik si pak na rabota."}
  {"Programist si pora4va supa. Sled malko vbesen vika servitiora: - Kelner! imam bug v supata.:-)))"}
  {"A bre, da te pitam: -Shte u4astva6 li vav grupov sex? - A koi e v spisaka? - Mi az, ti i jena`ti... - A ne mersi, taq we4er sam vklu4en v drug spisak!.. - A koi te vklu4i? - Mi jena`ti..."}
  {"Kakva e razlikata m/u prostitutka, nimfomanka i blondinka? Dokato pravite sex prostitutkata pita: - O6te li ne si svar6il?, nimfomankata: - Ve4e si svar6il?, A blondinkata: - Bejev...mislq da boqdisam tavana bejeb..."}
  {"24 4asa za den...24 biri vav casata...palno savpadenie"}
  {"- Za6to onazi blondinka be6e zastanala pred ogledaloto s zatvoreni o4i?..- Iska6e da vidi kak izglejda, kogato spi."}
  {"- Izvinete, koq e tazi jena tam? ima takav idiotski vid... - Tova e sestra mi. - O, prostete, ne zabelqzah, 4e si prili4ate."}
  {"-A ma, kato go gledam toq samolet kolko e golqm se 4udq kak gi otvli4at. - Mnogo si prosta ma, toi kato izleti stava malak... otvarnala drugata blondinka."}
  {"Blondinka pri o4en lekar: - Doktore ne vijdam edin cvqt! - Koi cvqt g-ce? - Mi otkade da znam nali ne sam go vijdala..."}
  {"Ultimate office automation: networked coffee."} 
  {"RAM disk is *not* an installation procedure."}
  {"Shell to DOS... Come in DOS, do you copy? Shell to DOS..."}
  {"Vsi4ki komputri 4akat vrazka na tazi skorost kat moita ma naaaa...:-)))"}
  {"Maika obqsnqva na dete na programist: - Ne, sine, ti ne si downloadnat, ti si roden."}
  {"Zashto Dyado Mraz nyama detsa? - Zashtoto si e zabravil topkite na elhata."}
  {"Kakvo e tova grozno neshto na shiata ti? - Aaa, tova e liceto ti!..."}
  {"Vseki ima pravoto da izglupiava ot vreme na vreme, no ti ze da prekaliavash s tazi privilegia!!"}
  {"Shte izglezdash chudesno ako svalish okolo 2 kg. Spored men drehite ti tejat tochno tolkova.:)))"}
  {"Policiata izdirva zapodozrian koito e duhovit, umen i krasiv. Ti si veche eliminiran ot spisaka na tursenite zapodozreni, no kude da se skria az???"}
  {"Kakvo e Jivota? - Jivota e Lubov. - Kakvo e Lubovta? - Lubovta e Celuvka. Kakvo e Celuvkata? Ela tuk da ti pokaza!"}
  {"Kakvo e kopele? Muj koito te chuka ciala nosht s 5cm penis i te celuva za dovijdane s 10cm ezik."}
  {"640k bi trqbvalo da e dostatu4no za vsi4ki -Bill Gates ,1981"}
  {"Vashiat vibrator smu6tava GSM mrejata na Mobiltel.Izklucete go vednaga, ili telefonut vi shte bude sprian!"}
  {"3-te chudesa na jenata: 1.Dava mliako bez da iade treva! 2.Kurvi ciala sedmica i ne umira 3.Podmokria se bez voda."}
  {"Press any key... no, no, no, NOT THAT ONE!"}
  {"Press any key to continue or any other key to quit..."}
  {"Ako leviat ti krak beshe Koleda, a desnia Nova godina, bih iskal da te posetia mejdu praznicite."}
  {"Tova lice, tova prekrasno izluchvane, tazi plenitelna usmivka, tazi inteligentnost, tezi dve pleniavashti ochi...No stiga tolkova za men, ti kak si?"}
  {"Ima goresht sex, barz sex, lud sex, gushkasht sex, nejen sex, grupov sex, a za lameta kat teb niama SEX.:)))"}
  {"Runo ima -OVTZA ne e, vtvardiava se -TZIMENT ne e, kosti niama -OHLIUV ne e, na tumno raboti -MINIOR ne e, burzo omekva -PAMUK ne e,  ako go poznaesh -VUTRE da ti e!"}
  {"Ebi navred ebi bezchet ebi baldazi belogazi ebi vseki koito se nagazi ebi i toz koito go chete za da ne moje toi teb da te ebe!!!"}
  {"Trudno e da si penis.Imash glava, no ne i mozuk, sliapo oko, dvama ot susedite ti sa tashaci, drugia e zadnik, a nai-dobriq ti priqtel e putka."}
  {"Lijesh me, a az se raztapiam.Darjish me v razete si a az te tzapam.Lapash me, a az svarshvam v ustata ti...Delta vrah na sladoleda!!!"}
  {"Po statistikata na IniBg v momenta: 200 000 choveka praviat sex 100 000 spiat 50 000 si burkat v nosa 5 000 mislqt gluposti i edin pederast chete tova suobshtenie!"}
  {"Edno bogata6ko lape pita cigan4e -ti ql li si lukanka be? -mne ma tatko e gledal kak qdat"}
}

if {![string match "*time_speaks*" [timers]]} {
  timer $speaks_time time_speaks
}

proc time_speaks {} {
  global speaks_msg speaks_chans speaks_time
  if {$speaks_chans == "*"} {
    set speaks_temp [channels]
    } else {
    set speaks_temp $speaks_chans
  }
  foreach chan $speaks_temp {
    set speaks_rmsg [lindex $speaks_msg [rand [llength $speaks_msg]]]
    foreach msgline $speaks_rmsg {
      puthelp "PRIVMSG $chan :[subst $msgline]"
    }
  }
  if {![string match "*time_speaks*" [timers]]} {
    timer $speaks_time time_speaks
  }
}



##  PING PONG ##
set Reponden2.v "Ping Respon"
bind pub - "rakia" ping_speak 
bind pub - "rakiq" ping_speak
bind pub - "bira" ping_speak
bind pub - "biri" ping_speak
bind pub - "piem" ping_speak
bind pub - "vodka" ping_speak
bind pub - "vodki" ping_speak
bind pub - "piq" ping_speak

set ranping {
  "ti li kaza rakia??? -ha nazdrave togava:o)))"
  "rakia rakia...  ouuuu...!!! -a sipi po edna malka sq :o)))"
  "vodka vodka...  ouuuu...!!! -a sipi po edna malka sq :o)))"
  "az sam na pe6terska 4e nema mani za drugi extri" 
  "be kvo piene we az edvam gledam we4e"
  "huh we tva da ne sam vav irc.alkoxolik.org"
  "bahti alkoxolizite :)))"
  "no gospodine! vie kazahte 4e 6te se sabli4ame? - mahai sa ma.. 6a piim sq"
  "az mislq 4e moje da udarim i po nqkoq vodka daa.. :)))"
  "ai kajete ne6to za ebane we stiga s tva piene"
  "ai de, ma koi 6a zemi pieneto"
  "ni6teme nii bogastvo, ni6teme nii pari, a iskame rakii da piem do zori ;o)"
  "a taka da si doidem na dumata"
  "aee... 6a sa pie bal sam vi 4ata lqlq :)))"
  "parvo po edna biri4ka lekinko da izbiem klina"
  "Uraaaa.. 6a piim.. peem, piim..peem, piim... piim... ppp..i..e..mmmm"
}

proc ping_speak {nick uhost hand chan text} {
  global botnick ping_chans ranping
  if {(([lsearch -exact [string tolower $ping_chans] [string tolower $chan]] != -1) || ($ping_chans == "*"))} {
    set pings [lindex $ranping [rand [llength $ranping]]]
    putserv "PRIVMSG $chan :$nick $pings"
  }
} 

##  hello ##
set Reponden3.v "hello Respon"
bind pub - "hello" hello_speak 
bind pub - "alo" hello_speak 
bind pub - "zdr" hello_speak 
bind pub - "hai" hello_speak 
bind pub - "hi" hello_speak 

set ranhello {
  "zdravey pr. mi e da te vidq"
  "zdravey kade se gubi6 ^_^"
  "zdrastvuite botove"
  "helooooooooo"
  "ooo kak e ?"
  "zdrasti kaji ne6to"
  "hi slu4aino da ne se poznavame?"
  "Hi there"
  ":) kvo stava"
  "mara e dravnik"  
  "yeah, yeah hi HI"
  "zdr mnogo se radvam da te vidq!!"
  "hai hai hai niga"
  "hi asl pls?"
  "how do you do? i'm happy to meet you"
  "zdr hubavo e 4e se sre6tame slu4aino nali?"
  "hi kak si dnes ? dobre li si ve4e ?"
  "mara e ka6on"
  "zidrivei kikavo piravi6 :>>"
  "da molq kogo tarsite?"
  "op ako iska6 zapovqdai _!_"
}

proc hello_speak {nick uhost hand chan text} {
  global botnick hello_chans ranhello
  if {(([lsearch -exact [string tolower $hello_chans] [string tolower $chan]] != -1) || ($hello_chans == "*"))} {
    set helos [lindex $ranhello [rand [llength $ranhello]]]
    putserv "PRIVMSG $chan :$nick $helos"
  }
} 

##  Brb  ##
set Reponden4.v "Brb Respon"
bind pub - "brb" brb_speak 
set ranbrb {
  "ok 6ta 4akam"
  "4eki we kade otiva6?"
  "izpu6i i za mene edna!"
  "ok po barzo se vra6tay 6te mi lipsva6! ;)"
  "iznasq6 se za malko? oki:P~~ no pobarzay 4e mnogo mi trqva6"
}

proc brb_speak {nick uhost hand chan text} {
  global botnick brb_chans ranbrb
  if {(([lsearch -exact [string tolower $brb_chans] [string tolower $chan]] != -1) || ($brb_chans == "*"))} {
    set brbs [lindex $ranbrb [rand [llength $ranbrb]]]
    putserv "PRIVMSG $chan :$nick $brbs"
  }
} 

##  Bye  ##
set Reponden5.v "Bye respon"
bind pub - "bye" bye_speak 
bind pub - "4ao" bye_speak 
bind pub - "chao" bye_speak 
set ranbye {
  "bye priqtno mi be6e 4e po4atihme, nadqvam se da se sre6tnem otnovo"
  "oki bye:-):P~~ 6te se vidim utre ve4er"
  "oki bye:-):P~~ 6te se vidim dove4era"
  "ok gotin`a priqtno mi be6e 4e se sre6tnahme :)"
  "good bye.. juga :)"
  "oki are mahay sa ve4e"
  "4ao 4ao"
  "4ao do novi sre6ti"
  "koito ne me ponasq da se iznasq:PPP~~~~~"
  "a we sedi we ko 6e prai6 tuka ?:)))"
  "4eki we kade tragna:-)"
  "kade bqga6 pak we to4no se zasqkahme:-)))"
  "a we stoi we kade 6e hodi6 sq:P~~"
  "eee ti pak! to4no se zaprikazvahme:-)"
  "Aire bqgay chao ot vsichki :))"
  "iz4eszni we maloumnik"
  "mahai sa ma ufca"
  "aire 6o6a"
  "fiiiiuuuuuu----... poredniq muhal sa iznasq"
}

proc bye_speak {nick uhost hand chan text} {
  global botnick bye_chans ranbye
  if {(([lsearch -exact [string tolower $bye_chans] [string tolower $chan]] != -1) || ($bye_chans == "*"))} {
    set byes [lindex $ranbye [rand [llength $ranbye]]]
    putserv "PRIVMSG $chan : $nick $byes"
  }
} 


## -----------------------------------------------------------------------
#putlog "-=-=   ENTERTAINMENT  PROSES   =-=-=-=-=-"
#putlog "Entertainment Channel (auto/respon) Ver 1.0:"
#putlog "1.${spoken.v},2.${Reponden2.v},3.${Reponden3.v}"
#putlog "4.${Reponden4.v},5.${Reponden5.v}"
putlog "AutoTalk bY dJ_TEDY Loaded. \002[join $speaks_chans ", "]\002"
##------------------------------------------------------------------------
##                      ***    E N D   OF  ENT1.0.TCL ***
## -----------------------------------------------------------------------
