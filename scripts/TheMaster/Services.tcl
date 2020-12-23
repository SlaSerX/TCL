#################################################################################
## Imeto koeto botyt wi polzwa w IRC.
set ImeNaBota "DarkWitch"

## Parolata na botyt wi s koqto se identificira w NS-a.
set Parola "parolkata"

## Alternatiwniqt psewdonim na botyt. Tozi koito shte polzwa ako $ImeNaBota e zaet.
set AltImeNaBota "DarkWitch"

## Parolata za identifikaciq na Alternatiwniqt psewdonim.
set AltParola "parolkata2"

## uhost na NS (za UniBG go ostawete taka!)
set NSnuh "NS!NickServ@UniBG.services"

## uhost na CS (za UniBG go ostawete taka!)
set CSnuh "CS!ChanServ@UniBG.services"

## Flagowete koito skriptyt da dobawq na Services (Ako neznaete za kakwo stawa duma ne gi pipaite)
set servicesflags "+fEP-dk"

## Maksimalnata dyljina na psewdonim koito se pozwolqwa ot syrwyryt (za UniBG go ostawete taka!)
set nicklength 15



###############################################################################################
##       AKO NEZNAETE KAKWO PRAWITE NEDEITE DA SE MESITE S KODYT KOJTO SLEDWA !!!!!!!!!!!    ##
###############################################################################################



bind notc - * serv_check
bind raw - INVITE invite_me 

proc serv_check {nick uhost hand text dest} {
  global botnick NS NSnuh CSnuh IdPls IdOrDie PassAcc WrongPass NeedID NoAcc
  global NeedReg Parola AltParola ImeNaBota AltImeNaBota nicklength ChanNotReg
  if {[strlwr $botnick] != [strlwr $dest]} {
	return -1
  }
#################################### Start NS #####################################
  if {[strlwr "$nick!$uhost"] == [strlwr $NSnuh]} {
	if {[strlwr $text] == [strlwr $IdPls]} {
	  set NS(Critic) 1
	  set NS(SentPass) 1
	  set NS(NotId) 1
	  set NS(NotReg) 0
	  botnsidentify
	  putlog "ID PLS"
	} elseif {[strlwr $text] == [strlwr $IdOrDie]} {
	  set NS(Critic) 2
	  set NS(NotId) 1
	  set NS(NotReg) 0
	  if {$NS(SentPass) == 0} {
		set NS(SentPass) 1
		botnsidentify
	  }
	  putlog "ID OR DIE."
	} elseif {[strlwr $text] == [strlwr $PassAcc]} {
	  set NS(Critic) 0
	  set NS(SentPass) 0
	  set NS(NotReg) 0
	  set NS(NotId) 0
	  putlog "Acc pass."
	} elseif {[strlwr $text] == [strlwr $WrongPass]} {
	  set NS(NotReg) 0
	  if {$NS(Critic) == 1} {
		if {[strlwr $botnick] == [strlwr $ImeNaBota]} {
		  set NS(Critic) 0
		  set NS(SentPass) 0
		  set NS(NotId) 0
		  puthelp "NICK $AltImeNaBota"
		  set keep-nick 0
		}
		return 1
	  }
	  randchangenick
	  set NS(Critic) 0
	  set NS(SentPass) 0
	  set NS(NotReg) 0
	  set NS(NotId) 0
	  putlog "Wrn pass"
	}
#################################### Start CS #####################################
  } elseif {[strlwr "$nick!$uhost"] == [strlwr $CSnuh]} {
	if {$NS(NotReg) == 1} {
	  return -1
	}
	if {[string match -nocase "$NeedID*" $text]} {
	  botnsidentify
	  set NS(NotId) 1
	  set NS(Critic) 0
	  set NS(SentPass) 1
	  putlog "Ne sam id"
	  foreach channel [channels] {
		zanulall $channel "invite op unban Mod"
	  }
        } elseif {[string match -nocase "*have been cleared on*" $text]} {
          set channel [lindex $text [expr [llength $text] -1]]
          if {[string match "*GECOSBANS*" $text]} {
    	    set channel [string replace $channel 0 1 ""]
            set channel [string range $channel 0 [expr [string length $channel] - 2]]
          }
          putserv "JOIN $channel"
	} elseif {[string match -nocase "$NoAcc*" $text]} {
	  set level [string replace [lindex $text [expr [llength $text] -3]] 0 1 ""]
   	  set level [string range $level 0 [expr [string length $level] - 2]]
	  set channel [lindex $text [expr [llength $text] -1]]
	  if {[lsearch -exact [array names NoLevel] $channel] != -1} {
	  set NoLevel($channel) [linsert $NoLevel($channel) end $level]
	  } else {
	  set NoLevel($channel) [list $level]
	  }
	  if {[strlwr $level] == "invite"} {
		zanulall $channel invite
	  } elseif {[strlwr $level] == "op"} {
		zanulall $channel op
	  } elseif {[strlwr $level] == "unban"} {
		zanulall $channel unban
	  } elseif {[strlwr $level] == "clear"} {
		zanulall $channel Mod
	  }
	  putlog "Nqmam level"
	} elseif {[strlwr $text] == [strlwr $NeedReg]} {
	  botnsregister
	  set NS(NotReg) 1
	  set NS(NotId) 1
	  set NS(Critic) 0
	  set NS(SentPass) 0
	  foreach channel [channels] {
		zanulall $channel "invite op unban Mod"
	  }
	  putlog "Ne sam registriran"
	} elseif {[strlwr $text] == [strlwr ChanNotReg]} {
	  set channel [string replace [lindex $text [expr [llength $text] - 4]] 0 1 ""]
   	  set channel [string range $level 0 [expr [string length $level] - 2]]
	  zanulall $channel "invite op unban Mod"
	  putlog "$channel ne e reg"
	} else {
    }
  }
}

# From alltools.tcl.
proc strlwr {string} {
  string tolower $string
}

proc randstring {length {chars abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}} {
  set count [string length $chars]
  for {set index 0} {$index < $length} {incr index} {
	append result [string index $chars [rand $count]]
  }
  return $result
}

proc botnsidentify {} {
  global botnick ImeNaBota AltImeNaBota NS NSnuh Parola AltParola

  if {[strlwr $botnick] == [strlwr $ImeNaBota]} {
	puthelp "PRIVMSG [lindex [split $NSnuh "!"] 0] :identify $Parola"
  } elseif {[strlwr $botnick] == [strlwr $AltImeNaBota]} {
	puthelp "PRIVMSG [lindex [split $NSnuh "!"] 0] :identify $AltParola"
  } else {
	if {$NS(Critic) == 2} {
	  randchangenick
	}
  }
}

proc botnsregister {} {
  global botnick ImeNaBota AltImeNaBota NS NSnuh Parola AltParola

  if {[strlwr $botnick] == [strlwr $ImeNaBota]} {
	puthelp "PRIVMSG [lindex [split $NSnuh "!"] 0] :register $Parola $Parola"
  } elseif {[strlwr $botnick] == [strlwr $AltImeNaBota]} {
	puthelp "PRIVMSG [lindex [split $NSnuh "!"] 0] :register $AltParola $AltParola"
  }
}


proc invite_me {from key text} {
global CSnuh
  if {[strlwr [lindex [split $from "!"] 0]] == [lindex [split $CSnuh "!"] 0]} {
	zanulall [string range [lindex $text 1] 1 end] invite
  }
}

proc zanulall {chan types} {
  global Sent
  
  foreach type [split $types " "] {
	if {[lsearch -exact $Sent($type) $chan] != -1} {
	  set Sent($type) [lreplace $Sent($type) [lsearch -exact $Sent($type) $chan] [lsearch -exact $Sent($type) $chan]]
    }
  }
}

## Fuck the rules.
set keep-nick 1

if {[strlwr $nick] != [strlwr $ImeNaBota]} {
  set nick $ImeNaBota
  puthelp "NICK $ImeNaBota"
  putlog "Greshka, set nick ne savpada s \$ImeNaBota"
}

set altnick $AltImeNaBota

utimer 10 checkzz

set IdPls "This nickname is owned by someone else"
set IdOrDie "If you do not \001IDENTIFY\001 within one minute, you will be disconnected"
set PassAcc "Password accepted - you are now recognized"
set WrongPass "Password Incorrect"
set NeedID "Password identification is required for"
set NoAcc "An access level of"
set NeedReg "Your nickname is not registered"
set ChanNotReg "The channel"

array set NoLevel ""
set NS(Critic) 0
set NS(SentPass) 0
set NS(NotId) 0
set NS(NotReg) 0
set NS(Critic) 0
set Sent(op) ""
set Sent(unban) ""
set Sent(Mod) ""
set Sent(invite) ""

proc checkzz {} {
  global NSnuh CSnuh servicesflags
  
  foreach ignore [ignorelist] {
    if {[string match [lindex $ignore 0] $NSnuh] || [string match [lindex $ignore 0] $CSnuh] ||
	    [string match -nocase *!*@[lindex [split $NSnuh "@"] 1] [lindex $ignore 0] ]} {
	  killignore [lindex $ignore 0]
    }
  }
  
  if {![validuser Services]} {
	if {[adduser Services *@[lindex [split $NSnuh "@"] 1]]} {
      chattr Services +$servicesflags
	  setuser Services HOSTS "[lindex [split $CSnuh "!"] 0]!*@*"
	  setuser Services PASS [randstring 10]
    } else {
	  putlog "Can't add Services, \001ERROR\001!"
	}
  } else {
	chattr Services +$servicesflags
  }

  foreach chan [channels] {
	channel set $chan need-op ""
	channel set $chan need-unban ""
	channel set $chan need-invite ""
	channel set $chan need-key ""
	channel set $chan need-limit ""
    foreach ban [banlist $chan] {
	  if {[string match -nocase [lindex $ban 0] $CSnuh]} {
		killchanban $chan [lindex $ban 0]
	  }
    }
  }

  foreach ban [banlist] {
	if {[string match -nocase [lindex $ban 0] $CSnuh]} {
	  killban [lindex $ban 0]
	}
  }
}

putlog "NS/CS support TCL by *** Loaded!!!"

bind mode - *+o* opala

proc opala {nick uhost hand chan mdechg op} {
global botnick
  if {[strlwr $botnick] == [strlwr $op]} {
      zanulall [strlwr $chan] op
	}
}
bind need - "*" needall

proc needall {chan type} {
  global NS NoLevel CSnuh Sent
  if {([botonchan $chan] && $type != "op") || ([botisop $chan] && $type == "op") ||

      ($NS(NotId) == 1 || $NS(NotReg) == 1) || (($type != "limit" && $type != "key" 
         && [lsearch -exact $Sent($type) $chan] != -1)) ||
	  ([lsearch -exact $Sent(Mod) $chan] != -1 && ($type == "limit" || $type == "key"))} {
	return
  }

  if {$type == "op"} {
    if {[lsearch -exact [array names NoLevel] $chan] != -1} {
	  if {[lsearch -exact $NoLevel($chan) "op"] == -1} {
		putquick "PRIVMSG [lindex [split $CSnuh "!"] 0] :op $chan"
	    set Sent(op) [linsert $Sent(op) end $chan]
	  }
	  return
	}
    putquick "PRIVMSG [lindex [split $CSnuh "!"] 0] :op $chan"
	set Sent(op) [linsert $Sent(op) end $chan]
  } elseif {$type == "invite"} {
	if {[lsearch -exact [array names NoLevel] $chan] != -1} {
	  if {[lsearch -exact $NoLevel($chan) "invite"] == -1} {
	    putquick "PRIVMSG [lindex [split $CSnuh "!"] 0] :invite $chan"
		putserv "JOIN $chan"
		set Sent(invite) [linsert $Sent(invite) end $chan]
	  }
	  return
	}

    putquick "PRIVMSG [lindex [split $CSnuh "!"] 0] :invite $chan"
    putserv "JOIN $chan"
    set Sent(invite) [linsert $Sent(invite) end $chan]
  } elseif {$type == "limit" || $type == "key"} {
  	if {[lsearch -exact [array names NoLevel] $chan] != -1} {
	  if {[lsearch -exact $NoLevel($chan) "clear"] == -1} {
	    putserv "PRIVMSG [lindex [split $CSnuh "!"] 0] :clear $chan modes"
	    putserv "JOIN $chan"
	    set Sent(Mod) [linsert $Sent(Mod) end $chan]
	  }
	  return
	}

    putserv "PRIVMSG [lindex [split $CSnuh "!"] 0] :clear $chan modes"
	putserv "JOIN $chan"
    set Sent(Mod) [linsert $Sent(Mod) end $chan]
  } elseif {$type == "unban"} {
	if {[lsearch -exact [array names NoLevel] $chan] != -1} {
	  if {[lsearch -exact $NoLevel($chan) "unban"] != -1 && [lsearch -exact $NoLevel($chan) "clear"] != -1} {
	    return
	  } elseif {[lsearch -exact $NoLevel($chan) "clear"] != -1} {
		putquick "PRIVMSG [lindex [split $CSnuh "!"] 0] :unban $chan"
		putserv "JOIN $chan"
		set Sent(unban) 1
	  } elseif {[lsearch -exact $NoLevel($chan) "unban"] != -1} {
		putserv "PRIVMSG [lindex [split $CSnuh "!"] 0] :clear $chan bans"
		putserv "PRIVMSG [lindex [split $CSnuh "!"] 0] :clear $chan gecosbans"
	    putserv "JOIN $chan"
	    set Sent(unban) [linsert $Sent(unban) end $chan]
	  } else {
		putserv "PRIVMSG [lindex [split $CSnuh "!"] 0] :clear $chan gecosbans"
		putquick "PRIVMSG [lindex [split $CSnuh "!"] 0] :unban $chan"
		putserv "JOIN $chan"
		set Sent(unban) [linsert $Sent(unban) end $chan]
	  }
	  return
	}

    putserv "PRIVMSG [lindex [split $CSnuh "!"] 0] :clear $chan gecosbans"
	putquick "PRIVMSG [lindex [split $CSnuh "!"] 0] :unban $chan"
	putserv "JOIN $chan"
	set Sent(unban) [linsert $Sent(unban) end $chan]
  }
}

proc randchangenick {} {
  global botnick ImeNaBota AltImeNaBota nicklength

  if {[strlwr $botnick] == [strlwr $ImeNaBota]} {
	puthelp "NICK $AltImeNaBota"
  } else {
    if {[string length $AltImeNaBota] > [expr $nicklength - 3]} {
      puthelp "NICK [string range $AltImeNaBota 0 12][randstring 3]"
    } else {
      puthelp "NICK $AltImeNaBota[randstring 3]"
    }
  }
}

# TODO
# bota kato go bannat da prowerqwa dali e ot CS bana
