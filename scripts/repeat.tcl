# Na kolko povtarqnia da rita ?
set repeatkick 5
# V oeriod na kolko sekundi ?
set repeattime 9
# Syobshtenie pri ritaneto :
set repeatmsg "Please, STOP"
# Iskash li bota da slaga ban ? /zamestvash 0 s 1/
set repeatban 1
# Kolko dylgo da stoi bana (v minuti)?
set repeatbantime 1


# Ne promenqi nadolo ako ne znaesh kakvo pravish !

bind pubm - * repeat_pubm
bind ctcp - ACTION repeat_action
bind nick - * repeat_nick
bind notc - * repeat_pubm

proc repeat_pubm {nick uhost hand chan text} {
  if [matchattr $hand F] {return 0}
  global repeat_last repeat_num repeatkick repeatmsg repeatban repeatbantime
  if [info exists repeat_last([set n [string tolower $nick]])] {
    if {[string compare [string tolower $repeat_last($n)] \
        [string tolower $text]] == 0} {
      if {[incr repeat_num($n)] >= ${repeatkick}} {
        if {$repeatban} {
		  set banmask $nick!*@*
          #set banmask "*!*[string range $uhost [string first "@" $uhost] end]"
          newban "$banmask" "Repeat" "$repeatmsg 4-> 15Channel repeat rejected 4<- Out for $repeatbantime min" "$repeatbantime"
        }
	    putlog "$nick!$uhost <$chan> $nick!->kick"
		putquick "MODE $chan +b $banmask"
        putquick "KICK $chan $nick :$repeatmsg 4-> 15Channel repeat rejected 4<- Out for $repeatbantime min"
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
		  set banmask $nick!*@*
          #set banmask "*!*[string range $uhost [string first "@" $uhost] end]"
          newban "$banmask" "Repeat" "$repeatmsg 4-> 15Action repeat rejected 4<- Out for $repeatbantime min" "$repeatbantime"
        }
		putquick "MODE $chan +b $banmask"
        putquick "KICK $chan $nick :$repeatmsg 4-> 15Channel repeat rejected 4<- Out for $repeatbantime min"
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

putlog "Инсталиран: repeat.tcl" 

