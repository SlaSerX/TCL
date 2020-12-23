###############################################
# I have taken the topic.1.3.0.a.tcl script   #
# and have turned it into a message script    #
#         For Eggdrop 1.1.4 and above         #
#               Created 8/31/01               #
# Modifyed by Rich25:  rich221976@aol.com     #
# Org Created by DaZA:  daza@speednet.com.au  #
# Version 1.0  First Script                   #
# Version 1.1  Fix bug in messages not being  #
#              announce in channel with time  #
#              set                            #
#                                             #
###############################################




################################################
#  topic1.0atcl by DaZa: daza@speednet.com.au  #
#         For Eggdrop 1.1.4 and above          #
#               Created 30/6/97                #
################################################

# Complete msg package for Eggdrop 1.1.4 and above. This will save msgs
# to a channel specific file (ie msg.#mychan) #mychan will be different for
# every channel you use the bot on.

# Also the msg will be changed randomly in every channel according to a 
# time you specify in the Config section

# Fixed (file does not exist) error when using !addmessage or !message... now
# checks to see if file exists and if not creates a new file like !clearmsg
# Also fixed (random limit must be greater than zero) now if there are no 
# msgs stored it will not set the msg and send a msg or put in the 
# logfile that there is no msgs stored yet.

# Updated 3/15/98 qwerty@rapfire.net  Took out the matchchanattr's, because
# they wernt working right on the 1.3.x eggies, and placed the attribute
# checking in the bindings instead

### CONFIG SECTION ###

set changemsgtime "120" 
# This is the amount of minutes between msg changes

set msgtimer "1"
# Set Timer on/off 1/0

### COMMANDS HELP ###

# Public Commands are:
# !addmessage <msg> - this saves the msg to a file called msg.#mychan

# !message <msg> - <msg> is optional if you dont specify a msg it 
#                  will pick one at randrom from the msg file otherwise it
#                  will change the current msg to <msg>

# MSG Commands are:
# !addmessage <channel> <msg> - this saves the msg to a file called 
#                               msg.#mychan #mychan being <channel>

# !message <channel> <msg> - <msg> is optional if you dont specify a 
#                            msg it will pick one at randrom from the 
#                            msg file otherwise it will change the 
#                            current msg to <msg>

# !clearmessages<channel>   - Clears the msg file for <channel>

# NOTE: !addmessage and !clearmessagesare Master commands only. !message is for
#       channel Ops and allows them to change the msg manually or randomly.

################# Main Script ##################

proc clearmsgfile {nick handle uhost var} {
  if {$var == ""} {
  putserv "NOTICE $nick :Usage is !clearmessages<channel>"
  return 0
  }
  set chan [string tolower [lindex $var 0]]
  set fd [open msg.$chan w]
  puts $fd [format "0"]
  close $fd
  putserv "NOTICE $nick :Cleared the msg file for $chan!"
  return 1
}
bind msg m|m !clearmessages clearmsgfile

proc msg_addmsg {nick hand uhost var} {
  if {$var == ""} {
  putserv "NOTICE $nick :Usage is !addmessage <channel> <new msg>"
  return 0
  }
  set chan [lindex $var 0]
  set msg [lrange $var 1 end]
  set chn [string tolower $chan]
  if {![file exists msg.$chn]} {
  set fd [open msg.$chn w]
  puts $fd [format "0"]
  close $fd
  }
  set fd [open msg.$chn r]
  set randlimit [gets $fd]
  incr randlimit
  set fdbak [open msg.$chn.bak a]
  puts $fdbak [format $randlimit]
  puts $fdbak [format $msg]
  close $fdbak
  while {![eof $fd]} {
  set fdbak [open msg.$chn.bak a]
  set getmsg [gets $fd]
  if {$getmsg != ""} {puts $fdbak [format $getmsg]}
  close $fdbak
  }
  close $fd
  exec mv -f msg.$chn.bak msg.$chn
  putserv "NOTICE $nick :Updated $chn msg File with - $msg"
  return 1
}
bind msg - !request msg_addmsg

proc pub_addmsg {nick hand uhost chan var} {
  if {$var == ""} {
  putserv "NOTICE $nick :Usage is !request username mail"
  return 0
  }
  set msg [lrange $var 0 end]
  set chn [string tolower $chan]
  if {![file exists msg.$chn]} {
  set fd [open msg.$chn w]
  puts $fd [format "0"]
  close $fd
  }
  set fd [open msg.$chn r]
  set randlimit [gets $fd]
  incr randlimit
  set fdbak [open msg.$chn.bak a]
  puts $fdbak [format $randlimit]
  puts $fdbak [format $msg]
  close $fdbak
  while {![eof $fd]} {
  set fdbak [open msg.$chn.bak a]
  set getmsg [gets $fd]
  if {$getmsg != ""} {puts $fdbak [format $getmsg]}
  close $fdbak
  }
  close $fd
  exec mv -f msg.$chn.bak msg.$chn
  putserv "NOTICE $nick :Updated $chan msg File with - $msg"
  return 1
}
bind pub m|m !addmessage pub_addmsg

proc msg_setmsg {nick hand uhost var} {
  if {$var == ""} {
  putserv "NOTICE $nick :Usage is !message <channel> <msg>"
  putserv "NOTICE $nick :If <msg> isnt specified then it will pick a random msg"
  return 0
  }
  set chan [lindex $var 0]
  set msg [lrange $var 1 end]
  set chn [string tolower $chan]
  if {$msg != ""} {
  putserv "PRIVMSG $chan :$msg"
  } else {
  if {![file exists msg.$chn]} {
  set fd [open msg.$chn w]
  puts $fd [format "0"]
  close $fd
  }
  set fd [open msg.$chn r]
  set msgnums [gets $fd]
  if {$msgnums == "0"} {
  set linenumber 1
  } else {
  set linenumber [rand $msgnums]
  }
  set count 0
  set line [randmsgline $fd]
  while {($count < $linenumber) && ($line != "")} {
      set line [randmsgline $fd]
      incr count
  }
  close $fd
  if {$line == ""} {
  putserv "NOTICE $nick :Sorry there are no msgs stored yet for $chan... use !addmessage"
  } else {
  putserv "PRIVMSG $chan :$line"
  unset line
  }
  return 1
  }
}  
bind msg o|o !message msg_setmsg

proc pub_setmsg {nick hand uhost chan var} {
  set msg [lrange $var 0 end]
  set chn [string tolower $chan]
  if {$msg != ""} {
  putserv "PRIVMSG $chan :$msg"
  } else {
  if {![file exists msg.$chn]} {
  set fd [open msg.$chn w]
  puts $fd [format "0"]
  close $fd
  }
  set fd [open msg.$chn r]
  set msgnums [gets $fd]
  if {$msgnums == "0"} {
  set linenumber 1
  } else {
  set linenumber [rand $msgnums]
  }
  set count 0
  set line [randmsgline $fd]
  while {($count < $linenumber) && ($line != "")} {
      set line [randmsgline $fd]
      incr count
  }
  close $fd
  if {$line == ""} {
  putserv "NOTICE $nick :Sorry there are no msgs stored yet for $chan... use !addmessage"
  } else {
  putserv "PRIVMSG $chan :$line"
  unset line
  }
  return 1
  }
}  
bind pub o|o !message pub_setmsg

proc domsgtimer {} {
  global msgtimer changemsgtime
#  if {[info exists timeflag]} {
   set channels [channels]
   foreach chan $channels {
   set chn [string tolower $chan]
   if {![file exists msg.$chn]} {
   set fd [open msg.$chn w]
   puts $fd [format "0"]
   close $fd
   }
   set fd [open msg.$chn r]
   set msgnums [gets $fd]
   if {$msgnums == "0"} {
   set linenumber 1
   } else {
   set linenumber [rand $msgnums]
   }
   set count 0
   set line [randmsgline $fd]
   while {($count < $linenumber) && ($line != "")} {
       set line [randmsgline $fd]
       incr count
   }
   close $fd
   if {$line == ""} {
   putlog "Could not set msg for $chan, no msgs stored yet!"
   } else {
   putserv "PRIVMSG $chan :$line"
   unset line
   }
   }
   if {$msgtimer == "1"} {
   timer $changemsgtime domsgtimer
   }
   set timeflag on
   return 1
#  }
}

proc startmsgtime {} {
  global msgtimer changemsgtime
  if {$msgtimer == "1"} {
  timer $changemsgtime domsgtimer
  }
}
startmsgtime

proc randmsgline {filename} {
    set chars 0
    set msgline ""
    while {$chars != -1 && $msgline == ""} {
        set chars [gets $filename msgline]
        if {$chars != -1} {
            if { [regexp "^( |\t)*#" $msgline] } {
                set msgline ""
            }
            } else {
            set msgline ""
        }
    }
    return $msgline
}

putlog "msg v1.0 by Rich25... loaded successfully..."
