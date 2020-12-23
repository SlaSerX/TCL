################################################################################
# Written by Ofloo inspired by Fuas
# HomePage: http://www.ofloo.net/
# Email: support[at]ofloo.net
# CVS: http://cvs.ofloo.net/
#
# Plz report bugs so I know about them, I tested most of the script but I could
# miss some stuff, use the email above to do so.
#
# Useage: !ip2c <ipaddr|nick|hostaddr>
#
# First check if you got the latest version. 
#
# Step 1: Download latest csv db from http://ip-to-country.directi.com/ 
# Step 2: Put the csv db into your eggdrop/windrop main dir
# Step 3: put this script in scripts and add this to config file
# "source scripts/ip-to-country.tcl"
# Step 4: Edit the triggers to your preference.
# Step 5: Rehash and reconnect the bot to your irc server, now you can use the 
# vars that are written down below for stats or what ever. And use the channel
# trigger to perfrom lookups after typing !ip2c
# 
# VARIABLES ADDED YOU CAN USE EM IN ANY SCRIPT IF THIS SCRIPT IS LOADED: 
# _____________________________________________________________________________
#
# - [MyIP] :shows your bots ip the one its using to get on irc
# - [location:type0] :Shows short country code ex: BE,NL,..
# - [location:type1] :Shows short country code ex: BEL,NED,..
# - [location:type2] :Shows full country name ex: Belguim,Netherlands,..
#
# VARIABLES ADDED YOU CAN USE EM IN ANY SCRIPT IF THIS SCRIPT IS LOADED: 
# _____________________________________________________________________________
#
# - .netip :Shows the ips of all the bots that are linked and loaded the script
# - .netvrs :Shows the version, (same as netip but for version)
# - .netloc :Shows the location of each bot, (same as netip but for locaton)
#
################################################################################
# CHANGELOG:
# _____________________________________________________________________________
#
# 17/10/2003:
# - Fixed selflookup
#
# 16/10/2003:
# - Fixed nummeric ip check system tnx to some help from people on egghelp.org 
#   (BarkerJr, ppslim, ..) 
# - Being able to just use a raw downloaded csv database. No more need editing 
#   it so just download the latest db.
#
# 6/10/2003:
# - Feature added non realy visible, now you can only enter nummeric ips and
#   before this was also the case but then a nasty error popped up in dcc so 
#   this is solved now. Not real bug or feature but mutch more nicer and also
#   now you can set this script to be enabled on only specifc channels.
#   one small bug remains in this syntax if the ip contains alphanummeric chars
#   as in abcd.. error will be triggerd and there will be send a msg to the 
#   chan, but if ip = 111.111.111.111a the last letter won't be reconized by as
#   an alphanummeric char ? witch is verry strange. but 90% of the error msg 
#   are write.
#
# 5/10/2003:
# - Secirity bug fixed found tnx to Quasi
#
# 30/03/2004:
# - Rewrite added some features, like !ip2c host, !ip2c nick !ip2c host
#   requested by different people.
# - Added old script support
# - Added mysql support
# - Removed on off switch
# - Removed all cache files
#
# 4/04/2004:
# - Added Ip2LongIP conversion from channel + error hand
# - Added LongIP2Ip conversion from channel + error hand
# - Added update checker
# - Added country ban + err
# - Added command menu
# - Fixed no arg err.
# - Fixed nick die exploit
# - Fixed host die exploit
# - Fixed channel die exploit
#
# 5/04/2004:
# - Updated valid ip range
# - Fixed can't find db
#
# 26/05/2004
# - Added result notification choise to prevent flood (requested)
# - Added bold removal by switch cause some channels do not allow colors.
#
# 26/06/2004
# - Added channel modes level support. 
#
# 2/07/2004
# - Added dynamic switch support
#
################################################################################

################################################################################
# SETTINGS

############################### EDIT TO YOUR PREF ##############################

# Set the public trigger
set ip2c(trigger) "!ip2c"

# Set flag who is allowed to use this
set ip2c(flag) "-"

# Set valid channels (#chan0,#chan1,..) set to "" for all channels
set ip2c(chan) ""

# set this path to the path where your data base is located
set ip2c(database) "cache/ip-to-country.csv"

# Choose between mysql or cvs: set to 1 for mysql, and set to 0 for cvs
set ip2c(sql) "0"

# Result msg type
# 0: Channel msg
# 1: Nick msg
# 2: Nick notice
set ip2c(type) 0

# turn bold in results on or off. 0 off 1 for on
set ip2c(bold) 1

# Change trigger channel modes for example if a user is voiced or opped ..
# 0: Everyone
# 1: Voice Halfops Opped
# 2: Halfops Opped
# 3: Opped
set ip2c(mode) 0

# Default switch mode
# 0: off
# 1: on
set ip2c(switch) 1

########################## Below only mysql settings ###########################
# Create a table and insert the data or download the premade db 
# from http://ofloo.net
#
# CREATE TABLE `resolve` (
#   `resolve_id` int(5) unsigned zerofill NOT NULL auto_increment,
#   `resolve_start` decimal(12,0) NOT NULL default '0',
#   `resolve_end` decimal(12,0) NOT NULL default '0',
#   `resolve_code_2` char(2) NOT NULL default '',
#   `resolve_code_3` char(3) NOT NULL default '',
#   `resolve_fullname` varchar(200) NOT NULL default '',
#   PRIMARY KEY  (`resolve_id`)
# ) TYPE=MyISAM;
################################################################################

# Host of mysql server 
set mysql(host) "127.0.0.1"

# Port of mysql server
set mysql(port) "3306"

# Database login
set mysql(user) "ip2c"

# Database pass change this
set mysql(pass) "xxxxxxxxxxxxxxxxxxx"

# Database name
set mysql(data) "ip2c"

# Location of MySQL lib for tcl tested with version 2.41 current is 2.5 
# checked the manual and syntax seems ok so I gues it still supports it
# download at http://www.xdobry.de/mysqltcl/
set mysql(libsql) "lib/mysqltcl-2.41/libmysqltcl2.41.so"

############################### DO NOT EDIT BELOW ##############################

# Script version.
set ip2c(vrs) "0.6"

# Script update tag
set ip2c(tag) "1088746257"

# Loading mysql libs and creating a connection.
if {![info exists mysql(conn)] && $ip2c(sql)} {
  if {[file exists $mysql(libsql)]} {
    load "$mysql(libsql)"
    set mysql(conn) [mysqlconnect -host $mysql(host) -port $mysql(port) -user $mysql(user) -password $mysql(pass)]
  } else {
    putlog "Error can't find the mysql lib."
  }
}

################################################################################
# BINDS

bind pub $ip2c(flag) $ip2c(trigger) ip2c:pub
bind raw - 302 raw:302
bind evnt - init-server conn:init

################################################################################
# PROCS

#########################################
# Bold switch
#########################################

if {[info exists ip2c(bold)]} {
  switch  -- $ip2c(bold) {
    "0" {
      set ip2c(boldset) ""
    }
    "1" {
      set ip2c(boldset) "\002"
    }
  }
} else {
  putlog "Ip-to-Country could contain errors, a required variable couldn't be resolved."
  return 0
}

if {![info exists ip2c(boldset)]} {
  putlog "Ip-to-Country could contain errors, a required variable couldn't be resolved."
  return 0
}

#########################################
# Msg type switch
#########################################

if {[info exists ip2c(type)]} {
  switch  -- $ip2c(type) {
    "0" {
      set ip2c(putserv) "PRIVMSG %CHAN%"
    }
    "1" {
      set ip2c(putserv) "PRIVMSG %NICK%"
    }
    "2" {
      set ip2c(putserv) "NOTICE %NICK%"
    }
  }
} else {
  putlog "Ip-to-Country could contain errors, a required variable couldn't be resolved."
  return 0
}

if {![info exists ip2c(bold)]} {
  putlog "Ip-to-Country could contain errors, a required variable couldn't be resolved."
  return 0
}

#########################################
# Main public proc (channel commands)
#########################################

proc ip2c:pub {nick host hand chan arg} {
  global ip2c
  set arg [string map {\\ \\\\ \[ \\\[ \] \\\] \{ \\\{ \} \\\} \" \\\"} $arg]
  if {([string match -nocase *$ip2c(chan)* $chan] || [string match -nocase {} $chan]) && [isstatus $nick $chan]} {
    if {[string match -nocase {} [lindex $arg 0]]} {
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Invalid option, $ip2c(boldset)$ip2c(trigger) -help$ip2c(boldset) for a list of options."
    } elseif {![string match -nocase {} [lindex $arg 1]] && ![string match -nocase "-set" [lindex $arg 0]] && ![string match -nocase "-ban" [lindex $arg 0]] && ![string match -nocase "-longip" [lindex $arg 0]] && ![string match -nocase "-ipaddr" [lindex $arg 0]]} {
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Error to mutch variables, usage: $ip2c(trigger) <nick|ipaddr|host>."
    } elseif {[isipaddr [lindex $arg 0]] && $ip2c(switch)} {
      set output [ip2country [lindex $arg 0]]
      set result(0) "[lindex $output 0]"
      set result(1) "[lindex $output 1]"
      set result(2) "[join [lrange $output 2 end]]"
      if {$result(0) != "00"} {
        foreach line [split $result(2) \x20] {
          if {[info exists word]} {
            append word \x20[word_format $line]
          } else {
            set word [word_format $line]
          }
        }
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Result lookup for [lindex $arg 0]: \($ip2c(boldset)$result(0), [join [lrange $word 0 end]]$ip2c(boldset)\)"
      } else {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$result(2)"
      }
    } elseif {[ishost [lindex $arg 0]] && $ip2c(switch)} {
      dnslookup "[string map {\\ \\\\ \[ \\\[ \] \\\] \{ \\\{ \} \\\} \" \\\"} [lindex $arg 0]]" resolve:ipaddrhost "[string map {\\ \\\\ \[ \\\[ \] \\\] \{ \\\{ \} \\\} \" \\\"} $nick]" "[string map {\\ \\\\ \[ \\\[ \] \\\] \{ \\\{ \} \\\} \" \\\"} $chan]"
    } elseif {[string match -nocase "-about" [lindex $arg 0]]} {
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$ip2c(boldset)Ip-to-Country.tcl$ip2c(boldset) by Ofloo version $ip2c(boldset)$ip2c(vrs)$ip2c(boldset)."
    } elseif {[string match -nocase "-update" [lindex $arg 0]] && [matchattr $nick m]} {
      set vrschk [newupdates]
      if {[string match -nocase "-1" $vrschk]} {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Error could not connect to webserver."
      } else {
        if {$vrschk} {
          putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :You are using the latest version."
	} else {
	  putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :You are not using the latest version check http://www.ofloo.net/ for updates."
	}
      }
    } elseif {[string match -nocase "-help" [lindex $arg 0]]} {
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Ip-to-Country.tcl command list."
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$ip2c(trigger) <nick|host|ipaddr> ::: perfrom lookup."
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$ip2c(trigger) -ban <country code> ::: only for ops bans all users that match the country."
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$ip2c(trigger) -set <on|off> ::: only for ops turns trigger status on or off."
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$ip2c(trigger) -status ::: only for ops shows current script status."
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$ip2c(trigger) -longip <ipaddr> ::: returns longip for ipaddr."
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$ip2c(trigger) -ipaddr <longip> ::: returns ipaddr for longip."
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$ip2c(trigger) -update ::: checks if your using the latest script version."
      putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$ip2c(trigger) -about ::: shows info about this script."
    } elseif {[string match -nocase "-ban" [lindex $arg 0]] && [matchattr $nick o]} {
      if {![string match -nocase {} [lindex $arg 1]] && [string match -nocase {} [lindex $arg 2]]} {
        if {([string bytelength [lindex $arg 1]] == 2) && [regexp -all {[a-zA-Z]} [lindex $arg 1]]} {
          bancountry [lindex $arg 1] $chan
	} else {
	  putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Invalid country code."
	}
      } else {
      	putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Usage: $ip2c(trigger) -ban <2digit country code>."
      }
    } elseif {[string match -nocase "-longip" [lindex $arg 0]]} {
      if {[isipaddr [lindex $arg 1]] && ![string match -nocase {} [lindex $arg 1]] && [string match -nocase {} [lindex $arg 2]]} {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :LongIP for \($ip2c(boldset)[lindex $arg 1]$ip2c(boldset)\) is \($ip2c(boldset)[ip2longip [lindex $arg 1]]$ip2c(boldset)\)"
      } elseif {[string match -nocase {} [lindex $arg 1]] || ![string match -nocase {} [lindex $arg 2]]} {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Usage: $ip2c(trigger) -longip <ipaddr>"
      } else {
      	putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :\($ip2c(boldset)[lindex $arg 1]$ip2c(boldset)\) is not a valid ipaddr."
      }
    } elseif {[string match -nocase "-ipaddr" [lindex $arg 0]]} {
      if {[regexp -all {[0-9]} [lindex $arg 1]] && ![string match -nocase {} [lindex $arg 1]] && [string match -nocase {} [lindex $arg 2]]} {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :IpAddr for \($ip2c(boldset)[lindex $arg 1]$ip2c(boldset)\) is \($ip2c(boldset)[longip2ip [lindex $arg 1]]$ip2c(boldset)\)"
      } elseif {[string match -nocase {} [lindex $arg 1]] || ![string match -nocase {} [lindex $arg 2]]} {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Usage: $ip2c(trigger) -ipaddr <longip>"
      } else {
      	putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :\($ip2c(boldset)[lindex $arg 1]$ip2c(boldset)\) is not a valid longip."
      }
    } elseif {[string match -nocase "-status" [lindex $arg 0]] && [matchattr $nick m]} {
      if {$ip2c(switch)} {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Trigger status is turned \($ip2c(boldset)on$ip2c(boldset)\)."
      } else {
      	putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Trigger status is turned \($ip2c(boldset)off$ip2c(boldset)\)."
      }
    } elseif {[string match -nocase "-set" [lindex $arg 0]] && [matchattr $nick m]} {
      if {[string equal -nocase {} [lindex $arg 1]]} {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] ::Usage: $ip2c(trigger) -set <on|off>."
      } else {
	if {[string equal -nocase "on" [lindex $arg 1]]} {
	  if {!($ip2c(switch))} {
	    set ip2c(switch) 1
	    putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Turned trigger status \($ip2c(boldset)on$ip2c(boldset)\)."
      	  } else {
      	    putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Allready turned on."
      	  }
	} elseif {[string equal -nocase "off" [lindex $arg 1]]} {
	  if {$ip2c(switch)} {
	    set ip2c(switch) 0
	    putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Turned trigger status \($ip2c(boldset)off$ip2c(boldset)\)."
      	  } else {
      	    putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Allready turned off."
      	  }
	} else {
	  putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] ::Usage: $ip2c(trigger) -set <on|off>."
	}
      }
    } else {
      if {[onchan [lindex $arg 0] $chan] && $ip2c(switch)} {
        dnslookup [lindex [split [getchanhost [lindex $arg 0]] \x40] 1] resolve:ipaddrnick [string map {\\ \\\\ \[ \\\[ \] \\\] \{ \\\{ \} \\\} \" \\\"} [lindex $arg 0]] [string map {\\ \\\\ \[ \\\[ \] \\\] \{ \\\{ \} \\\} \" \\\"} $chan]
      } elseif {$ip2c(switch)} {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :\($ip2c(boldset)[lindex $arg 0]$ip2c(boldset)\) is not on the current channel."
      }
    }
  }
}

#########################################
# Ban country command this command 
# checks if the user its gone ban is no
# op or is not the bot himself if those
# conditions are not true then it will 
# ban every user that matches the coutry
# code that is given.
#########################################

proc bancountry {cc chan} {
  global botnick
  foreach line [chanlist $chan] {
    if {![string match -nocase $botnick $line] && ![matchattr $line o]} {
      dnslookup [lindex [split [getchanhost $line] \x40] 1] resolve:countryban $cc $chan
    }
  }
}

#########################################
# Checks country and bans the ones it 
# matches against the given country
#########################################

proc resolve:countryban {ipaddr hostname status cc chan} {
  if {[string match -nocase $cc [lindex [ip2country $ipaddr] 0]]} {
    pushmode $chan +b *!*@$hostname
  }
}

#########################################
# Resolve ipaddr with nick identifyer
#########################################

proc resolve:ipaddrnick {ipaddr hostname status nick chan} {
  global ip2c
  if {[ip2longip $ipaddr]} {
    if {[isipaddr $ipaddr]} {
      set output [ip2country $ipaddr]
      set result(0) "[lindex $output 0]"
      set result(1) "[lindex $output 1]"
      set result(2) "[join [lrange $output 2 end]]"
      if {$result(0) != "00"} {
        foreach line [split $result(2) \x20] {
          if {[info exists word]} {
            append word \x20[word_format $line]
          } else {
            set word [word_format $line]
          }
        }
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Result lookup for $nick: \($ip2c(boldset)$result(0), [join [lrange $word 0 end]]$ip2c(boldset)\)"
      } else {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$result(2)"
      }
    }

  } else {
    putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Couldn't look up the \($ip2c(boldset)$hostname$ip2c(boldset)\) for \($ip2c(boldset)$nick$ip2c(boldset)\)."
  }
}

#########################################
# resolve ipaddr from host
#########################################

proc resolve:ipaddrhost {ipaddr hostname status nick chan} {
  global ip2c
  if {[ip2longip $ipaddr]} {
    if {[isipaddr $ipaddr]} {
      set output [ip2country $ipaddr]
      set result(0) "[lindex $output 0]"
      set result(1) "[lindex $output 1]"
      set result(2) "[join [lrange $output 2 end]]"
      if {$result(0) != "00"} {
        foreach line [split $result(2) \x20] {
          if {[info exists word]} {
            append word \x20[word_format $line]
          } else {
            set word [word_format $line]
          }
        }
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Result lookup for $hostname: \($ip2c(boldset)$result(0), [join [lrange $word 0 end]]$ip2c(boldset)\)"
      } else {
        putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :$result(2)"
      }
    }

  } else {
    putserv "[string map [list %CHAN% $chan %NICK% $nick] $ip2c(putserv)] :Couldn't look up the hostname \($ip2c(boldset)$hostname$ip2c(boldset)\)."
  }
}

#########################################
# Reverse a string
#########################################

proc reverse_string {arg} {
   set out {}
   foreach line [split $arg {}] {set out $line$out} 
   set out
}

#########################################
# Create a long ip out of a nummeric ip
#########################################

proc ip2longip {ipaddr} {
  foreach ipbyte [split $ipaddr \x2E] { 
    append hexaddr [format {%02x} $ipbyte] 
  } 
  return [format {%u} "0x$hexaddr"] 
}

#########################################
# Create a normal nummeric ip from longip
#########################################

proc longip2ip {longip} {
  return [expr {$longip>>24&255}]\x2E[expr {$longip>>16&255}]\x2E[expr {$longip>>8&255}]\x2E[expr {$longip&255}]
}

#########################################
# Check if the ipaddr is nummeric
#########################################

proc isipaddr {ipaddr} {
  if {[string match -nocase {} $ipaddr]} {
    return 0
  }
  foreach line [split $ipaddr \x2E] {
    if {![regexp ^\[0-9\]+$ $line]} {
      return 0
    } elseif {$line > 255} {
      return 0
    }
    if {[info exists count]} {
      incr count
    } else {
      set count 1
    }
  }
  if {$count != 4} {
    return 0
  } else {
    return 1
  }
}

#########################################
# Checking if ipaddr is a real internet
# ipaddr and not a lan ip or localhost..
#########################################

proc isvalidip {ipaddr} {
  if {(([ip2longip $ipaddr] >= 2130706432) && ([ip2longip $ipaddr] <= 2130706687)) || (([ip2longip $ipaddr] >= 167772160) && ([ip2longip $ipaddr] <= 184549375)) || (([ip2longip $ipaddr] >= 2886729728) && ([ip2longip $ipaddr] <= 2887778303)) || (([ip2longip $ipaddr] >= 3232235520) && ([ip2longip $ipaddr] <= 3232301055)) || (([ip2longip $ipaddr] >= 2851995648) && ([ip2longip $ipaddr] <= 2852061183)) || (([ip2longip $ipaddr] >= 3758096384) && ([ip2longip $ipaddr] <= 4026531839))} {
    return 0
  } else {
    return 1
  }
}

#########################################
# Basicly this checks if the input is
# a host, and if this host is valid
# by checking if there are "." within 
# the string and by checking if the tld 
# is not a number.
#########################################

proc ishost {host} {
  foreach {a b} [split [reverse_string $host] \x2E] break
  if {[regexp -all {[a-zA-Z]} $a] && [regexp -all {[a-zA-Z0-9]} $b]} {
    if {![string match -nocase {} $a] && ![string match -nocase {} $b]} {
      return 1
    } else {
      return 0
    }
  } else {
    return 0
  }
}

#########################################
# Reformat string every word will be set
# to lower then only the first char will
# be to upper.
#########################################

proc word_format {arg} {
  foreach line [split [string tolower $arg] {}] {
    if {[info exists word]} {
      append word $line
    } else {
      set word [string toupper $line]
    }
  }
  return $word
}

#########################################
# This will lookup the country codes
#########################################

proc ip2country {ipaddr} {
  global ip2c mysql
  if {![info exists mysql(conn)] && $ip2c(sql)} {
    set mysql(conn) [mysqlconnect -host $mysql(host) -port $mysql(port) -user $mysql(user) -password $mysql(pass)]
  }
  if {[isvalidip $ipaddr]} {
    if {$ip2c(sql)} {
      if {[ip2longip $ipaddr]} {
        mysqluse $mysql(conn) $mysql(data)
	foreach query [mysqlsel $mysql(conn) "SELECT resolve_start,resolve_end,resolve_code_2,resolve_code_3,resolve_fullname FROM resolve WHERE ([ip2longip $ipaddr] >= resolve_start) and ([ip2longip $ipaddr] <= resolve_end);" -list] {
	  if {![info exists test]} {
	    set location(0) "[lindex $query 2]"
	    set location(1) "[lindex $query 3]"
	    set location(2) "[join [lrange $query 4 end]]"
	  } else {
	    putlog "Error to many results."
	  }
	}
      }
      if {[array exists location]} {
        if {[string match -nocase {} $location(0)]} {
	  set location(0) "00"
        }
	if {[string match -nocase {} $location(1)]} {
	  set location(1) "000"
	}
	if {[string match -nocase {} $location(2)]} {
	  set location(2) "Unknown"
	}
	return "$location(0) $location(1) $location(2)"
      } else {
        return "00 000 Couldn't resolve \($ip2c(boldset)$ipaddr$ip2c(boldset)\) to a country, plz contact the channel operators so they can contact the owners of the database."
      }
    } else {
      if {[file exists $ip2c(database)]} {
        if {[ip2longip $ipaddr]} {
          set rfile [open "$ip2c(database)" r]
          while {![eof $rfile]} {
            gets $rfile line
	    set data [string map {\x22 {} \x2C \x20} $line]
            if {[ip2longip $ipaddr] >= [lindex $data 0]} {
	      if {[ip2longip $ipaddr] <= [lindex $data 1]} {
	        set location(0) [lindex $data 2]
	        set location(1) [lindex $data 3]
	        set location(2) [join [lrange $data 4 end]]
	        break
	      }
            }
          }
          close $rfile
	  if {[array exists location]} {
	    return "$location(0) $location(1) $location(2)"
	  } else {
	    return "00 000 Couldn't resolve \($ip2c(boldset)$ipaddr$ip2c(boldset)\) to a country, plz contact the channel operators so they can contact the owners of the database."
	  }
        }
      } else {
        putlog "Can't find the cvs database."
      }
    }
  } else {
    return "00 000 Localhost and Lan ips can $ip2c(boldset)NOT$ip2c(boldset) be resolved to a country."
  }
}

#########################################
# Channel mode support is .. v/h/o 
#########################################

proc isstatus {nick chan} {
  global ip2c
  if {$ip2c(mode)} {
    if {[isvoice $nick $chan] && ($ip2c(mode) == 1)} {
      return 1
    } elseif {[ishalfop $nick $chan] && ($ip2c(mode) <= 2)} {
      return 1
    } elseif {[isop $nick $chan] && ($ip2c(mode) <= 3)} {
      return 1
    } else {
      return 0
    }
  } else {
    return 1
  }
}

#########################################
# This proc connects to my webserver and
# checks the lastest update of the script
# like this you will be able to know 
# when a new version releases without 
# having to check the website everyday.
#########################################

proc newupdates {} {
  global ip2c
  catch {socket update.ofloo.net 80} sock
  if {[string match -nocase "sock??" $sock]} {
    flush $sock
    puts $sock "GET /ip-to-country HTTP/1.1"
    puts $sock "Host: update.ofloo.net"
    puts $sock "Connection: Close"
    puts $sock "User-Agent: Ip-to-Country updater"
    puts $sock "\n\r"
    while {![eof $sock]} {
      flush $sock
      gets $sock line
      if {[string match -nocase "<tag>*</tag>" [lindex $line 0]]} {
        if {[regexp -all {[0-9]} [string map {<tag> {} </tag> {}} [lindex $line 0]]] && ![string match -nocase {} [lindex $line 0]]} {
          if {[string map {<tag> {} </tag> {}} [lindex $line 0]] > $ip2c(tag)} {
            set return "0"
          } else {
            set return "1"
          }
        }
      }
    }
    close $sock
  } else {
    set return "-1"
  }
  return $return
}

#########################################
# Old script support
#########################################

#########################################
# Will catch the host from irc this will
# give you a real ip and resolve it
#########################################

proc raw:302 {from key arg} {
  global botnick
  if {[string match -nocase [lindex [split [lindex [split [join [lrange $arg 0 end]] \x3D] 0] \x3A] 1] $botnick]} {
    dnslookup "[lindex [split [join [lrange $arg 0 end]] \x40] 1]" resolve:raw
  }
}

#########################################
# resolving the bots host
#########################################

proc resolve:raw {ipaddr hostname status} {
  global MyIP
  set MyIP "$ipaddr"
}

#########################################
# A command that returns $MyIP variable 
# this is usefull when users have that
# have a nat ip and wich to resolve the 
# bots ip or for users with huge amount
# of ips for example if you are on a
# shell provider and you don't bind your
# bot to a certain ip this will resolve
# it for you each time the bot connects.
#########################################

proc MyIP {} {
  global MyIP
  if {[info exists MyIP]} {
  
    if {[string match {} $MyIP] || [ip2longip $MyIP] || [isvalidip $MyIP]} {
      set MyIP {}
      foreach a {a b c d e f g h i j k} { 
        catch { 
          set external [socket $a.root-servers.net 53] 
          set MyIP [lindex [fconfigure $external -sockname] 0] 
          close $external             
        } 
        if { ![string equal $MyIP {}] } { 
	  break 
	} 
      }
      return $MyIP
    } else {
      return $MyIP	    
    }
  } else {
    set MyIP {}
    foreach a {a b c d e f g h i j k} { 
      catch { 
        set external [socket $a.root-servers.net 53] 
        set MyIP [lindex [fconfigure $external -sockname] 0] 
        close $external             
      } 
      if { ![string equal $MyIP {}] } { 
        break 
      } 
    }
    return $MyIP
  }
}

#########################################
# Perfrom on connect
#########################################

proc conn:init init-server { 
  global botnick
  putserv "USERHOST $botnick"
}

#########################################
# Returns country code 2 digits
#########################################

proc location:type0 {} {
  set location [lindex [ip2country [MyIP]] 0]
  if {[regexp -all {[0-9]} $location]} {
    set location "Unknown"
  }
  return $location
}

#########################################
# Returns country code 3 digits
#########################################

proc location:type1 {} {
  set location [lindex [ip2country [MyIP]] 1]
  if {[regexp -all {[0-9]} $location]} {
    set location "Unknown"
  }
  return $location
}

#########################################
# Returns full country name
#########################################

proc location:type2 {} {
  foreach line [split [join [lrange [ip2country [MyIP]]] 2 end] \x20] {
    if {[info exists location]} {
      append location \x20[word_format $line]
    } else {
      set location [word_format $line]
    }
  }
  if {[regexp -all {[0-9]} [lindex [ip2country [MyIP]] 0]]} {
    set location "Unknown"
  }
  return $location
}

#########################################
# Old dcc commands.
#########################################

# this section will be rewritten in the futur
#BOTNET DCC COMMANDS
bind dcc n netip netip:dcc 
bind dcc n netvrs netvrs:dcc
bind dcc n netloc netloc:dcc

#SHOW IP OVER BOTNET
proc netip:dcc {hand idx arg} { 
  global botnick
  putdcc $idx "$ip2c(boldset)$botnick$ip2c(boldset) current ip is: $ip2c(boldset)[MyIP]$ip2c(boldset)"
  putallbots "botdcccmd $idx getip" 
} 

#SHOW SCRIPT VERSION OVER BOTNET
proc netvrs:dcc {hand idx arg} {
  global ip2c botnick
  putdcc $idx "$ip2c(boldset)$botnick$ip2c(boldset) current script version is: $ip2c(boldset)$ip2c(vrs)$ip2c(boldset)"
  putallbots "botdcccmd $idx scriptversion" 
} 

#SHOW LOCATION OVER BOTNET
proc netloc:dcc {hand idx arg} {
  global botnick
  putdcc $idx "$ip2c(boldset)$botnick$ip2c(boldset) location is: $ip2c(boldset)[location:type1]$ip2c(boldset)"
  putallbots "botdcccmd $idx botlocation"
}

#BOTNET ECHO RESULTS
bind bot - result result:bot 

proc result:bot {hand idx arg} { 
  putidx [lindex $arg 0] "$ip2c(boldset)$hand$ip2c(boldset) answered back: $ip2c(boldset)[join [lrange $arg 1 end]]$ip2c(boldset)" 
} 

#BOTNET ANSWER BACK 
bind bot - botdcccmd botdcccmd:bot 

proc botdcccmd:bot {hand idx arg} {
  global ip2c botnick
  switch -exact -- [strlwr [lindex $arg 1]] { 
    "getip" { 
      putbot $hand "result [lindex $arg 0] [MyIP]" 
    } 
    "scriptversion" { 
      putbot $hand "result [lindex $arg 0] $ip2c(vrs)" 
    }
    "botlocation" {
      putbot $hand "result [lindex $arg 0] [location:type1]"
    }
  } 
}

############################################################################
putlog "\002Ip-to-Country.tcl\002 by Ofloo version \002$ip2c(vrs)\002."
