bind mode o "* +b" enforcebans

set enforce(max) "8"
set enforce(kmsg) "14·Banned14· :ban: от 7:nick:"

proc enforcebans {nick uhost hand chan mc ban} {
  global enforce botname
  #putquick "PRIVMSG CS :op $chan"
  set ban [string map {"\\" "\\\\" "\[" "\\["} $ban]
  if {[string match -nocase $ban $botname]} { return }
  set kickmsg "$enforce(kmsg)"
  regsub -all :ban: $kickmsg $ban kickmsg
  regsub -all :nick: $kickmsg $nick kickmsg
  set list ""
  foreach user [chanlist $chan] {
    if {[string match -nocase $ban $user![getchanhost $user $chan]]} {
      lappend list $user
    }
  }
  if {[llength $list] == "0"} { return }
  if {[llength $list] > $enforce(max)} {
    putquick "MODE $chan -ob $nick $ban"
	#timer 5 "putquick \"MODE $chan -o $::botnick\""
  } else {
    if {[llength $list] <= "3"} {
      putquick "KICK $chan [join $list ,] :$kickmsg"
	  #timer 5 "putquick \"MODE $chan -o $::botnick\""
    } else {
      set nlist ""
      foreach x $list {
        lappend nlist $x
        if {[llength $nlist] == "3"} {
          putquick "KICK $chan [join $nlist ,] :$kickmsg"
		  ##timer 5 "putquick \"MODE $chan -o $::botnick\""
          set nlist ""
        }
      }
      if {[llength $nlist] != ""} {
        putquick "KICK $chan [join $nlist ,] :$kickmsg"
		##timer 5 "putquick \"MODE $chan -o $::botnick\""
        set nlist ""
      }
    }
  }
}

putlog "Инсталиран: Enforcebans.tcl"