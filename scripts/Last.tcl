# Last.tcl v1.0 (11 Sep 2006)
# Copyright by Kiril Georgiev a.k.a Arkadietz
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################

bind dcc o last dcc:last
bind chon o * dcc:join
bind chof o * dcc:part


set filename "Last.txt"

if {![file exists $filename]} {
  set fh [open $filename w]
  puts -nonewline $fh ""
  close $fh
}

proc dcc:last {hand idx args} {
  set trala ""
  if {[lindex $args 0] == ""} {
	set trala [file:last $hand 20]
  } elseif {([regexp \[^0-9\] $args]) || [lindex $args 0] > 20 || [lindex $args 0] <= 0} {
	putdcc $idx "Usage: .last <logins> (Max usage: 20)"
	return
  } else {
	set trala [file:last $hand [lindex $args 0]]
  }
  
  set i 0
  while {$i < [llength $trala]} {
	set logedin [valididx [lindex [lindex $trala $i] 2]]
	if {$logedin == 1} {
	  putdcc $idx "14Потребител: [lindex [lindex $trala $i] 0] 14Флагове: [lindex [lindex $trala $i] 1] 14Idx: [lindex [lindex $trala $i] 2] 14Логнат на: [lrange [lindex $trala $i] 3 end] - 14логнат"
	} else {
	  putdcc $idx "14Потребител: [lindex [lindex $trala $i] 0] 14Флагове: [lindex [lindex $trala $i] 1] 14Idx: [string range [lindex [lindex $trala $i] 2] 2 end] 14Логнат на: [lrange [lindex $trala $i] 3 4] - 14Излязъл: [lrange [lindex $trala $i] 5 6] 14от IP: [lindex [lindex $trala $i] 7]"
  	} 
	set i [incr i]
  }
}



proc dcc:join {hand idx} {
global filename
ipuser $hand
  set time [clock format "[clock seconds]" -format "%d.%m.%Y %H:%M"]
  set fd [open $filename r]
  set fdtmp [open $filename.tmp w]
  set count 0
  puts $fdtmp "$hand [chattr $hand] $idx $time"
  while {![eof $fd]} {
    set line [gets $fd]
	if {$line == "" || $line == "\n"} {
	  continue
	}
	if {[lindex $line 0] == $hand} {
	  set count [incr count]	  
	  if {$count < 20} {
		puts $fdtmp $line
	  }
	} else {
	  puts $fdtmp $line
	}
  }
  close $fd
  close $fdtmp
  file rename -force ${filename}.tmp $filename
}

proc dcc:part {hand idx} {
global filename
  set time [clock format "[clock seconds]" -format "%d.%m.%Y %H:%M"]
  set fd [open $filename r]
  set fdtmp [open $filename.tmp w]
  while {![eof $fd]} {
    set line [gets $fd]
	if {$line == "" || $line == "\n"} {
	  continue
	}
	if {[lindex $line 2] == $idx} {
	  puts $fdtmp "$hand [chattr $hand] -1$idx [lrange $line 3 end] $time $::ip($hand)"
	} else {
	  puts $fdtmp $line
	}
  }
  close $fd
  close $fdtmp
  file rename -force ${filename}.tmp $filename
unset ::ip($hand)
}

proc file:last {hand count} {
global filename
  set fd [open $filename r]
  set i 0
  set bla ""
  while {![eof $fd]} {
    set line [gets $fd]
	if {$line == "" || $line == "\n"} {
	  continue
	}
	  set i [incr i]
	  if {$i < $count} {
		set bla [linsert $bla [llength $bla] "$line" ]
    }
  } 
  close $fd
  return $bla
}
proc ipuser {nick} {
	foreach stuff [whom *] {
		set user [lindex $stuff 0]
		 if {$user == $nick} { 
			set ::ip($nick) [lindex $stuff 2]
		}
	}
}

putlog "Инсталиран: Last.tcl"
