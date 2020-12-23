
# set nickname described in o-line
set onick "cloud"

# set pass for opernick
set opass ""

# set server where is opernick
set oserv "irc.illusion.bg"

## End of Settings ##

bind raw - 001 oper_mode
proc oper_mode {from keyw arg} {
  global server oserv onick opass botnick
  set from [string tolower $from]
  set oserv [string tolower $oserv]
  if {$from == $oserv} {
    putserv "oper $onick $opass"
    putserv "mode $botnick +yxzkcbw"
    putlog "Acquire the IRCop atribute on server $from"
  } {
    putlog "Could't acquire the IRCop atribute on server $from"
  }
}

putlog "\002Loaded\002: IRC(o)p TCL by SlaSerX (C)"

