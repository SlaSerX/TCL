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
set AntiSpam(ExemptFlags) "f"

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
    *.mylan.com
    *.mylan2.net
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
set AntiSpamCheck(Message) 0
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
set AntiSpamCheck(Invite) 1

set AntiSpam(matchtext) {
    {*# *}
    {*#rakovski *}
    {*.rakovski.bg *}
    {*.rakovski.net *}
    {*.langame.org *}
    {*.rakovski.bg}
    {*.langame.org}
    {*#langame}
    {*#cancel}
    {*#cancel *}
    {*#}
    {*.rakovski.net}
    {*#rakovski}
    {*.mp3}
    {*.mp3 *}
    {*#plovdiv *}
    {*#plovdiv}
    {*#sofia *}
    {*#sofia}
    {*#bulgaria *}
    {*#bulgaria}
    {*#4 *}
    {*#4}
    {*#5 *}
    {*#5}
    {*#6 *}
    {*#6}
    {*#7 *}
    {*#7}
    {*#8 *}
    {*#8}
    {*#9 *}
    {*#9}
    {*#10 *}
    {*#10}
    {*#11 *}
    {*#11}
    {*#12 *}
    {*#12}
    {*#13 *}
    {*#13}
    {*#14 *}
    {*#14}
    {*#15 *}
    {*#15}
    {*#16 *}
    {*#16}
    {*#17 *}
    {*#17}
    {*#18 *}
    {*#18}
    {*#19 *}
    {*#19}
    {*#20 *}
    {*#20}
    {*#21 *}
    {*#21}
    {*#22 *}
    {*#22}
    {*#23 *}
    {*#23}
    {*#24 *}
    {*#24}
    {*#25 *}
    {*#25}
    {*#26 *}
    {*#26}
    {*#27 *}
    {*#27}
    {*#28 *}
    {*#28}
    {*#29 *}
    {*#29}
    {*#30 *}
    {*#30}
    {*#31 *}
    {*#31}
    {*#32 *}
    {*#32}
    {*#33 *}
    {*#33}
    {*#34 *}
    {*#34}
    {*#35 *}
    {*#35}
    {*#36 *}
    {*#36}
    {*#37 *}
    {*#37}
    {*#38 *}
    {*#38}
    {*#39 *}
    {*#39}
    {*#40 *}
    {*#40}
    {*#41 *}
    {*#41}
    {*#42 *}
    {*#42}
    {*#43 *}
    {*#43}
    {*#44 *}
    {*#44}
    {*#45 *}
    {*#45}
    {*#46 *}
    {*#46}
    {*#47 *}
    {*#47}
    {*#48 *}
    {*#48}
    {*#49 *}
    {*#49}
    {*#50 *}
    {*#50}
    {*#51 *}
    {*#51}
    {*#52 *}
    {*#52}
    {*#53 *}
    {*#53}
    {*#54 *}
    {*#54}
    {*#55 *}
    {*#55}
    {*#56 *}
    {*#56}
    {*#57 *}
    {*#57}
    {*#58 *}
    {*#58}
    {*#59 *}
    {*#59}
    {*#60 *}
    {*#60}
    {*#61 *}
    {*#61}
    {*#62 *}
    {*#62}
    {*#63 *}
    {*#63}
    {*#64 *}
    {*#64}
    {*#65 *}
    {*#65}
    {*#66 *}
    {*#66}
    {*#67 *}
    {*#67}
    {*#68 *}
    {*#68}
    {*#69 *}
    {*#69}
    {*#70 *}
    {*#70}
    {*#71 *}
    {*#71}
    {*#72 *}
    {*#72}
    {*#73 *}
    {*#73}
    {*#74 *}
    {*#74}
    {*#75 *}
    {*#75}
    {*#76 *}
    {*#76}
    {*#77 *}
    {*#77}
    {*#78 *}
    {*#78}
    {*#79 *}
    {*#79}
    {*#80 *}
    {*#80}
    {*#81 *}
    {*#81}
    {*#82 *}
    {*#82}
    {*#83 *}
    {*#83}
    {*#84 *}
    {*#84}
    {*#85 *}
    {*#85}
    {*#86 *}
    {*#86}
    {*#87 *}
    {*#87}
    {*#89 *}
    {*#89}
    {*#88 *}
    {*#88}
    {*#90 *}
    {*#90}
    {*#91 *}
    {*#91}
    {*#92 *}
    {*#92}
    {*#93 *}
    {*#93}
    {*#94 *}
    {*#94}
    {*#95 *}
    {*#95}
    {*#96 *}
    {*#96}
    {*#97 *}
    {*#97}
    {*#98 *}
    {*#98}
    {*#99 *}
    {*#99}
    {*#100 *}
    {*#100}
    {*.rakovski.ch *}
    {*.rakovski.ch}
    {*.rakovski.net *}
    {*.rakovski.net}
    {*.rakovski.bg *}
    {*.rakovski.bg}
    {*.rakovski.org *}
    {*.rakovski.org}
    {*.rakovski.info *}
    {*.rakovski.info}
    {*#101 *}
    {*#101}
    {*#102 *}
    {*#102}
    {*#103 *}
    {*#103}
    {*#104 *}
    {*#104}
    {*#105 *}
    {*#105}
    {*#106 *}
    {*#106}
    {*#107 *}
    {*#107}
    {*#108 *}
    {*#108}
    {*#109 *}
    {*#109}
    {*#110 *}
    {*#110}
    {*#111 *}
    {*#111}
    {*#112 *}
    {*#112}
    {*#113 *}
    {*#113}
    {*#114 *}
    {*#114}
    {*#115 *}
    {*#115}
    {*#116 *}
    {*#116}
    {*#117 *}
    {*#117}
    {*#118 *}
    {*#118}
    {*#119 *}
    {*#119}
    {*#120 *}
    {*#120}
    {*#121 *}
    {*#121}
    {*#122 *}
    {*#122}
    {*#123 *}
    {*#123}
    {*#124 *}
    {*#124}
    {*#125 *}
    {*#125}
    {*#126 *}
    {*#126}
    {*#127 *}
    {*#127}
    {*#128 *}
    {*#128}
    {*#129 *}
    {*#129}
    {*#130 *}
    {*#130}
    {*#131 *}
    {*#131}
    {*#132 *}
    {*#132}
    {*#133 *}
    {*#133}
    {*#134 *}
    {*#134}
    {*#135 *}
    {*#135}
    {*#136 *}
    {*#136}
    {*#137 *}
    {*#137}
    {*#138 *}
    {*#138}
    {*#139 *}
    {*#139}
    {*#140 *}
    {*#140}
    {*#141 *}
    {*#141}
    {*#142 *}
    {*#142}
    {*#143 *}
    {*#143}
    {*#144 *}
    {*#144}
    {*#145 *}
    {*#145}
    {*#146 *}
    {*#146}
    {*#147 *}
    {*#147}
    {*#148 *}
    {*#148}
    {*#149 *}
    {*#149}
    {*#150 *}
    {*#150}
    {*#151 *}
    {*#151}
    {*#152 *}
    {*#152}
    {*#153 *}
    {*#153}
    {*#154 *}
    {*#154}
    {*#155 *}
    {*#155}
    {*#156 *}
    {*#156}
    {*#157 *}
    {*#157}
    {*#158 *}
    {*#158}
    {*#159 *}
    {*#159}
    {*#160 *}
    {*#160}
    {*#161 *}
    {*#161}
    {*#162 *}
    {*#162}
    {*#163 *}
    {*#163}
    {*#164 *}
    {*#164}
    {*#165 *}
    {*#165}
    {*#166 *}
    {*#166}
    {*#167 *}
    {*#167}
    {*#168 *}
    {*#168}
    {*#169 *}
    {*#169}
    {*#170 *}
    {*#170}
    {*#171 *}
    {*#171}
    {*#172 *}
    {*#172}
    {*#173 *}
    {*#173}
    {*#174 *}
    {*#174}
    {*#175 *}
    {*#175}
    {*#176 *}
    {*#176}
    {*#177 *}
    {*#177}
    {*#178 *}
    {*#178}
    {*#179 *}
    {*#179}
    {*#180 *}
    {*#180}
    {*#181 *}
    {*#181}
    {*#182 *}
    {*#182}
    {*#183 *}
    {*#183}
    {*#184 *}
    {*#184}
    {*#185 *}
    {*#185}
    {*#186 *}
    {*#186}
    {*#187 *}
    {*#187}
    {*#188 *}
    {*#188}
    {*#189 *}
    {*#189}
    {*#190 *}
    {*#190}
    {*#191 *}
    {*#191}
    {*#192 *}
    {*#192}
    {*#193 *}
    {*#193}
    {*#194 *}
    {*#194}
    {*#195 *}
    {*#195}
    {*#196 *}
    {*#196}
    {*#197 *}
    {*#197}
    {*#198 *}
    {*#198}
    {*#199 *}
    {*#199}
    {*#200 *}
    {*#200}
    {*#201 *}
    {*#201}
    {*#202 *}
    {*#202}
    {*#203 *}
    {*#203}
    {*#204 *}
    {*#204}
    {*#205 *}
    {*#205}
    {*#206 *}
    {*#206}
    {*#207 *}
    {*#207}
    {*#208 *}
    {*#208}
    {*#209 *}
    {*#209}
    {*#210 *}
    {*#210}
    {*#211 *}
    {*#211}
    {*#212 *}
    {*#212}
    {*#213 *}
    {*#213}
    {*#214 *}
    {*#214}
    {*#215 *}
    {*#215}
    {*#216 *}
    {*#216}
    {*#217 *}
    {*#217}
    {*#218 *}
    {*#218}
    {*#219 *}
    {*#219}
    {*#220 *}
    {*#220}
    {*#221 *}
    {*#221}
    {*#222 *}
    {*#222}
    {*#223 *}
    {*#223}
    {*#224 *}
    {*#224}
    {*#225 *}
    {*#225}
    {*#226 *}
    {*#226}
    {*#227 *}
    {*#227}
    {*#228 *}
    {*#228}
    {*#229 *}
    {*#229}
    {*#230 *}
    {*#230}
    {*#231 *}
    {*#231}
    {*#232 *}
    {*#232}
    {*#233 *}
    {*#233}
    {*#234 *}
    {*#234}
    {*#235 *}
    {*#235}
    {*#236 *}
    {*#236}
    {*#237 *}
    {*#237}
    {*#238 *}
    {*#238}
    {*#239 *}
    {*#239}
    {*#240 *}
    {*#240}
    {*#241 *}
    {*#241}
    {*#242 *}
    {*#242}
    {*#243 *}
    {*#243}
    {*#244 *}
    {*#244}
    {*#245 *}
    {*#245}
    {*#246 *}
    {*#246}
    {*#247 *}
    {*#247}
    {*#248 *}
    {*#248}
    {*#249 *}
    {*#249}
    {*#250 *}
    {*#250}
    {*#251 *}
    {*#251}
    {*#252 *}
    {*#252}
    {*#253 *}
    {*#253}
    {*#251 *}
    {*#251}
    {*#252 *}
    {*#252}
    {*#253 *}
    {*#253}
    {*#254 *}
    {*#254}
    {*#255 *}
    {*#255}
    {*#256 *}
    {*#256}
    {*#257 *}
    {*#257}
    {*#258 *}
    {*#258}
    {*#259 *}
    {*#259}
    {*#260 *}
    {*#260}
    {*#261 *}
    {*#261}
    {*#262 *}
    {*#262}
    {*#263 *}
    {*#263}
    {*#264 *}
    {*#264}
    {*#265 *}
    {*#265}
    {*#266 *}
    {*#266}
    {*#267 *}
    {*#267}
    {*#268 *}
    {*#268}
    {*#269 *}
    {*#269}
    {*#270 *}
    {*#270}
    {*#271 *}
    {*#271}
    {*#272 *}
    {*#272}
    {*#273 *}
    {*#273}
    {*#274 *}
    {*#274}
    {*#275 *}
    {*#275}
    {*#276 *}
    {*#276}
    {*#277 *}
    {*#277}
    {*#278 *}
    {*#278}
    {*#279 *}
    {*#279}
    {*#280 *}
    {*#280}
    {*#281 *}
    {*#281}
    {*#282 *}
    {*#282}
    {*#283 *}
    {*#283}
    {*#284 *}
    {*#284}
    {*#285 *}
    {*#285}
    {*#286 *}
    {*#286}
    {*#287 *}
    {*#287}
    {*#288 *}
    {*#288}
    {*#289 *}
    {*#289}
    {*#290 *}
    {*#290}
    {*#291 *}
    {*#291}
    {*#292 *}
    {*#292}
    {*#293 *}
    {*#293}
    {*#294 *}
    {*#294}
    {*#295 *}
    {*#295}
    {*#296 *}
    {*#296}
    {*#297 *}
    {*#297}
    {*#298 *}
    {*#298}
    {*#299 *}
    {*#299}
    {*#300 *}
    {*#300}
    {*#301 *}
    {*#301}
    {*#302 *}
    {*#302}
    {*#303 *}
    {*#303}
    {*#304 *}
    {*#304}
    {*#305 *}
    {*#305}
    {*#306 *}
    {*#306}
    {*#307 *}
    {*#307}
    {*#308 *}
    {*#308}
    {*#309 *}
    {*#309}
    {*#310 *}
    {*#310}
    {*#311 *}
    {*#311}
    {*#312 *}
    {*#312}
    {*#313 *}
    {*#313}
    {*#314 *}
    {*#314}
    {*#315 *}
    {*#315}
    {*#316 *}
    {*#316}
    {*#317 *}
    {*#317}
    {*#318 *}
    {*#318}
    {*#319 *}
    {*#319}
    {*#320 *}
    {*#320}
    {*#321 *}
    {*#321}
    {*#322 *}
    {*#322}
    {*#323 *}
    {*#323}
    {*#324 *}
    {*#324}
    {*#325 *}
    {*#325}
    {*#326 *}
    {*#326}
    {*#327 *}
    {*#327}
    {*#328 *}
    {*#328}
    {*#329 *}
    {*#329}
    {*#330 *}
    {*#330}
    {*#331 *}
    {*#331}
    {*#332 *}
    {*#332}
    {*#333 *}
    {*#333}
    {*#334 *}
    {*#334}
    {*#335 *}
    {*#335}
    {*#336 *}
    {*#336}
    {*#337 *}
    {*#337}
    {*#338 *}
    {*#338}
    {*#339 *}
    {*#339}
    {*#340 *}
    {*#340}
    {*#341 *}
    {*#341}
    {*#342 *}
    {*#342}
    {*#343 *}
    {*#343}
    {*#344 *}
    {*#344}
    {*#345 *}
    {*#345}
    {*#346 *}
    {*#346}
    {*#347 *}
    {*#347}
    {*#348 *}
    {*#348}
    {*#349 *}
    {*#349}
    {*#350 *}
    {*#350}
    {*#351 *}
    {*#351}
    {*#352 *}
    {*#352}
    {*#353 *}
    {*#353}
    {*#354 *}
    {*#354}
    {*#355 *}
    {*#355}
    {*#356 *}
    {*#356}
    {*#357 *}
    {*#357}
    {*#358 *}
    {*#358}
    {*#359 *}
    {*#359}
    {*#360 *}
    {*#360}
    {*#361 *}
    {*#361}
    {*#362 *}
    {*#362}
    {*#363 *}
    {*#363}
    {*#364 *}
    {*#364}
    {*#365 *}
    {*#365}
    {*#366 *}
    {*#366}
    {*#367 *}
    {*#367}
    {*#368 *}
    {*#368}
    {*#369 *}
    {*#369}
    {*#370 *}
    {*#370}
    {*#371 *}
    {*#371}
    {*#372 *}
    {*#372}
    {*#373 *}
    {*#373}
    {*#374 *}
    {*#374}
    {*#375 *}
    {*#375}
    {*#376 *}
    {*#376}
    {*#377 *}
    {*#377}
    {*#378 *}
    {*#378}
    {*#379 *}
    {*#379}
    {*#380 *}
    {*#380}
    {*#381 *}
    {*#381}
    {*#382 *}
    {*#382}
    {*#383 *}
    {*#383}
    {*#384 *}
    {*#384}
    {*#385 *}
    {*#385}
    {*#386 *}
    {*#386}
    {*#387 *}
    {*#387}
    {*#388 *}
    {*#388}
    {*#389 *}
    {*#389}
    {*#390 *}
    {*#390}
    {*#391 *}
    {*#391}
    {*#392 *}
    {*#392}
    {*#393 *}
    {*#393}
    {*#394 *}
    {*#394}
    {*#395 *}
    {*#395}
    {*#396 *}
    {*#396}
    {*#397 *}
    {*#397}
    {*#398 *}
    {*#398}
    {*#399 *}
    {*#399}
    {*#400 *}
    {*#400}
    {*#401 *}
    {*#401}
    {*#402 *}
    {*#402}
    {*#403 *}
    {*#403}
    {*#404 *}
    {*#404}
    {*#405 *}
    {*#405}
    {*#406 *}
    {*#406}
    {*#407 *}
    {*#407}
    {*#408 *}
    {*#408}
    {*#409 *}
    {*#409}
    {*#410 *}
    {*#410}
    {*#411 *}
    {*#411}
    {*#412 *}
    {*#412}
    {*#413 *}
    {*#413}
    {*#414 *}
    {*#414}
    {*#415 *}
    {*#415}
    {*#416 *}
    {*#416}
    {*#417 *}
    {*#417}
    {*#418 *}
    {*#418}
    {*#419 *}
    {*#419}
    {*#420 *}
    {*#420}
    {*#421 *}
    {*#421}
    {*#422 *}
    {*#422}
    {*#423 *}
    {*#423}
    {*#424 *}
    {*#424}
    {*#425 *}
    {*#425}
    {*#426 *}
    {*#426}
    {*#427 *}
    {*#427}
    {*#428 *}
    {*#428} 
    {*#429 *}
    {*#429}
    {*#430 *}
    {*#430}
    {*#431 *}
    {*#431}
    {*#432 *}
    {*#432}
    {*#433 *}
    {*#433}
    {*#434 *}
    {*#434}
    {*#435 *}
    {*#435}
    {*#436 *}
    {*#436}
    {*#437 *}
    {*#437}
    {*#438 *}
    {*#438}
    {*#439 *}
    {*#439}
    {*#440 *}
    {*#440}
    {*#441 *}
    {*#441}
    {*#442 *}
    {*#442}
    {*#443 *}
    {*#443}
    {*#444 *}
    {*#444}
    {*#445 *}
    {*#445}
    {*#446 *}
    {*#446}
    {*#447 *}
    {*#447}
    {*#448 *}
    {*#448}
    {*#449 *}
    {*#449}
    {*#450 *}
    {*#450}
    {*#451 *}
    {*#451}
    {*#452 *}
    {*#452}
    {*#453 *}
    {*#453}
    {*#454 *}
    {*#454}
    {*#455 *}
    {*#455}
    {*#456 *}
    {*#456}
    {*#457 *}
    {*#457}
    {*#458 *}
    {*#458}
    {*#459 *}
    {*#459}
    {*#460 *}
    {*#460}
    {*#461 *}
    {*#461}
    {*#462 *}
    {*#462}
    {*#463 *}
    {*#463}
    {*#464 *}
    {*#464}
    {*#465 *}
    {*#465}
    {*#466 *}
    {*#466}
    {*#467 *}
    {*#467}
    {*#468 *}
    {*#468}
    {*#469 *}
    {*#469}
    {*#470 *}
    {*#470}
    {*#471 *}
    {*#471}
    {*#472 *}
    {*#472}
    {*#473 *}
    {*#473}
    {*#474 *}
    {*#474}
    {*#475 *}
    {*#475}
    {*#476 *}
    {*#476}
    {*#477 *}
    {*#477}
    {*#478 *}
    {*#478}
    {*#479 *}
    {*#479}
    {*#480 *}
    {*#480}
    {*#481 *}
    {*#481}
    {*#482 *}
    {*#482}
    {*#483 *}
    {*#483}
    {*#484 *}
    {*#484}
    {*#485 *}
    {*#485}
    {*#486 *}
    {*#486}
    {*#487 *}
    {*#487}
    {*#488 *}
    {*#488}
    {*#489 *}
    {*#489}
    {*#490 *}
    {*#490}
    {*#491 *}
    {*#491}
    {*#492 *}
    {*#492}
    {*#493 *}
    {*#493}
    {*#494 *}
    {*#494}
    {*#495 *}
    {*#495}
    {*#496 *}
    {*#496}
    {*#497 *}
    {*#497}
    {*#498 *}
    {*#498}
    {*#499 *}
    {*#499}
    {*#500 *}
    {*#500}

}
    
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
    {*#&%#&*}
    {*#*}
    {*join in*}
    {*elate w*}
    {*elate v*}
    {*kanala se mesti v*}
    {*zapovqdaite v kanal*}
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
    {*zapovqdaite v nai qkia kanal*}
    {*please join #*}
    {*elate v #*}
    {*go to #*}
    {*kanala se mesti v*}
    {*visit #*}
    {*poseti moeto kanalche*}
    {*shte vleznesh li v moq kanal*}
    {*follow me to*#*}
    {*Join pls*#*}
    {*ako iskash vlez v*}
    {*#*}
    {*haide vsichki v kanal*}
    {*/j*}
    {*j/*}
    {*/server*}
    {*/s*}
    {*irc.*}
    
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
    {*ela v*}
    {*join*}
    {*wlez*}
    {*vles*}
    {*vlez*}
    {*zapovqdai v*}
    {*#*}	
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
    {*elate v*}
    {*zapovqdaite v*}
    {*kanala se mesti v*}
    {*#*}
    {*vlizaite v kanal*}
    {*join*}
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
    {*vlizaite v kanal*}
    {*nai qkia kanal*}
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
    {*#*}
    {*PING*}
    {*VERSION*}
    {*SERVER*}
    {*IRC*}
    {*/s*}
    {*/server*}
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
    {*ela v*}
    {*join my*}
    {*#*}
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
  {*Take Over*}
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
  {*Take Over*}
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
set AntiSpam(Reason) "Detected invite (Type - \$type) from you on \[AntiSpam:NowDate\]."

### BanLast
## Opisanie:  Kolko minuti da trae bana na spamera.
##
## Stojnosti: 0 = zawinagi
##            R = w minuti
###
set AntiSpam(BanLast) 120

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
set AntiSpam(BanSticky) 0

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
set AntiSpam(BanType) "20"

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
set AntiSpam(BogusFlagsAdd) "n"

### BogusFlagsDel
## Opisanie:  Koj ste moje da polzwa !delbogus komandata.
##
## Stojnosti: Flag
##
## Poqsnenie: !delbogus = Iztriwa bogus nick ot BogusNickF
###
set AntiSpam(BogusFlagsDel) "n"

### BogusFlagsList
## Opisanie:  Koj ste moje da polzwa !listbogus komandata.
##
## Stojnosti: Flag
##
## Poqsnenie: !listbogus = Pokazwa wsi4ki bogus nickowe.
###
set AntiSpam(BogusFlagsList) "n"
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
    putserv "PRIVMSG $chan :Usage: !delbogus <wildnick>"
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
    putserv "PRIVMSG $chan :Nick not found."
  }

  file rename -force $AntiSpam(BogusNickFTmp) $AntiSpam(BogusNickF)
  putserv "PRIVMSG $chan :$newnick deleted."
}

bind pub $AntiSpam(BogusFlagsAdd) !addbogus AntiSpam:BogusAdd
proc AntiSpam:BogusAdd {nick uhost hand chan arg} {
  global AntiSpam
  set arg [split $arg]
  if {[lindex $arg 0] == ""} {
    putserv "PRIVMSG $chan :Usage: !addbogus <wildnick>"
    putserv "PRIVMSG $chan :It depends to you adding correct nicknames ;)"
    return 0
  }

  set newnick [lindex $arg 0]
  set fh [open $AntiSpam(BogusNickF) r]
  while {![eof $fh]} {
    set line [gets $fh]
    if {$line != "" && [string match -nocase $line $newnick]} {
      putserv "PRIVMSG $chan :This nicknames already is in the list."
      return 0
    }
  }

  close $fh

  set fh [open $AntiSpam(BogusNickF) a]
  puts $fh $newnick
  close $fh
  putserv "PRIVMSG $chan :Added $newnick as a bogus one."
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
    putserv "PRIVMSG $chan :No nicknames are added."
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
        putserv "PRIVMSG $chan :Bogus nicks are: [join [lrange $added $j $i] ", "]"
      } else {
        putserv "PRIVMSG $chan :[join [lrange $added $j $i] ", "]"
      }
      set j [expr $i + 1]
    }
  }

  if {$j != $i} {
    if {$j == 0} {
      putserv "PRIVMSG $chan :Bogus nicks are: [join [lrange $added $j $i] ", "]"
    } else {
      putserv "PRIVMSG $chan :[join [lrange $added $j $i] ", "]"
    }
  }

  putserv "PRIVMSG $chan :Results found: $p"
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
    putserv "PRIVMSG $nick :Hello, dude!"
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

  AntiSpam:Punish $nick $uhost $hand CTCP
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
        putserv "PRIVMSG $SayBot :[encrypt $AntiSpam(AllBotsKey) $SayMsg]"
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
    pushmode $chan -o $nick
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
    putkick $chan $nick [subst $AntiSpam(Reason)]
    return 1
  }

  return 0
}

proc AntiSpam:BanNick {ban chan} {
  if {$chan == "" || $ban == "*!*@*" || $ban == ""} {
    return 0
  }

  if {[validchan $chan] == 1 && [botonchan $chan] == 1 && [botisop $chan] == 1} {
    pushmode $chan +b $ban
    return 1
  }

  return 0
}

proc AntiSpam:NowDate {} {
  # 01 Feb 2004 11:01 PM
  return [strftime "%d %b %Y %I:%M %P"]
}

proc AntiSpam:IsSpam {type arg} {
  global AntiSpam

  if {$arg == ""} {
    return 0
  }
  if {[info exists AntiSpam(matchtext)]} {
    foreach matchtext $AntiSpam(matchtext) {
      if {[string match -nocase $matchtext $arg]} {
        return 0
      }
    }
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
