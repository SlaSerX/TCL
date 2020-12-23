#for local flags... 
#set alienflags [lindex [split [chattr $handle $alienchan] |] 1]

set wwwfile "/home/hate/public_html/index.html"
set bodytag {<body TEXT=#000000 BGCOLOR=#FFFFFF LINK=#0000EE VLINK=#005AAF ALINK=#666666>}
set update_time 5
set update_rate 5
set www_enable 1
set th_a(0) "#7F91A7"
set th_a(1) "#7F91A7"
set td_a(0) "#7F91A7"
set td_a(1) "#7F91A7"

proc for_time { input } {
	# Algorythm stolen from Floyd's implementation in seen:
	set totalyear [expr [clock seconds] - $input]
	if {$totalyear < 60} {
		return "less then a minute"
	}
	if {$totalyear > 31536000} {
		set yearsfull [expr $totalyear/31536000]
		set years [expr int($yearsfull)]
		set yearssub [expr 31536000*$years]
		set totalday [expr $totalyear - $yearssub]
	}
	if {$totalyear < 31536000} {
	 	set totalday $totalyear
		set years 0
	}
	if {$totalday > 86400} {
		set daysfull [expr $totalday/86400]
		set days [expr int($daysfull)]
		set dayssub [expr 86400*$days]
		set totalhour [expr $totalday - $dayssub]
	}
	if {$totalday < 86400} {
		set totalhour $totalday
		set days 0
	}
	if {$totalhour > 3600} {
		set hoursfull [expr $totalhour/3600]
		set hours [expr int($hoursfull)]
		set hourssub [expr 3600*$hours]
		set totalmin [expr $totalhour - $hourssub]
	}
	if {$totalhour < 3600} {
		set totalmin $totalhour
		set hours 0
	}
	if {$totalmin >= 60} {
		set minsfull [expr $totalmin/60]
		set mins [expr int($minsfull)]
	}
	if {$totalmin < 60} {
		set mins 0
	}
	# Changed a bit from floyd
	if {$years < 1} {set yearstext ""} elseif {$years == 1} {set yearstext "$years year "} {set yearstext "$years years "}
	if {$days < 1} {set daystext ""} elseif {$days == 1} {set daystext "$days day "} {set daystext "$days days "}
	if {$hours < 1} {set hourstext ""} elseif {$hours == 1} {set hourstext "$hours hour "} {set hourstext "$hours hours "}
	if {$mins < 1} {set minstext ""} elseif {$mins == 1} {set minstext "$mins minute"} {set minstext "$mins minutes"}
	set output $yearstext$daystext$hourstext$minstext
	set output [string trimright $output " "]
	set output [string trimright $output ","]
	return "$output"
}


proc sort {user} {
  set chan [string tolower $user]
  foreach i [userlist] {
    if {![matchchanattr $i 15|15 ]} {
        set some [lindex [getuser $i XTRA created] 0]
        if {$some != "" && $i != "*ban"} {
            lappend list "$some $i"
           }
       }
  }
  set list [lsort -increasing -integer -index 0 $list]
  return $list  
}

bind dcc m dorecord dcc_dorecord
proc dcc_dorecord {hand idx text} {
  switch -glob [clock format [clock seconds] -format %M] {    
    default {
      do_stats 
      putdcc $idx "Updating webfiles."
      return 1
    }
  }
}
proc do_stats {} {
  global wwwfile bodytag botnick update_time th_a td_a bot_admin admin_email server uptime b
  set b [clock seconds]
  foreach statuser [channels] {
        putserv "ping 0"
        set out "<meta http-equiv=\"Refresh\" content=\"[expr $update_time * 60]\">"
        append out "\n<html><head>\n"
        append out "<title>$botnick users - status</title>\n"
        append out "\n</head>\n"
        append out "\n$bodytag\n"
        append out "\n<table CELLSPACING=0 BORDER=0 WIDTH=100%>\n<caption><br>"
        append out "\n Last Update : <B>[clock format "$b" -format "%d.%m.%Y %H:%M"]</B><br>"
		putlog "[clock format "$b" -format "%d.%m.%Y %H:%M"]"
        append out "\n Running For : <B>[for_time $uptime]</B><br>"
        append out "\n Next Update : <B>after $update_time minute(s).<B></table>"  
	append out "\n Legends: <br>"
	append out "\n<table border=0><TBODY><TR><td bgcolor=#DEDECE>&nbsp;&nbsp;&nbsp;</TD><TD>Owner</TD></TR>"
	append out "\n<TR><TD bgcolor=#EEEEDE>&nbsp;&nbsp;&nbsp;</TD><TD>Master</TD></TR>"
	append out "\n<TR><TD bgcolor=#EEDEEE>&nbsp;&nbsp;&nbsp;</TD><TD>Bot</TD></TR><TR></TR></TBODY></TABLE>"
        append out "\n<table bordercolorlight=#FF0066 bordercolordark=#000000 width=100% valign=top border=0>\n<caption><br>"
        append out "\n<BR>Recorded users:</BR>"
        append out "</caption>\n<tr>"
        append out "\n<td noWrap align=middle bgcolor=\"$th_a(0)\"><font size=-1 face=Verdana color=black>Nr</td>"
        append out "\n<td noWrap align=middle bgcolor=\"$th_a(1)\"><font size=-1 face=Verdana color=black>Nick</td>"
        append out "\n<td noWrap align=middle bgcolor=\"$th_a(0)\"><font size=-1 face=Verdana color=black>Global</td>"
        append out "\n<td noWrap align=middle bgcolor=\"$th_a(1)\"><font size=-1 face=Verdana color=black>Added</td>"
	append out "\n<td noWrap align=middle bgcolor=\"$th_a(1)\"><font size=-1 face=Verdana color=black>Users</td>"
        append out "\n<td noWrap align=middle bgcolor=\"$th_a(0)\"><font size=-1 face=Verdana color=black>E-mail</td>"
        append out "\n</tr>"

        set lista [lrange [sort ""] 0 999]
        set no 0
        foreach i $lista {
          incr no
	  set buza ""
          set handle [lindex $i 1]
          set flags [chattr $handle]
              if {$flags == 1 } {set flags -} {set color "#eeeeee"}
          set added [getuser $handle XTRA Added]
              if {$added == ""} {set added -}
          set comment [getuser $handle COMMENT]
              if {$comment == ""} {set comment -}    
          set email [getuser $handle XTRA Email]
              if {$email == ""} {set email -}
          if {[matchchanattr $handle "+n"]} {
	   set flagove [chattr $handle]
	   if {[getuser $handle xtra users] == ""} { } else {append buza "Users <b>[lindex [split [lindex [split [getuser $handle xtra users] (] 1] )] 0]</b> "}
	   if {[getuser $handle xtra masters] == ""} { } else {append buza "Masters <b>[lindex [split [lindex [split [getuser $handle xtra masters] (] 1] )] 0]</b> "}
#	   if {![ispermowner $handle]} { } else {
#	   if {[getuser $handle xtra owners] == ""} { } else {append buza "Owners <b>[lindex [split [lindex [split [getuser $handle xtra owners] (] 1] )] 0]</b>"}
#	   }
	   set color "#DEDECE"
	   }
          if {[matchchanattr $handle "+m-n"]} {
	   if {[getuser $handle xtra users] == ""} { } else {append buza "Users <b>[lindex [split [lindex [split [getuser $handle xtra users] (] 1] )] 0]</b> "}
	   if {[getuser $handle xtra masters] == ""} { } else {append buza "Masters <b>[lindex [split [lindex [split [getuser $handle xtra masters] (] 1] )] 0]</b> "}
	   set color "#EEEEDE"
	   }
          if {[matchchanattr $handle "+b"]} {set color "#EEDEEE"}
          append out "\n<tr>"
          append out "\n<td width=30 noWrap align=center bgcolor=\"$color\"><font size=-1 face=Verdana color=black> $no</td>"
          append out "\n<td width=100 noWrap align=center bgcolor=\"$color\"><font size=2 face=Verdana color=black><b>$handle</b></td>"
          append out "\n<td width=1% noWrap align=center bgcolor=\"$color\"><font size=-1 face=Verdana color=black>$flags</td>" 
          append out "\n<td noWrap align=center bgcolor=\"$color\"><font size=-1 face=Verdana color=black>$added</td>"
          append out "\n<td noWrap align=center bgcolor=\"$color\"><font size=-1 face=Verdana color=black>$buza</td>"
          append out "\n<td noWrap align=center bgcolor=\"$color\"><font size=-1 face=Verdana color=black><a href=\"mailto:$email\">$email</a></td>"
          append out "\n</tr>"
        }
        append out "\n</table></center>"
        append out "\n<table width=100% valign=top border=0>\n<caption><br>"
               set cnt 0 
                 foreach usr [userlist +n] {
                 incr cnt 1 
                  }
               set cnt1 0 
                 foreach usr [userlist +m-n] {
                 incr cnt1 1 
                  }
               set cnt2 0 
                 foreach usr2 [userlist +b] {
                 incr cnt2 1 
                  }
	       set cnt3 0
	         foreach usr3 [userlist -b] {
		 incr cnt3 1
		 }
        append out "\n<table border=1 bordercolorlight=#7F91A7 bordercolordark=#7F91A7><tbody><tr><td>Owner: $cnt</td></tr>"
        append out "\n<tr><td>Masters: $cnt1</td></tr>"
	append out "\n<tr><td><B>Total Users: $cnt3</td><B></tr>"
        append out "\n<tr><td>Bots: $cnt2</td></tr>"
        append out "\n<tr><td><B>Total Records: [countusers]</td><B></th>"        
        append out "\n</tbody></table></caption></center><br>"
        append out "</center>"
        append out "\n</body></html>"
        set fd [open "$wwwfile" w]
        puts $fd $out
        close $fd
        unset out
   }
 }
proc do_record_run {} {
  global update_rate www_enable
  if {$www_enable} {
    do_stats
    if { ![string match "* do_record_run *" [timers]] } {
      timer $update_rate do_record_run
      }
    }
  }

proc do_record_check {} {
  global update_rate
  if { ![string match "* do_record_run *" [timers]] } {
    timer $update_rate do_record_run
    }
  }
if {![string match "* do_record_run *" [timers]]} { timer $update_rate do_record_run }
do_record_check
