#################################################################################
#Tova e nai-dobriqt tcl za invite uverqvam vi sega 6te vi zapoznaq s podrobnosti#
#FuckInvite.tcl Powered by raven<Dobo@Programmer.net> http://raven.data.bg/######
#################################################################################
#Znachi bota ne bani samo v kanala ami i na private ako go invite i ako go spam #
#s dumi kato http,www i takiva a za invite na private kato go invite i vednaga  #
#bani usera ot vsichki kanali v koito e i razbirase kadeto e i bota:))Bota ne   #
#bani ako usera ima +mnfop.Bota slaga ban za opredeleno vreme mi drugo kvo da vi#
#kaja prosto nai-dobriqt tcl za invite koito ste vijdali!:)######################
#################################################################################
#For Comments And Problems Send Mail To Dobo@Programmer.net r in IRC My nick is # #raven Thank you!Ne mi smenqyte imeto ot tcl-a oti ke ima boy!###################
#################################################################################
set ban_time 30
set bantime 30
set cycletime 10
set i_reason "4 You bad old inviter ! Burn in hell!"
set s_reason "4 You bad old inviter ! Burn in hell!"
bind msgm - *#* got_invite
bind msgm - *http* got_invite
bind msgm - *http* got_spam
bind msgm - *www* got_invite
bind msgm - *site* got_spam
bind msgm - *sait* got_spam

proc got_spam {nick uhost handle args} {
 global botnick bantime cycletime s_reason checker_nick ban_time
 foreach c [channels] {
  set n2hand [nick2hand $nick $c]
  if {([matchattr $n2hand m] || [matchattr $n2hand p]  || [matchattr $n2hand b] || [matchattr $n2hand n] || [matchattr $n2hand f])} {
    return 0
  }
  set n2hand $nick
  if {([matchattr $n2hand m] || [matchattr $n2hand p]  || [matchattr $n2hand b] || [matchattr $n2hand n] || [matchattr $n2hand f])} {
    return 0
  }
  putlog "Spam from $nick"
  set targmask *!*@[lindex [split [getchanhost $nick $c] "@"] 1]
  newban $targmask $botnick $s_reason $ban_time
  if {[onchan $nick $c]} {
   putserv "mode $c -o+b $nick $targmask"
   putserv "Kick $c $nick :$s_reason"
   putserv "mode $channel +m"
  }
  return 0
 }
}
proc got_invite {nick uhost handle args} {
 global botnick bantime cycletime i_reason checker_nick ban_time
 foreach c [channels] {
  set n2hand [nick2hand $nick $c]
  if {([matchattr $n2hand m] || [matchattr $n2hand p]  || [matchattr $n2hand b] || [matchattr $n2hand n] || [matchattr $n2hand f])} {
    return 0
  }
  set n2hand $nick
  if {([matchattr $n2hand m] || [matchattr $n2hand p]  || [matchattr $n2hand b] || [matchattr $n2hand n] || [matchattr $n2hand f])} {
    return 0
  }
  putlog "Invite from $nick"
  set targmask *!*@[lindex [split [getchanhost $nick $c] "@"] 1]
  newban $targmask $botnick $i_reason $ban_time
  if {[onchan $nick $c]} {
   putserv "mode $c -o+b $nick $targmask"
   putserv "Kick $c $nick :$i_reason"
   putserv "mode $channel +m"

  }
  return 0
 }
}

bind ctcp - DCC got_dcc
proc got_dcc {nick uhost handle dest key arg} {
 global botnick bantime cycletime reason checker_nick  ban_time
 set filename [string tolower [lindex $arg 1]]
 if {[string match "*.*" $filename]} {
  foreach c [channels] {
   set n2hand [nick2hand $nick $c]
   if {([matchattr $n2hand m] || [matchattr $n2hand p]  || [matchattr $n2hand b] || [matchattr $n2hand n] || [matchattr $n2hand f])} {
     return 0
   }
   set n2hand $nick
   if {([matchattr $n2hand m] || [matchattr $n2hand p]  || [matchattr $n2hand b] || [matchattr $n2hand n] || [matchattr $n2hand f])} {
     return 0
   }
   putlog "DCC Send from $nick"
   set targmask *!*@[lindex [split [getchanhost $nick $c] "@"] 1]
   newban $targmask $botnick $reason $ban_time
   if {[onchan $nick $c]} {
    putserv "mode $c -o+b $nick $targmask"
    putserv "Kick $c $nick :$reason"
    putserv "mode $channel +m"
   }
   return 0
  }
 }
}
bind raw - PRIVMSG invite_check
bind raw - NOTICE invite_check
set ban_time 30
set noinv_reason "4 You bad old inviter ! Burn in hell!"
proc invite_check {from keyword arg} {
	global botnick ban_time noinv_reason
        if {[string match "*#*" [lrange $arg 1 end]] == 0} {return 0}
        set channel "[lindex $arg 0]"
	if {![validchan $channel]} {return 0}
	set nick [lindex [split $from "!"] 0]
	foreach word [string range [lrange $arg 1 end] 1 end] {
		if {$word == $channel} {return 0}
	}
        set targmask *!*@[lindex [split $from "@"] 1]
	if {![isop $botnick $channel]} {return 0}
	if {[isop $nick $channel]} {return 0}
	set n2hand [nick2hand $nick $channel]
	if {([matchattr $n2hand I])} {return 0}
	newban $targmask $botnick $noinv_reason $ban_time 
      putserv "mode $channel +b $targmask"
      putserv "mode $channel +m"
      puthelp "PRIVMSG $channel :Are Begay Che Shefa Ako Ta Fani Neznam :)"
      putserv "KICK $channel $nick :$noinv_reason"
      set c [lindex $arg 0]
      set n [lindex $nick 0]
      putlog "Inviter Detected - $n on $c FuckInvite.Tcl Powered by raven"
        
	return 0
}
putlog "FuckInvite.Tcl powered by raven<Dobo@Programmer.net> has loaded!"