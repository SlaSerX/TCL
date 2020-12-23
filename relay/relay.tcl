#------------------------------------------------------------------------
# relay.tcl v1.0.0 - Send channel text from one network to another       
#   By: cl00bie <cl00bie@sorcery.net>
# relay.tcl v1.0.1 - EDITED by iamdeath @ Cricket #Undernet
# Fixed bugs and added more features and added color features.
#-------------------------------------------------------------------------
# This script takes text, joins, parts, etc.  From a channel on one network, 
# sends it to the other network on the same channel and visa versa.  This 
# script requires two bots which are botnetted (Instructions on how to link
# bots is beyond the scope of this document.  See BOTNET in the $eggdrop/doc
# directory.)
#
# Once your bots are netted, simply add the channels you'd like to relay
# to the channelList variable, fill in the server?List variables (as per
# (the instructions) and load this script on both bots.
#
# Proposed Enhancements:
#  o xkick - kick someone off the remote bot channel
#  o xwhois - do a /whois on the remote bot channel
#  o xmsg - send a private message to someone on the remote bot channel
#  o Synchronize topics
#------------------------------------------------------------------------  

# List of channels to relay between (lower case only!)
set channelList "#cricket"

# This identifies the server information of the two networks you wish to
#  relay to each other.  There are three entries in each and they are as
#  follows:
#  0 - A unique pattern in each of the servers you use on a particular 
#      network.  (ex. all SorceryNet servers contain the word "sorcery"
#      in them, but none of the DALnet servers use this.)
#  1 - The name of the network as you'd like it to appear on the *other*
#      network (ex. <Dal-Bot> [SorceryNet] <Nickname> hi there everyone on
#      DALnet :))
#  2 - The name of the bot which sits on the *other* network.  (The bot you
#      want the informaiton sent *to*)
set server1List "dal DALnet Cricket"
set server2List "undernet Undernet Dalnet"

# Procedure: send_across - sends the information from one network to 
#   the other.
proc send_across {cmd chan nick text} {
  global server channelList server1List server2List
  if {[lsearch $channelList [string tolower $chan]] != -1} {
    if  {[string first [lindex $server1List 0] $server] != -1} {
      set fromServer "[lindex $server1List 1]"
      set toBot "[lindex $server1List 2]" 
    } else {
      set fromServer "[lindex $server2List 1]"
      set toBot "[lindex $server2List 2]" 
    }
    set botMsg [concat $cmd $chan $fromServer $nick $text]
    putbot $toBot $botMsg
  }
}

# Find out who's on the other network channel
proc send_xnames {nick uhost hand arg} {
  if {$arg == "" || [string first "#" $arg] != 0} {
    putserv "NOTICE $nick :Usage\: /msg Eros xnames #channel"
  } else {
    if {[onchan $nick $arg]} {
      send_across "names" $arg $nick "dummy"
    } else {
      putserv "NOTICE $nick :I'm sorry, you must be in channel $arg to do a remote names (xnames) command"
    }
  }
}
bind msg - xnames send_xnames

proc relay_xnames {frm_bot command arg} {
  set startingChanlist "[chanlist [lindex $arg 0]]" 
  foreach mem $startingChanlist {
    if {[isop $mem [lindex $arg 0]]} {
      lappend finalChanlist \@$mem
    } elseif {[isvoice $mem [lindex $arg 0]]} {
      lappend finalChanlist \+$mem
    } else {
      lappend finalChanlist $mem
    }
  }
  send_across "rnames" [lindex $arg 0] [lindex $arg 2] $finalChanlist
}
bind bot - names relay_xnames

proc recv_xnames {frm_bot command arg} {
  putserv "NOTICE [lindex $arg 2] :\00301We have linked our channel with [lindex $arg 0] @ [lindex $arg 1]. The following people are on the channel: [lrange $arg 3 end]\003"
}
bind bot - rnames recv_xnames

proc send_nick {nick uhost hand chan newnick} {
  send_across "nick" $chan $nick $newnick
}
bind nick - * send_nick

proc recv_nick {frm_bot command arg} {
  putserv "PRIVMSG [lindex $arg 0] :\[[lindex $arg 1]\] *** \00303[lindex $arg 2] is now known as [lrange $arg 3 end]\003"
}
bind bot - nick recv_nick

proc send_mode {nick uhost hand chan mchg victim} {
  if {[string first "b" [lindex $mchg 0]] != -1} {
    send_across "ban" $chan $nick $mchg 
  }
}
bind mode - * send_mode

# Multiple recv's from one send
proc recv_ban {frm_bot command arg} {
  putserv "MODE [lindex $arg 0] [lrange $arg 3 end]"
}
bind bot - ban recv_ban

proc send_sign {nick uhost hand chan reason} {
  send_across "sign" $chan $nick $reason
}
bind sign - * send_sign

proc recv_sign {frm_bot command arg} {
  putserv "PRIVMSG [lindex $arg 0] :\[[lindex $arg 1]\] *** \00302[lindex $arg 2] Quits \([lrange $arg 3 end] \)\003"
}
bind bot - sign recv_sign

proc send_pubm {nick uhost hand chan text} {
  set cmd "pubm"
  if {[isop $nick $chan]} {set nick "\@$nick"}
  if {[isvoice $nick $chan]} {set nick "\+$nick"}
  send_across $cmd $chan $nick $text
}
bind pubm - * send_pubm

proc recv_pubm {frm_bot command arg} {
  putserv "PRIVMSG [lindex $arg 0] :\[[lindex $arg 1]\] \<[lindex $arg 2]\> [lrange $arg 3 end]"
}
bind bot - pubm recv_pubm

proc send_action {nick uhost hand chan keyw text} {
  send_across "act" $chan $nick $text
}
bind ctcp - "ACTION" send_action

proc recv_action {frm_bot command arg} {
  putserv "PRIVMSG [lindex $arg 0] :\[[lindex $arg 1]\] \00306\* [lindex $arg 2] [lrange $arg 3 end]\003"
}
bind bot - act recv_action

proc send_join {nick uhost hand chan} {
  send_across "join" $chan $nick "dummy"
  send_across "names" $chan $nick "dummy"
}
bind join - * send_join

proc recv_join {frm_bot command arg} {
  putserv "PRIVMSG [lindex $arg 0] :\[[lindex $arg 1]\] \*** \00303[lindex $arg 2] has joined channel [lindex $arg 0]\003"
}
bind bot - join recv_join

proc send_kick {nick uhost hand chan target reason} {
 send_across "kicks" $chan $nick "$target $reason"
}
bind kick - * send_kick

proc recv_kick {frm_bot command arg} {
  putserv "PRIVMSG [lindex $arg 0] :\[[lindex $arg 1]\] \*** \00303[lindex $arg 3] was kicked by [lindex $arg 2] \([lindex $arg 4]\)\003"
}
bind bot - kicks recv_kick

proc send_part {nick uhost hand chan arg} {
  send_across "part" $chan $nick ""
}
bind part - * send_part

proc recv_part {frm_bot command arg} {
  putserv "PRIVMSG [lindex $arg 0] :\[[lindex $arg 1]\] \*** \00303[lindex $arg 2] has left channel [lindex $arg 0]\003"
}
bind bot - part recv_part

putlog "relay 1.0.0 by: cl00bie <cl00bie@sorcery.net> edited by: iamdeath"
