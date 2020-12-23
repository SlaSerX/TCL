# Number of repeats before kicking
set repeatkick 4
# In how many seconds
set repeattime 7 
# Kick msg
set repeatmsg "Mnogo Glupav si nachi da povtarqsh kato maloumnite maimuni v zoologicheskata!"
# Also ban?
set repeatban 1
# How long the ban should last (in minutes)
set repeatbantime 120


# Don't edit below unless you know what you're doing

bind pubm - * repeat_pubm
bind ctcp - ACTION repeat_action
bind nick - * repeat_nick

proc repeat_pubm {nick uhost hand chan text} {
  if [matchattr $hand m|m $chan] {return 0}
  global repeat_last repeat_num repeatkick repeatmsg repeatban repeatbantime
  if [info exists repeat_last([set n [string tolower $nick]])] {
    if {[string compare [string tolower $repeat_last($n)] \
        [string tolower $text]] == 0} {
      if {[incr repeat_num($n)] >= ${repeatkick}} {
        if {$repeatban} {
          set banmask "*!*[string range $uhost [string first "@" $uhost] end]"
          newchanban $chan $banmask repeat $repeatmsg $repeatbantime
        }
        putserv "KICK $chan $nick :$repeatmsg"
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
        putserv "KICK $dest $nick :$repeatmsg"
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

if ![regexp repeat_timr [utimers]] {     # thanks to SmasHinG
  utimer $repeattime repeat_timr
}

