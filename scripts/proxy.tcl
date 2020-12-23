#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Този TCL e написан за да се опита
# да спре напоследък нарасналия flood
# в мрежата на UniBG.
# Aвтор: Paco Мейл: paco@unix-bg.org
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
######################################
##  Редактирайте променливите       ##
######################################

# Задайте причината, с която бота ще рита търчоляците
set clone_msg "Open proxy (Expire: never)"

# Задайте максимален брой потребители с един хост/IP
set clone_max 50

# Задайте каналите, в които да работи скрипта
set clone_chans "#ruse"

# Ако е 0, бота само ще рита потребителите без да ги бани.
set s_ban 1

# Колко време да трае бана ,aко е 0 ще е преманентен. (в минути)
set s_time 60

## Заключване на канала 
# За да не заключва канала оставете така "" 
set lockmodes "rq"

## След колко време да отключи канала (в секунди)
set unlocktime "90"

## Тук може да изберете как да бани вашия бот
# По подразбиране e 1 (*!*@some.domain.com),
# 1 - *!*@some.domain.com
# 2 - *!*@*.domain.com
# 3 - *!*ident@some.domain.com
# 4 - *!*ident@*.domain.com
# 5 - *!*ident*@some.domain.com
# 6 - *nick*!*@*.domain.com
# 7 - *nick*!*@some.domain.com
# 8 - nick!ident@some.domain.com
# 9 - nick!ident@*.host.com
set bantype "2"

#############################################################
##    ОТ ТУК НАДОЛУ НЕ РЕДАКТИРАЙ, ЗА ДА РАБОТИ СКРИПТА    ##
#############################################################

bind join - * join_clone

proc join_clone {nick uhost hand chan} {
 global clone_msg clone_max clone_chans botnick unlocktime lockmodes clonemask
 if {(([lsearch -exact [string tolower $clone_chans] [string tolower $chan]] != -1) || ($clone_chans == "*")) && (![matchattr $hand o|o $chan]) && (![matchattr $hand b]) && ($nick != $botnick)} {
  set clone_temp2 0
  set clonemask [type:banmask $uhost $nick]
  foreach i [chanlist $chan] {
   set clone_temp [lindex [split [getchanhost $i $chan] @] 1]
   if {$clone_temp == [lindex [split $uhost @] 1]} {
    incr clone_temp2
   }
  }
  if {$clone_temp2 >= $clone_max} {
   putquick "MODE $chan +imrq"
   putquick "MODE $chan +b $clonemask"
   setuser Proxy HOSTS $clonemask
   putquick "KICK $chan $nick :Banned: $clone_msg"
   utimer $unlocktime [list putquick "MODE $chan -imrq"]
  }
 }
}

##########################################

bind join - * check
proc check {nick uhost handl chan} {
 global s_ban s_time clone_chans clone_msg botnick unlock lockmodes banmask unlocktime
 set uhost [string tolower $uhost]
 set host [lindex [split $uhost @] 1]
 set chan [string tolower $chan]
 if { [matchattr $handl f|f $chan] } {
 putlog "14***15 Proxy exempt for: $nick"
 return 1
 }
 if { [matchattr $handl S] } {
 set banmask [type:banmask $uhost $nick]
 putlog "14***15 Proxy detected for: $nick"
 putquick "MODE $chan +imrq"
 newban $banmask $botnick $clone_msg $s_time
 utimer $unlocktime [list putquick "MODE $chan -imrq"]
 }
}

bind pub m|m !+proxy pub_+clone
proc pub_+clone {nick uhost hand chan txt} {
if {[llength $txt]<1} {
putnotc $nick "Ползвай: !+proxy <mask>"
   return 0
 }
    setuser Proxy HOSTS $txt
	putquick "PRIVMSG $chan :[strftime %T/%d.%m.%Y:] New proxy added $txt req. by (@$hand)"
    putlog "<<$nick>> \002!$hand!\002 added host on user proxy <<$txt>>"
    save
    return 0
}

bind pub m|m !-proxy pub_-clone
proc pub_-clone {nick uhost hand chan txt} {
if {[llength $txt]<1} {
putnotc $nick "Ползвай: !-proxy <mask>"
   return 0
 }
    delhost Proxy $txt
	putquick "PRIVMSG $chan :[strftime %T/%d.%m.%Y:] Proxy removed $txt req. by (@$hand)"
    putlog "<<$nick>> \002!$hand!\002 removed host from user proxy <<$txt>>"
    save
    return 0
}

#######

bind pub m|m !+protect pub_+pclone
proc pub_+pclone {nick uhost hand chan txt} {
if {[llength $txt]<1} {
putnotc $nick "Ползвай: !+protect <mask>"
   return 0
 }
    setuser Protect HOSTS $txt
	putquick "PRIVMSG $chan :[strftime %T/%d.%m.%Y:] New protected added $txt req. by (@$hand)"
    putlog "<<$nick>> \002!$hand!\002 New protected added <<$txt>>"
    save
    return 0
}

bind pub m|m !-protect pub_-pclone
proc pub_-pclone {nick uhost hand chan txt} {
if {[llength $txt]<1} {
putnotc $nick "Ползвай: !-protect <mask>"
   return 0
 }
    delhost Protect $txt
	putquick "PRIVMSG $chan :[strftime %T/%d.%m.%Y:] Protected host removed $txt req. by (@$hand)"
    putlog "<<$nick>> \002!$hand!\002 Protected host removed <<$txt>>"
    save
    return 0
}

proc type:banmask {uhost nick} {
 global bantype
  switch -- $bantype {
   1 { set banmask "*!*@[lindex [split $uhost @] 1]" }
   2 { set banmask "*!*@[lindex [split [maskhost $uhost] "@"] 1]" }
   3 { set banmask "*!*$uhost" }
   4 { set banmask "*!*[lindex [split [maskhost $uhost] "!"] 1]" }
   5 { set banmask "*!*[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]" }
   6 { set banmask "*$nick*!*@[lindex [split [maskhost $uhost] "@"] 1]" }
   7 { set banmask "*$nick*!*@[lindex [split $uhost "@"] 1]" }
   8 { set banmask "$nick![lindex [split $uhost "@"] 0]@[lindex [split $uhost @] 1]" }
   9 { set banmask "$nick![lindex [split $uhost "@"] 0]@[lindex [split [maskhost $uhost] "@"] 1]" }
   default { set banmask "*!*@[lindex [split $uhost @] 1]" }
   return $banmask
  }
}

putlog "Инсталиран: Proxy/Clones.tcl"