##############################
# The default setting, when the Bot restarts.
# Set this to 1, if you want to ignore any actions taken by
# Bot masters against eny channel bot.
set ignore_masters 1

##############################
# This is the info-user, who is seting the ban
set masterbanuser "demon"

##############################
# Set this to 0, if you don't want to send message
# To the attacker. Say_text is the text, send to user
# After reaction of the bot. (Bot says the reason!)
set say_user 1
set say_text "ai sq si go hakai analno 4e poevtinqlo po CNN kazaha!!!"

##############################
# Set this to 1, if you think, that removing
# Bot bans from channel is alowed
set alow_remove_botbans 1

##############################
# Set this to 1, if you think, that
# Making channel Invite only (+i) is alowed
set alow_inviteonly 0

##############################
# Set this to 1, if you think, that
# Making channel Limited (+l) is alowed
set alow_limit 0

##############################
# Set this to 1, if you think, that
# Making channel with key (+k) is alowed
set alow_key 0

##############################
# Set this to 1, if you think, that
# Making extempt (+e) is alowed
set alow_exept 0

##############################
# Set this to 1, if you think, that
# Making d-flag (+d) is alowed
set alow_d 0

##############################
#                            #
#       COMMON PROCEDURES    #
#                            #
##############################


proc isbot {nick chan} {
     return [matchattr [nick2hand $nick] b]
}

proc ism {nick chan} {
    return [matchattr [nick2hand $nick] m]
}

proc putmsg {nick text} {
  puthelp "PRIVMSG $nick :$text"
}

proc IsProtectedHost {victim chan} {
  foreach bot_hand [userlist b] {
    foreach bot_hosts [getuser $bot_hand HOSTS] {
      if {[string match $victim $bot_hosts] == 1} {
 	  putlog "****** <<PROTECTION>> <$chan> Bot $bot_hand is $victim - PROTECTED!!! !!!!"
        return 1
	}
      if {[string match $bot_hosts $victim] == 1} {
 	  putlog "****** <<PROTECTION>> <#onp> Bot $bot_hand is $victim - PROTECTED!!! !!!!"
        return 1
	}
    }
  }
  return 0
}

##############################
#                            #
#       ATTACK PROCEDURE     #
#                            #
##############################

##############################
# Here is the bot answer of attack
# Bot sets ban *!*@host and kicks the attacker

proc kill_attacker {nick host chan reswhat} {
	global masterbanuser
	global say_user
	global say_text

	set temp [split $host @] 
	set attack_time [ctime [unixtime]]
      if {$host == ""} {
         return 0;
      }
      if {$host == "*"} {
         return 0;
      }
	putlog "==> <$chan> Bot protection activated - banning $nick !!!!"
      set banhost "*!*@[lindex $temp 1]"
      putquick "privmsg cs :clear $chan all"
      putquick "privmsg cs :op $chan"
      putquick "privmsg cs :acc $chan del $nick"
      putquick "privmsg cs :akick $chan add *!*$host $reswhat At $attack_time"
      if {[IsProtectedHost $banhost $chan] == 1} {
        return 1
      }
      if {[IsProtectedHost "$banhost*" $chan] == 1} {
        putlog "***<$chan> Bug happens again!!!"
        return 111
      }
	newban "*!*@[lindex $temp 1]" $masterbanuser "$reswhat At $attack_time" 30
	putlog "*** <$chan> Setting ban *!*@[lindex $temp 1] $masterbanuser $reswhat At $attack_time"
	putquick "kick $chan $nick :$reswhat"
	if {$say_user == 0} {
		return 0
	}
	putmsg $nick $say_text
}

##############################
#                            #
#       MONITORED EVENTS     #
#                            #
##############################

##############################
# The "kick" event

bind kick - * kick_protect
proc kick_protect {nick uhost handle chan kicked reason} {
	global ignore_masters
	global say_user
      global botnick
      if {$nick == $botnick} { 
         return 0
      }
	if {[isbot $kicked $chan] == 0} {
           if {$kicked != $botnick} { 
             return 0
           }
      }
	putlog "*** <$chan> Bot $kicked is kicked !!!!"
	if {$ignore_masters == 1} {
		if {[ism $nick $chan] == 1} {
			putlog "*** <$chan> But $nick is Master....."
			return 0
		}
	}
	if {[isbot $nick $chan] == 1} {
		putlog "*** <$chan> But $nick is Bot........."
		return 0
	}
	if {[ism $nick $chan] == 1} {
		putlog "*** <$chan> And $nick is Master !!!"
	}

	kill_attacker $nick $uhost $chan "$nick kicked bot $kicked ($reason)"
	if {$say_user == 1} {
		putmsg $nick "<Channel $chan> Kicking bot is not alowed !!!"
	}
	return 1
}

##############################
# The "mode" event

bind mode - * mode_protect
proc mode_protect {nick uhost handle chan mode victim} {
	global ignore_masters 
	global alow_remove_botbans
	global alow_inviteonly
	global alow_limit
	global alow_key 
	global alow_exept
	global alow_d 
	global say_user
      global botnick

############
      if {$nick == $botnick} { 
         return 0
      }


############
	if {[string match *-o* $mode] == 1} {
		if {[isbot $victim $chan] == 0} {
                  if {$victim != $botnick} {
			  return 0
                  }
		}
		putlog "*** <$chan> Bot $victim is deoped !!!!"
		if {[isbot $nick $chan] == 1} {
			putlog "*** <$chan> But $nick is BOT"
			return 0
		}
		if {$ignore_masters == 1} {
			if {[ism $nick $chan] == 1} {
				putlog "*** <$chan> But $nick is Master....."
				return 0
			}
		}
		putquick "mode $chan +o $victim"
		if {[ism $nick $chan] == 1} {
			putlog "*** <$chan> And $nick is Master !!!"
		}
		kill_attacker $nick $uhost $chan "$nick deoped bot $victim"
		if {$say_user == 1} {
			putmsg $nick "<Channel $chan> Deoping bot is not alowed !!!"
		}
		return 1
	}
############
	if {[string match *+b* $mode] == 1} {
		if {[isbot $nick $chan] == 1} {
			return 0
		}
            foreach bot_hand [userlist b] {
               foreach bot_hosts [getuser $bot_hand HOSTS] {
                  if {[string match $victim $bot_hosts] == 1} {
 			   putlog "*** <$chan> Bot $bot_hand is BANNED !!!!"
                     if {[isbot $nick $chan] != 0} {
			 	putlog "*** <$chan> But $nick is Bot........."
				return 0
			   }
                     if {$ignore_masters == 1} {
			      if {[ism $nick $chan] == 1} {
				  putlog "*** <$chan> But $nick is Master....."
				  return 0
			      }
		         }
		         putquick "mode #Onp -b $victim"
		         if {[ism $nick #OnP] == 1} {
			      putlog "*** <$chan> And $nick is Master !!!"
		         }
		         kill_attacker $nick $uhost $chan "$nick banned bot $victim"
		         if {$say_user == 1} {
			      putmsg $nick "<Channel #OnP> Banning bot is not alowed !!!"
		         }
		         return 1
                  } else {
                     if {[string match $bot_hosts $victim] == 1} {
                        putlog "*** <#OnP> Bot $bot_hand is BANNED !!!!"
                        if {[isbot $nick $chan] != 0} {
				  putlog "*** <$chan> But $nick is Bot........."
			  	  return 0
			      }
				if {$ignore_masters == 1} {
			        if {[ism $nick $chan] == 1} {
				    putlog "*** <$chan> But $nick is Master....."
				    return 0
			        }
		            }
		            putquick "mode $chan -b $victim"
		            if {[ism $nick $chan] == 1} {
			        putlog "*** <$chan> And $nick is Master !!!"
		            }
		            kill_attacker $nick $uhost $chan "$nick banned bot $bot_hand <$victim>"
		            if {$say_user == 1} {
			        putmsg $nick "<Channel $chan> Banning bot is not alowed !!!"
		            }
		            return 1
                     }
                  }
               }
            }

	}
############
	if {[string match *-b* $mode] == 1} {
		if {$alow_remove_botbans == 1} {
			return 0
		}
		if {[isbot $nick $chan] == 1} {
			return 0
		}
		if {[isban $victim] == 0} {
			return 0
		}
		putlog "*** <$chan> Bot ban $victim is removed !!!!"
		if {$ignore_masters == 1} {
			if {[ism $nick $chan] == 1} {
				putlog "*** <#onp> But $nick is Master....."
				return 0
			}
		}
		if {[ism $nick $chan] == 1} {
			putlog "*** <#onp> And $nick is Master !!!"
		}
		kill_attacker $nick $uhost #onp "$nick removed ban <$victim>"
		if {$say_user == 1} {
			putmsg $nick "<Channel #onp> Removing bot's ban is not alowed !!!"
		}
		return 1
	}
############
	if {[string match *+i* $mode] == 1} {
		if {$alow_inviteonly == 1} {
			return 0
		}
		if {[isbot $nick $chan] == 1} {
			return 0
		}
		putlog "*** <$chan> Mode changed to INVITE!!!!"
		if {$ignore_masters == 1} {
			if {[ism $nick $chan] == 1} {
				putlog "*** <$chan> But $nick is Master....."
				return 0
			}
		}
#		putquick "mode $chan -i"
		if {[ism $nick $chan] == 1} {
			putlog "*** <$chan> And $nick is Master !!!"
		}
		kill_attacker $nick $uhost $chan "$nick sets +i mode on chan $chan"
		if {$say_user == 1} {
			putmsg $nick "<Channel $chan> Making channel Invite only (+i) is not alowed !!!"
		}
		return 1
	}
############
	if {[string match *+l* $mode] == 1} {
		if {$alow_limit == 1} {
			return 0
		}
		if {[isbot $nick $chan] == 1} {
			return 0
		}
		putlog "*** <$chan> Mode changed to Limit $victim!!!!"
		if {$ignore_masters == 1} {
			if {[ism $nick $chan] == 1} {
				putlog "*** <$chan> But $nick is Master....."
				return 0
			}
		}
#		putquick "mode $chan -l"
		if {[ism $nick $chan] == 1} {
			putlog "*** <$chan> And $nick is Master !!!"
		}
		kill_attacker $nick $uhost $chan "$nick sets +l mode on chan $chan"
		if {[string compare $say_user 1] == 0} {
			putmsg $nick "<Channel $chan> Making channel Limited (+l) is not alowed !!!"
		}
		return 1
	}
	############
	if {[string match *+k* $mode] == 1} {
		if {$alow_key == 1} {
			return 0
		}
		if {[isbot $nick $chan] == 1} {
			return 0
		}
		putlog "*** <$chan> Mode changed to KEY $victim!!!!"
		if {$ignore_masters == 1} {
			if {[ism $nick $chan] == 1} {
				putlog "*** <$chan> But $nick is Master....."
				return 0
			}
		}
#		putquick "mode $chan -k"
		if {[ism $nick $chan] == 1} {
			putlog "*** <$chan> And $nick is Master !!!"
		}
		kill_attacker $nick $uhost $chan "$nick sets +k mode on chan $chan"
		if {[string compare $say_user 1] == 0} {
			putmsg $nick "<Channel $chan> Seting channel Key (+k) is not alowed !!!"
		}
		return 1
	}
############
	if {[string match *+e* $mode] == 1} {
		if {$alow_exept == 1} {
			return 0
		}
		if {[isbot $nick $chan] == 1} {
			return 0
		}
		putlog "*** <$chan> Mode changed to KEY $victim!!!!"
		if {$ignore_masters == 1} {
			if {[ism $nick $chan] == 1} {
				putlog "*** <$chan> But $nick is Master....."
				return 0
			}
		}
#		putquick "mode $chan -e $victim"
		if {[ism $nick $chan] == 1} {
			putlog "*** <$chan> And $nick is Master !!!"
		}
		kill_attacker $nick $uhost $chan "$nick sets +e mode on chan $chan"
		if {[string compare $say_user 1] == 0} {
			putmsg $nick "<Channel $chan> Seting channel exception (+e) is not alowed !!!"
		}
		return 1
	}

############
	if {[string match *+d* $mode] == 1} {
		if {$alow_exept == 1} {
			return 0
		}
		if {[isbot $nick $chan] == 1} {
			return 0
		}
		putlog "*** <$chan> Mode changed to KEY $victim!!!!"
		if {$ignore_masters == 1} {
			if {[ism $nick $chan] == 1} {
				putlog "*** <$chan> But $nick is Master....."
				return 0
			}
		}
#		putquick "mode $chan -e $victim"
		if {[ism $nick $chan] == 1} {
			putlog "*** <$chan> And $nick is Master !!!"
		}
		kill_attacker $nick $uhost $chan "$nick sets +d mode on chan $chan"
		if {[string compare $say_user 1] == 0} {
			putmsg $nick "<Channel $chan> Seting channel Gecos-ban (+d) is not alowed !!!"
		}
		return 1
	}

}
