# winident.tcl v1.2 - by FireEgl@EFNet <FireEgl@Windrop.cjb.net> - April 5, 2001

### Description:
# Implementation of an ident server meant to be used on "WinDrops".

### Features:
# It automatically turns itself on and off when needed so it (usually)
# shouldn't conflict with other identd's that do the same.

### Notes/Suggestions:
# * If you use mIRC be sure that it's Identd setting
#    "Enable only when connecting" is CHECKED in Options.
# * Use at least Eggdrop v1.4.4 (stable), or v1.5.5 (development) for this script to work best.
# * For older versions it uses a kludge method for detecting if it needs
#    to be turned on or off, and is more likely to conflict with other
#    ident servers that may be running.
# * If you run several bots on the same machine then set their server-timeout
#    setting differently in their configs. This will stop them from timing out and
#    trying to turn on their identd and connecting back to a server at the same time.
# * Make sure that your bot is able to connect to all the servers in its
#    $servers list, so that the identd will only be listening for a short time.

### Known Problems:
# * For old Eggdrops (using the kludge method), the first server the bot tries
#    to connect to after it disconnects from one may not get an ident responce. (rare)
# * Sometimes (using the kludge method), the Identd thinks it's on, when it's really not. (very rare)
# * If Eggdrop crashes it's possible that the identd port will get stuck open. (only a reboot will fix it)

### DCC Commands:
# .ident on|off - Will temporarily turn the identd on or off (until the bot thinks it needs it on or off again).
# .ident status - Tells you if the identd is listening or not, and what it's replying with.
# .ident reset - Resets your ident responce to what you have defined as $username in your Eggdrops config.
# .ident <newident> - Will temporarily change your ident responce (until you rehash).

# History:
# 1.0 - Released.
# 1.1 - Updated to enable non-kludge operation on the current 1.5.4 CVS.
# 1.2 - Added the ident(kludge) option (because it didn't properly detect your Eggdrop version before).

### Comments?  Suggestions?
# Email me at FireEgl@Windrop.cjb.net

### If you need help, here's some places to find it:
# First, sure to get the latest "Windrop" from http://Windrop.cjb.net
# http://WindropFAQ.tsx.org - A mini-FAQ with focus on newbies to Eggdrop and to the Cygwin (Windows) ports.
# http://WindropCVS.tsx.org - Kirben's Eggdrop CVS ports.
# Subscribe to the WinDrop mail list @ http://Egg95.ListBot.com
# #EggHeads on EFNet - Ask general Eggdrop questions here, even scripting questions.
# http://www.EggHelp.org - slennox's Eggdrop Page; get netbots.tcl from here!!!
# http://EggTCL.tsx.org - My Eggdrop scripts page. =)
# #Windrop and #WinDropHelp on EFNet - Also visit http://Windrop.tsx.org

### Options:
## Set this to the ident you want to have:
# Leave as $username*** for it use the $username setting you defined in your
# Eggdrop config, along with up to 3 random alphanumeric characters at the end.
# (You can use *'s (for alphanumeric) or ?'s (for digit) as wildcards here to
# have random characters put in place of them whenever an ident is requested.)
set ident(username) "$username***"

## You prolly shouldn't need to touch these:
set ident(system) "UNIX"
set ident(port) "113"
set ident(timeout) "${server-timeout}"

## If you're using an old Eggdrop (Windrop) version
## v1.4.4 or less; or v1.5.3 or less enable this option
set ident(kludge) 0


### Begin Script:
## (Don't change anything below here...)

# Fixed version of randstring found in alltools.tcl:
if {(("[info procs randstring]" == "") || (("[info procs randstring]" == "randstring") && ("[randstring 1]" == "")))} {
   proc randstring {length} { set count [string length [set chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"]]
      for {set i 0} {$i < $length} {incr i} { append result [string index $chars [rand $count]] }
      return "$result"
   }
}

# Also in alltools.tcl, but including it here in case you're not loading alltools.tcl:
if {[info procs isnumber] == ""} { proc isnumber {string} { if {([string compare $string ""]) && (![regexp \[^0-9\] $string])} then { return 1 } { return 0 } } }

# dcc command to let you control the identd:
bind dcc n ident dcc:ident
bind dcc n winident dcc:ident
proc dcc:ident {hand idx arg} { global ident username server
   switch -- "[string tolower [lindex [set arg [split $arg]] 0]]" {
      "on" {
         switch -- "[identon]" {
            "0" { putdcc $idx "Identd was Already On, Listening On Port $ident(port), Replying as $ident(username)" }
            "1" { putlog "Identd: Listening On Port $ident(port), Replying as $ident(username)" }
            "-1" { putlog "Identd: Couldn't Open Port $ident(port).. Another Identd Running Somewhere?" }
         }
      }
      "off" {
         switch -- "[identoff]" {
            "0" { putdcc $idx "Identd Already Disabled." }
            "1" {
               putlog "Identd: Disabled."
               if {(($ident(kludge)) && ("$server" == ""))} {
                  putdcc $idx "Identd can't be turned off while the bot is trying to connect to a server."
               }
            }
            "-1" { putdcc $idx "Identd Already Disabled. (Tried to Close)" }
         }
      }
      "status" {
         if {[info exists ident(server-socket)]} {
            putdcc $idx "Identd is currently enabled and responding as $ident(username)"
         } else {
            putdcc $idx "Identd is currently disabled."
         }
      }
      "reset" { putlog "Identd: Set Ident to [set ident(username) $username]" }
      "set" {
         if {[llength "[set newident [lindex $arg 1]]"] > 1 } {
            putlog "Ident: Set Ident to [set ident(username) $newident]"
         } else {
            putdcc $idx "Usage: .ident set <newident>"
         }
      }
      "default" {
         if {([llength "$arg"] < 1) || ("[string tolower $arg]" == "help")} {
            putdcc $idx "Usage: .ident on|off|status|reset|set <value>"
         } else {
            putlog "Identd: Set Ident to [set ident(username) [join $arg]]"
         }
      }
   }
}

# Turns the identd on unless it's already on:
# Returns 1 on success, 0 for already running, and -1 for error (another Ident is probably running).
proc identon {} { global ident
   if {(![info exists ident(server-socket)]) || (!$ident(kludge))} {
      if {[catch { set ident(server-socket) [socket -server connect:ident $ident(port)] } grr]} {
         if {[info exists ident(server-socket)]} { return 0 } { return -1 }
      } else {
         fconfigure $ident(server-socket) -buffering line
         return 1
      }
   }
   return 0
}

# Turns the identd off unless it's already off:
# Returns 1 for success, 0 for already disabled, and -1 for error (it tried to close a non-existable sock aka "already disabled").
proc identoff {} { global ident
   if {([info exists ident(server-socket)]) || (!$ident(kludge))} {
      if {[catch { close $ident(server-socket) }]} {
         catch { unset ident(server-socket) }
         return -1
      } else {
         catch { unset ident(server-socket) }
         return 1
      }
   }
   return 0
}

# Accepts the ident connections:
proc connect:ident {sock address clientport} { fconfigure $sock -buffering line
   putlog "Identd: Connect from $address:$clientport..."
   fileevent $sock readable [list readable:ident $sock $address $clientport]
   global ident
   utimer $ident(timeout) [split "timeout:ident $sock $address $clientport"]
   set ident($sock,$clientport) ""
}

# Reads from the client and responds:
proc readable:ident {sock address clientport} {
   if {[gets $sock got] != -1} { global ident
      set got [split $got]
      # More RFC 1413 compliant than mIRC.  =P
      if {(((![string match "*, *" "[join $got]"]) && (([llength $got] != 3) || ([llength $got] != 2))) || ([string length $got] > 16) || ([string length $got] < 3))} {
         puts $sock "[join $got] : ERROR : UNKNOWN-ERROR"
         putlog "Identd: Replied: [join $got] : ERROR : UNKNOWN-ERROR"
      } elseif {((![isnumber [join [lindex [split $got ,] 0]]]) || (![isnumber [join [lindex [split $got ,] 1]]]) || ([join [lindex [split $got ,] 1]] > 65535) || ([join [lindex [split $got ,] 1]] < 1) || ([join [lindex [split $got ,] 0]] > 65535) || ([join [lindex [split $got ,] 0]] < 1))} {
         puts $sock "[join $got] : ERROR : INVALID-PORT"
         putlog "Identd: Replied: [join $got] : ERROR : INVALID-PORT"
      } else {
         set username $ident(username)
         while {[regsub -- \\? $username [rand 10] username]} { continue }
         while {[regsub -- \\* $username [randstring 1] username]} { continue }
         puts $sock "[join $got] : USERID : $ident(system) : $username"
         putlog "Identd: Replied: [join $got] : USERID : $ident(system) : $username"
      }
   }
   if {!$ident(kludge)} {
      switch -- "[identoff]" {
         "0" { putlog "Identd Already Disabled." }
         "1" { putlog "Identd: Disabled." }
         "-1" { putlog "Identd Already Disabled. (Tried to Close)" }
      }
   }
   close:ident $sock $clientport
}

# Closes the client socket and returns 1 for success or 0 for error.
proc close:ident {sock clientport} { global ident
   if {[info exists ident($sock,$clientport)]} {
      catch { fileevent $sock readable {} }
      catch { close $sock }
      unset ident($sock,$clientport)
      return 1
   }
   return 0
}

# Thingie that closes the client connection if it's left idle too long:
proc timeout:ident {sock address clientport} { global ident
   if {[close:ident $sock $clientport]} {
      putlog "Identd: Connection to $address:$clientport Timed Out."
   }
}

if {"[string tolower [lindex [split [lindex [split [info nameofexecutable] /] end] .] end]]" != "exe"} {
   putlog "Identd: I don't know why you're using winident.tcl on your system, but it probably won't work on anything but Windows."
}

# Older bots probably don't have these events, but we do the bindings just in case:
bind evnt - connect-server evnt:ident
bind evnt - init-server evnt:ident
# bind evnt - disconnect-server evnt:ident
# These are here so that the bot can close the identd port before it dies...
# (It's possible that the port can get stuck open, and only a reboot will let you get it back.)
bind evnt - sigterm evnt:ident
bind evnt - sigquit evnt:ident
bind evnt - sigill evnt:ident
bind evnt - sighup evnt:ident
bind evnt - prerehash evnt:ident
proc evnt:ident {arg} { global ident
   switch -- "$arg" {
      "connect-server" {
         switch -- "[identon]" {
            "0" { putlog "Identd was Already On, Listening On Port $ident(port), Replying as $ident(username)" }
            "1" { putlog "Identd: Listening On Port $ident(port), Replying as $ident(username)" }
            "-1" { putlog "Identd: Couldn't Open Port $ident(port).. Another Identd Running Somewhere?" }
         }
      }
      "default" {
         switch -- "[identoff]" {
            "0" { putlog "Identd Already Disabled." }
            "1" { putlog "Identd: Disabled." }
            "-1" { putlog "Identd Already Disabled. (Tried to Close)" }
         }
      }
   }
}

# These are here in case people forgot or don't like typing a space between .ident and on/off.  =P
bind dcc n identon dcc:identon
bind dcc n winidenton dcc:identon
proc dcc:identon {hand idx arg} { global ident
   switch -- "[identon]" {
      "0" { putdcc $idx "Identd was Already On, Listening On Port $ident(port), Replying as $ident(username)" }
      "1" { putlog "Identd: Listening On Port $ident(port), Replying as $ident(username)" }
      "-1" { putlog "Identd: Couldn't Open Port $ident(port).. Another Identd Running Somewhere?" }
   }
}
bind dcc n identoff dcc:identoff
bind dcc n winidentoff dcc:identoff
proc dcc:identoff {hand idx arg} { global ident
   switch -- "[identoff]" {
      "0" { putdcc $idx "Identd Already Disabled." }
      "1" { putlog "Identd: Disabled." }
      "-1" { putdcc $idx "Identd Already Disabled. (Tried to Close)" }
   }
}

# Use different methods depending on the Eggdrop version:
# Do you know how hard it is to distinguish between CVS and release, and 1.4 and 1.5??  =P
if {(($ident(kludge) == 0) || (([lindex $version 2] == "CVS") && ([lindex $version 1] >= 1040403) && (([string compare [lindex $version 3] ""]) && (![regexp \[^0-9\] [lindex $version 3]])) && ([lindex $version 3] >= 959114934)) || (([lindex $version 1] >= 1040400) && ([string range [lindex $version 1] 0 2] == "104") && ([lindex $version 2] != "CVS")) || ([lindex $version 1] >= 1050403) && (([string compare [lindex $version 3] ""]) && (![regexp \[^0-9\] [lindex $version 3]])) && ([lindex $version 3] >= 959114934))} {
   set ident(kludge) 0
} else {
   putlog "winident.tcl - Using kludge method, upgrade your Eggdrop!"
   set ident(kludge) 1

   # This one checks once per second to see if we're not on a server
   # and if we're not then starts the identd.
   proc identcheckserver {} { global server ident
      foreach t "[utimers]" { if {"[lindex $t 1]" == "identcheckserver"} { killutimer "[lindex $t 2]" } }
      if {"$server" == ""} {
         if {[identon] == 1} {
            putlog "Identd: Listening On Port $ident(port), Replying as $ident(username)"
         }
      }
      utimer 1 identcheckserver
   }
   identcheckserver

   # This one disables the identd upon successful connection to a server:
   bind raw - "001" connect:identoff
   proc connect:identoff {from key arg} {
      switch -- "[identoff]" {
         "0" { putlog "Identd Already Disabled." }
         "1" { putlog "Identd: Disabled." }
         "-1" { putlog "Identd Already Disabled. (Tried to Close)" }
      }
   }
}

putlog "winident.tcl v1.2 - by FireEgl@EFNet <FireEgl@Windrop.cjb.net> - Loaded."
