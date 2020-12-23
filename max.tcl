# peak1.5.tcl - FireEgl@EFNet <FireEgl@LinuxFan.com> - 1/1/00

### Description:
# Keeps up with the peak number of people in the
# channel and announces it when a new record is set.

### History:
# 1.5 - Oh no! The peak.*.txt files got reset when you restarted the bot..
#		- Also the thinger that's sposta clean-up unused peak.*.txt's was deleting used ones.
# 1.4 - Minor changes.
# 1.3 - Now loads peak data from file on demand (if it's not already in memory).
# 1.2 - Now uses a file to store peak data.
#     - Added !peak public command.
#     - Now says how long ago the last record was set.
#     - Removed mIRC colors. =P
# 1.1 - uhmmmmm...
# 1.0 - Released.

### Thanks To:
# slann@EFNet <slann@bigfoot.com> for the timeago proc, which is really from seen.tcl by Ernst, which is really by robey.

bind join - * join:peak
proc join:peak {nick host hand chan} {
   set curnum [llength [chanlist $chan]]
   set peak [getpeak $chan]
   set lastmax [lindex $peak 0]
   if {$curnum > $lastmax} {
#		if {$lastmax} { puthelp "PRIVMSG $chan :Nov maximalen broi na horata! (\002$curnum\002)  Posleden zapis ... [timeago [lindex $peak 1]] ago." }
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

# provides the !max public command:
bind pub o|o !max pub:peak
proc pub:peak {nick host hand chan arg} { set peak [getpeak $chan]
   putcmdlog "<$nick@$chan> !$hand! peak"
   #puthelp "PRIVMSG $chan :Channel MaX Record: [lindex $peak 0] ([timeago [lindex $peak 1]] ago)."
    puthelp "PRIVMSG $chan :Channel $chan MaX Record: [lindex $peak 0] (predi [timeago [lindex $peak 1]] posledno na [clock format [lindex $peak 1] -format %d.%b.%Y] v [clock format [lindex $peak 1] -format %H:%M]h)."
}
bind msg o|o !max msg:peak
proc msg:peak {nick host hand arg} { 
    if {[info exists $arg]} {set peak [getpeak $arg]} else {set peak [getpeak "#mIRC"]}
    putcmdlog "<$nick> !$hand! peak"
    puthelp "PRIVMSG $nick :Channel #mIRC MaX Record: [lindex $peak 0] (Before [timeago [lindex $peak 1]] on [clock format [lindex $peak 1] -format %d.%b.%Y] at [clock format [lindex $peak 1] -format %H:%M]h)."
}

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
  if {$years < 1} {set yearstext ""} elseif {$years == 1} {set yearstext "$years godina, "} {set yearstext "$years godini, "}
  if {$days < 1} {set daystext ""} elseif {$days == 1} {set daystext "$days den, "} {set daystext "$days dena, "}
  if {$hours < 1} {set hourstext ""} elseif {$hours == 1} {set hourstext "$hours chas, "} {set hourstext "$hours chasa, "}
  if {$mins < 1} {set minstext ""} elseif {$mins == 1} {set minstext "$mins minuta"} {set minstext "$mins minuti"}
  if {$secs < 1} {set secstext ""} elseif {$secs == 1} {set secstext "$secs sekunda"} {set secstext "$secs sekundi"}
  set output $yearstext$daystext$hourstext$minstext$secstext
  set output [string trimright $output ", "]
  return $output
}

