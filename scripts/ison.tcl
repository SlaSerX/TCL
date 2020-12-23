## File, where the list of the !ison-ed users are stored.
set filename "nlist.txt"

# Channel to whom the stuff goes.
set nchan "#SweetHell"

# File exits ? if no then created!
if {![file exists $filename]} {
    set fh [open $filename w]
    puts -nonewline $fh ""
    close $fh
}

## Don't change anything below, unless you know what you are doing!
# glob vars
set tell "notell"
set online ""

### raw 303 (ISON)
bind raw - 303 online:raw

### raw 325 (NS Id)
bind raw - 325 whois:idented

proc whois:idented {* 325 arg} {
global nchan
  putserv "INVITE [lindex $arg 1] $nchan"
}

## ison is triggered
proc online:raw {* 303 arg} {
  global online nchan tell
  set nlist [getinfo]
  string tolower $nlist
  set arg [string trimleft [lrange $arg 1 end] ":"]
  set arg [charfilter $arg]
  if {$arg == ""} {
	set online1 $online
    if {$tell == "tell"} {
      puthelp "PRIVMSG $nchan :Noone's online."
      set tell "notell"
    }
	unset online
	set online [qonreport 1 $arg $online1]
	set quitted [qonreport 0 $online1 $online]
	set quitted [charfilter $quitted]
	set quitted [removespaces $quitted]
	if {$quitted == ""} {
	  return
	}
    putserv "PRIVMSG $nchan: $quitted offline."
    set online ""
  } else {
  	if {$tell == "tell"} {
	  set arg [removespaces $arg]
	  set onchan [onlineon $arg]
	  set tell "notell"
	  set online $arg
      puthelp "PRIVMSG $nchan :Online: $arg"
      puthelp "PRIVMSG $nchan :Online total [llength $arg] of [llength $nlist]."
      puthelp "PRIVMSG $nchan :On $nchan: [llength $onchan] of [llength $arg] online."
	  return
	}

	if {$online == ""} {
	  set arg [removespaces $arg]
	  set onchan [onlineon $arg]
      set online $arg
      puthelp "PRIVMSG $nchan :Online: $arg"
      puthelp "PRIVMSG $nchan :Online total [llength $arg] of [llength $nlist]."
      puthelp "PRIVMSG $nchan :On $nchan: [llength $onchan] of [llength $arg] online."
      return
	}

	set foo [qonreport 0 $arg $online]

	if {$foo != ""} {
	  set foo [charfilter $foo]
	  set foo [removespaces $foo]
	  set onchan [onlineon $arg]
      append online " $foo"
      puthelp "PRIVMSG $nchan :Online: $foo"
      puthelp "PRIVMSG $nchan :Online total [llength $arg] of [llength $nlist]."
      puthelp "PRIVMSG $nchan :On $nchan: [llength $onchan] of [llength $arg] online."
	}
	set online1 $online
	unset online
	set online [qonreport 1 $arg $online1]
	set quitted [qonreport 0 $online1 $online]
	set quitted [charfilter $quitted]
	set quitted [removespaces $quitted]
	if {$quitted == ""} {
	  return
	}
    putserv "PRIVMSG $nchan :$quitted offline."
  }
}

### !ison
bind pub n !ison ison:pub

proc ison:pub {nick host hand chan arg} {
  global nchan tell
  if {[string tolower $chan] != [string tolower $nchan]} {
	return
  }
  set tell "tell"
  set nlist "[getinfo]"
  putserv "ISON :$nlist"
}

### !addison <nickname(s)>
bind pub n !addison ison:addison

proc ison:addison {nick host hand chan arg} {
  global nchan
  if {[string tolower $chan] != [string tolower $nchan]} {
	return
  }
  if {[lindex $arg 0] == ""} {
	putserv "PRIVMSG $chan :$nick: Usage !addison <nickname(s)>"
	return
  }
  set nlist [getinfo]
  set dontsay [dupZZ $nlist $arg 0]
  if {$dontsay == ""} {
	set count [expr [llength $arg] + [llength $nlist]]
	set arg [charfilter $arg]
	set arg [removespaces $arg]
	putserv "PRIVMSG $chan :$nick: Done. Successfully added $arg. Total ($count)."
	writetof "$nlist $arg"
	set tell "tell"
    putserv "ISON :$nlist"
  } else {
	set dontsay [removespaces $dontsay]
	set dontsay [charfilter $dontsay]
	putserv "PRIVMSG $chan :There is a duplicate :$dontsay"
	set nlist [getinfo]
        set list ""
        foreach bla $arg {
        if {[lsearch $list $bla] == -1} {
          lappend list $bla
            }
        }
        set final [$nlist $list 1]
	if {$final != ""} {
	  set count [expr [llength $final] + [llength $nlist]]
	  set final [removespaces $final]
	  set final [charfilter $final]
	  putserv "PRIVMSG $chan :$nick: Done. Successfully added $final. Total ($count)."
	}
	writetof "$nlist $final"
    putserv "ISON :$nlist $final"
	set tell "tell"
  }
}

## !delison <nickname>
bind pub n !delison del_in_fd
proc del_in_fd {nick uhost hand chan arg} {
  global nchan
  if {[string tolower $chan] != [string tolower $nchan]} {
	return
  }
  if {[llength $arg] != 1} {
    puthelp "NOTICE $nick :Usage: !delison <nickname|phone number>"
    return 0
  }
  set nicknames [getinfo]
  
  set who [lindex $arg 0]
  set who [charfilter $who]
  
  if {[lsearch -exact $nicknames [lindex $arg 0]] == -1} {
	puthelp "NOTICE $nick :Nickname $who not found in the database!"
	return 0
  }
  regsub -all "\\\m$who\\\M" $nicknames "" nicknames
  regsub -all {\s+} $nicknames { } nicknames
  writetof $nicknames
  puthelp "NOTICE $nick :Nickname $who erased from the database!"
}

## !list [nickname]
bind pub n !list list_out_of_fd
proc list_out_of_fd {nick uhost hand chan arg} {
  global nchan
  if {[string tolower $chan] != [string tolower $nchan]} {
	return
  }
  if {[llength $arg] == 0} {
	set nicknames [getinfo]
	set nicknames [charfilter $nicknames]
	set nicknames [removespaces $nicknames]
	if {$nicknames == ""} {
	  puthelp "NOTICE $nick :No one is added in the database!"
	} else {
	  puthelp "NOTICE $nick :Added in the database: $nicknames"
	}
  } elseif {[llength $arg] == 1} {
	set nicknames [getinfo]
	set nicknames [string tolower $nicknames]
	if {[lsearch -exact $nicknames [lindex $arg 0]] == -1} {
	  puthelp "NOTICE $nick :[charfilter [lindex $arg 0]] not found in the database!"
	} else {
	  puthelp "NOTICE $nick :[charfilter [lindex $arg 0]] is in the database!"
	}
  } else {
	puthelp "NOTICE $nick :Usage: !list \[nickname\]"
  }
}

## The proc
proc notify {} {
  set nlist [getinfo]
  putserv "ISON :$nlist"
  if {![string match *notify* [utimers]]} { utimer 30 notify }
}

proc charfilter {x {y ""} } {
  for {set i 0} {$i < [string length $x]} {incr i} {
    switch -- [string index $x $i] {
      "\"" {append y "\\\""}
      "\\" {append y "\\\\"}
      "\[" {append y "\\\["}
      "\]" {append y "\\\]"}
      "\}" {append y "\\\}"}
      "\{" {append y "\\\{"}
      default {append y [string index $x $i]}
    }
  }
  return $y
}

proc getinfo {} {
  global filename
  set file [open $filename r]
  set nlist ""
  while {![eof $file]} {
	set chast [gets $file]
    if {$chast != ""} {
	  append nlist $chast
	}
  }
  close $file
  return $nlist
}

proc removespaces {arg} {
  regsub {^\s+} $arg "" arg
  return $arg
}

proc onlineon {arg} {
  global nchan
  set onchan ""
  foreach tempchar $arg {
    if {![onchan $tempchar $nchan]} {
#      putserv "INVITE $tempchar $nchan"
      putserv "WHOIS $tempchar"
    } else {
      append onchan " $tempchar"
    }
  }
  return $onchan
}

proc qonreport {how arg online} {
  set aq 0
  set foo ""
  foreach el $arg {
    foreach el1 $online {
	  if {$el == $el1} {
	    set aq 1
	  }
    }
    if {$aq == $how} {
	  append foo " $el"
	}
    set aq 0
  }
  return $foo
}

proc writetof {what} {
  global filename
  set fh [open $filename w]
  puts $fh $what
  close $fh
}

proc dupZZ {where what how} {
  set dontsay ""
  foreach el1 $what {
	if {[lsearch -exact $where $el1] != -1} {
	  if {$how == 0} {
  		append dontsay " $el1"
	  }
    } else {
	  if {$how == 1} {
		append dontsay " $el1"
	  }
	}
  }
  return $dontsay
}

if {![string match *notify* [utimers]]} { utimer 30 notify }

putlog "ISON TCL by dJ_TEDY Loaded."
