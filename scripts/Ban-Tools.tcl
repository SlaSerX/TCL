#################################################################
# Ban Tools.tcl By Arkadietz                                    #
# Powered by Arkadietz cOrp. © 2005-2006, Inc.                  #
#################################################################

# This little script adds (%Y/%m/%d $handle@$botnick) to your bans' reason, so banned
# person can see who set a ban on him
#
# any ideas, suggestions, bug-fixes, flames, English gramma corrections, cash,
# cars (I prefer newest model of Volvo), etc should go to me (conatct info
# above).
#
# Thanks to... ehmm... to all I like.
# Also big thanks to strftime man page ;)
#
# If you like this script, tell me about it!

unbind dcc o|o +ban *dcc:+ban;
bind dcc o|o +ban ban:+ban

proc ban:+ban {handle idx arg} {
  global botnick
    if {$arg == ""} {
    *dcc:+ban $handle $idx $arg
    return 0
  }
  set date [strftime %Y/%m/%d]
  *dcc:+ban $handle $idx "$arg ($date $handle@$botnick)"
}

putlog "TCL | Ban Tools"
