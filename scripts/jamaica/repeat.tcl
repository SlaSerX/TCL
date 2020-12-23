# linijte na koito bota da kick?
set repeatkick 4
# za kolko sec?
set repeattime 6
# Syobshtenie za kick?
set repeatmsg "12-=11 Don't repeat, LAME! 12 =-"
# Ako zhelaesh bot da slaga ban slozhi 1 , inache slozhi 0 
set repeatban 1
# Kolko da byde vremeto na bana? (min)
set repeatbantime 5

bind pubm - * repeat_pubm
bind ctcp - ACTION repeat_action
bind nick - * repeat_nick

proc repeat_pubm {nick uhost hand chan text} {
  if [matchattr $hand f|f $chan] {return 0}
  global repeat_last repeat_num repeatkick repeatmsg repeatban repeatbantime
  if [info exists repeat_last([set n [string tolower $nick]])] {
    if {[string compare [string tolower $repeat_last($n)] \
        [string tolower $text]] == 0} {
      if {[incr repeat_num($n)] >= ${repeatkick}} {
        if {$repeatban} {
          set banmask "*!*[string range $uhost [string first "@" $uhost] end]"
          newchanban $chan $banmask repeat $repeatmsg $repeatbantime
        }
	putlog "$nick!$uhost <$chan> $nick!->kick"
        putserv "KICK $chan $nick :$repeatmsg $nick"
        putserv "NOTICE $nick :$nick, molya ne floodi v $chan"
        unset repeat_last($n)
        unset repeat_num($n)
      }
      return
    }
  }
  set repeat_num($n) 1
  set repeat_last($n) $text
}

proc repeat_action {nick uhost hand dest keyword text} {
  global botnick altnick repeat_last repeat_num repeatkick repeatmsg repeatban repeatbantime
  if {$dest == $botnick || $dest == $altnick || [matchattr $hand f|f $dest]} {return 0}
  if [info exists repeat_last([set n [string tolower $nick]])] {
    if {[string compare [string tolower $repeat_last($n)] \
        [string tolower $text]] == 0} {
      if {[incr repeat_num($n)] >= ${repeatkick}} {
        if {$repeatban} {
          set banmask "*!*[string range $uhost [string first "@" $uhost] end]"
          newchanban $dest $banmask repeat $repeatmsg $repeatbantime
        }
	putlog "$nick!$uhost <$dest> kicking -> $nick!"
        putserv "KICK $dest $nick :$repeatmsg $nick"
        putserv "NOTICE $nick :$nick, please do not repeat on $chan"
        unset repeat_last($n)
        unset repeat_num($n)
      }
      return
    }
  }
  set repeat_num($n) 1
  set repeat_last($n) $text
}

proc repeat_nick {nick uhost hand chan newnick} {
  if [matchattr $hand f|f $chan] {return 0}
  global repeat_last repeat_num
  catch {set repeat_last([set nn [string tolower $newnick]]) \
         $repeat_last([set on [string tolower $nick]])}
  catch {unset repeat_last($on)}
  catch {set repeat_num($nn) $repeat_num($on)}
  catch {unset repeat_num($on)}
}

proc repeat_timr {} {
  global repeat_last repeattime
  catch {unset repeat_last}
  catch {unset repeat_num}
  utimer $repeattime repeat_timr
}

if ![regexp repeat_timr [utimers]] {    
  utimer $repeattime repeat_timr
}

#putlog "repeat.tcl zareden yspeshno! vzemi poveche ot http://eggzone.hit.bg" 

