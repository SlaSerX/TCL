##########################################################
###### botnetstats.tcl v1.1 by Lucas <eggy@eggdrop-fr.org> ######
##########################################################

### Namerete http://link.kum/botnet.html i go smenete za da vi refreshwa stranicata prez 10 min ###

# Usage of this script must be made according to that licence :
# http://www.eggdrop-fr.org/licence.html

#####################################################
###                 CONFIGURATION                 ###
#####################################################

# Enable reports by mail (0/1)

set bs_reports_email 1

# Enable HTML reports (0/1)

set bs_report_html 1

# (If you set both variables to 0, why are you using this script ?!?)

# Tell botnet users that I am generating web pages on the botnet
set bs_announce_html 1

# Name of the botnet (if no, leave empty)
set bsbotnetname "от HDMI @ UniBG"

# Language of the output (english = 0 ; french = 1)
set bslang 0

#####################################################
###         EMAIL REPORTS CONFIGURATION           ###
#####################################################

# To send a mail : .sendreport

#/!\ This script uses sendmail to send the mail. If you don't have it,
# the script will not work.
# Path to sendmail
set bssendmailpath "/usr/sbin/sendmail"

# email address of those who will receive the stats
set bsaddressto "Paco <paco@gsmbg.org>"

# email address the bot uses to send the mails
set bsaddressfrom "Botnet <noreply@botnet.net>"

if $bs_reports_email {
# When to send the mail (look at the bind time syntax)
# this sends the mail at midnight every day (or night :p)
bind time - "00 00 * * *" bstime:sendmail
}

# Number of bots per line in the mail
set bsbotsperline 7

#####################################################
###         HTML REPORTS CONFIGURATION            ###
#####################################################

# Where to create to web page :
set bsstatslocation "/putq/do/papkata/kudeto/shte/se/prawi/faila.html"

if $bs_report_html {
# When to update the web page (look at the bind time syntax)
# This update the web page every 10 minutes
bind time - "10 * * * *" bsmakehtml
bind time - "20 * * * *" bsmakehtml
bind time - "30 * * * *" bsmakehtml
bind time - "40 * * * *" bsmakehtml
bind time - "50 * * * *" bsmakehtml
bind time - "00 * * * *" bsmakehtml
}

bind pub N !updatebotnet bsmakehtml

##### HTML #####

##  body's color
set bshtmlcolor(bodybg) #000000

## Text's color
set bshtmlcolor(bodytxt) #ffffff

## links' color
set bshtmlcolor(bodylink) #0000FF

## Visited links' color
set bshtmlcolor(bodyvlink) #FF0000

## Active link's color
set bshtmlcolor(bodyalink) #33CC33

## Borders' width
#  Ex : set border 1
set bshtmlcolor(border) 1

## Light borders' color
set bshtmlcolor(bordercolorlight) #9b171b

## Dark borders' color
set bshtmlcolor(bordercolordark) #000000

## Background of the first lines of tables
set bshtmlcolor(borderbg) #000000

## Color of border
set bshtmlcolor(bordercolor) #FF0000

## Background of the other lines of tables
set bshtmlcolor(lborderbg) #000000

#####################################################
###      BOTNET ANNOUNCEMENT CONFIGURATION        ###
#####################################################

# URL where the stats are located
set bsstatsurl "http://gsmbg.org/stats"

if $bs_announce_html&&$bs_report_html {
# When to announce on the botnet (look at the bind time syntax)
# this sends the mail at 20pm every evening
bind time - "00 10 * * *" bstime:botnetell
}

#####################################################
### PLEASE DO NOT MODIFY ANYTHING BELOW THIS LINE ###
#####################################################

# Version du script
set bsver 1.1

#
## INTERNAL FUNCTIONS
#

proc bst { index } {
global bstextes bslang
   if [info exists bstextes(l${bslang}i${index})] {
      return $bstextes(l${bslang}i${index})
   } else {
      putlog "Botnetstats : Missing Language entry ! lang = $bslang ; index = $index . Please report this bug to the script's author !"
      return "ERROR"
   }
}

proc bsgetversion { bot } {
   set blist [botlist]
   set index [lsearch [string tolower $blist] [string tolower [list $bot *]]]
   if $index!=-1 {
      return [lindex [lindex $blist $index] 2]
   } else {
      return -1
   }
}

proc bsremovezero { number } {
   if ![string compare [string index $number 0] "0"] {
      return [string index $number 1]
   } else {
      return $number
   }
}

proc bsgettextbranch { numbranch } {
   if $numbranch==1031 {
      return [bst 2]
   } elseif $numbranch==1032 {
      return [bst 3]
   } else {
      if [string length $numbranch]==3 {
         return "eggdrop [string index $numbranch 0].[bsremovezero [string range $numbranch 1 2]]"
      } else {
         return "[bst 4] $numbranch"
      }
   }
}

proc bsgettextversion { numversion } {
   if [string length $numversion]==5 {
      return "eggdrop [string index $numversion 0].[bsremovezero [string range $numversion 1 2]].[bsremovezero [string range $numversion 3 4]]"
   } else {
      return "[bst 5] $numversion"
   }
}

proc bssearchbot { bot } {
   global bsseenbots
   return [lsearch -exact [string tolower $bsseenbots] [string tolower $bot]]
}

proc bsspaces { number } {
   set spc ""
   while {[string length $spc]<$number} {
      set spc "$spc "
   }
   return $spc
}

proc bsdispbotlist { sendmail liste } {
   global bsbotsperline
   set liste [lsort -dictionary $liste]
   set listlength [llength $liste]
   for {
      set i 0
      set output ""
      set nbbotsline 0
   } { $i<$listlength } {
      incr i
   } {
      incr nbbotsline
      set output "$output [lindex [lindex $liste $i] 0][bsspaces [expr 9 - [string length [lindex [lindex $liste $i] 0]]]]"
      if $nbbotsline==$bsbotsperline {
         puts $sendmail $output
         set nbbotsline 0
         set output ""
      }
   }  
   if [llength $output] {
      puts $sendmail $output
   }
}

proc bsdispbotlisthtml { file liste } {
   global bshtmlcolor
   set liste [lsort -dictionary $liste]
   set listlength [llength $liste]
   for {
      set i 0
      set output "<tr bgcolor=$bshtmlcolor(lborderbg)>"
      set nbbotsline 0
   } { $i<$listlength } {
      incr i
   } {
      incr nbbotsline
      set output "$output <td width=100>[lindex [lindex $liste $i] 0]</td>"
      if $nbbotsline==6 {
         puts $file "$output </TR>"
         set nbbotsline 0
         set output "<tr bgcolor=$bshtmlcolor(lborderbg)>"
      }
   }  
   if $nbbotsline {
      puts $file "$output <td colspan=[expr 6-$nbbotsline]>&nbsp;</TD></tr>"
   }
}

#
## FONCTIONS D'INTERACTION AVEC EVENEMENTS SUR LE BOTNET
#

bind link - * bsbotnet:link
proc bsbotnet:link { bot hubbot } {
   global bsseenbots bshub bslinks bsislinked bsnbbots bsmaxnbbots bsmaxnbbotstime bsbotversion bsabsmaxnbbots bsabsmaxnbbotstime
   if [bssearchbot $bot]==-1 {
      lappend bsseenbots $bot
   }
   set bshub([string tolower $bot]) $hubbot
   if [info exists bslinks([string tolower $bot])] {
      incr bslinks([string tolower $bot])
   } else {
      set bslinks([string tolower $bot]) 1
   }
   set bsislinked([string tolower $bot]) 1
   set bsbotversion([string tolower $bot]) [bsgetversion $bot]
   incr bsnbbots
   if $bsnbbots>$bsmaxnbbots { 
      set bsmaxnbbots $bsnbbots
      set bsmaxnbbotstime [unixtime]
      if $bsmaxnbbots>$bsabsmaxnbbots {
         set bsabsmaxnbbots $bsmaxnbbots
         set bsabsmaxnbbotstime [unixtime]
      }
   }
}

bind disc - * bsbotnet:delnk
proc bsbotnet:delnk { bot } {
   global bsseenbots bshub bslinks bsislinked bsnbbots
   if [bssearchbot $bot]==-1 {
      lappend bsseenbots $bot
      set bshub([string tolower $bot]) "unknown!"
      putlog "WARNING ! $bot just delinked, but wasn't linked !"
   }
   if [info exists bslinks([string tolower $bot])] {
      incr bslinks([string tolower $bot])
   } else {
      set bslinks([string tolower $bot]) 1
   }
   set bsislinked([string tolower $bot]) 0
   incr bsnbbots -1
}

#
## FONCTIONS DE SORTIE DES RAPPORTS
#

proc bstime:botnetell {min hour day month year} {
global bsstatsurl
dccbroadcast "[bst 40] $bsstatsurl !"
}

proc bstime:sendmail { min hour day month year } {
   bssendmail
}

bind dcc n sendreport bsdcc:sendreport
proc bsdcc:sendreport { handle idx arguments } {
   bssendmail
   return 1
}

proc bsddcclisthtml { file liste } {
   global bshtmlcolor
   set liste [lsort -dictionary $liste]
   set listlength [llength $liste]
   for {
      set i 0
      set output "<tr bgcolor=$bshtmlcolor(lborderbg)>"
      set nbbotsline 0
   } { $i<$listlength } {
      incr i
   } {
      incr nbbotsline
      set output "$output <td width=100>[lindex [lindex $liste $i] 0]</td>"
      if $nbbotsline==6 {
         puts $file "$output </TR>"
         set nbbotsline 0
         set output "<tr bgcolor=$bshtmlcolor(lborderbg)>"
      }
   }
   if $nbbotsline {
      puts $file "$output <td colspan=[expr 6-$nbbotsline]>&nbsp;</TD></tr>"
   }
}

proc bssendmail { } {
   global bsseenbots bsnbbots bsmaxnbbots bsmaxnbbotstime bshub bsislinked bsbotversion bslinks bsabsmaxnbbots bsabsmaxnbbotstime bsbotnetname
   global bssendmailpath bsaddressto bsaddressfrom bsver bs_reports_email
   if !$bs_reports_email { return 0 }
   set linkedbots ""
   set unlinkedbots ""
   set toplink ""
   set hubs ""
   set exactvers ""
   set branchvers ""
   foreach bot $bsseenbots {
      if $bsislinked([string tolower $bot]) {
         lappend linkedbots $bot
      } else {
         lappend unlinkedbots $bot
      }
      lappend toplink [list $bslinks([string tolower $bot]) $bot]
      
      set sresult [lsearch $hubs [list * $bshub([string tolower $bot])]]
      if $sresult!=-1 {
         set hubs [lreplace $hubs $sresult $sresult [list [expr [lindex [lindex $hubs $sresult] 0] + 1] $bshub([string tolower $bot])]]
      } else {
         lappend hubs [list 1 $bshub([string tolower $bot])]
      }
      set exactver [string range $bsbotversion([string tolower $bot]) 0 4]
      set branchver [string range $bsbotversion([string tolower $bot]) 0 2]
      if $branchver==103 {
         if $exactver<10324 {
            set branchver 1031
         } else {
            set branchver 1032
         }
      }
      set sresult [lsearch $exactvers [list * $exactver]]
      if $sresult!=-1 {
         set exactvers [lreplace $exactvers $sresult $sresult [list [expr [lindex [lindex $exactvers $sresult] 0] + 1] $exactver]]
      } else {
         lappend exactvers [list 1 $exactver]
      }
      set sresult [lsearch $branchvers [list * $branchver]]
      if $sresult!=-1 {
         set branchvers [lreplace $branchvers $sresult $sresult [list [expr [lindex [lindex $branchvers $sresult] 0] + 1] $branchver]]
      } else {
         lappend branchvers [list 1 $branchver]
      }

   }
   set toplink [lsort -index 0 -decreasing -integer $toplink]
   set hubs [lsort -index 0 -decreasing -integer $hubs]
   set exactvers [lsort -index 0 -decreasing -integer $exactvers]
   set branchvers [lsort -index 1 $branchvers]
   
   set sendmail [open "|$bssendmailpath -t" w]
   puts $sendmail "To: $bsaddressto"
   puts $sendmail "From: $bsaddressfrom"
   if [string length $bsbotnetname] {
      puts $sendmail "Subject: [bst 6] : $bsbotnetname"
   } else {
      puts $sendmail "Subject: [bst 6]"
   }
   puts $sendmail ""
   puts $sendmail "            --- B o t n e t S t a t s ---"
   if [string length $bsbotnetname] {
      puts $sendmail ""
      puts $sendmail "[bst 7] $bsbotnetname"
   }
   puts $sendmail ""
   puts $sendmail "1. [bst 8]"
   puts $sendmail "[bst 9] : $bsabsmaxnbbots ([ctime $bsabsmaxnbbotstime])"
   puts $sendmail "[bst 10] : $bsmaxnbbots ([ctime $bsmaxnbbotstime])"
   puts $sendmail "[bst 11] : $bsnbbots"
   puts $sendmail ""
   puts $sendmail "2. [bst 12]"
   if [llength $linkedbots]==0 {
      puts $sendmail [bst 14]
   } elseif [llength $linkedbots]==1 {
      puts $sendmail "[bst 13] :"
      bsdispbotlist $sendmail $linkedbots
   } else {
      puts $sendmail "[bst 17] :"
      bsdispbotlist $sendmail $linkedbots
   }
   puts $sendmail ""
   if [llength $unlinkedbots]==0 {
      puts $sendmail [bst 15]
   } elseif [llength $unlinkedbots]==1 {
      puts $sendmail "[bst 16] :"   
      bsdispbotlist $sendmail $unlinkedbots
   } else {
      puts $sendmail "[bst 18] :"   
      bsdispbotlist $sendmail $unlinkedbots
   }
   puts $sendmail ""
   puts $sendmail "3. [bst 19]"
   puts $sendmail [bst 20]
   for { set i 0 } { $i<10&&$i<[llength $toplink] } { incr i } {
      puts $sendmail "[expr $i + 1]. [lindex [lindex $toplink $i] 1] - [lindex [lindex $toplink $i] 0]"
   }
   puts $sendmail ""
   puts $sendmail "4. [bst 21]"
   puts $sendmail [bst 22]
   for { set i 0 } { $i<10&&$i<[llength $hubs] } { incr i } {
      puts $sendmail "[expr $i + 1]. [lindex [lindex $hubs $i] 1] - [lindex [lindex $hubs $i] 0]"
   }
   puts $sendmail ""
   puts $sendmail "5. [bst 23]"
   puts $sendmail "5.1. [bst 24]"
   foreach element $branchvers {
      if [lindex $element 0]==1 {
         puts $sendmail "[lindex $element 0] [bst 26] [bsgettextbranch [lindex $element 1]]"
      } else {
         puts $sendmail "[lindex $element 0] [bst 27] [bsgettextbranch [lindex $element 1]]"
      }
   }
   puts $sendmail ""
   puts $sendmail "5.2. [bst 25]"
   foreach element $exactvers {
      if [lindex $element 0]==1 {
         puts $sendmail "[bsgettextversion [lindex $element 1]] : [lindex $element 0] bot"
      } else {
         puts $sendmail "[bsgettextversion [lindex $element 1]] : [lindex $element 0] bots"
      }
   }
   puts $sendmail ""
   puts $sendmail [bst 28]
   puts $sendmail "."
   close $sendmail
   # RAZ Variables
   bsrazvars
}

proc bsmakehtml {min hour day month year} {
   global bsseenbots bsnbbots bsmaxnbbots bsmaxnbbotstime bshub bsislinked bsbotversion bslinks bsabsmaxnbbots bsabsmaxnbbotstime bsbotnetname
   global bsstatslocation bshtmlcolor bsver bs_report_html bs_reports_email
   if !$bs_report_html { return 0 }
   set linkedbots ""
   set unlinkedbots ""
   set toplink ""
   set hubs ""
   set exactvers ""
   set branchvers ""
   set dccusers ""
   foreach user [whom *] {
         set usera [lindex $user 0]
         lappend dccusers $usera
   }
   foreach bot $bsseenbots {
      if $bsislinked([string tolower $bot]) {
         lappend linkedbots $bot
      } else {
         lappend unlinkedbots $bot
      }
      lappend toplink [list $bslinks([string tolower $bot]) $bot]
      
      set sresult [lsearch $hubs [list * $bshub([string tolower $bot])]]
      if $sresult!=-1 {
         set hubs [lreplace $hubs $sresult $sresult [list [expr [lindex [lindex $hubs $sresult] 0] + 1] $bshub([string tolower $bot])]]
      } else {
         lappend hubs [list 1 $bshub([string tolower $bot])]
      }
      set exactver [string range $bsbotversion([string tolower $bot]) 0 4]
      set branchver [string range $bsbotversion([string tolower $bot]) 0 2]
      if $branchver==103 {
         if $exactver<10324 {
            set branchver 1031
         } else {
            set branchver 1032
         }
      }
      set sresult [lsearch $exactvers [list * $exactver]]
      if $sresult!=-1 {
         set exactvers [lreplace $exactvers $sresult $sresult [list [expr [lindex [lindex $exactvers $sresult] 0] + 1] $exactver]]
      } else {
         lappend exactvers [list 1 $exactver]
      }
      set sresult [lsearch $branchvers [list * $branchver]]
      if $sresult!=-1 {
         set branchvers [lreplace $branchvers $sresult $sresult [list [expr [lindex [lindex $branchvers $sresult] 0] + 1] $branchver]]
      } else {
         lappend branchvers [list 1 $branchver]
      }

   }
   set toplink [lsort -index 0 -decreasing -integer $toplink]
   set hubs [lsort -index 0 -decreasing -integer $hubs]
   set exactvers [lsort -index 1 -increasing -integer $exactvers]
   set branchvers [lsort -index 1 $branchvers]

   set file [open "$bsstatslocation" w]
   puts $file [bst 29]
   puts $file "<html>"
   puts $file "<head>"
   puts $file "<title>Ботнет Статистика от irc.GSMBG.org</title>"
   puts $file "<meta http-equiv=\"content-type\" content=\"text/html; charset=windows-1251\" />"
   puts $file "<meta http-equiv=\"refresh\" content=\"60;URL=#\">"
   puts $file "<STYLE TYPE=\"text/css\">"
   puts $file "BODY { font-family : Tahoma;"
   puts $file " font-size : small}"
   puts $file "H1 { font-family : Tahoma;"
   puts $file "font-size : small;"
   puts $file "text-align : center}"
   puts $file "TD { font-family : Tahoma;"
   puts $file "font-size : small;"
   puts $file "text-align : center}"
   puts $file "</STYLE>"
   puts $file "</head>"
   puts $file "<body bgcolor=\"#000000\" text=\"#CCCCCC\">"
   puts $file "<div align=center>"
   puts $file "<img src=\"botnet.gif\"><br><br>"
   if [string length $bsbotnetname] {
      puts $file "<H2>[bst 7] $bsbotnetname</H2>"
	  puts $file "<h4>Страницата ще се презареди автоматично</h4>"
   }
   puts $file "<H1>1. [bst 8]</H1>"
   puts $file "<table width=500 border=$bshtmlcolor(border) bordercolorlight=$bshtmlcolor(bordercolorlight) bordercolordark=$bshtmlcolor(bordercolordark) bgcolor=$bshtmlcolor(borderbg) bordercolor=$bshtmlcolor(bordercolor)>"
   puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)>" 
   puts $file "<td width=280>[bst 9]</td>"
   puts $file "<td width=50>$bsabsmaxnbbots</td>"
   puts $file "<td width=170>([ctime $bsmaxnbbotstime])</td>"
   puts $file "</tr>"
   if $bs_reports_email {
      puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)>"
      puts $file "<td width=280>[bst 10]</td>"
      puts $file "<td width=50>$bsmaxnbbots</td>"
      puts $file "<td width=170>([ctime $bsmaxnbbotstime])</td>"
      puts $file "</tr>"
   }
   puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)>"
   puts $file "<td width=280>[bst 11]</td>"
   puts $file "<td width=50>$bsnbbots</td>"
   puts $file "<td width=170>([ctime [unixtime]])</td>"
   puts $file "</tr>"
   puts $file "</table>"
   puts $file "<H1>2. [bst 12]</H1>"
   puts $file "<table cols=6 width=600 border=$bshtmlcolor(border) bordercolorlight=$bshtmlcolor(bordercolorlight) bordercolordark=$bshtmlcolor(bordercolordark) bgcolor=$bshtmlcolor(borderbg) bordercolor=$bshtmlcolor(bordercolor)>"
   puts $file "<tr bgcolor=$bshtmlcolor(borderbg)>" 
   puts $file "<td colspan=6>[bst 17]</td>"
   puts $file "</tr>"
   if [llength $linkedbots]==0 {
      puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)><td colspan=6>[bst 14]</td></tr>"
   } else {
      bsdispbotlisthtml $file $linkedbots
   }
   puts $file "<tr bgcolor=$bshtmlcolor(borderbg)>" 
   puts $file "<td colspan=6>[bst 18]</td>"
   puts $file "</tr>"
   if [llength $unlinkedbots]==0 {
      puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)><td colspan=6>[bst 15]</td></tr>"
   } else {
      bsdispbotlisthtml $file $unlinkedbots
   }
puts $file "    </table>" 
   puts $file "<H1>3. Потребители в partyline на ботовете</H1>"
   puts $file "<table cols=6 width=600 border=$bshtmlcolor(border) bordercolorlight=$bshtmlcolor(bordercolorlight) bordercolordark=$bshtmlcolor(bordercolordark) bgcolor=$bshtmlcolor(borderbg) bordercolor=$bshtmlcolor(bordercolor)>"
   puts $file "<tr bgcolor=$bshtmlcolor(borderbg)>"
   puts $file "<td colspan=6>Потребители</td>"
   puts $file "</tr>"
   if [llength $dccusers]==0 {
      puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)><td colspan=6>Няма нито един потребител в partyline</td></tr>"
   } else {
      bsddcclisthtml $file $dccusers
   }
   puts $file "  </table>"
   puts $file "<H1>4. [bst 19]</H1>"
   puts $file "<table cols=3 width=180 border=$bshtmlcolor(border) bordercolorlight=$bshtmlcolor(bordercolorlight) bordercolordark=$bshtmlcolor(bordercolordark) bgcolor=$bshtmlcolor(borderbg) bordercolor=$bshtmlcolor(bordercolor)>"
   puts $file "<tr><td width=25>[bst 30]</td><td width=75>[bst 31]</td><td width=30>[bst 32]</td></tr>"
   for { set i 0 } { $i<10&&$i<[llength $toplink] } { incr i } {
      puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)><td width=25>[expr $i + 1].</TD><TD width=75>[lindex [lindex $toplink $i] 1]</TD><TD width=30>[lindex [lindex $toplink $i] 0]</TD></TR>"
   }
   puts $file "</table>"
   puts $file "<H1>5. [bst 21]</H1>"
   puts $file "<table cols=3 width=180 border=$bshtmlcolor(border) bordercolorlight=$bshtmlcolor(bordercolorlight) bordercolordark=$bshtmlcolor(bordercolordark) bgcolor=$bshtmlcolor(borderbg) bordercolor=$bshtmlcolor(bordercolor)>"
   puts $file "<tr><td width=25>[bst 30]</td><td width=75>[bst 33]</td><td width=30>[bst 34]</td></tr>"
   for { set i 0 } { $i<10&&$i<[llength $hubs] } { incr i } {
      puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)><td width=25>[expr $i + 1].</TD><TD width=75>[lindex [lindex $hubs $i] 1]</TD><TD width=30>[lindex [lindex $hubs $i] 0]</TD></TR>"
   }
   puts $file "</table>"
   puts $file "<H1>6. [bst 23]</H1>"
   puts $file "<H1>6.1. [bst 24]</H1>"
   puts $file "<table cols=3 width=600 border=$bshtmlcolor(border) bordercolorlight=$bshtmlcolor(bordercolorlight) bordercolordark=$bshtmlcolor(bordercolordark) bgcolor=$bshtmlcolor(borderbg) bordercolor=$bshtmlcolor(bordercolor)>"
   puts $file "<tr><td width=300>[bst 35]</td><td width=275>[bst 36]</td><td width=25>[bst 34]</td></tr>"
   set maxbranchvers 0
   foreach element $branchvers {
      if $maxbranchvers<[lindex $element 0] { set maxbranchvers [lindex $element 0] }
   }
   foreach element $branchvers {
      puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)><td width=300><div align=left>[bsgettextbranch [lindex $element 1]]</div></TD><td width=275><DIV align=left><img src=\"barre.gif\" height=10 width=[expr [lindex $element 0]*275/$maxbranchvers]</div></TD><td width=25>[lindex $element 0]</td></tr>"
   }
   puts $file "</table>"   
   puts $file "<H1>6.2. [bst 25]</H1>"
   puts $file "<table cols=3 width=600 border=$bshtmlcolor(border) bordercolorlight=$bshtmlcolor(bordercolorlight) bordercolordark=$bshtmlcolor(bordercolordark) bgcolor=$bshtmlcolor(borderbg) bordercolor=$bshtmlcolor(bordercolor)>"
   puts $file "<tr><td width=130>[bst 37]</td><td width=445>[bst 36]</td><td width=25>[bst 34]</td></tr>"
   set maxexactvers 0
   foreach element $exactvers {
      if $maxexactvers<[lindex $element 0] { set maxexactvers [lindex $element 0] }
   }
   foreach element $exactvers {
      if [string length [lindex $element 1]]==5 {
         if [info exists maxversbranch([string range [lindex $element 1] 0 2 ])] {
            if [lindex $element 1]>$maxversbranch([string range [lindex $element 1] 0 2 ]) {
               set maxversbranch([string range [lindex $element 1] 0 2 ]) [lindex $element 1]
            }
         } else {
            set maxversbranch([string range [lindex $element 1] 0 2 ]) [lindex $element 1]
         }
      }
   }
   set toggle 0
   foreach element $exactvers {
      if [string length [lindex $element 1]]==5 {
         if [info exists maxversbranch([string range [lindex $element 1] 0 2 ])] {
            if [lindex $element 1]==$maxversbranch([string range [lindex $element 1] 0 2 ]) {
               puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)><td width=130><div align=left><FONT COLOR=\"red\">[bsgettextversion [lindex $element 1]]</FONT></div></TD><td width=445><DIV align=left><img src=\"barre.gif\" height=10 width=[expr [lindex $element 0]*445/$maxexactvers]</div></TD><td width=25>[lindex $element 0]</td></tr>"
               set toggle 1
            }
         }
      }
      if !$toggle {
         puts $file "<tr bgcolor=$bshtmlcolor(lborderbg)><td width=130><div align=left>[bsgettextversion [lindex $element 1]]</div></TD><td width=445><DIV align=left><img src=\"barre.gif\" height=10 width=[expr [lindex $element 0]*445/$maxexactvers]</div></TD><td width=25>[lindex $element 0]</td></tr>"
      }
      set toggle 0
   }
   puts $file "<TR><TD colspan=3 align=center>[bst 41]</TD></TR>"
   puts $file "</table>"   

   puts $file "<h1>Следващото обновяване на данните ще е в: [lindex [ctime [unixtime]] 3]</h1>"
   puts $file [bst 39]
   puts $file "</div>"
   puts $file "</body>"
   puts $file "</html>"
   close $file
}

#
## FONCTION DE RAZ DES VARS
#

proc bsrazvars { } {
   global bsseenbots bsnbbots bsmaxnbbots bsmaxnbbotstime bshub bsislinked bsbotversion bslinks
   set bsseenbots [bots]
   set bsnbbots [llength $bsseenbots]
   set bsmaxnbbots $bsnbbots
   set bsmaxnbbotstime [unixtime]
   foreach element [botlist] {
      set bshub([string tolower [lindex $element 0]]) [lindex $element 1]
      set bsislinked([string tolower [lindex $element 0]]) 1
      set bsbotversion([string tolower [lindex $element 0]]) [lindex $element 2]
      set bslinks([string tolower [lindex $element 0]]) 0
   }
}

#
## INITIALISATION DU SCRIPT
#

if !([info exists bsseenbots]&&[info exists bnbbots]&&[info exists bsmaxnbbots]&&[info exists bsabsmaxnbbots]) {
   bsrazvars
   set bsabsmaxnbbots $bsmaxnbbots
   set bsabsmaxnbbotstime [unixtime]
}

#
## DONNEES DE LANGUES
#

set bstextes(l0i1) ""
set bstextes(l0i2) "eggdrop 1.3 - Original Dev Team (1.3.0 - 1.3.23)"
set bstextes(l0i3) "eggdrop 1.3 - New Dev Team (1.3.24 and higher)"
set bstextes(l0i4) "an unknown branch :"
set bstextes(l0i5) "a bogus eggdrop :"
set bstextes(l0i6) "Botnetstats.tcl output"
set bstextes(l0i7) "Статистика"
set bstextes(l0i8) "Брой ботове"
set bstextes(l0i9) "Максимален брой ботове в ботнета"
set bstextes(l0i10) "Максимален брой ботове преди последния рапорт"
set bstextes(l0i11) "Брой ботове в момента"
set bstextes(l0i12) "Закачени и Разкачени ботове"
set bstextes(l0i13) "Закачен бот"
set bstextes(l0i17) "Закачени ботове"
set bstextes(l0i14) "Няма закачени ботове"
set bstextes(l0i15) "Няма разкачени ботове"
set bstextes(l0i16) "Разкачен бот"
set bstextes(l0i18) "Разкачени ботове"
set bstextes(l0i19) "По-нестабилни ботове"
set bstextes(l0i20) "ranking / bot / number of links/delinks"
set bstextes(l0i21) "Най-големи хъбове"
set bstextes(l0i22) "ranking / bot / number of leaves"
set bstextes(l0i23) "Версия ползвана от ботовете във ботнета"
set bstextes(l0i24) "Най-ползвана версия в бранша"
set bstextes(l0i25) "Ползвана версия"
set bstextes(l0i26) "bot uses"
set bstextes(l0i27) "bots use"
set bstextes(l0i28) ""
set bstextes(l0i29) "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">"
set bstextes(l0i30) "Ранг"
set bstextes(l0i31) "Ник на бота"
set bstextes(l0i32) "Сплитове"
set bstextes(l0i33) "Никове на хъб ботове"
set bstextes(l0i34) "Брой ботове"
set bstextes(l0i35) "Версия"
set bstextes(l0i36) "Графика"
set bstextes(l0i37) "Версия"
set bstextes(l0i38) ""
set bstextes(l0i39) ""
set bstextes(l0i40) "Статистика на ботнета:"
set bstextes(l0i41) "<font color=\"red\">В червено е</FONT> последната стабилна версия"

set bstextes(l1i1) "Chargй : BotnetStats.tcl v.$bsver par Lucas <lucas@eggdrop-fr.org>"
set bstextes(l1i2) "eggdrop 1.3 - Equipe Originale (1.3.0 - 1.3.23)"
set bstextes(l1i3) "eggdrop 1.3 - Nouvelle Equipe (1.3.24 et suivants)"
set bstextes(l1i4) "une branche inconnue :"
set bstextes(l1i5) "un eggdrop boguй :"
set bstextes(l1i6) "rapport de Botnetstats.tcl"
set bstextes(l1i7) "Statistiques pour"
set bstextes(l1i8) "Nombre de bots"
set bstextes(l1i9) "Nombre maximum absolu de bots"
set bstextes(l1i10) "Nombre maximum de bots depuis le dernier rapport"
set bstextes(l1i11) "Nombre actuel de bots"
set bstextes(l1i12) "Bots linkйs et dйlinkйs"
set bstextes(l1i13) "Bot linkй"
set bstextes(l1i17) "Bots linkйs"
set bstextes(l1i14) "Pas de bots linkйs"
set bstextes(l1i15) "Pas de bots dйlinkйs"
set bstextes(l1i16) "Bot dйlinkй"
set bstextes(l1i18) "Bots dйlinkйs"
set bstextes(l1i19) "Bots les plus instables"
set bstextes(l1i20) "classement / bot / nombre de links/dйlinks"
set bstextes(l1i21) "Plus grand HUB"
set bstextes(l1i22) "classement / bot / nombre de bots linkйs"
set bstextes(l1i23) "Utilisation des versions de l'Eggdrop"
set bstextes(l1i24) "Utilisation des branches"
set bstextes(l1i25) "Utilisation des versions"
set bstextes(l1i26) "bot utilise"
set bstextes(l1i27) "bots utilisent"
set bstextes(l1i28) "BotnetStats.tcl v.1.3.4 linkйs et dйlinkйs"
set bstextes(l1i13) "Bot linkй"
set bstextes(l1i17) "Bots linkйs"
set bstextes(l1i14) "Pas de bots linkйs"
set bstextes(l1i15) "Pas de bots dйlinkйs"
set bstextes(l1i16) "Bot dйlinkй"
set bstextes(l1i18) "Bots dйlinkйs"
set bstextes(l1i19) "Bots les plus instables"
set bstextes(l1i20) "classement / bot / nombre de links/dйlinks"
set bstextes(l1i21) "Plus grand HUB"
set bstextes(l1i22) "classement / bot / nombre de bots linkйs"
set bstextes(l1i23) "Utilisation des versions de l'Eggdrop"
set bstextes(l1i24) "Utilisation des branches"
set bstextes(l1i25) "Utilisation des versions"
set bstextes(l1i26) "bot utilise"
set bstextes(l1i27) "bots utilisent"
set bstextes(l1i28) "BotnetStats.tcl v.$bsver - Http://www.eggdrop-fr.org - par Lucas"
set bstextes(l1i29) "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//FR\">"
set bstextes(l1i30) "Class."
set bstextes(l1i31) "Nick du bot"
set bstextes(l1i32) "Splits"
set bstextes(l1i33) "Nick du Hub"
set bstextes(l1i34) "Bots"
set bstextes(l1i35) "Branche"
set bstextes(l1i36) "Graphique"
set bstextes(l1i37) "Version"
set bstextes(l1i38) "Derniиre mise а jour"
set bstextes(l1i39) ""
set bstextes(l1i40) "Bonjour ! je gйnиre des statistiques sur ce botnet. Jetez un coup d'oeil sur"
set bstextes(l1i41) "<font color=\"red\">rouge : </FONT>Derniиre version de chaque branche"

putlog "Инсталиран: botnet.tcl"

### HISTORY ###
##
# v1.1 : 05/06/2000 : now display reports in several languages, announce the stats page on the botnet and display in red the last version of each branch.
# v1.0 : 02/06/2000 : First release. A few things based on botnetlog.tcl by NESS (NESS@IANS.Be (as she wants to write her email address :p).
##
### HISTORY ###
