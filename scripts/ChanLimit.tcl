# chanlimit.tcl v1.5 (1 April 1999) by slennox <slenny@ozemail.com.au>
# Latest versions can be found at www.ozemail.com.au/~slenny/eggdrop/
#
# This script maintains a user limit in channels your bot is in. It is used
# primarily to help discourage large flood attacks.
#
# Some features in this script that you won't find in some other limiter 
# scripts include the ability to select the channels in which to activate
# the limiting function, and a 'grace' to reduce the number of unnecessary
# mode changes (i.e. if the limit doesn't need to be changed by more than
# the grace number, it doesn't bother setting the new limit).
#
# DCC commands (channel/global +m users)
# .dolimit to run limit checking on demand
# .stoplimit to temporarily stop limiting
# .startlimit to restart limiting
#
# Note that this script has only been tested for eggdrop 1.3.x
#
# v1.0 - Initial release
# v1.1 - Added .stoplimit and .startlimit commands, added support for
# limiting on +k channels, improved startup timer
# v1.2 - Oops, fixed problem with .dolimit command causing multiple timers
# to load
# v1.3 - Hmm, limiter kept setting limit on +k channels even when it didn't
# need to be changed (found by icetrey), seems the different method for
# getting the current limit when channel is +k wasn't needed
# v1.4 - Small fix for people who use +k - tcl error was occuring if there
# was an 'l' in the key (found by wangster), putlog at startup/rehash now
# shows which channels limiting is active on
# v1.5 - Limiting wasn't working if upper case characters were used in
# cl_chans list (found by \-\iTman), streamlined some timer checks,
# limiting on channels containing []{}\ wasn't working when entered in
# cl_chans list
#
# Credits: this script was inspired by UserLimiter v0.32 by ^Fluffy^

# Channels in which to activate limiting, this should be a list like
# "#elephants #wildlife #etc". Leave it set to "" if you wish to activate
# limiting on all channels the bot is on.
set cl_chans "#ruse"

# Limit to set (number of users on the channel + this setting)
set cl_limit 5

# Limit grace (if the limit doesn't need to be changed by more than this,
# don't bother setting a new limit)
set cl_grace 2

# Frequency of checking whether a new limit needs to be set (in minutes)
set cl_timer 1


# Don't edit anything below unless you know what you're doing

proc cl_dolimit {} {
  global cl_chans cl_limit cl_grace cl_timer
  timer $cl_timer cl_dolimit
  foreach chan [string tolower [channels]] {
    if {$cl_chans != ""} {
      if {[lsearch -exact [split $cl_chans] [string tolower $chan]] == -1} {continue}
    }
    if {![botisop $chan]} {continue}
    set numusers [llength [chanlist $chan]]
    set newlimit [expr $numusers + $cl_limit]
    if {[string match *l* [lindex [getchanmode $chan] 0]]} {
      set currlimit [string range [getchanmode $chan] [expr [string last " " [getchanmode $chan]] + 1] end]
      } else {
      set currlimit 0
    }
    if {$newlimit == $currlimit} {continue}
    if {$newlimit > $currlimit} {
      set difference [expr $newlimit - $currlimit]
      } elseif {$currlimit > $newlimit} {
      set difference [expr $currlimit - $newlimit]
    }
    if {$difference <= $cl_grace} {continue}
    pushmode $chan "+l" "$newlimit"
    flushmode $chan
    putlog "chanlimit: set +l $newlimit on $chan"
  }
}

proc cl_dccdolimit {hand idx arg} {
  foreach timer [timers] {
    if {[string match *cl_dolimit* $timer]} {
      killtimer [lindex $timer 2]
    }
  }
  putidx $idx "Checking limits..."
  cl_dolimit
}

proc cl_dccstoplimit {hand idx arg} {
  foreach timer [timers] {
    if {[string match *cl_dolimit* $timer]} {
      killtimer [lindex $timer 2]
      putidx $idx "Limiting is now OFF."
      return 0
    }
  }
  putidx $idx "Limiting is already off."
}

proc cl_dccstartlimit {hand idx arg} {
  global cl_timer
  if {[string match *cl_dolimit* [timers]]} {
    putidx $idx "Limiting is already on."
    return 0
  }
  timer $cl_timer cl_dolimit
  putidx $idx "Limiting is now ON."
}

proc cl_startlimit {} {
  global cl_timer
  if {[string match *cl_dolimit* [timers]]} {return 0}
  timer $cl_timer cl_dolimit
}

set cl_chans [string tolower $cl_chans]

cl_startlimit

bind dcc m|m dolimit cl_dccdolimit
bind dcc m|m stoplimit cl_dccstoplimit
bind dcc m|m startlimit cl_dccstartlimit

if {$cl_chans == ""} {
  putlog "Loaded chanlimit.tcl v1.5 by slennox (active on all channels)"
} else {
putlog "Loaded chanlimit.tcl v1.5 by slennox (active on: [join $cl_chans ", "])"
}
