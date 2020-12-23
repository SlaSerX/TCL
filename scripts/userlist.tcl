#Da ne se polzvat globalni flags +FB #
#Da ne se add user nakoito nicka mu zapochva s { ili } #

set wwwfile "/var/www/sofia/userlist.html"

set bodytag {<body bgcolor="#EDEDED" text="#006699" link="#006699" vlink="#5493B4" alink="#006699">}

set update_time 5

set update_rate 5

set www_enable 1

set td_a(0) "#DEE3E7"

set td_a(1) "#D1D8DE"

set go_back_url "irc.Lamzo.com UniBG IRC Server - One group to rule them all!"

set bot_admin "dJ_TEDY"

set admin_email "TeodOR@Sellinet.net"

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

bind dcc K dorecord dcc_dorecord
proc dcc_dorecord {hand idx text} {
  switch -glob [clock format [clock seconds] -format %M] {    
    default {
      do_stats 
      putdcc $idx "Updating Webfiles."
      return 1
    }
  }
}

proc do_stats {} {
  global wwwfile bodytag botnick update_time th_a td_a bot_admin admin_email go_back_url 
  foreach statuser [channels] {
        putserv "ping 0"
        set out "<meta http-equiv=\"Refresh\" content=\"[expr $update_time * 60]\">"
        append out "\n<html><head>\n"
        append out "<title>$botnick User File Records</title>\n"
        append out "\n<style type=\"text/css\">"
        append out "body { background-color: #E5E5E5; scrollbar-face-color: #DEE3E7; scrollbar-highlight-color: #FFFFFF; scrollbar-shadow-color: #DEE3E7; scrollbar-3dlight-color: #D1D7DC; scrollbar-arrow-color:  #006699; scrollbar-track-color: #EFEFEF; scrollbar-darkshadow-color: #98AAB1; }"
        append out "  <!-- A:link {text-decoration: none} A:visited {text-decoration: none} A:active {text-decoration: none} A:hover {text-decoration: underline} { Font-family: Arial;    }   -->"
        append out "</style>"
        append out "\n</head>\n"
        append out "\n$bodytag\n"
        append out "\n<div align=\"center\"><font color=\"#999999\" size=\"5\"><i>$botnick User File Records</font></i></div>"
        append out "\n<table width=100% valign=top border=0>\n<caption align=\"left\"><font size=\"2\"><br>"
        append out "\n Last Update : [clock format [clock seconds] -format "%H:%M | %d.%m.%Y "]<br>"
        append out "\n Next Update in $update_time minute(s).<br>" 
        append out "\n Go back to : <a href=\"$go_back_url\" target=\"_self\">$go_back_url</a>" 
        append out "</caption>\n<tr>"
        append out "\n<th align=center background=\"images/cellpic.gif\"><font color=\"#FF9900\" size=2 face=Verdana>#</th>"
        append out "\n<th align=center background=\"images/cellpic.gif\"><font color=\"#FF9900\" size=2 face=Verdana>Nick</th>"
        append out "\n<th align=center background=\"images/cellpic.gif\"><font color=\"#FF9900\" size=2 face=Verdana>Global Flags</th>"
        append out "\n<th align=center background=\"images/cellpic.gif\"><font color=\"#FF9900\" size=2 face=Verdana>Added ...</th>"
        append out "\n<th align=center background=\"images/cellpic.gif\"><font color=\"#FF9900\" size=2 face=Verdana>Comment</th>"
        append out "\n<th align=center background=\"images/cellpic.gif\"><font color=\"#FF9900\" size=2 face=Verdana>Info</th>"
        append out "\n<th align=center background=\"images/cellpic.gif\"><font color=\"#FF9900\" size=2 face=Verdana>E-mail</th>"
        append out "\n</tr>"

        set lista [lrange [sort ""] 0 999]
        set no 0
        foreach i $lista {
          incr no
          set handle [lindex $i 1]
          set flags [matchchanattr $handle ""]
              if {[matchchanattr $handle "+n"]}   {set flags Owner}
              if {[matchchanattr $handle "+m-n"]} {set flags Master}
              if {[matchchanattr $handle "+o-m"]} {set flags Op}                 
              if {[matchchanattr $handle "+b"]}   {set flags Bot} 
              if {[matchchanattr $handle "+t-m"]} {set flags "Bot Master"}
              if {[matchchanattr $handle "+d"]}   {set flags +d}
              if {[matchchanattr $handle "+k"]}   {set flags +dk}
              if {$flags == 1 } {set flags -}
          set added [getuser $handle XTRA Added]
              if {$added == ""} {set added -}
          set comment [getuser $handle COMMENT]
              if {$comment == ""} {set comment -}    
          set info [getuser $handle INFO]
              if {$info == ""}  {set info -}  
          set email [getuser $handle XTRA Email]
              if {$email == ""} {set email -}
          append out "\n<tr>"
          append out "\n<td height=\"18\" align=center bgcolor=\"$td_a(0)\"><font size=1 face=Verdana color=\"#000000\">$no</td>"
          append out "\n<td height=\"18\" align=center bgcolor=\"$td_a(1)\"><font face=Verdana><font size=\"1\">$handle</td>"
          append out "\n<td height=\"18\" align=center bgcolor=\"$td_a(0)\"><font face=Verdana><font size=\"1\">$flags</td>" 
          append out "\n<td height=\"18\" align=center bgcolor=\"$td_a(1)\"><font face=Verdana><font size=\"1\">$added</td>"
          append out "\n<td height=\"18\" align=center bgcolor=\"$td_a(0)\"><font face=Verdana><font size=\"1\">$comment</td>"
          append out "\n<td height=\"18\" align=center bgcolor=\"$td_a(1)\"><font face=Verdana><font size=\"1\">$info</td>"
          append out "\n<td height=\"18\" align=center bgcolor=\"$td_a(0)\"><font face=Verdana><font size=\"1\"><a href=\"mailto:$email\">$email</a></td>"
          append out "\n</tr>"
        }
        append out "\n</table></center>"
        append out "\n<table align=\"center\" width=\"234\" valign=top border=0 cellpadding=0 cellspacing=0><br>"

               set cnt 0 
                 foreach usr [userlist +n] {
                 incr cnt 1 
                  }
               set cnt1 0 
                 foreach usr [userlist +m-n] {
                 incr cnt1 1 
                  }
               set cnt2 0 
                 foreach usr2 [userlist +b-nm] {
                 incr cnt2 1 
                  }
        append out "\n<tr>" 
        append out "\n<td width=\"234\" height=\"19\" valign=\"top\" background=\"images/cellpic.gif\">"
        append out "\n<div align=\"center\"><font color=\"#FF9900\" size=\"2\"><b>Total Users in the bot database [countusers]</b></div>"
        append out "\n</td>"
        append out "\n</tr>"
        append out "\n<tr> "
        append out "\n<tr> " 
        append out "\n<td height=\"19\" valign=\"top\" bgcolor=\"#DEE3E7\">" 
        append out "\n<div align=\"center\"><font size=\"2\"><b>Owner $cnt</b></div>"
        append out "\n</td>"
        append out "\n</tr>"
        append out "\n<tr> "
        append out "\n<td height=\"19\" valign=\"top\" bgcolor=\"#D1D8DE\">" 
        append out "\n<div align=\"center\"><font size=\"2\"><b>Masters $cnt1</b></div>"
        append out "\n</td>"
        append out "\n</tr>"
        append out "\n<tr>" 
        append out "\n<td height=\"19\" valign=\"top\" bgcolor=\"#DEE3E7\">" 
        append out "\n<div align=\"center\"><font size=\"2\"><b>Bots $cnt2</b></div>"
        append out "\n</td>"
        append out "\n</tr>"
        append out "\n</table></center><br>"
        append out "\n<div align=\"center\"><font size=\"1\">Any other questions send to the Admin of this bot <A HREF=\"mailto:$admin_email\">$bot_admin </A></font></div>"
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
do_record_check
putlog "userlist loaded."
