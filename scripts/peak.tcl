### Thanks To:
# slann@EFNet <slann@bigfoot.com> for the timeago proc, which is really from seen.tcl by Ernst, which is really by robey.

bind join - * join:peak
proc join:peak {nick host hand chan} {
   set curnum [llength [chanlist $chan]]
   set peak [getpeak $chan]
   set lastmax [lindex $peak 0]
   if {$curnum > $lastmax} {
		if {$lastmax} {
#		puthelp "PRIVMSG $chan :Nov maksimalen broi potrebiteli! (\002$curnum\002)  Posleden zapis predi ... [timeago [lindex $peak 1]] " 
}
      return [setpeak $chan $curnum [unixtime]]
   }
}

# Loads the peak data from file if it's not already in memory and returns the data:
proc getpeak {chan} { global peak
   set chan [string tolower $chan]
   if {[info exists peak($chan)]} {
      set lastmax [lindex $peak($chan) 0]
      set lastdate [lindex $peak($chan) 1]
   } else {
      set fid [open "peak.$chan.txt" "RDONLY CREAT"]
      set lastmax "[gets $fid]"
      if {$lastmax == ""} { set lastmax 0 }
      set lastdate "[gets $fid]"
      if {$lastdate == ""} { set lastdate [unixtime] }
      set peak($chan) "$lastmax $lastdate"
      close $fid
   }
   return "$lastmax $lastdate"
}

# Sets peak data to file:
proc setpeak {chan curnum unixtime} { global peak
   set chan [string tolower $chan]
   set peak($chan) "$curnum $unixtime"
   set fid [open "peak.$chan.txt" "WRONLY CREAT"]
   puts $fid $curnum
   puts $fid $unixtime
   close $fid
}

# provides the !peak public command:
bind pub n|n !peak pub:peak
proc pub:peak {nick host hand chan arg} { set peak [getpeak $chan]
   #putcmdlog "<$nick@$chan> !$hand! peak"
   puthelp "PRIVMSG $chan :Най-много посетители: [lindex $peak 0] (Преди: [timeago [lindex $peak 1]])"
}

###------------ misc by slann <slann@bigfoot.com> -----------###
###------------------------ time ago ------------------------###
proc timeago {lasttime} {
  set totalyear [expr [unixtime] - $lasttime]
  if {$totalyear >= 31536000} {
    set yearsfull [expr $totalyear/31536000]
    set years [expr int($yearsfull)]
    set yearssub [expr 31536000*$years]
    set totalday [expr $totalyear - $yearssub]
  }
  if {$totalyear < 31536000} {
    set totalday $totalyear
    set years 0
  }
  if {$totalday >= 86400} {
    set daysfull [expr $totalday/86400]
    set days [expr int($daysfull)]
    set dayssub [expr 86400*$days]
    set totalhour 0
  }
  if {$totalday < 86400} {
    set totalhour $totalday
    set days 0
  }
  if {$totalhour >= 3600} {
    set hoursfull [expr $totalhour/3600]
    set hours [expr int($hoursfull)]
    set hourssub [expr 3600*$hours]
    set totalmin [expr $totalhour - $hourssub]
     if {$totalhour >= 14400} { set totalmin 0 }
   }
  if {$totalhour < 3600} {
    set totalmin $totalhour
    set hours 0
  }
  if {$totalmin > 60} {
    set minsfull [expr $totalmin/60]
    set mins [expr int($minsfull)]
    set minssub [expr 60*$mins]
    set secs 0
  }
  if {$totalmin < 60} {
    set secs $totalmin
    set mins 0
  }
  if {$years < 1} {set yearstext ""} elseif {$years == 1} {set yearstext "$years година, "} {set yearstext "$years години, "}
  if {$days < 1} {set daystext ""} elseif {$days == 1} {set daystext "$days ден, "} {set daystext "$days дни, "}
  if {$hours < 1} {set hourstext ""} elseif {$hours == 1} {set hourstext "$hours час, "} {set hourstext "$hours часа, "}
  if {$mins < 1} {set minstext ""} elseif {$mins == 1} {set minstext "$mins минута"} {set minstext "$mins минути"}
  if {$secs < 1} {set secstext ""} elseif {$secs == 1} {set secstext "$secs секунда"} {set secstext "$secs секунди"}
  set output $yearstext$daystext$hourstext$minstext$secstext
  set output [string trimright $output ", "]
  return $output
}

putlog "Инсталиран: peak.tcl"