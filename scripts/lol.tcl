#         #   #   ##   #####        #          @@@@     @@
#    #### #   #  #       #          #             @    @  @
#    #  # #       #      #  ### ### #    ###     @     @  @
#    #  # #        #     #  # # # # #     #     @      @  @
#### #### ####  ###      #  ### ### #### ###    @    @  @@

# [LoL's TooLz 7.0a]
#
# Eggdrop TCL Script: [LoL's TooLz] Copyright (C) 1998-2003 Ltd Productions.
# This software is free under the terms of GNU GPL 2.
# Type .gpl-lol in party-line for more information.
#
# HomePage: http://www.SweetHeLL.Cx/
#
# ORIGINAL AUTHOR: dJ_TEDY
# 	E-MAIL: TeodoR11@oo1corp.zzn.com	ICQ: 171768872
#
# NEW MAINTENER: Yoann SERVANT alias Thor
#	E-MAIL: yservant@free.fr	ICQ: 50383313
#
# Thanks for bugs reports (and patches):
#	Hawkeye, PPSlim, Tim Ballantine and many others.
#
################################################################################
#
# LEVELS USED IN LOL'S TOOLZ:
#
#            +M +N (Masters, Owners) [+B & +0 (Bots with +O) in passive mode]
#               +O (Operators)
#               +V (Voice)
#               +F (Friend)
#               - (User without flags)
#               *  (Nothing = Not a bot user)
#
# MAKE SURE COMMANDS THAT USE THE PRIORITY LEVELS ARE NOT SET SO THAT
# LOWER USERS ARE ALLOWED TO PERFORM A NEGATIVE ACTION ON A USER WITH A HIGHER
# LEVEL. BOTS HAVE THE HIGHEST LEVEL TO PREVENT BOTWARS (THE BOT
# ALWAYS RESPECTS THE COMMANDS OF OTHER BOTS).

#########
# SETUP #
#########

# ENABLE (1) OR DISABLE (0) CHAN-KEY AUTO-UPDATE AND CHAN_KEY MEMORISATION.
# ***** WARNING !!!! *****
# IF YOU USE GETOPS.TCL YOU NEED TO SET 0 HERE.
set lol(chankey) 0

# THESE ARE THE DEFAULT FLAGS, YOU CAN CHANGE THEM WHEN THE BOT IS ONLINE.

# BAN TYPE 
# HOW DO YOU WANT TO BAN THE USER ? DEFAULT 1
#  0 - *!*user@*.domain
#  1 - *!*@host.domain
set lol(bantype) 0

# SET THE CHARACTER THAT WILL BE USED BEFORE PUBLIC QUERRIES
# EXAMPLE: "#" => #seen, #op .... DEFAULT: "!"
# IF YOU USE MANY BOTS WITH LoL's TooLz IN THE SAME CHAN, IT CAN BE VERY USEFUL
# TO GIVE EACH BOTS A DIFFERENT COMMAND CHARACTER.
set lol(cmdchar) "."

# ENABLE (1) OR DISABLE (0) SECURITY WARNING WHEN NEWBIE MASTERS JOIN THE PARTY-LINE.
# WITH THE NEW IDENT SYSTEM THERE IS NO BIG SECURITY RISK.
set lol(security) 0

# ENABLE (1) OR DISABLE (0) PASSWORD CHECKER WHEN A USER JOINS THE CHAN.
# IF SET TO 1, THE BOT REMEMBERS A USER WITHOUT HAVING A PASSWORD SET.
set lol(nopass) 1

# ENABLE (1) OR DISABLE (0) IDENTIFICATION SYSTEM.
# WARNING !!! IF THIS IS DISABLED, SECURITY IS NOT GUARANTED.
# THE BOT WILL USE ONLY USERMASKS TO IDENTIFY USERS.
# USE THIS AT YOUR OWN RISK. DEFAULT: 1
set lol(ident) 1

# ENABLE (1) OR DISABLE (0) IDENTIFICATION CONFIRMATION.
set lol(id_confirm) 1

# ENABLE (1) OR DISABLE (0) ALERTS A USER TO IDENT HIMSELF IN ORDER TO USE THE CHAN COMMANDS. 
# 1 = DON'T WARN.
# WITH THE NEW SILENT, UNSILENT COMMANDS, YOU SHOULD KEEP
# 0 HERE TO ALLOW USERS TO CHOOSE THEIR OWN MODE.
# IF YOU SET 1 HERE, THE USER'S CHOICE IS OVERRIDEN AND SILENT MODE REMAINS.
set lol(silent) 0

# SET TO 1 IF YOU WANT CLONES TO BE IDENTIFIED. 
# IF SET TO 0, ONLY THE LAST NICK THAT MADE THE IDENT IS IDENTIFIED. 
# IF YOU ARE ON A SHELL WITH MULTIPLE ACCOUNTS, YOU MAY WANT TO PLACE 0 HERE.
set lol(clone) 1

# ENABLE (1) OR DISABLE (0) JOKES
set lol(jokes) 1

# !HELP AND !TROUBLES ARE 2 PUBLIC COMMANDS THAT USE BANDWITH.
# THERE CAN BE WARBOTS THAT FLOOD THE CHAN SAYING !HELP OR
# !TROUBLES MULTIPLES TIMES. IT CAN BE A GOOD IDEA TO DISABLE
# THEM (FOR THE PUBLIC ONLY).

# ENABLE (1) OR DISABLE (0) !HELP COMMAND FOR USERS NOT ON THE BOT.
set lol(help) 0

# ENABLE (1) OR DISABLE (0) !TROUBLES COMMAND FOR USERS NOT ON THE BOT.
set lol(troubles) 0

# ENABLE (1) OR DISABLE (0) !SEEN COMMAND FOR USERS NOT ON THE BOT.
set lol(seen) 1

# ENABLE (1) OR DISABLE (0) !TIME COMMAND FOR USERS NOT ON THE BOT.
set lol(time) 1

# ADJUST THESE DEFAULT CHAN LINES (USED BY !JOIN, .JOIN...)
#(flood accepted:number of seconds)
set lol(chan_flood) "10:60"
set lol(join_flood) "10:60"
set lol(deop_flood) "3:10"
set lol(ctcp_flood) "3:30"
set lol(kick_flood) "3:10"
set lol(chan_parameters) "+clearbans +enforcebans +dynamicbans +userbans -autoop -bitch +greet -protectops -statuslog -stopnethack -revenge -autovoice -secret -shared +cycle -seen"
set lol(chanmode) "+nt"

# DEFAULT SERVER FLAGS
# CHANGE THIS ONLY IF YOU KNOW THE SERVER FLAGS...
set lol(server_flags) "+iw-s"

# ENABLE (1) OR DISABLE (0) BOT PROTECTION AGAINST BANS MADE
# BY LOWER USERS AGAINST HIGHER USERS.
# IF THE BAN IS SET BY A CHAN MASTER, ONLY A WARNING IS DISPLAYED. IF NOT,
# THE FLAG OF THE USER AND OF THE VICTIM(S) ARE COMPARED. IF THE
# VICTIM HAS THE HIGHEST FLAG, THE BAN IS REMOVED BY THE BOT.
# THE BOT ALSO REMOVES BANS THAT MATCH ITSELF.
set lol(ban_protect) 1

# AWAY MESSAGE, IF YOU WANT TO SET AN AWAY MESSAGE FOR THE BOT...
set lol(away) "SweetHell Guard BOT"

# ENABLE (1) OR DISABLE (0) WELCOME MESSAGE FOR THE USERS NOT ON THE BOT.
# (WELCOME CAN USE A LOT OF BANDWIDTH IF YOU HAVE HIGH TRAFFIC CHANS)
set lol(welcome) 1

# IF YOU WANT A SPECIAL WELCOME MESSAGE ON YOUR CHANS, SET IT HERE. IF NOT,
# KEEP IT EMPTY ! (EMPTY = DEFAULT MESSAGE)
set lol(welmsg) ""

# ENABLE (1) OR DISABLE (0) PROTECTION AGAIN IDLE USERS.
# ALL THE IDLE SETTINGS BELOW APPLY ONLY IF IDLE PROTECTION IS ENABLED. 
set lol(idle_protect) 0

# HOW LONG UNTIL A USER RECEIVES AN IDLE WARNING BY MSG. IF THIS
# VALUE IS GREATER OR EQUAL THAN max_idle_time, THERE IS NO WARNING.
# VALUE IS IN MINUTES.
set lol(warn_idle_time) 99999

# HOW LONG A USER CAN BE IDLE ON A CHAN BEFORE BEING BANNED.
# VALUE IS IN MINUTES.
set lol(max_idle_time) 99999

# HOW LONG UNTIL AN IDLE USER IS KICKED FROM THE CHAN. IF THIS VALUE IS LOWER
# THAN max_idle_time, THE USER IS KICKED AND NEVER BANNED. TO DISABLE IDLE KICK
# AND KEEP ONLY IDLE BAN, SET A VALUE GREATER THAN max_idle_time HERE.
# VALUE IS IN MINUTES.
set lol(kick_idle_time) 99999

# HOW MANY TIME AN IDLE USER IS BANNED.  VALUE IS IN MINUTES.
set lol(idle_ban_time) 0

# SET THE FLAGS FOR USERS THAT YOU DO NOT WANT KICKED IN THE EVENT OF
# A !KICK <MASK>, !QUICK <MASK>, CLIENT KICK (!MIRC, !IRCII...). THE OPED
# OR VOICED USERS AT THE MOMENT OF THE KICK ARE NOT KICKED, THIS SETTING ONLY
# AFFECTS THE OTHER USERS IN THE CHAN. FOR EXAMPLE IF YOU WANT TO PROTECT
# +N, +M, +O, +V: set lol(no_kick_flags) "nmov"
set lol(no_kick_flags) "nmo"

# SAME AS ABOVE BUT FOR !BAN <MASK>
set lol(no_ban_flags) "nmo"

# SAME AS ABOVE BUT FOR THE IDLE USERS (IF YOU SET "" HERE, ALL THE NON OPED,
# NON VOICED USERS *EVEN IF THE BOT DETECTS THEY HAVE +N OR +O* CAN BE KICKED
# OR BANNED IF THEY ARE IDLE.
set lol(no_idle_flags) "nmo"

#########
# BINDS #
#########

# CHANGE THE FLAGS AT YOUR OWN RISK !!! FOR EXAMPLE m|m => o|o
# IT CAN CREATE SECURITY HOLES AND SCRIPT PROBLEMS.
# YOU CAN DISABLE ANY COMMANDS PLACING "#" BEFORE THEM.

bind pub n [string trim $lol(cmdchar)]param pub_lol_param
bind pub n [string trim $lol(cmdchar)]enable pub_lol_enable
bind pub n [string trim $lol(cmdchar)]disable pub_lol_disable
bind pub n [string trim $lol(cmdchar)]deluser pub_lol_deluser
bind pub n -user pub_lol_deluser
bind pub n [string trim $lol(cmdchar)]join pub_lol_join
bind pub n +chan pub_lol_join
bind pub n [string trim $lol(cmdchar)]remove pub_lol_remove
bind pub n -chan pub_lol_remove
bind pub n [string trim $lol(cmdchar)]part pub_lol_remove
bind pub n [string trim $lol(cmdchar)]addhost pub_lol_addhost
bind pub n +host pub_lol_addhost
bind pub n [string trim $lol(cmdchar)]delhost pub_lol_delhost
bind pub n -host pub_lol_delhost
bind pub n|n [string trim $lol(cmdchar)]addowner pub_lol_addowner
bind pub n|n +owner pub_lol_addowner
bind pub n|n [string trim $lol(cmdchar)]addmaster pub_lol_addmaster
bind pub n|n +master pub_lol_addmaster
bind pub n|n [string trim $lol(cmdchar)]delowner pub_lol_delowner
bind pub n|n -owner pub_lol_delowner
bind pub n|n [string trim $lol(cmdchar)]delmaster pub_lol_delmaster
bind pub n|n -master pub_lol_delmaster
bind pub m [string trim $lol(cmdchar)]jump pub_lol_jump
bind pub m [string trim $lol(cmdchar)]botnick pub_lol_botnick
bind pub m|m [string trim $lol(cmdchar)]adduser pub_lol_adduser
bind pub m|m +user pub_lol_adduser
bind pub m|m [string trim $lol(cmdchar)]addbot pub_lol_addbot
bind pub m|m +bot pub_lol_addbot
bind pub m|m [string trim $lol(cmdchar)]addop pub_lol_addop
bind pub m|m +op pub_lol_addop
bind pub m|m [string trim $lol(cmdchar)]delop pub_lol_delop
bind pub m|m -op pub_lol_delop
bind pub m|m [string trim $lol(cmdchar)]findip pub_lol_findip
bind pub o|o [string trim $lol(cmdchar)]ban pub_lol_ban
bind pub o|o +b pub_lol_ban
bind pub o|o [string trim $lol(cmdchar)]unban pub_lol_unban
bind pub o|o -b pub_lol_unban
bind pub o|o [string trim $lol(cmdchar)]chattr pub_lol_chattr
bind pub o|o [string trim $lol(cmdchar)]mode pub_lol_chan
bind pub o|o [string trim $lol(cmdchar)]op pub_lol_op
bind pub o|o +o pub_lol_op
bind pub o|o [string trim $lol(cmdchar)]deop pub_lol_deop
bind pub o|o -o pub_lol_deop
bind pub o|o [string trim $lol(cmdchar)]banlist pub_lol_banlist
bind pub o|o [string trim $lol(cmdchar)]broadcast pub_lol_broadcast
bind pub o|o [string trim $lol(cmdchar)]addvoice pub_lol_addvoice
bind pub o|o +voice pub_lol_addvoice
bind pub o|o [string trim $lol(cmdchar)]delvoice pub_lol_delvoice
bind pub o|o -voice pub_lol_delvoice
bind pub o|o [string trim $lol(cmdchar)]addfriend pub_lol_addfriend
bind pub o|o +friend pub_lol_addfriend
bind pub o|o [string trim $lol(cmdchar)]delfriend pub_lol_delfriend
bind pub o|o -friend pub_lol_delfriend
bind pub o|o [string trim $lol(cmdchar)]topic pub_lol_topic
bind pub o|o [string trim $lol(cmdchar)]whois pub_lol_whois
bind pub o|o [string trim $lol(cmdchar)]online pub_lol_online
bind pub o|o [string trim $lol(cmdchar)]quick pub_lol_quick
bind pub o|o [string trim $lol(cmdchar)]mirc pub_lol_mirc
bind pub o|o [string trim $lol(cmdchar)]bitchx pub_lol_bitchx
bind pub o|o [string trim $lol(cmdchar)]ircii pub_lol_ircii
bind pub o|o [string trim $lol(cmdchar)]eggdrop pub_lol_eggdrop
bind pub o|o [string trim $lol(cmdchar)]info pub_lol_info
bind pub ov|ov [string trim $lol(cmdchar)]voice pub_lol_voice
bind pub ov|ov +v pub_lol_voice
bind pub ov|ov [string trim $lol(cmdchar)]devoice pub_lol_devoice
bind pub ov|ov -v pub_lol_devoice
bind pub ov|ov [string trim $lol(cmdchar)]kick pub_lol_kick
bind pub ov|ov [string trim $lol(cmdchar)]stats pub_lol_stats
bind pub ov|ov [string trim $lol(cmdchar)]cigarette pub_lol_cigarette
bind pub ov|ov [string trim $lol(cmdchar)]rose pub_lol_rose
bind pub ov|ov [string trim $lol(cmdchar)]pastis pub_lol_pastis
bind pub ov|ov [string trim $lol(cmdchar)]pastaga pub_lol_pastis
bind pub ov|ov [string trim $lol(cmdchar)]51 pub_lol_pastis
bind pub ov|ov [string trim $lol(cmdchar)]coca-cola pub_lol_coke
bind pub ov|ov [string trim $lol(cmdchar)]coke pub_lol_coke
bind pub ov|ov [string trim $lol(cmdchar)]beer pub_lol_beer
bind pub ov|ov [string trim $lol(cmdchar)]penalty pub_lol_penalty
bind pub - [string trim $lol(cmdchar)]silent pub_lol_silent
bind pub - [string trim $lol(cmdchar)]unsilent pub_lol_unsilent
bind pub - [string trim $lol(cmdchar)]unident pub_lol_unident
bind pub - [string trim $lol(cmdchar)]unpermident pub_lol_unpermident
bind pub - [string trim $lol(cmdchar)]uid pub_lol_unident
bind pub - [string trim $lol(cmdchar)]upid pub_lol_unpermident
bind pub - [string trim $lol(cmdchar)]time pub_lol_time
bind pub - [string trim $lol(cmdchar)]seen pub_lol_seen
bind pub - [string trim $lol(cmdchar)]help pub_lol_help
bind pub - [string trim $lol(cmdchar)]troubles pub_lol_troubles

# DCC
bind dcc n param dcc_lol_param
bind dcc n enable dcc_lol_enable
bind dcc n disable dcc_lol_disable
bind dcc n join dcc_lol_join
bind dcc n j dcc_lol_join
bind dcc m notice dcc_lol_notice
bind dcc m partyban dcc_lol_partyban
bind dcc m botnick dcc_lol_botnick
bind dcc m|m part dcc_lol_part
bind dcc m|m p dcc_lol_part
bind dcc m|m security dcc_lol_security
bind dcc m|m addop dcc_lol_addop
bind dcc m|m delop dcc_lol_delop
bind dcc o userlist dcc_lol_userlist
bind dcc o chanlist dcc_lol_chanlist
bind dcc o online dcc_lol_online
bind dcc ot|o whois dcc_lol_whois
bind dcc o|o onotice dcc_lol_onotice
bind dcc o|o channel dcc_lol_channel
bind dcc o|o mode dcc_lol_mode
bind dcc - seen dcc_lol_seen
bind dcc - silent dcc_lol_silent
bind dcc - unsilent dcc_lol_unsilent
bind dcc - unident dcc_lol_unident
bind dcc - unpermident dcc_lol_unpermident
bind dcc - permident dcc_lol_permident
bind dcc - uid dcc_lol_unident
bind dcc - upid dcc_lol_unpermident
bind dcc - pid dcc_lol_permident
bind dcc - help-lol dcc_lol_help-lol
bind dcc - gpl-lol dcc_lol_gpl-lol
bind dcc - chanhelp dcc_lol_chanhelp
bind dcc - identhelp dcc_lol_identhelp

# MSG
bind msg n param msg_lol_param
bind msg n enable msg_lol_enable
bind msg n disable msg_lol_disable
bind msg n join msg_lol_join
bind msg n j msg_lol_join
bind msg n remove msg_lol_remove
bind msg n r msg_lol_remove
bind msg n part msg_lol_remove
bind msg n p msg_lol_remove
bind msg n deluser msg_lol_deluser
bind msg n addhost msg_lol_addhost
bind msg n delhost msg_lol_delhost
bind msg n|n addmaster msg_lol_addmaster
bind msg m msg msg_lol_msg
bind msg m botnick msg_lol_botnick
bind msg m|m part msg_lol_part
bind msg m|m p msg_lol_part
bind msg m|m addop msg_lol_addop
bind msg m|m adduser msg_lol_adduser
bind msg m|m addbot msg_lol_addbot
bind msg o|o chattr msg_lol_chattr
bind msg o|o broadcast msg_lol_broadcast
bind msg o|o addvoice msg_lol_addvoice
bind msg o|o key msg_lol_key
bind msg o|o quick msg_lol_quick
bind msg o|o banlist msg_lol_banlist
bind msg o|o ban msg_lol_ban
bind msg o|o unban msg_lol_unban
bind msg o|o mode msg_lol_chan
bind msg o|o online msg_lol_online
bind msg ov|ov invite msg_lol_invite
bind msg ov|ov whois msg_lol_whois
bind msg ov|ov kick msg_lol_kick
bind msg - seen msg_lol_seen
bind msg - silent msg_lol_silent
bind msg - unsilent msg_lol_unsilent
bind msg - ident msg_lol_ident
bind msg - permident msg_lol_permident
bind msg - unpermident msg_lol_unpermident
bind msg - unident msg_lol_unident
bind msg - id msg_lol_ident
bind msg - pid msg_lol_permident
bind msg - upid msg_lol_unpermident
bind msg - uid msg_lol_unident
bind msg - help msg_lol_help

################
# END OF SETUP #
################

  ###############################################################
 ##                                                             ##
##  USUALLY YOU DON'T HAVE TO CHANGE ANY OF THE FOLLOWING LINES  ##
 ##                                                             ##
  ###############################################################

################# MISC #################
set lol(version_number) "7.0"
set lol(version) "\002LoL's TooLz $lol(version_number)\002"

bind dcc - help dcc_lol_help
bind chon - * chon_security
bind join - * join_welcome
bind mode - * lol_watch_mode
unbind dcc - su *dcc:su
unbind msg - ident *msg:ident
bind dcc n su *dcc:su
#unbind pub -|- seen *pub:seen
unbind msg - invite *msg:invite
bind ctcr * VERSION lol_ctcp_version
bind mode - "* +k" see_new_pass
bind nick - * chidentnick
bind sign - * deident
bind join - * joinident
bind kick - * kickident
bind rejn - * rejnident
bind raw * 311 lol_whois_reply
bind raw * 318 lol_whois_unknow
bind raw * 401 lol_whois_nofound
set init-server {initserv}

################# START OF JOIN PROCEDURES #################

proc chon_security {hand idx} {
	global lol
	if {$lol(security) == 0} {return 0}
	set find 0
	foreach chan [channels] {
		if {[matchattr $hand -|m $chan]} {
			set find 1
			break
		}
	}
	if {[matchattr $hand m]} {set find 1}
	if {[matchattr $hand n]} {set find 0}
	if {$find == 0} {return 0}
	putdcc $idx "\002*** WARNING !!!! ***\r"
        putdcc $idx "For security reasons masters must NOT SET THE +a FLAG (auto-op) !!!\r"
        putdcc $idx "Type \002.security\002 for more information...\r"
        putdcc $idx "!!! Type \002.help-lol\002 to see the special commands for $lol(version) !!!\r"
}

proc join_welcome {nick host hand chan} {
	global lol botnick
	if {![validuser $hand]} {
		if {$lol(welcome) == 1 && $nick != $botnick} {
			if {$lol(welmsg) != ""} {
				puthelp "NOTICE $nick :$lol(welmsg)"
			} {
				if {$lol(help) == 1} {
                        	puthelp "NOTICE $nick :!!! Please don't flood, abuse or advertise or you will get killed/klined/glined. Thank you! Type \002[string trim $lol(cmdchar)]help\002 for more..."
				} {
                              puthelp "NOTICE $nick :2Welcome to $chan 4 Enjoy your stay have fun and 5BEHAVE4 !!!!"
				}
			}
		}
	}
	if {[passwdok $hand ""] && ![matchattr $hand b]} {
		if {$lol(nopass) == 1} {
			puthelp "NOTICE $nick :\002You haven't still a password set !!! YOU MUST SET YOUR PASSWORD !!!"
			puthelp "NOTICE $nick :\002To set your password type: /msg $botnick pass <your_new_password>"
		}
	}
}

################# END OF JOIN PROCEDURES #################

################# START OF CHAN COMMANDS #################

### !INFO <INFO LINE>

proc pub_lol_info {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no longer receive this alert."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]info <info line>"
		return 0
	}
	if {[string length $arg] > 80} {
            puthelp "NOTICE $nick :Your infoline is too long and has not been stored. (MAX: 80 Chars)"
		return 0
	}
	setchaninfo $hand $chan $arg
	puthelp "NOTICE $nick :\002$arg\002 stored in your info line for $chan."
	return 0
}

### !SILENT

proc pub_lol_silent {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $mynick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no longer receive this alert."
		return 0
	}
	setuser $hand xtra silent 1
}

### !UNSILENT

proc pub_lol_unsilent {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no longer receive this alert."
		return 0
	}
	setuser $hand xtra silent 0
      puthelp "NOTICE $nick :You are no longer in silent mode.\r"
}

### !UNPERMIDENT

proc pub_lol_unpermident {nick host hand chan arg} {
	setuser $hand xtra permident ""
	if {[getuser $hand xtra auth] != "DEAD"} { setuser $hand xtra auth 0 }
	chattr $hand -3
      puthelp "NOTICE $nick :You are no longer using a permident mask."
}

### !UNIDENT

proc pub_lol_unident {nick host hand chan arg} {
	if {![check $hand $nick $host]} { return 0 }
	if {[getuser $hand xtra auth] != "DEAD"} { setuser $hand xtra auth 0 }
	chattr $hand -3
}

### !BOTNICK <nick>

proc pub_lol_botnick {mynick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick nick
	if {![check $hand $mynick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $mynick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no longer receive this alert."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $mynick :\002Usage:\002 [string trim $lol(cmdchar)]botnick <nick>"
		return 0
	}
	set nick [lindex $arg 0]
}

### !JUMP [server] [port]

proc pub_lol_jump {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no longer receive this alert."
		return 0
	}
	set server [lindex $arg 0]
	set port [lindex $arg 1]
	if {![isnumber $port]} {set port ""}
	if {$server == ""} { jump ; return 0 }
	if {[isnumber $port]} {
		jump $server $port
	} {
		jump $server
	}
	return 0
}

### !ADDHOST <nick|hand> [host]

proc pub_lol_addhost {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no longer receive this alert."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]addhost <nick|hand> \[host\]"
		return 0
	}
	set who [lindex $arg 0]
	set host [lindex $arg 1]
	if {$host == ""} {
		set ipmask [lindex [split [maskhost $who![getchanhost $who $chan]] "@"] 1]
		set userm [lindex [split [getchanhost $who $chan] "@"] 0]
		set host *!*$userm@$ipmask
		if {[nick2hand $who $chan] == "*"} {
			if {[validuser $who]} {
				setuser $who hosts $host
				puthelp "NOTICE $nick :$host added for $who."
				return 0
			}
                  puthelp "NOTICE $nick :$who is not a user on the bot."
			return 0
		}
		puthelp "NOTICE $nick :$who is already recognized by the bot with this hand: [nick2hand $who $chan]."
		return 0
	}
	if {![onchan $who $chan]} {
		if {[validuser $who]} {
			setuser $who hosts $host
			puthelp "NOTICE $nick :$host added for $who."
			return 0
		} {
			puthelp "NOTICE $nick :$who is not in $chan, and there is no user with this hand."
			return 0
		}
	} {
		set whohand [nick2hand $who $chan]
		if {$whohand == "*"} {
			if {![validuser $who]} {
				puthelp "NOTICE $nick :$who is not a registered user and no user in the bot has the hand $who."
				return 0
			} {
				setuser $who hosts $host
				puthelp "NOTICE $nick :$host added for $who."
				return 0
			}
		} {
			setuser $whohand hosts $host
			puthelp "NOTICE $nick :$host added for $who ($whohand)."
			return 0
		}
	}
	return 0
}

### !DELHOST <nick|hand> <host>

proc pub_lol_delhost {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no longer receive this alert."
		return 0
	}
	if {[llength $arg] != 2} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]delhost <nick|hand> <host>"
		return 0
	}
	set who [lindex $arg 0]
	set host [lindex $arg 1]
	if {![onchan $who $chan]} {
		set whohand $who
		if {[validuser $whohand]} {
			if {[delhost $whohand $host]} {
				puthelp "NOTICE $nick :$host removed for $who."
				return 0
			} {
                        puthelp "NOTICE $nick :I can't remove $host from $who."
				return 0
			}
		} {
			puthelp "NOTICE $nick :$who is not in $chan, and there is no user with this hand."
			return 0
		}
	}
	set whohand [nick2hand $who $chan]
	if {$whohand == "*"} {
		puthelp "NOTICE $nick :$who is not a registered user."
		return 0
	}
	if {[delhost $whohand $host]} {
		puthelp "NOTICE $nick :$host removed for $who."
		return 0
	} {
            puthelp "NOTICE $nick :I can't remove $host from $who."
		return 0
	}
	return 0
}

### !CHATTR <nick> <flags>

proc pub_lol_chattr {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 2} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]chattr <nick> <flags>"
		return 0
	}
	set who [lindex $arg 0]
	set flags [lindex $arg 1]
	if {![onchan $who $chan]} {
            puthelp "NOTICE $nick :Sorry, but I don't see $who in $chan."
		return 0
	}
	set whohand [nick2hand $who $chan]
	if {$whohand == "*"} {
		puthelp "NOTICE $nick :$who is not a registered user."
		return 0
	}
	if {[matchattr $hand n|n $chan]} {
		set change [chattr $whohand -|$flags $chan]
		if {$change != ""} {
			set change [lindex [split $change "|"] 1]
                  puthelp "NOTICE $nick :$who now has these flags in $chan: $change"
			return 0
		}
		puthelp "NOTICE $nick :The flags for $who have not changed."
		return 0
	}
	regsub -all -- "n" $flags "" flags
	regsub -all -- "m" $flags "" flags
	if {[matchattr $hand m|m $chan]} {
		set change [chattr $whohand -|$flags $chan]
		if {$change != ""} {
			set change [lindex [split $change "|"] 1]
                  puthelp "NOTICE $nick :$who now has these flags in $chan: $change"
			return 0
		}
		puthelp "NOTICE $nick :The flags for $who have not changed."
		return 0
	}
	regsub -all -- "o" $flags "" flags
	if {[matchattr $hand o|o $chan]} {
		set change [chattr $whohand -|$flags $chan]
		if {$change != ""} {
			set change [lindex [split $change "|"] 1]
                  puthelp "NOTICE $nick :$who now has these flags in $chan: $change"
			return 0
		}
		puthelp "NOTICE $nick :The flags for $who have not changed."
		return 0
	}
      puthelp "NOTICE $nick :You do not have not enough rights to use this function."
	return 0
}

### !JOIN <chan> [chan pass]

proc pub_lol_join {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]join <chan> \[chan pass\]"
		return 0
	}
	set chan [lindex $arg 0]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set pass [lindex $arg 1]
	if {[validchan $chan]} {
		puthelp "NOTICE $nick :I'm already monitoring $chan. "
		if {$pass != ""} {
			if {$lol(chankey) == 1} {
				puthelp "NOTICE $nick :New pass set for $chan: $pass."
				channel set $chan need-key "chankey $chan $pass"
			} {
				puthelp "NOTICE $nick :I can't memorize password to keep compatibility with getops.tcl"
			}
		}
		if {![onchan [strlwr $botnick] $chan]} {
			puthelp "NOTICE $nick :I'll now try to join it."
			putserv "JOIN $chan $pass"
			return 0
		}
		puthelp "NOTICE $nick :I'm already in $chan."
		return 0
	}
	puthelp "NOTICE $nick :New chan monitoring : $chan."
	channel add $chan
	channel set $chan chanmode $lol(chanmode)
	channel set $chan flood-chan $lol(chan_flood)
	channel set $chan flood-deop $lol(deop_flood)
	channel set $chan flood-kick $lol(kick_flood)
	channel set $chan flood-join $lol(join_flood)
	channel set $chan flood-ctcp $lol(ctcp_flood)
	foreach param $lol(chan_parameters) { channel set $chan $param }
	if {$pass != ""} {
		if {$lol(chankey) == 1} {
			puthelp "NOTICE $nick :New pass set for $chan : $pass. "
			channel set $chan need-key "chankey $chan $pass"
		} {
			puthelp "NOTICE $nick :I can't memorize password to keep compatibility with getops.tcl"
		}
	}
	puthelp "NOTICE $nick :$chan is now configured. I'll now try to join it."
	puthelp "NOTICE $nick :Use \002.-chan\002 to remove a chan (chan userlist will be deleted)."
	putserv "JOIN $chan $pass"
}

### !REMOVE [chan]

proc pub_lol_remove {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set ch [lindex $arg 0]
	if {$ch != ""} {set ch [chanaddapt $ch]}
	if {$ch == ""} {set ch $chan}
	if {![validchan $ch]} {	puthelp "NOTICE $nick :I'm not on $ch " ;	return 0 }
	channel remove $ch
	puthelp "NOTICE $nick :$ch has been removed."
}

### !PARAM <parameter> <value>

proc pub_lol_param {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 2} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]param <parameter> <value>"
		set param_display ""
		append param_display "\002cmdchar:\002 $lol(cmdchar)"
		append param_display "   "
		append param_display "\002security:\002 $lol(security)"
		append param_display "   "
		append param_display "\002nopass:\002 $lol(nopass)"
		append param_display "   "
		append param_display "\002chankey:\002 $lol(chankey)"
		append param_display "   "
		append param_display "\002silent:\002 $lol(silent)"
		append param_display "   "
		append param_display "\002ident:\002 $lol(ident)"
		append param_display "   "
		append param_display "\002id_confirm:\002 $lol(id_confirm)"
		append param_display "   "
		append param_display "\002clone:\002 $lol(clone)"
		append param_display "   "
		append param_display "\002jokes:\002 $lol(jokes)"
		append param_display "   "
		append param_display "\002help:\002 $lol(help)"
		append param_display "   "
		append param_display "\002troubles:\002 $lol(troubles)"
		append param_display "   "
		append param_display "\002seen:\002 $lol(seen)"
		append param_display "   "
		append param_display "\002time:\002 $lol(time)"
		append param_display "   "
		append param_display "\002chan_flood:\002 $lol(chan_flood)"
		append param_display "   "
		append param_display "\002join_flood:\002 $lol(join_flood)"
		append param_display "   "
		append param_display "\002deop_flood:\002 $lol(deop_flood)"
		append param_display "   "
		append param_display "\002ctcp_flood:\002 $lol(ctcp_flood)"
		append param_display "   "
		append param_display "\002kick_flood:\002 $lol(kick_flood)"
		append param_display "   "
		append param_display "\002chan_parameters:\002 $lol(chan_parameters)"
		puthelp "NOTICE $nick :$param_display"
		set param_display ""
		append param_display "\002ban_protect:\002 $lol(ban_protect)"
		append param_display "   "
		append param_display "\002chanmode:\002 $lol(chanmode)"
		append param_display "   "
		append param_display "\002server_flags:\002 $lol(server_flags)"
		append param_display "   "
		append param_display "\002welcome:\002 $lol(welcome)"
		append param_display "   "
		append param_display "\002idle_protect:\002 $lol(idle_protect)"
		append param_display "   "
		append param_display "\002warn_idle_time:\002 $lol(warn_idle_time)"
		append param_display "   "
		append param_display "\002max_idle_time:\002 $lol(max_idle_time)"
		append param_display "   "
		append param_display "\002kick_idle_time:\002 $lol(kick_idle_time)"
		append param_display "   "
		append param_display "\002idle_ban_time:\002 $lol(idle_ban_time)"
		append param_display "   "
		append param_display "\002no_kick_flags:\002 $lol(no_kick_flags)"
		append param_display "   "
		append param_display "\002no_ban_flags:\002 $lol(no_ban_flags)"
		append param_display "   "
		append param_display "\002no_idle_flags:\002 $lol(no_idle_flags)"
		puthelp "NOTICE $nick :$param_display"
		set param_display ""
		append param_display "\002welmsg:\002 $lol(welmsg)"
		puthelp "NOTICE $nick :$param_display"
		set param_display ""
		append param_display "\002away:\002 $lol(away)"
		puthelp "NOTICE $nick :$param_display"
		return 0
	}
	set lol([strlwr [lindex $arg 0]]) [lrange $arg 1 end]
	puthelp "NOTICE $nick :The new value of [strlwr [lindex $arg 0]] is [lrange $arg 1 end]."
	return 0
}

### !ENABLE <nick>

proc pub_lol_enable {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
                puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]enable <nick>"
		return 0
	}
	set who [lindex $arg 0]
	set whohand [nick2hand $who $chan]
	if {![onchan $who $chan]} {
            puthelp "NOTICE $nick :Sorry, but I don't see $who in $chan."
		return 0
	}
	if {[strlwr $who] == [strlwr $botnick]} {
            puthelp "NOTICE $nick :I don't need to be enabled."
		return 0
	}
	if {$whohand == "*"} {
            puthelp "NOTICE $nick :I don't recognize $who as a user."
		return 0
	}
	if {[getuser $whohand xtra auth] != "DEAD"} {
		puthelp "NOTICE $nick :$who is already enabled."
		return 0
	}
	setuser $whohand xtra auth 0
	puthelp "NOTICE $nick :$who is now enabled."
	return 0
}

### !DISABLE <nick>

proc pub_lol_disable {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]disable <nick>"
		return 0
	}
	set who [lindex $arg 0]
	set whohand [nick2hand $who $chan]
	if {![onchan $who $chan]} {
            puthelp "NOTICE $nick :Sorry, but I don't see $who in $chan."
		return 0
	}
	if {[strlwr $who] == [strlwr $botnick]} {
            puthelp "NOTICE $nick :I can't be disabled."
		return 0
	}
	if {$whohand == "*"} {
            puthelp "NOTICE $nick :I don't recognize $who as a user."
		return 0
	}
	if {[getuser $whohand xtra auth] == "DEAD"} {
		puthelp "NOTICE $nick :$who is already disabled."
		return 0
	}
	setuser $whohand xtra auth DEAD
	chattr $whohand -3
	puthelp "NOTICE $nick :$who is now disabled."
	return 0
}

### !ONLINE

proc pub_lol_online {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol server {server-online} uptime botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set ip [lindex [split $server ":"] 0]
	set port [lindex [split [lindex [split $server ":"] 1] "-"] 0]
	set timeon [time_diff ${server-online}]
	set numbots 0
	foreach bot [bots] { incr numbots }
	set numchans 0
	foreach ch [channels] { incr numchans }
	set msg ""
      append msg "*** ONLINE info !!! ***"
	append msg "I have not crashed since [time_diff $uptime] ;) "
	append msg "\002I'm on $ip since $timeon.\002 "
	append msg "I'm on $numchans chans. "
	if {$numbots != 0} {
		append msg "\002I'm linked with $numbots bots.\002 "
	} {
		append msg "\002I'm not linked with bots.\002 "
	}
	puthelp "PRIVMSG $chan :$msg"
}

### !BROADCAST <text>

proc pub_lol_broadcast {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]broadcast <text>"
		return 0
	}
	foreach c [channels] {
		if {[matchattr $hand o|o $c] && [strlwr $c] != [strlwr $chan]} {
			puthelp "PRIVMSG $c :\00314\[\003\002$nick\002\00314\]\003 $arg"
		}
	}
}

### !STATS

proc pub_lol_stats {nick host han chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $han $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $han]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set op 0
	set voice 0
	set reco 0
	set normal 0
	set total 0
	foreach vnick [chanlist $chan] {
		if {[nick2hand $vnick $chan] != "*"} { incr reco }
		if {[isop $vnick $chan]} { incr op }
		if {[isvoice $vnick $chan] && ![isop $vnick $chan]} {	incr voice }
		if {![isvoice $vnick $chan] && ![isop $vnick $chan] && [nick2hand $vnick $chan] == "*" && [strlwr $vnick] != [strlwr $botnick]} {
			incr normal
		}
		incr total
	}
	set reco_pc [expr (100 / $total) * $reco]
	set op_pc [expr (100 / $total) * $op]
	set voice_pc [expr (100 / $total) * $voice]
	set normal_pc [expr (100 / $total) * $normal]
	puthelp "PRIVMSG $chan :*** $chan STATS !!! *** \002Oped:\002 $op ($op_pc%) \002Voiced:\002 $voice ($voice_pc%) \002Bot users:\002 $reco ($reco_pc%) \002Other:\002 $normal ($normal_pc%) \002Total:\002 $total"
}

### !SEEN <nick|hand>

proc pub_lol_seen {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol
	if {![validuser $hand] && $lol(seen) == 0} {return 0}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $nick :\002Usage\002: !seen <nick|hand>"
		return 0
	}
	set who [lindex $arg 0]
	set prefix "\00314\[\003\002$nick\002\00314\]\003 "
	append msg $prefix [lol_seen $nick $hand $who $chan]
	puthelp "PRIVMSG $chan :$msg"
	return 0
}

### !BANLIST

proc pub_lol_banlist {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set num 1
      puthelp "NOTICE $nick :*** $chan BANS info !!! ***"
	foreach bans [banlist $chan] {
		set victim [lindex $bans 0]
		set why [lindex $bans 1]
		set expire [lindex $bans 2]
		set who [lindex $bans 5]
		set remain [expr $expire - [unixtime]]
		if {$remain > 0} {
			set remain "expire in [time_diff2 $expire]."
		} {
			set remain "PermBan"
		}
		puthelp "NOTICE $nick :\002BAN $num:\002 $victim, $remain"
		puthelp "NOTICE $nick :$who: $why"
		incr num
	}
      if {$num == 1} {puthelp "NOTICE $nick :There are no bans on the bot for chan $chan."}
	return 0
}

### !BAN <nick|mask> [time] [reason]

proc pub_lol_ban {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]ban <nick|mask> \[time\] \[reason\]"
		return 0
	}
	set who [lindex $arg 0]
	if {[strlwr $who] == [strlwr $botnick]} {
		puthelp "NOTICE $nick :Yeah right, like I'm going to let you ban ME!"
		return 0
	}
	
	set ti [lindex $arg 1]
	if {[isnumber $ti]} {
		set reason [lrange $arg 2 end]
	} {
		set ti ""
		set reason [lrange $arg 1 end]
	}

	if {$reason == ""} { set reason "requested" }
	
	if {[onchan $who $chan]} {
		if { $lol(bantype) == 0 } { 
			set ipmask [lindex [split [maskhost $who![getchanhost $who $chan]] "@"] 1]
			set usermask [lindex [split [getchanhost $who $chan] "@"] 0]		
			set banmask *!*$usermask@$ipmask
		} else { 
			set banmask [getchanhost $who $chan]
     	      	set banmask "*!*[string range $banmask [string first @ $banmask] e]" 
		}	
	} else {  		
		set banmask [lindex $arg 0]
		if {[string first "!" $banmask] == -1 && [string first "@" $banmask] == -1} {
			if {[isnumber [string index $banmask 0]]} { 
				set banmask *!*@$banmask 
			} else {
				 set banmask $banmask*!*@* 
			}
		}
		if {[string first "!" $banmask] == -1} { set banmask *!*$banmask }
		if {[string first "@" $banmask] == -1} { set banmask $banmask*@* }
	}
			   		
	if {![botisop $chan]} { return 0 }
	putserv "MODE $chan +b $banmask"

  	foreach chanuser [chanlist $chan] {
      	if {[string match [strlwr $banmask] [strlwr "$chanuser![getchanhost $chanuser $chan]"]] && $chanuser != $botnick } { 
			if {[nick2hand $chanuser $chan] != "*"} {
				if {$hand != [nick2hand $chanuser $chan]} {
					if {[matchattr [nick2hand $chanuser $chan] o|o $chan] && ![matchattr $hand o|o $chan]} {
                  	            puthelp "NOTICE $nick :Sorry, you must be an operator to ban an operator."
						return 0
					}
					if {([matchattr [nick2hand $chanuser $chan] m|m $chan] || [matchattr [nick2hand $who $chan] b]) && ![matchattr $hand m|m $chan]} {
            	                  puthelp "NOTICE $nick :Sorry, you must be a master to ban a master or a bot."
						return 0
					}
				}
			}
	    	   	putkick $chan $chanuser $reason
		}
       }	 

	switch $ti {
		""
		{
			newchanban $chan $banmask $nick $reason
			puthelp "NOTICE $nick :New mask added : $banmask"
		}
		0
		{
			newchanban $chan $banmask $nick $reason $ti
			puthelp "NOTICE $nick :New mask added permanently : $banmask"
		}
		default
		{
			newchanban $chan $banmask $nick $reason $ti
			puthelp "NOTICE $nick :New mask added for $ti minutes : $banmask"
		}
	}
	return 0
}

### !UNBAN <mask|number>

proc pub_lol_unban {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]unban <mask|number>"
		return 0
	}
	set find 0
	set mask [lindex $arg 0]

	if {[isnumber $mask]} {
		foreach bans [banlist $chan] {
			incr find
			if {$find == $mask} { set mask [lindex $bans 0] ; break }
		}
		if {[isnumber $mask]} {
			puthelp "NOTICE $nick :There is no ban number $mask in this chan, type !banlist."
			return 0
		} 
	} else {	if {[string first "!" $mask] == -1 && [string first "@" $mask] == -1} {
				if {[isnumber [string index $mask 0]]} { set mask *!*@$mask 
				} else { set mask $mask*!*@* }
			}
			if {[string first "!" $mask] == -1} {set mask *!*$mask}
			if {[string first "@" $mask] == -1} {set mask $mask*@*}
	}
	
	if {[isban $mask $chan]} { 
		killchanban $chan $mask
		killban $mask
		puthelp "NOTICE $nick :Ban successfully removed on $chan."
		return 0
	} 

	foreach bans [chanbans $chan] {
		set victim [lindex $bans 0]
		if {[strlwr $victim] == [strlwr $mask]} {set find 1}
	}

	if {[botisop $chan] && $find == 1} {
		pushmode $chan -b $mask
            puthelp "NOTICE $nick :Ban successfully removed."
		return 0
	}
		
	puthelp "NOTICE $nick :No such ban on $chan."
	return 0
}

### !MODE <chanmode>

proc pub_lol_chan {nick host hand chan mode} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $mode]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]mode <chanmode>"
		return 0
	}
	if {$lol(chankey) == 1} {
		if {[string first k [lindex $mode 0]] != -1} {
			set posmode [string first k [lindex $mode 0]]
			if {[string first l [lindex $mode 0]] != -1} {
				set poslim [string first l [lindex $mode 0]]
				if {$posmode < $poslim} {
					channel set $chan need-key "chankey $chan [lindex $mode 1]"
				} {
					channel set $chan need-key "chankey $chan [lindex $mode 2]"
				}
			} {
				channel set $chan need-key "chankey $chan [lindex $mode 1]"
			}
		}
	}
	putserv "MODE $chan $mode"
	return 0
}

### !ADDUSER <nick> [hand]

proc pub_lol_adduser {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]adduser <nick> \[hand\]"
		return 0
	}
	set nick [lindex $arg 0]
	set alternate [lindex $arg 1]
	set bot [strlwr $botnick]
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
            puthelp "NOTICE $me :Sorry, but I can't adduser myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {[validuser $hand]} {
		puthelp "NOTICE $me :$nick is already recognized with this hand: $hand"
	} {
		if {[validuser $nick] && $alternate == ""} {
			puthelp "NOTICE $me :The hand $nick already exist. \002Usage:\002 !adduser <nick> <hand> "
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "NOTICE $me :The hand $alternate already exists. Choose another. \002Usage:\002 !adduser <nick> <hand>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
			puthelp "NOTICE $nick :You have been added in $botnick userlist by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			return 0
		}
		adduser $nick [maskhost $hostmask]
		puthelp "NOTICE $me :New user: $nick ([maskhost $hostmask])"
		puthelp "NOTICE $nick :You have been added in $botnick userlist by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
			puthelp "NOTICE $me :The hand $alternate already exist. \002Usage:\002 !adduser <nick> <hand>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
		puthelp "NOTICE $nick :You have been added in $botnick userlist by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		return 0
	}
	return 0
}

### !DELUSER <nick>

proc pub_lol_deluser {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]deluser <nick>"
		return 0
	}
	set nick [lindex $arg 0]
	set bot [strlwr $botnick]
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
            puthelp "NOTICE $me :Yeah right, like I'm going to let you delete ME!"
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		puthelp "NOTICE $me :$nick is not a registered user."
		return 0
	}
	if {[matchattr $hand n]} {
		puthelp "NOTICE $me :You can't delete a bot owner."
		return 0
	}
	deluser $hand
	boot $hand "You have been deleted"
      puthelp "NOTICE $me :$nick has been removed from the userlist."
      puthelp "NOTICE $nick :You have been removed from the userlist by $me."
	if {[botisop $chan]} {pushmode $chan -o $nick}
	return 0
}

### !ADDOWNER <nick> [hand] 

proc pub_lol_addowner {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]addowner <nick> \[hand\]"
		return 0
	}
	set nick [lindex $arg 0]
	set alternate [lindex $arg 1]
	set bot [strlwr $botnick]
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
            puthelp "NOTICE $me :Sorry, but I can't addowner myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		if {[validuser $nick] && $alternate == ""} {
                  puthelp "NOTICE $me :The hand $nick already exists. \002Usage:\002 !addowner <nick> <hand>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "NOTICE $me :The hand $alternate already exists. Choose another. \002Usage:\002 !addowner <nick> <hand>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			chattr $alternate +p|+n $chan
			puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
                  puthelp "NOTICE $me :$nick added to the $chan ownerlist and party-line with the hand: $alternate."
                  puthelp "NOTICE $nick :You have been added to the $chan ownerlist and party-line by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			if {[botisop $chan] && ![isop $nick $chan]} { pushmode $chan +o $nick }
			return 0
		}
		adduser $nick [maskhost $hostmask]
		chattr $nick +p|+n $chan
		puthelp "NOTICE $me :New user: $nick ([maskhost $hostmask])"
            puthelp "NOTICE $me :$nick added to the $chan ownerlist and party-line with the hand: $nick."
            puthelp "NOTICE $nick :You have been added to the $chan ownerlist and party-line by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		if {[botisop $chan] && ![isop $nick $chan]} { pushmode $chan +o $nick }
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "NOTICE $me :The hand $alternate already exists. \002Usage:\002 !addowner <nick> <hand>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		chattr $alternate +p|+n $chan
		puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
            puthelp "NOTICE $me :$nick added to the $chan ownerlist and party-line with the hand: $alternate."
            puthelp "NOTICE $nick :You have been added to the $chan ownerlist and party-line by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		if {[botisop $chan] && ![isop $nick $chan]} { pushmode $chan +o $nick }
		return 0
	}
	if {[matchattr $hand -|+n $chan]} {
            puthelp "NOTICE $me :$nick is already an owner in $chan with this hand: $hand"
	} {
		chattr $hand -|+n $chan
            puthelp "NOTICE $me :$nick added to the $chan ownerlist with this hand: $hand."
            puthelp "NOTICE $nick :You have been added to the $chan ownerlist by $me."
	}
	if {[botisop $chan] && ![isop $nick $chan]} { pushmode $chan +o $nick ; return 0 }
	return 0
}

### !DELOWNER <nick>

proc pub_lol_delowner {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]delowner <nick>"
		return 0
	}
	set nick [lindex $arg 0]
	set bot [strlwr $botnick]
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
            puthelp "NOTICE $me :Yeah right, like I'm going to let you delowner ME!"
		return 0
	}
	if {![validuser $hand]} {
		puthelp "NOTICE $me :$nick is not a registered user."
		if {[botisop $chan] && [isop $nick $chan]} { pushmode $chan -o $nick }
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![matchattr $hand -|+n $chan]} {
                puthelp "NOTICE $me :$nick is not an owner in $chan"
	} {
		chattr $hand -|-n $chan
            puthelp "NOTICE $me :$nick has been removed from the $chan ownerlist."
            puthelp "NOTICE $nick :You have been removed from the $chan ownerlist by $me."
	}
	return 0
}


### !ADDMASTER <nick> [hand] 

proc pub_lol_addmaster {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]addmaster <nick> \[hand\]"
		return 0
	}
	set nick [lindex $arg 0]
	set alternate [lindex $arg 1]
	set bot [strlwr $botnick]
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
            puthelp "NOTICE $me :Sorry, but I can't addmaster myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		if {[validuser $nick] && $alternate == ""} {
                  puthelp "NOTICE $me :The hand $nick already exists. \002Usage:\002 !addmaster <nick> <hand>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "NOTICE $me :The hand $alternate already exists. Choose another. \002Usage:\002 !addmaster <nick> <hand>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			chattr $alternate +p|+m $chan
			puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
                  puthelp "NOTICE $me :$nick added to the $chan masterlist and party-line with the hand: $alternate."
                  puthelp "NOTICE $nick :You have been added to the $chan masterlist and party-line by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			if {[botisop $chan] && ![isop $nick $chan]} { pushmode $chan +o $nick }
			return 0
		}
		adduser $nick [maskhost $hostmask]
		chattr $nick +p|+m $chan
		puthelp "NOTICE $me :New user: $nick ([maskhost $hostmask])"
            puthelp "NOTICE $me :$nick added to the $chan masterlist and party-line with the hand: $nick."
            puthelp "NOTICE $nick :You have been added to the $chan masterlist and party-line by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		if {[botisop $chan] && ![isop $nick $chan]} { pushmode $chan +o $nick }
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "NOTICE $me :The hand $alternate already exists. \002Usage:\002 !addmaster <nick> <hand>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		chattr $alternate +p|+m $chan
		puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
            puthelp "NOTICE $me :$nick added to the $chan masterlist and party-line with the hand: $alternate."
            puthelp "NOTICE $nick :You have been added to the $chan masterlist and party-line by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		if {[botisop $chan] && ![isop $nick $chan]} { pushmode $chan +o $nick }
		return 0
	}
	if {[matchattr $hand -|+m $chan]} {
            puthelp "NOTICE $me :$nick is already a master in $chan with this hand: $hand"
	} {
		chattr $hand -|+m $chan
            puthelp "NOTICE $me :$nick added to the $chan masterlist with this hand: $hand."
            puthelp "NOTICE $nick :You have been added to the $chan masterlist by $me."
	}
	if {[botisop $chan] && ![isop $nick $chan]} { pushmode $chan +o $nick ; return 0 }
	return 0
}

### !DELMASTER <nick>

proc pub_lol_delmaster {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]delmaster <nick>"
		return 0
	}
	set nick [lindex $arg 0]
	set bot [strlwr $botnick]
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
            puthelp "NOTICE $me :Yeah right, like I'm going to let you delmaster ME!"
		return 0
	}
	if {![validuser $hand]} {
		puthelp "NOTICE $me :$nick is not a registered user."
		if {[botisop $chan] && [isop $nick $chan]} { pushmode $chan -o $nick }
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![matchattr $hand -|+m $chan]} {
                puthelp "NOTICE $me :$nick is not a master in $chan"
	} {
		chattr $hand -|-m $chan
            puthelp "NOTICE $me :$nick has been removed from the $chan masterlist."
            puthelp "NOTICE $nick :You have been removed from the $chan masterlist by $me."
	}
	return 0
}

### !ADDFRIEND <nick> [hand] 

proc pub_lol_addfriend {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]addfriend <nick> \[hand\]"
		return 0
	}
	set nick [lindex $arg 0]
	set alternate [lindex $arg 1]
	set bot [strlwr $botnick]
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
            puthelp "NOTICE $me :Sorry, but I can't addfriend myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		if {[validuser $nick] && $alternate == ""} {
                  puthelp "NOTICE $me :The hand $nick already exists. \002Usage:\002 !addfriend <nick> <hand>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "NOTICE $me :The hand $alternate already exists. Choose another. \002Usage:\002 !addfriend <nick> <hand>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			chattr $alternate +p|+f $chan
			puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
                  puthelp "NOTICE $me :$nick added to the $chan friendlist and party-line with the hand: $alternate."
                  puthelp "NOTICE $nick :You have been added to the $chan friendlist and party-line by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			return 0
		}
		adduser $nick [maskhost $hostmask]
		chattr $nick +p|+f $chan
		puthelp "NOTICE $me :New user: $nick ([maskhost $hostmask])"
            puthelp "NOTICE $me :$nick added to the $chan friendlist and party-line with the hand: $nick."
            puthelp "NOTICE $nick :You have been added to the $chan friendlist and party-line by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "NOTICE $me :The hand $alternate already exists. \002Usage:\002 !addfriend <nick> <hand>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		chattr $alternate +p|+f $chan
		puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
            puthelp "NOTICE $me :$nick added to the $chan friendlist and party-line with the hand: $alternate."
            puthelp "NOTICE $nick :You have been added to the $chan friendlist and party-line by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		return 0
	}
	if {[matchattr $hand -|+f $chan]} {
            puthelp "NOTICE $me :$nick is already a friend in $chan with this hand: $hand"
	} {
		chattr $hand -|+f $chan
            puthelp "NOTICE $me :$nick added to the $chan friendlist with this hand: $hand."
            puthelp "NOTICE $nick :You have been added to the $chan friendlist by $me."
	}
	return 0
}

### !DELFRIEND <nick>

proc pub_lol_delfriend {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]delfriend <nick>"
		return 0
	}
	set nick [lindex $arg 0]
	set bot [strlwr $botnick]
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
		puthelp "NOTICE $me :Yeah right, like I'm going to let you delfriend ME!"
		return 0
	}
	if {![validuser $hand]} {
		puthelp "NOTICE $me :$nick is not a registered user."
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![matchattr $hand -|+f $chan]} {
            puthelp "NOTICE $me :$nick is not a friend in $chan"
	} {
		chattr $hand -|-f $chan
            puthelp "NOTICE $me :$nick has been removed from the $chan friendlist."
            puthelp "NOTICE $nick :You have been removed from the $chan friendlist by $me."
	}
	return 0
}

### !ADDOP <nick> [hand] 

proc pub_lol_addop {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]addop <nick> \[hand\]"
		return 0
	}
	set nick [lindex $arg 0]
	set alternate [lindex $arg 1]
	set bot [strlwr $botnick]
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
            puthelp "NOTICE $me :Sorry, but I can't addop myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		if {[validuser $nick] && $alternate == ""} {
                  puthelp "NOTICE $me :The hand $nick already exists. \002Usage:\002 !addop <nick> <hand>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "NOTICE $me :The hand $alternate already exists. Choose another. \002Usage:\002 !addop <nick> <hand>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			chattr $alternate +p|+o $chan
			puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
                        puthelp "NOTICE $me :$nick added to the $chan oplist and party-line with the hand: $alternate."
                        puthelp "NOTICE $nick :You have been added to the $chan oplist and party-line by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			if {[botisop $chan] && ![isop $nick $chan]} {
				pushmode $chan +o $nick
			}
			return 0
		}
		adduser $nick [maskhost $hostmask]
		chattr $nick +p|+o $chan
		puthelp "NOTICE $me :New user: $nick ([maskhost $hostmask])"
                puthelp "NOTICE $me :$nick added to the $chan oplist and party-line with the hand: $nick."
                puthelp "NOTICE $nick :You have been added to the $chan oplist and party-line by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		if {[botisop $chan] && ![isop $nick $chan]} {
			pushmode $chan +o $nick
		}
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "NOTICE $me :The hand $alternate already exists. \002Usage:\002 !addop <nick> <hand>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		chattr $alternate +p|+o $chan
		puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
                puthelp "NOTICE $me :$nick added to the $chan oplist and party-line with the hand: $alternate."
                puthelp "NOTICE $nick :You have been added to the $chan oplist and party-line by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		if {[botisop $chan] && ![isop $nick $chan]} {
			pushmode $chan +o $nick
		}
		return 0
	}
	if {[matchattr $hand -|+o $chan]} {
                puthelp "NOTICE $me :$nick is already an op in $chan with this hand: $hand"
	} {
		chattr $hand -|+o $chan
                puthelp "NOTICE $me :$nick added to the $chan oplist with this hand: $hand."
                puthelp "NOTICE $nick :You have been added to the $chan oplist by $me."
	}
	if {[botisop $chan] && ![isop $nick $chan]} { pushmode $chan +o $nick ;	return 0 }
	return 0
}

### !DELOP <nick>

proc pub_lol_delop {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]delop <nick>"
		return 0
	}
	set nick [lindex $arg 0]
	set bot [strlwr $botnick]
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
		puthelp "NOTICE $me :Yeah right, like I'm going to let you delop ME!"
		return 0
	}
	if {![validuser $hand]} {
		puthelp "NOTICE $me :$nick is not a registered user."
		if {[botisop $chan] && [isop $nick $chan]} { pushmode $chan -o $nick }
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![matchattr $hand -|+o $chan]} {
            puthelp "NOTICE $me :$nick is not an op in $chan"
	} {
		chattr $hand -|-o $chan
            puthelp "NOTICE $me :$nick has been removed from the $chan oplist."
            puthelp "NOTICE $nick :You have been removed from the $chan oplist by $me."
	}
	if {[botisop $chan]} {
		if {[botisop $chan] && [isop $nick $chan]} { pushmode $chan -o $nick }
		return 0
	}
	return 0
}

### !OP [nick]

proc pub_lol_op {a b c chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $a $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $a :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set nick [lindex $arg 0]
	set hand [nick2hand $nick $chan]
	if {$nick == ""} {
		if {![isop $a $chan]} {	pushmode $chan +o $a }
		return 0
	}

	if {![onchan $nick $chan]} {
            puthelp "NOTICE $a :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {![isop $nick $chan] && [strlwr $nick] != [strlwr $botnick]} { pushmode $chan +o $nick ; return 0 }
	return 0
}

### !DEOP [nick]

proc pub_lol_deop {a b c chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $a $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $a :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set nick [lindex $arg 0]
	set bot [strlwr $botnick]
	set hand [nick2hand $nick $chan]
	if {$nick == ""} {
		if {[isop $a $chan]} { pushmode $chan -o $a }
		return 0
	}
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $a :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
		puthelp "NOTICE $a :Yeah right, like I'm going to let you deop ME!"
		return 0
	}
	if {$hand != "*"} {
		if {$c != $hand} {
			if {[matchattr $hand o|o $chan] && ![matchattr $c o|o $chan]} {
				puthelp "NOTICE $a :Sorry, you must to be an operator to deop an operator."
				return 0
			}
			if {([matchattr $hand m|m $chan] || [matchattr $hand b]) && ![matchattr $c m|m $chan]} {
				puthelp "NOTICE $a :Sorry, you must to be a master to deop a master or a bot."
				return 0
			}
		}
	}
	if {[isop $nick $chan]} { pushmode $chan -o $nick }
	return 0
}

### !ADDVOICE <nick> [hand] 

proc pub_lol_addvoice {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
                puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]addvoice <nick> \[hand\]"
		return 0
	}
	set nick [lindex $arg 0]
	set alternate [lindex $arg 1]
	set bot [strlwr $botnick]
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
            puthelp "NOTICE $me :Sorry, but I can't addvoice myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		if {[validuser $nick] && $alternate == ""} {
                        puthelp "NOTICE $me :The hand $nick already exists. \002Usage:\002 !addvoice <nick> <hand>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "NOTICE $me :The hand $alternate already exists. Choose another. \002Usage:\002 !addvoice <nick> <hand>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			chattr $alternate +p|+v $chan
			puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
                        puthelp "NOTICE $me :$nick added to the $chan voicelist and party-line with the hand: $alternate."
                        puthelp "NOTICE $nick :You have been added to the $chan voicelist and party-line by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			if {[botisop $chan] && ![isop $nick $chan] && ![isvoice $nick $chan]} {
				pushmode $chan +v $nick
			}
			return 0
		}
		adduser $nick [maskhost $hostmask]
		chattr $nick +p|+v $chan
		puthelp "NOTICE $me :New user: $nick ([maskhost $hostmask])"
                puthelp "NOTICE $me :$nick added to the $chan voicelist and party-line with the hand: $nick."
                puthelp "NOTICE $nick :You have been added to the $chan voicelist and party-line by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		if {[botisop $chan] && ![isop $nick $chan] && ![isvoice $nick $chan]} {
			pushmode $chan +v $nick
		}
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "NOTICE $me :The hand $alternate already exists. \002Usage:\002 !addvoice <nick> <hand>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		chattr $alternate +p|+v $chan
		puthelp "NOTICE $me :New user: $alternate ([maskhost $hostmask])"
                puthelp "NOTICE $me :$nick added to the $chan voicelist and party-line with the hand: $alternate."
                puthelp "NOTICE $nick :You have been added to the $chan voicelist and party-line by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		if {[botisop $chan] && ![isop $nick $chan] && ![isvoice $nick $chan]} {
			pushmode $chan +v $nick
		}
		return 0
	}
	if {[matchattr $hand -|+v $chan]} {
                puthelp "NOTICE $me :$nick already has voice in $chan with this hand: $hand"
	} {
		chattr $hand -|+v $chan
                puthelp "NOTICE $me :$nick added to the $chan voicelist with this hand: $hand."
                puthelp "NOTICE $nick :You have been added to the $chan voicelist by $me."
	}
	if {[botisop $chan] && ![isop $nick $chan] && ![isvoice $nick $chan]} {
		pushmode $chan +v $nick
		return 0
	}
	return 0
}

### !DELVOICE <nick>

proc pub_lol_delvoice {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
                puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]delvoice <nick>"
		return 0
	}
	set nick [lindex $arg 0]
	set bot [strlwr $botnick]
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
                puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == $bot} {
		puthelp "NOTICE $me :Yeah right, like I'm going to let you delvoice ME!"
		return 0
	}
	if {![validuser $hand]} {
		puthelp "NOTICE $me :$nick is not a registered user."
		if {[botisop $chan] && [isvoice $nick $chan]} {
			pushmode $chan -v $nick
		}
		return 0
	}
	if {[getting-users]} {
                puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![matchattr $hand -|+v $chan]} {
                puthelp "NOTICE $me :$nick does not have voice in $chan"
	} {
		chattr $hand -|-v $chan
                puthelp "NOTICE $me :$nick has been removed from the $chan voicelist."
                puthelp "NOTICE $nick :You have been removed from the $chan voicelist by $me."
	}
	if {[botisop $chan] && [isvoice $nick $chan]} {
		pushmode $chan -v $nick
		return 0
	}
	return 0
}

### !VOICE [nick]

proc pub_lol_voice {a b c chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $a $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $a :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set nick [lindex $arg 0]
	set bot [strlwr $botnick]
	set hand [nick2hand $nick $chan]
	if {$nick == ""} {
		if {![isvoice $a $chan]} { pushmode $chan +v $a }
		return 0
	}
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $a :Sorry, but I don't see $nick in $chan."
		return 0
	}
		
	if {![isvoice $nick $chan]} {	pushmode $chan +v $nick }
	return 0
}

### !DEVOICE [nick]

proc pub_lol_devoice {a b c chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $a $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
            puthelp "NOTICE $a :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set nick [lindex $arg 0]
	set bot [strlwr $botnick]
	set hand [nick2hand $nick $chan]
	if {$nick == ""} {
		if {[isvoice $a $chan]} { pushmode $chan -v $a	}
		return 0
	}
	
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $a :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[isvoice $nick $chan]} { pushmode $chan -v $nick }
	return 0
}

### !ADDBOT <nick> [port] [hand]

proc pub_lol_addbot {me b c chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $c $me $b]} {
		if {$lol(silent) == 1 || [checksilent $c]} {return 0}
                puthelp "NOTICE $me :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $me :\002Usage:\002 [string trim $lol(cmdchar)]addbot <nick> \[port\] \[hand\]"
		return 0
	}
	set nick [lindex $arg 0]
	set port [lindex $arg 1]
	if {[isnumber $port]} {
		set alternate [lindex $arg 2]
	} {
		set port 3333
		set alternate [lindex $arg 1]
	}
	set host [lindex [split [getchanhost $nick $chan] "@"] 1]
	set hostmask "*!*[getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            puthelp "NOTICE $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == [strlwr $botnick]} {
            puthelp "NOTICE $me :Sorry, but I can't addbot myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "NOTICE $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {[validuser $hand]} {
		puthelp "NOTICE $me :$nick is already recognized with this hand: $hand"
		return 0
	} {
		if {[validuser $nick] && $alternate == ""} {
                  puthelp "NOTICE $me :The hand $nick already exists. \002Usage:\002 !addbot <nick> <port> <hand>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "NOTICE $me :The hand $alternate already exists. Choose another. \002Usage:\002 !addbot <nick> <port> <hand>"
				return 0
			}
			addbot $alternate $host:$port
			setuser $alternate hosts $hostmask
			puthelp "NOTICE $me :New bot: $alternate ($hostmask)"
			return 0
		}
		addbot $nick $host:$port
		setuser $nick hosts $hostmask
		puthelp "NOTICE $me :New bot: $nick ($hostmask)"
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "NOTICE $me :The hand $alternate already exists. \002Usage:\002 !addbot <nick> <port> <hand>"
			return 0
		}
		addbot $alternate $host:$port
		setuser $alternate hosts $hostmask
		puthelp "NOTICE $me :New bot: $alternate ($hostmask)"
		return 0
	}
	return 0
}

### !KICK <nick|mask> [reason]

proc pub_lol_kick {nick host hand chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]kick <nick|mask> \[reason\]"
		return 0
	}
	set who [lindex $arg 0]
	set reason [lrange $arg 1 end]
	if {$reason == ""} {set reason "requested"}
	if {[string first "*" $who] != -1 || [string first "?" $who] != -1} {
		if {$reason == "requested"} {set reason "MaskKick: $who"}
		if {![matchattr $hand o|o $chan]} {
			puthelp "NOTICE $nick :You need to be an op to use mask kick."
			return 0
		}
		set who [strlwr $who]
		set kickcount 0
		set flags "-$lol(no_kick_flags)&-$lol(no_kick_flags)"
		if {$lol(no_kick_flags) == ""} {
			set list [strlwr [chanlist $chan]]
		} {
			set list [strlwr [chanlist $chan $flags]]
		}
		foreach chanuser $list {
			if {[string match [strlwr $who] [strlwr $chanuser]] && $chanuser != [strlwr $botnick] && $chanuser != [strlwr $nick] && ![isop $chanuser $chan] && ![isvoice $chanuser $chan]} {
				incr kickcount
				putserv "KICK $chan $chanuser :$nick: $reason"
			}
		}
		if {$kickcount == 0} {
                  puthelp "NOTICE $nick :Sorry but nobody matches this mask."
		}
	} {
		if {![onchan $who $chan]} {
                  puthelp "NOTICE $nick :Sorry, but I don't see $who in $chan."
			return 0
		}
		if {[strlwr $who] == [strlwr $botnick]} {
			puthelp "NOTICE $nick :Yeah right, like I'm going to let you kick ME!"
			return 0
		}
		if {[nick2hand $who $chan] != "*"} {
			if {$hand != [nick2hand $who $chan]} {
				if {[matchattr [nick2hand $who $chan] o|o $chan] && ![matchattr $hand o|o $chan]} {
					puthelp "NOTICE $nick :Sorry, you must to be an operator to kick an operator."
					return 0
				}
				if {([matchattr [nick2hand $who $chan] m|m $chan] || [matchattr [nick2hand $who $chan] b]) && ![matchattr $hand m|m $chan]} {
					puthelp "NOTICE $nick :Sorry, you must to be a master to kick a master or a bot."
					return 0
				}
			}
		}
		putserv "KICK $chan $who :$nick: $reason"
	}
	return 0
}

### !QUICK <nick|mask> [reason]

proc pub_lol_quick {nick host hand chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]quick <nick|mask> \[reason\]"
		return 0
	}
	set who [lindex $arg 0]
	set reason [lrange $arg 1 end]
	if {$reason == ""} {set reason "requested"}
	if {[string first "*" $who] != -1 || [string first "?" $who] != -1} {
		if {$reason == "requested"} {set reason "MaskQuick: $who"}
		set who [strlwr $who]
		set kickcount 0
		set flags "-$lol(no_kick_flags)&-$lol(no_kick_flags)"
		if {$lol(no_kick_flags) == ""} {
			set list [strlwr [chanlist $chan]]
		} {
			set list [strlwr [chanlist $chan $flags]]
		}
		foreach chanuser $list {
			if {[string match [strlwr $who] [strlwr $chanuser]] && $chanuser != [strlwr $botnick] && $chanuser != [strlwr $nick] && ![isop $chanuser $chan] && ![isvoice $chanuser $chan]} {
				incr kickcount
				set hostmask "*!*[getchanhost $chanuser $chan]"
				putserv "MODE $chan +b $hostmask"
				putserv "KICK $chan $chanuser :$nick: $reason"
				utimer 7 "deban $chan $hostmask"
			}
		}
		if {$kickcount == 0} {
                  puthelp "NOTICE $nick :Sorry but nobody matches this mask."
		}
	} {
		if {![onchan $who $chan]} {
                  puthelp "NOTICE $nick :Sorry, but I don't see $who in $chan."
			return 0
		}
		if {[strlwr $who] == [strlwr $botnick]} {
			puthelp "NOTICE $nick :Yeah right, like I'm going to let you kick ME!"
			return 0
		}
		if {[nick2hand $who $chan] != "*"} {
			if {$hand != [nick2hand $who $chan]} {
				if {[matchattr [nick2hand $who $chan] o|o $chan] && ![matchattr $hand o|o $chan]} {
					puthelp "NOTICE $nick :Sorry, you must to be an operator to kick an operator."
					return 0
				}
				if {([matchattr [nick2hand $who $chan] m|m $chan] || [matchattr [nick2hand $who $chan] b]) && ![matchattr $hand m|m $chan]} {
					puthelp "NOTICE $nick :Sorry, you must to be a master to kick a master or a bot."
					return 0
				}
			}
		}
		set hostmask "*!*[getchanhost $who $chan]"
		putserv "MODE $chan +b $hostmask"
		putserv "KICK $chan $who :$nick: $reason"
		utimer 7 "deban $chan $hostmask"
	}
	return 0
}

proc deban {chan hostmask} {
	if{[botisop $chan]} {pushmode $chan -b $hostmask}
}

### CLIENT KICK

proc pub_lol_mirc {nick host hand chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick lol_mirc_kick remove_kickmirc_timer
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
                puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set flags "-$lol(no_kick_flags)&-$lol(no_kick_flags)"
	if {$lol(no_kick_flags) == ""} {
		set list [strlwr [chanlist $chan]]
	} {
		set list [strlwr [chanlist $chan $flags]]
	}
	foreach chanuser $list {
		if {[strlwr $chanuser] != [strlwr $botnick] && [strlwr $chanuser] != [strlwr $nick] && ![isop $chanuser $chan] && ![isvoice $chanuser $chan]} {
			puthelp "PRIVMSG $chanuser :\001VERSION\001"
		}
	}
	if {$remove_kickmirc_timer != ""} {
		killutimer $remove_kickmirc_timer
	}
	set lol_mirc_kick $chan
	set remove_kickmirc_timer [utimer 60 {
		set lol_mirc_kick ""
		set remove_kickmirc_timer ""
	}]
	kick_chan_check $chan mirc
	return 0
}

proc pub_lol_bitchx {nick host hand chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick lol_bitchx_kick remove_kickbitchx_timer
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
                puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set flags "-$lol(no_kick_flags)&-$lol(no_kick_flags)"
	if {$lol(no_kick_flags) == ""} {
		set list [strlwr [chanlist $chan]]
	} {
		set list [strlwr [chanlist $chan $flags]]
	}
	foreach chanuser $list {
		if {[strlwr $chanuser] != [strlwr $botnick] && [strlwr $chanuser] != [strlwr $nick] && ![isop $chanuser $chan] && ![isvoice $chanuser $chan]} {
			puthelp "PRIVMSG $chanuser :\001VERSION\001"
		}
	}
	if {$remove_kickbitchx_timer != ""} {
		killutimer $remove_kickbitchx_timer
	}
	set lol_bitchx_kick $chan
	set remove_kickbitchx_timer [utimer 60 {
		set lol_bitchx_kick ""
		set remove_kickbitchx_timer ""
	}]
	kick_chan_check $chan bitchx
	return 0
}

proc pub_lol_ircii {nick host hand chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick lol_ircii_kick remove_kickircii_timer
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
                puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set flags "-$lol(no_kick_flags)&-$lol(no_kick_flags)"
	if {$lol(no_kick_flags) == ""} {
		set list [strlwr [chanlist $chan]]
	} {
		set list [strlwr [chanlist $chan $flags]]
	}
	foreach chanuser $list {
		if {[strlwr $chanuser] != [strlwr $botnick] && [strlwr $chanuser] != [strlwr $nick] && ![isop $chanuser $chan] && ![isvoice $chanuser $chan]} {
			puthelp "PRIVMSG $chanuser :\001VERSION\001"
		}
	}
	if {$remove_kickircii_timer != ""} {
		killutimer $remove_kickircii_timer
	}
	set lol_ircii_kick $chan
	set remove_kickircii_timer [utimer 60 {
		set lol_ircii_kick ""
		set remove_kickircii_timer ""
	}]
	kick_chan_check $chan ircii
	return 0
}

proc pub_lol_eggdrop {nick host hand chan arg} {
	if {![botisop $chan]} {return 0}
	set arg [charfilter $arg]
	global lol botnick lol_eggdrop_kick remove_kickeggdrop_timer
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set flags "-$lol(no_kick_flags)&-$lol(no_kick_flags)"
	if {$lol(no_kick_flags) == ""} {
		set list [strlwr [chanlist $chan]]
	} {
		set list [strlwr [chanlist $chan $flags]]
	}
	foreach chanuser $list {
		if {[strlwr $chanuser] != [strlwr $botnick] && [strlwr $chanuser] != [strlwr $nick] && ![isop $chanuser $chan] && ![isvoice $chanuser $chan]} {
			puthelp "PRIVMSG $chanuser :\001VERSION\001"
		}
	}
	if {$remove_kickeggdrop_timer != ""} {
		killutimer $remove_kickeggdrop_timer
	}
	set lol_eggdrop_kick $chan
	set remove_kickeggdrop_timer [utimer 60 {
		set lol_eggdrop_kick ""
		set remove_kickeggdrop_timer ""
	}]
	kick_chan_check $chan eggdrop
	return 0
}

proc kick_chan_check {chan client} {
	global lol_mirc_kick lol_bitchx_kick lol_ircii_kick lol_eggdrop_kick
	if {$client == "mirc"} {
		if {$lol_bitchx_kick == $chan} { set lol_bitchx_kick "" }
		if {$lol_ircii_kick == $chan} { set lol_ircii_kick ""	}
		if {$lol_eggdrop_kick == $chan} { set lol_eggdrop_kick "" }
	}
	if {$client == "bitchx"} {
		if {$lol_mirc_kick == $chan} { set lol_mirc_kick "" }
		if {$lol_ircii_kick == $chan} { set lol_ircii_kick "" }
		if {$lol_eggdrop_kick == $chan} { set lol_eggdrop_kick "" }
	}
	if {$client == "ircii"} {
		if {$lol_bitchx_kick == $chan} { set lol_bitchx_kick "" }
		if {$lol_mirc_kick == $chan} { set lol_mirc_kick "" }
		if {$lol_eggdrop_kick == $chan} { set lol_eggdrop_kick "" }
	}
	if {$client == "eggdrop"} {
		if {$lol_bitchx_kick == $chan} { set lol_bitchx_kick "" }
		if {$lol_ircii_kick == $chan} { set lol_ircii_kick ""	}
		if {$lol_mirc_kick == $chan} { set lol_mirc_kick "" }
	}
	return 0
}

### CTCP VERSION CLIENT KICK

proc lol_ctcp_version {nick host hand dest key arg} {
	global lol lol_mirc_kick lol_bitchx_kick lol_ircii_kick lol_eggdrop_kick
	if {[string first "mirc" [strlwr $arg]] != -1} { set version "mirc" }
	if {[string first "ircii" [strlwr $arg]] != -1} { set version "ircii" }
	if {[string first "bitchx" [strlwr $arg]] != -1} { set version "bitchx" }
	if {[string first "eggsrop" [strlwr $arg]] != -1} { set version "eggdrop" }
	set flags "-$lol(no_kick_flags)&-$lol(no_kick_flags)"
	set chan [lindex $lol_mirc_kick 0]
	if {$version == "mirc" && [validchan $chan]} {
		if {[botisop $chan] && ![isop $nick $chan] && ![isvoice $nick $chan]} {
			if {$hand != "*" && $lol(no_kick_flags) != "" } {
				if {[matchattr $hand $flags $chan]} { return 0 }
			}
			putserv "KICK $chan $nick :Mirc kick !"
		}
		return 0
	}
	set chan [lindex $lol_bitchx_kick 0]
	if {$version == "bitchx" && [validchan $chan]} {
		if {[botisop $chan] && ![isop $nick $chan] && ![isvoice $nick $chan]} {
			if {$hand != "*" && $lol(no_kick_flags) != ""} {
				if {[matchattr $hand $flags $chan]} { return 0 }
			}
			putserv "KICK $chan $nick :BitchX kick !"
		}
		return 0
	}
	set chan [lindex $lol_ircii_kick 0]
	if {$version == "ircii" && [validchan $chan]} {
		if {[botisop $chan] && ![isop $nick $chan] && ![isvoice $nick $chan]} {
			if {$hand != "*" && $lol(no_kick_flags) != ""} {
				if {[matchattr $hand $flags $chan]} { return 0 }
			}
			putserv "KICK $chan $nick :IrcII kick !"
		}
		return 0
	}
	set chan [lindex $lol_eggdrop_kick 0]
	if {$version == "eggdrop" && [validchan $chan]} {
		if {[botisop $chan] && ![isop $nick $chan] && ![isvoice $nick $chan]} {
			if {$hand != "*" && $lol(no_kick_flags) != ""} {
				if {[matchattr $hand $flags $chan]} { return 0 }
			}
			putserv "KICK $chan $nick :Eggdrop kick !"
		}
		return 0
	}
	return 0
}

### !FINDIP <mask>

proc pub_lol_findip {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]findip <mask>"
		return 0
	}
	set mask [lindex $arg 0]
	set msg "These users have been found: "
	set find 0
	foreach chans [channels] {
		foreach chanuser [strlwr [chanlist $chans]] {
			if {$chanuser == [strlwr $nick] || $chanuser == [strlwr $botnick]} {continue}
			set ipmask [strlwr [lindex [split [maskhost $chanuser![getchanhost $chanuser $chan]] "@"] 1]]
			set ip [lindex [split [getchanhost $chanuser $chans] @] 1]
			if {[string match [strlwr $mask] [strlwr $ip]]} {
				append msg "* \002$chanuser :$ip\002 on $chans "
				incr find
			}
			if {[string length $msg] > 200} {
				puthelp "NOTICE $nick :$msg"
				set msg ""
			}	
		}
	}
	if {$find != 0} {
		if {$msg != ""} {puthelp "NOTICE $nick :$msg"}
	} {
            puthelp "NOTICE $nick :No IPs that match $mask were found on my chans."
	}
	return 0
}

### !TOPIC <topic>

proc pub_lol_topic {nick host hand chan arg} {
	if {![botisop $chan]} {return 0}
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "NOTICE $nick :\002Usage\002: [string trim $lol(cmdchar)]topic <topic>"
		return 0
	}
	puthelp "TOPIC $chan :$arg"
	return 0
}

### !WHOIS <nick>

proc pub_lol_whois {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {[llength $arg] != 1} {
		puthelp "NOTICE $nick :\002Usage:\002 [string trim $lol(cmdchar)]whois <nick>"
		return 0
	}
	set who [lindex $arg 0]
	set handle [nick2hand $who $chan]
	set host2 [getchanhost $who $chan]
	puthelp "NOTICE $nick :[lol_whois $who $host2 $handle $chan]"
	return 0
}

### BOT JOKES ;)

proc pub_lol_cigarette {nick host hand chan arg} {
	set arg [charfilter $arg]
	set arg [lindex $arg 0]
	global lol botnick
	if {$lol(jokes) == 0} {return 0}
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {$arg != ""} {
		puthelp "PRIVMSG $chan :$nick offers this \002(\037)????)???????????\037)~~~\002 at $arg !!!"
		return 0
	}
	puthelp "PRIVMSG $chan :I offer this \002(\037)????)???????????\037)~~~\002 at $nick !!!"
	return 0
}

proc pub_lol_rose {nick host hand chan arg} {
	set arg [charfilter $arg]
	set arg [lindex $arg 0]
	global lol botnick
	if {$lol(jokes) == 0} {return 0}
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {$arg != ""} {
            	puthelp "PRIVMSG $chan :$nick offers this beautiful rose \0034@\003\0033\} >-`--,--`---\003 at $arg !!!"
			return 0
	}
	puthelp "PRIVMSG $chan :I offer this beautiful rose \0034@\003\0033\} >-`--,--`---\003 at $nick !!!"
	return 0
}

proc pub_lol_pastis {nick host hand chan arg} {
	set arg [charfilter $arg]
	set arg [lindex $arg 0]
	global lol botnick
	if {$lol(jokes) == 0} {return 0}
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {$arg != ""} {
		puthelp "PRIVMSG $chan :$nick offers a glass full of pastaga at $arg, enjoy !!!"
		return 0
	}
	puthelp "PRIVMSG $chan :I offer a glass full of pastaga at $nick, enjoy !!!"
	return 0
}

proc pub_lol_coke {nick host hand chan arg} {
	set arg [charfilter $arg]
	set arg [lindex $arg 0]
	global lol botnick
	if {$lol(jokes) == 0} {return 0}
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {$arg != ""} {
            puthelp "PRIVMSG $chan :$nick offers a delicious bottle of Coca-Cola at $arg, enjoy !!!"
		return 0
	}
      puthelp "PRIVMSG $chan :I offer a delicious bottle of Coca-Cola at $nick, enjoy !!!"
	return 0
}

proc pub_lol_beer {nick host hand chan arg} {
	set arg [charfilter $arg]
	set arg [lindex $arg 0]
	global lol botnick
	if {$lol(jokes) == 0} {return 0}
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
            puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	if {$arg != ""} {
            puthelp "PRIVMSG $chan :$nick offers a bottle of Beer to $arg, enjoy !!!"
		return 0
	}
      puthelp "PRIVMSG $chan :I offer a of Beer to $nick, enjoy !!!"
	return 0
}

proc pub_lol_penalty {nick host hand chan arg} {
	set arg [charfilter $arg]
	set joueur [lindex $arg 0]
	set balle [lindex $arg 1]
	if {$balle == ""} {
		set text "S'ELANCE SUR LA BALLE ET IL SHOOOT !!!!!!!"
	} {
		set text "S'ELANCE SUR [string toupper $balle] ET LE FRAPPE DE TOUTE SES FORCES !!!!!"
	}
	global lol botnick
	if {$lol(jokes) == 0} {return 0}
	if {![check $hand $nick $host]} {
		if {$lol(silent) == 1 || [checksilent $hand]} {return 0}
                puthelp "NOTICE $nick :You need to be identified to use this function. Type .identhelp in the partyline for more info. : \002/msg $botnick id <password>\002 or \002/msg $botnick silent <password>\002 to no more receive this warning."
		return 0
	}
	set results {
		{!!! GGGOOOOOOOOOAAAAAAAAAAAAAAAAAAALLLLLLLLLLLLL !!!!!!!!! dans la lucarne gauche :))))}
		{EVIVAAAAAAAAAAAAAAAA dans la lucarne droite :))))}
		{!!! GGGOOOOOOOOOAAAAAAAAAAAAAAAAAAALLLLLLLLLLLLL !!!!!!!!! en plein centre :))))}
		{!!! GGGOOOOOOOOOAAAAAAAAAAAAAAAAAAALLLLLLLLLLLLL !!!!!!!!! en force a gauche, le gardien a frol? le ballon :))))}
		{IL L'A FAIT !!!!!!!!!! YEAHHHHHHH en force a droite, le gardien a frol? le ballon :))))}
		{EVIVAAAAAAAAAAAAAAAA !!!!!!!!! en finnesse a gauche, le gardien pris a contre-pied :))))}
		{Sans probl?mes en finnesse a droite, le gardien pris a contre-pied :))))}
		{!!! GOAL GOAL GOOOOOOOOOOOOOOAAAAAAAAAAL \/\/ Tout en puissance sous la transversale.}
		{AHHHHHHRGGGGG :(( Par dessus la transversale !!!!}
		{OOOOOOOHHUUUUUU :(((( Plein poteau :(}
		{NOOOOOOOOON :((((( pleine transversale :(((((((}
		{PUUTTTTTAAAIIINNNN !!! Il a tir? a cot? :-/}
		{Salopard de gardien !!! :((( Il a plong? du bon cot? :((}
		{En plein centre mais le gardien n'avait h?las pas anticip? :(}
		{ARRGGGHHHH Tir central, mais le gardien devie la balle du pied :/}
	}
	if {$arg != ""} {
		puthelp "PRIVMSG $chan :$joueur doit ? tout prix marquer le penalty pour sauver son ?quipe..."
		puthelp "PRIVMSG $chan :[string toupper $joueur] $text"
		puthelp "PRIVMSG $chan :[lindex $results [rand [llength $results]]]"
		return 0
	}
	puthelp "PRIVMSG $chan :$nick doit ? tout prix marquer le penalty pour sauver son ?quipe..."
	puthelp "PRIVMSG $chan :[string toupper $nick] S'ELANCE SUR LA BALLE ET IL SHOOOT !!!!!!!"
	puthelp "PRIVMSG $chan :[lindex $results [rand [llength $results]]]"
	return 0
}

### !TIME

proc pub_lol_time {a b c d e} {
	global lol
	if {![validuser $c] && $lol(time) == 0} {return 0}
      puthelp "NOTICE $a :The date is [date], and it's [time] !"
	return 0
}

### !HELP

proc pub_lol_help {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol
	if {![validuser $hand] && $lol(help) == 0} {return 0}
	puthelp "NOTICE $nick :*** $lol(version) CHAN HELP ***"
	set help ""
	if {[matchattr $hand n]} {
		append help "\002[string trim $lol(cmdchar)]param\002 <parameter> <value>  \002[string trim $lol(cmdchar)]enable\002 <nick>  \002[string trim $lol(cmdchar)]disable\002 <nick>  \002[string trim $lol(cmdchar)]deluser\002 <nick>"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]join\002 <chan> \[chanpass\]  \002[string trim $lol(cmdchar)]remove\002 \[chan\]"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]addhost\002 <nick|hand> \[host\]  \002[string trim $lol(cmdchar)]delhost\002 <nick|hand> <host>"
		append help "  "
	}
	if {[matchattr $hand n|n $chan]} {
		append help "\002[string trim $lol(cmdchar)]addowner\002 <nick> \[hand\]  \002[string trim $lol(cmdchar)]delowner\002 <nick>"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]addmaster\002 <nick> \[hand\]  \002[string trim $lol(cmdchar)]delmaster\002 <nick>"
		append help "  "

	}
	if {[matchattr $hand m]} {
		append help "\002[string trim $lol(cmdchar)]jump\002 <server> \[port\]"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]botnick\002 <nick>"
		append help "  "
	}
	if {[matchattr $hand m|m $chan]} {
		append help "  "
		append help "\002[string trim $lol(cmdchar)]adduser\002 <nick> \[hand\]  \002[string trim $lol(cmdchar)]addbot\002 <nick> \[port\] \[hand\]"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]addop\002 <nick> \[hand\]  \002[string trim $lol(cmdchar)]delop\002 <nick>  \002[string trim $lol(cmdchar)]banmask\002 <mask> \[time\] \[reason\]  \002[string trim $lol(cmdchar)]findip\002 <mask>"
	}
	puthelp "NOTICE  $nick :$help"
	set help ""
	if {[matchattr $hand o|o $chan]} {
		append help "\002[string trim $lol(cmdchar)]banlist\002  \002[string trim $lol(cmdchar)]ban\002 <nick|mask> \[time\] \[reason\]  \002[string trim $lol(cmdchar)]unban\002 <mask|number>  \002[string trim $lol(cmdchar)]chattr\002 <nick> <flags>"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]mode\002 <chanmode>  \002[string trim $lol(cmdchar)]op\002 \[nick\]  \002[string trim $lol(cmdchar)]deop\002 \[nick\]  \002[string trim $lol(cmdchar)]broadcast\002 <text>"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]addvoice\002 <nick> \[hand\] \002[string trim $lol(cmdchar)]delvoice\002 <nick>"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]addfriend\002 <nick> \[hand\] \002[string trim $lol(cmdchar)]delfriend\002 <nick>"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]topic\002 <topic>  \002[string trim $lol(cmdchar)]whois\002 <nick>  \002[string trim $lol(cmdchar)]online\002"
		append help "  "
		append help "\002[string trim $lol(cmdchar)]quick\002 <nick|mask> \[reason\]  \002[string trim $lol(cmdchar)]mirc\002  \002[string trim $lol(cmdchar)]ircii\002  \002[string trim $lol(cmdchar)]bitchx\002  \002[string trim $lol(cmdchar)]eggdrop\002"
		append help " "
	}
	puthelp "NOTICE  $nick :$help"
	set help ""
	if {[matchattr $hand ov|ov $chan]} {
		append help "\002[string trim $lol(cmdchar)]kick\002 <nick|mask> \[reason\]  \002[string trim $lol(cmdchar)]stats\002  \002[string trim $lol(cmdchar)]voice\002 \[nick\]  \002[string trim $lol(cmdchar)]devoice\002 \[nick\]"
		append help "  "
		if {$lol(jokes) == 1} {
			append help "\002[string trim $lol(cmdchar)]cigarette\002 \[nick\]  \002[string trim $lol(cmdchar)]rose\002 \[nick\]"
			append help "  "
			append help "\002[string trim $lol(cmdchar)]pastaga ([string trim $lol(cmdchar)]pastis, [string trim $lol(cmdchar)]51)\002 \[nick\]  \002[string trim $lol(cmdchar)]beer\002 \[nick\]"
			append help "  "
			append help "\002[string trim $lol(cmdchar)]coca-cola ([string trim $lol(cmdchar)]coke)\002 \[nick\]  \002[string trim $lol(cmdchar)]penalty\002 \[player\] \[ball\]"
			append help "  "
		}
	}
	if {$lol(time) == 1} {append help "  \002[string trim $lol(cmdchar)]time\002"}
	if {$lol(seen) == 1} {append help "  \002[string trim $lol(cmdchar)]seen\002"}
	if {$lol(troubles) == 1} {append help "  \002[string trim $lol(cmdchar)]troubles\002"}
	append help "  \002[string trim $lol(cmdchar)]help\002"
	puthelp "NOTICE  $nick :$help"
	if {[validuser $hand]} {
		puthelp "NOTICE  $nick :For a complete description, use dcc chat: \002.chanhelp\002"
	}
}

### !TROUBLES

proc pub_lol_troubles {nick host hand chan arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {![validuser $hand] && $lol(troubles) == 0} {return 0}
	puthelp "NOTICE $nick :*** $lol(version) TROUBLES ***"
      append help "*** 1_You are a registered user but the bot does not recognize you: ***"
	append help "  "
	append help "You have probably changed your user@hostmask...Try:"
	append help "  "
	append help "\002/msg $botnick id <password> <nick>\002"
	append help "  "
      append help "Use the <nick> that you had, when you registered in the bot. You must do this each time your hostmask changes."
	puthelp "NOTICE $nick :$help"
	
	set help ""
      append help "*** 2_The bot doesn't auto-op you: ***"
	append help "  "
      append help "The bot probably doesn't have auto-op enabled, to get ops type:"
	append help "  "
	append help "\002/MSG $botnick OP \[#chan\]\002"
	puthelp "NOTICE $nick :$help"
	
	set help ""
      append help "*** 3_The bot recognizes you, but doesn't answer to a DCC CHAT: ***"
	append help "  "
      append help "You don't have DCC CHAT rights / You are using mIRC and it don't always use standard DCC CHAT, try:"
	append help "  "
	append help "\002/CTCP $botnick CHAT\002"
	append help "  "
      append help "If that doesn't work change your DCC CHAT config or change your script."
	puthelp "NOTICE $nick :$help"
	
	set help ""
	if {![check $hand $nick $host]} {
            append help "*** 4_Chan commands do not work : ***"
		append help "  "
		append help "You are not identified, type:"
		append help "  "
		append help "\002/msg $botnick id <password>\002"
		puthelp "NOTICE $nick :$help"
	}
	return 0
}

################# END OF CHAN COMMANDS #################

################# START OF DCC COMMANDS #################

### .whois

proc dcc_lol_whois {hand idx arg} {
	global lol
	*dcc:whois $hand $idx $arg
	set arg [charfilter $arg]
	set whohand [lindex $arg 0]
	if {[strlwr $hand] == [strlwr $whohand] || ([validuser $whohand] && [matchattr $hand m|m])} {
            putdcc $idx "$lol(version) Specific information.\r"
		putdcc $idx "\r"
		putdcc $idx "Ident Statut: [getuser $whohand xtra auth]   Last Ident Nick: [getuser $whohand xtra authnick]\r"
		putdcc $idx "Silent: [getuser $whohand xtra silent]         Permident Mask: [getuser $whohand xtra permident]\r"
	}
	return 0
}

### .unident

proc dcc_lol_unident {hand idx arg} {
	if {[getuser $hand xtra auth] != 1} {
            putdcc $idx "You are already unidentified.\r"
		return 0
	}
	if {[getuser $hand xtra auth] != "DEAD"} { setuser $hand xtra auth 0 }
	chattr $hand -3
      putdcc $idx "You are no longer identified.\r"
}

### .permident <nick!user@host>

proc dcc_lol_permident {hand idx arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 1} {
		putdcc $idx "\002Usage:\002 .permident <nick!user@host>\r"
		return 0
	}
	set host [lindex $arg 0]
	setuser $hand xtra permident $host
	putdcc $idx "You are now permidentified with this mask: $host. Use \002unpermident\002 to remove it.\r"
}

### .unpermident

proc dcc_lol_unpermident {hand idx arg} {
	setuser $hand xtra permident ""
	if {[getuser $hand xtra auth] != "DEAD"} { setuser $hand xtra auth 0 }
	chattr $hand -3
      putdcc $idx "You have deleted your permident mask.\r"
}

### .silent

proc dcc_lol_silent {hand idx arg} {
	set arg [charfilter $arg]
	setuser $hand xtra silent 1
	putdcc $idx "You are now in silent mode.\r"
      putdcc $idx "You will not be notified if you try a command without first being identified.\r"
	putdcc $idx "Use \002.unsilent\002 or message \002unsilent <password>\002 to remove the silent mode.\r"
}

### .unsilent

proc dcc_lol_unsilent {hand idx arg} {
	set arg [charfilter $arg]
	setuser $hand xtra silent 0
      putdcc $idx "You are no longer in silent mode.\r"
      putdcc $idx "You will be notified if you try a command without first being identified.\r"
      putdcc $idx "Use \002.silent\002 or message \002silent <password>\002 to return to the silent mode.\r"
}

### .botnick <nick>

proc dcc_lol_botnick {hand idx arg} {
	set arg [charfilter $arg]
	global botnick nick
	if {[llength $arg] != 1} {
		putdcc $idx "\002Usage:\002 .botnick <nick>\r"
		return 0
	}
	set nick [lindex $arg 0]
}

### .param <parameter> <value>

proc dcc_lol_param {hand idx arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {[llength $arg] != 2} {
		putdcc $idx "\002Usage:\002 .param <parameter> <value>"
		putdcc $idx "\002cmdchar:\002 $lol(cmdchar)"
		putdcc $idx "\002security:\002 $lol(security)"
		putdcc $idx "\002nopass:\002 $lol(nopass)"
		putdcc $idx "\002chankey:\002 $lol(chankey)"
		putdcc $idx "\002silent:\002 $lol(silent)"
		putdcc $idx "\002ident:\002 $lol(ident)"
		putdcc $idx "\002id_confirm:\002 $lol(id_confirm)"
		putdcc $idx "\002clone:\002 $lol(clone)"
		putdcc $idx "\002jokes:\002 $lol(jokes)"
		putdcc $idx "\002help:\002 $lol(help)"
		putdcc $idx "\002troubles:\002 $lol(troubles)"
		putdcc $idx "\002seen:\002 $lol(seen)"
		putdcc $idx "\002time:\002 $lol(time)"
		putdcc $idx "\002chan_flood:\002 $lol(chan_flood)"
		putdcc $idx "\002join_flood:\002 $lol(join_flood)"
		putdcc $idx "\002deop_flood:\002 $lol(deop_flood)"
		putdcc $idx "\002ctcp_flood:\002 $lol(ctcp_flood)"
		putdcc $idx "\002kick_flood:\002 $lol(kick_flood)"
		putdcc $idx "\002ban_protect:\002 $lol(ban_protect)"
		putdcc $idx "\002chan_parameters:\002 $lol(chan_parameters)"
		putdcc $idx "\002chanmode:\002 $lol(chanmode)"
		putdcc $idx "\002server_flags:\002 $lol(server_flags)"
		putdcc $idx "\002away:\002 $lol(away)"
		putdcc $idx "\002welcome:\002 $lol(welcome)"
		putdcc $idx "\002welmsg:\002 $lol(welmsg)"
		putdcc $idx "\002idle_protect:\002 $lol(idle_protect)"
		putdcc $idx "\002warn_idle_time:\002 $lol(warn_idle_time)"
		putdcc $idx "\002max_idle_time:\002 $lol(max_idle_time)"
		putdcc $idx "\002kick_idle_time:\002 $lol(kick_idle_time)"
		putdcc $idx "\002idle_ban_time:\002 $lol(idle_ban_time)"
		putdcc $idx "\002no_kick_flags:\002 $lol(no_kick_flags)"
		putdcc $idx "\002no_ban_flags:\002 $lol(no_ban_flags)"
		putdcc $idx "\002no_idle_flags:\002 $lol(no_idle_flags)"
		return 0
	}
	set lol([strlwr [lindex $arg 0]]) [lrange $arg 1 end]
	putdcc $idx "The new value of [strlwr [lindex $arg 0]] is [lrange $arg 1 end]."
	return 0
}

### .partyban <user> [reason]

proc dcc_lol_partyban {hand idx arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] < 1} {
		putdcc $idx "\002Usage:\002 .partyban <user> \[reason\]\r"
		return 0
	}
	set user [lindex $arg 0]
	set reason [lrange $arg 1 end]
	if {[matchattr $user o] && ![matchattr $hand o]} {
            putdcc $idx "You can't partyban an op, without being an op.\r"
		return 0
	}
	if {[matchattr $user m] && ![matchattr $hand m]} {
            putdcc $idx "You can't partyban a master, without being a master.\r"
		return 0
	}
	if {[matchattr $user n] && ![matchattr $hand n]} {
            putdcc $idx "You can't partyban an owner, without being an owner.\r"
		return 0
	}
	boot $user $reason
	chattr $user -p
	putdcc $idx "$user has been partybaned.\r"
}

### .chanlist

proc dcc_lol_chanlist {hand idx arg} {
	set arg [charfilter $arg]
	if {[channels] == ""} {
		putdcc $idx "I'm not on any chans"
		return 0
	}
      putdcc $idx "I'm on these chans:\r"
	foreach chan [channels] { putdcc $idx "$chan\r"	}
}

### .seen <nick|hand>

proc dcc_lol_seen {hand idx arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 1} {
		putdcc $idx "\002Usage\002: seen <nick|hand>\r"
		return 0
	}
	set who [lindex $arg 0]
	putdcc $idx "[lol_seen $hand $hand $who ""]\r"
}

### .enable <hand>

proc dcc_lol_enable {hand idx arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 1} {
		putdcc $idx "\002Usage:\002 .enable <hand>\r"
		return 0
	}
	set who [lindex $arg 0]
	if {![validuser $who]} {
            putdcc $idx "I don't see $who in my user database.\r"
		return 0
	}
	if {[getuser $who xtra auth] != "DEAD"} {
		putdcc $idx "$who is already enabled.\r"
		return 0
	}
	setuser $who xtra auth 0
	putdcc $idx "$who is now enabled.\r"
	return 0
}

### .disable <hand>

proc dcc_lol_disable {hand idx arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 1} {
		putdcc $idx "\002Usage:\002 .disable <hand>\r"
		return 0
	}
	set who [lindex $arg 0]
	if {![validuser $who]} {
            putdcc $idx "I don't see $who in my user database.\r"
		return 0
	}
	if {[getuser $who xtra auth] == "DEAD"} {
		putdcc $idx "$who is already disabled.\r"
		return 0
	}
	setuser $who xtra auth DEAD
	chattr $who -3
	putdcc $idx "$who is now disabled.\r"
	return 0
}

### .online

proc dcc_lol_online {hand idx arg} {
	set arg [charfilter $arg]
	global server {server-online} uptime
	set ip [lindex [split $server ":"] 0]
	set port [lindex [split [lindex [split $server ":"] 1] "-"] 0]
	set timeon [time_diff ${server-online}]
	set numbots 0
	foreach bot [bots] { incr numbots }
	set numchans 0
	foreach ch [channels] {	incr numchans }
      putdcc $idx "*** ONLINE info !!! ***\r"
	putdcc $idx "I have not crashed since [time_diff $uptime] ;)\r"
	if {$ip != ""} {
		putdcc $idx "I'm on $ip since $timeon.\r"
	} {
		putdcc $idx "I'm not on a server.\r"
	}
	if {![matchattr $hand o]} {
                putdcc $idx "I'm in $numchans chan(s).\r"
	} {
		if {$numchans != 0} {
            	putdcc $idx "I'm in these chans: [channels]\r"
		} {
                  putdcc $idx "I'm not in any chans.\r"
		}
	}
	if {![matchattr $hand o]} {
		putdcc $idx "I'm linked with $numbots bot(s).\r"
	} {
		if {$numbots != 0} {
            	putdcc $idx "I'm linked with these bots: [bots]\r"
		} {
                  putdcc $idx "I'm not linked with any bots.\r"
		}
	}
}

### .join <chan> [chan pass]

proc dcc_lol_join {han idx arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {[llength $arg] < 1} {
		putdcc $idx "\002Usage:\002 .join <chan> \[chan pass\]\r"
		return 0
	}
	set chan [lindex $arg 0]
	set pass [lindex $arg 1]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {[validchan $chan]} {
		putdcc $idx "I'm already monitoring $chan. \r"
		if {$pass != ""} {
			if {$lol(chankey) == 1} {
				putdcc $idx "New pass set for $chan: $pass. \r"
				channel set $chan need-key "chankey $chan $pass"
			} {
				putdcc $idx "I can't memorize password to keep compatibility with getops.tcl\r"
			}
		}
		if {![onchan [strlwr $botnick] $chan]} {
			putdcc $idx "I'll now try to join $chan.\r"
			putserv "JOIN $chan $pass"
			return 0
		}
		putdcc $idx "I'm already in $chan. \r"
		return 0
	}
	putdcc $idx "New chan monitoring: $chan.\r"
	channel add $chan
	channel set $chan chanmode $lol(chanmode)
	channel set $chan flood-chan $lol(chan_flood)
	channel set $chan flood-deop $lol(deop_flood)
	channel set $chan flood-kick $lol(kick_flood)
	channel set $chan flood-join $lol(join_flood)
	channel set $chan flood-ctcp $lol(ctcp_flood)
	foreach param $lol(chan_parameters) {
		channel set $chan $param
	}
	if {$pass != ""} {
		if {$lol(chankey) == 1} {
			putdcc $idx "New pass set for $chan: $pass. \r"
			channel set $chan need-key "chankey $chan $pass"
		} {
			putdcc $idx "I can't memorize the chan password to keep compatibility with getops.tcl\r"
		}
	}
	putdcc $idx "$chan is now configured. I'll now try to join it.\r"
	putdcc $idx "Use \002.-chan\002 to remove a chan (chan userlist will be deleted).\r"
	putserv "JOIN $chan $pass"
}

### .notice <#chan or nick>

proc dcc_lol_notice {hand idx arg} {
	if {$arg == ""} { putdcc $idx "Usage: .notice <#chan or nick> <message>." ; return 0 }
	set argument [lindex $arg 0]
	set espace [expr [strlen $argument]+1]
	set text [string range $arg $espace end]
	if {[string first "#" $argument] == 0} { 
		if {![validchan $argument] } {putdcc $idx "I'm not on $argument." ; return 0 }
	}
	puthelp "NOTICE $argument :$text" 
	putdcc $idx "- $text - has been sent by notice to $argument"
	return 0
}

### .onotice <#chan>

proc dcc_lol_onotice {hand idx arg} {
  if {$arg == ""} { putdcc $idx "Usage: .onotice <#chan> <message>" ; return 0 }
  set chan [lindex $arg 0]
  set espace [expr [strlen $chan]+1]
  set text [string range $arg $espace end]
  if {![validchan $chan] } {putdcc $idx "I'm not on $chan." ; return 0 }
  puthelp "NOTICE @$chan :$text" 
  putdcc $idx "- $text - has been sent by notice to ops on $chan"
  return 0
}

### .part <chan>

proc dcc_lol_part {han idx arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 1} {
		putdcc $idx "\002Usage:\002 .part <chan>\r"
		return 0
	}
	set chan [lindex $arg 0]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {![validchan $chan]} {
		putdcc $idx "I'm not monitoring $chan. \r"
		return 0
	}
	if {![matchattr $han m|m $chan]} {
            putdcc $idx "Sorry, but you are not a master in $chan."
		return 0
	}
	putdcc $idx "I'll part $chan. \r"
	putdcc $idx "To delete monitoring of this chan, use: \002.-chan $chan\002. \r"
	putserv "PART $chan"
}

### .userlist [flags]

proc dcc_lol_userlist {hand idx arg} {
	set arg [charfilter $arg]
	set param [lindex $arg 0]
	if {[string match #* $param]} {putdcc $idx "Usage : .userlist flags <#chan>" ; return 0 }
	set chan [lindex $arg 1]
	if { $chan == "" } { set list [userlist $param] 
      } else { 
		if {![validchan $chan]} { putdcc $idx "I'm not on $chan\r" ; return 0 }
		set list [userlist -|$param $chan] 
	} 
	putdcc $idx "List of my users : $list\r"
	putdcc $idx "on the whole, your request includes [llength $list] users."
}

### .security

proc dcc_lol_security {hand idx arg} {
	set arg [charfilter $arg]
	global lol
	putdcc $idx "                 \002********************************************\r"
	putdcc $idx "                 \002*** SECURITY RISK WITH DYNAMIC IP by LoL ***\r"
	putdcc $idx "                 \002********************************************\r"
	putdcc $idx "\r"
      putdcc $idx "Auto-op is dangerous because the majority of people do not have a fixed IP, but a\r"
      putdcc $idx "dynamic IP that changes every time that person connects. When the bot makes the mask value\r"
      putdcc $idx "that it will recognize you by, it uses wildcards (*). For example Bill is identified\r"
      putdcc $idx "on the net like this:\r"
	putdcc $idx "\r"
	putdcc $idx "                 |  nick  | |  user  | |  ip addresse  |\r"
	putdcc $idx "  Complete mask:    bill   !  bgates  @  195.135.14.28\r"
	putdcc $idx "\r"
      putdcc $idx "But the bot thinks that bill doesn't have a fixed IP address so it wont recognize\r"
      putdcc $idx "bill even if he has a different one. So it decides to recognize bill with this:\r"
	putdcc $idx "\r"
	putdcc $idx "                 |  nick  | |  user  | |  ip addresse  |\r"
	putdcc $idx "  Partial mask:      *     !  bgates  @  195.135.14.*\r"
	putdcc $idx "\r"
      putdcc $idx "The user part is not secure, any user can take the same user value.\r"
      putdcc $idx "\r
      putdcc $idx "All users with an IP beginning with 195.135.14 can make\r"
      putdcc $idx "the bot think that they are bill....\r"
	putdcc $idx " "
      putdcc $idx "In this case, all the commands that bill used without a password can now be used by\r"
      putdcc $idx "anyone that matches that IP. If bill used !op !ban !kick command in a chan, anyone with a matching IP\r"
      putdcc $idx "can use them also.\r"
	putdcc $idx "\r"
      putdcc $idx "Now you know where the security hole is, you can change that....You know\r"
      putdcc $idx "that bill has a fixed IP, you tell the bot to use bill's complete IP \r"
      putdcc $idx "to recognize him.\r"
	putdcc $idx "\r"
	putdcc $idx ".-host bill *!bgates@195.135.14.*\r"
	putdcc $idx ".+host bill *!*@195.135.14.28\r"
	putdcc $idx "\r"
      putdcc $idx "Now bill is safe, no one can take his place. What about users\r"
      putdcc $idx "without a fixed ips ? For them you must use * in IPs, so you are never\r"
      putdcc $idx "sure that someone else can't take their place... It's because of this that there is in LoL's Toolz\r"
	putdcc $idx "a complete password protected ident system before any dangerous commands.\r"
	putdcc $idx "\r"
      putdcc $idx "Now back to auto-op :) We face exactly the same problem...So if a user has a fixed\r"
      putdcc $idx "IP address, you must check that the bot has taken the complete address, and then\r"
      putdcc $idx "you can use the auto-op flag, if this user doesn't have a fixed IP address you shouldn't\r"
      putdcc $idx "use the +a flag (+a flag = !OP function).\r"
	putdcc $idx "\r"
	putdcc $idx "                                                $lol(version)\r"
}

### .identhelp

proc dcc_lol_identhelp {hand idx arg} {
	set arg [charfilter $arg]
	global botnick
	putdcc $idx "                    \002**************************************\r"
	putdcc $idx "                    \002*** IDENTIFICATION TUTORIAL BY LOL ***\r"
	putdcc $idx "                    \002**************************************\r"
	putdcc $idx "\r"
      putdcc $idx "With version 4 of my toolz, the identification system has been added. Before you\r"
      putdcc $idx "can use the chan commands, you must type:\r"
	putdcc $idx "\r"
	putdcc $idx "/msg $botnick ident <password>\r"
	putdcc $idx "\r"
	putdcc $idx "or\r"
	putdcc $idx "\r"
	putdcc $idx "/msg $botnick id <password>\r"
	putdcc $idx "\r"
      putdcc $idx "If you have a recognized user@hostname the bot will identify you. Now you\r"
      putdcc $idx "can use the chan commands.\r"
	putdcc $idx "\r"
      putdcc $idx "If you are an owner you can disable or enable the chan commands for a user:\r"
	putdcc $idx "\r"
	putdcc $idx "partyline:\r"
	putdcc $idx "   .enable <hand>\r"
	putdcc $idx "   .disable <hand>\r"
	putdcc $idx "msg:\r"
	putdcc $idx "   enable <password> <nick|hand> \[chan\]\r"
	putdcc $idx "   disable <password> <nick|hand> \[chan\]\r"
	putdcc $idx "chan:\r"
	putdcc $idx "   !enable <nick>\r"
	putdcc $idx "   !disable <nick>\r"
	putdcc $idx "\r"
        putdcc $idx "The identification is kept as long as the bot can see the user in a chan.\r"
        putdcc $idx "When the user parts all the chans, the bot is on, the identification is removed.\r"
	putdcc $idx "I have make identification 100% compatible with chantoolz and normally\r"
	putdcc $idx "compatible with eggtoolz (concurrent tcl scripts).\r"
	putdcc $idx "\r"
        putdcc $idx "If \"CLONE=1\" all the others that are recognized as you by the bot AND have the same\r"
        putdcc $idx "IP address as the nick that made the identification are allowed to use chan commands.\r"
	putdcc $idx "\r"
	putdcc $idx "Example: your mask is *!darkvador@193.143.*.* and your IP: 193.143.12.23\r"
        putdcc $idx "=> anyone with *!darkvador@193.143.12.23 is recognized as your clones.\r"
	putdcc $idx "\r"
        putdcc $idx "If \"CLONE=0\" only the last nick identified is authorized to use the commands.\r"
        putdcc $idx "Use this for maximum security (against IP spoofing for example). \r"
        putdcc $idx ""
        putdcc $idx "LoL's TooLz detects if you change your nick.\r"
	putdcc $idx "\r"
        putdcc $idx "The variable SILENT alerts a user if he wants to use chan commands without being\r"
        putdcc $idx "identified. Set SILENT = 1 (no warning) can be good for example is there is more\r"
        putdcc $idx "than one bot in the chan using my script, and also to limit the help queue of\r"
        putdcc $idx "the bot. But at the beginning it is good to set SILENT = 0 because without it\r"
        putdcc $idx "the users will not understand why the chan's commands do not work.\r"
	putdcc $idx "\r"
        putdcc $idx "(You can now manually remove the identification using !unident, .unident...)\r"
	putdcc $idx "\r"
        putdcc $idx "Still one thing !!!\r"
	putdcc $idx "\r"
	putdcc $idx "ident <password>\r"
	putdcc $idx "\r"
	putdcc $idx "and\r"
	putdcc $idx "\r"
	putdcc $idx "ident <password> <hand>\r"
	putdcc $idx "\r"
        putdcc $idx "ARE NOT THE SAME COMMANDS !!!\r"
	putdcc $idx "\r"
        putdcc $idx "The first is an LoL TooLz command to enable chan commands.\r"
        putdcc $idx "The second is an eggdrop command to add a host when you have changed hostmasks\r"
	putdcc $idx "or anything...\r"
	putdcc $idx "\r"
	putdcc $idx "Example:\r"
        putdcc $idx "You have changed hostmasks and you come back on IRC:\r"
	putdcc $idx "ident <password> <hand(original nick)>     (to add  you new address)\r"
	putdcc $idx "ident <password>                           (to enable chan commands)\r"
	putdcc $idx "\r"
	putdcc $idx "With LoL's TooLz 5.1, a new feature has been added:\r"
	putdcc $idx "PERMIDENT (msg and party-line)\r"
        putdcc $idx "With this, you can set a mask where the bot no longer asks for\r"
	putdcc $idx "identification if you match it.\r"
	putdcc $idx "\r"
	putdcc $idx "Example:\r"
	putdcc $idx "/msg $botnick permident <password>\r"
	putdcc $idx "The mask added is your current *!user@IP, the COMPLETE IP is used by\r"
        putdcc $idx "default. If you want to specify another mask you can make it like that:\r"
	putdcc $idx "/msg $botnick permident <password> <mask>\r"
        putdcc $idx "Be careful choosing it!\r"
	putdcc $idx "\r"
        putdcc $idx "Hope this has helped you.\r"
}

### .addop <nick> <chan> [hand] 

proc dcc_lol_addop {handy idx arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] < 2} {
		putdcc $idx "\002Usage:\002 .addop <nick> <chan> \[hand\]\r"
		return 0
	}
	set nick [lindex $arg 0]
	set chan [strlwr [lindex $arg 1]]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set alternate [lindex $arg 2]
	if {![validchan $chan]} {
		putdcc $idx "I'm not on $chan\r"
		return 0
	}
	if {![matchattr $handy m|m $chan]} {
            putdcc $idx "Sorry, but you are not a master in $chan.\r"
		return 0
	}
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
            putdcc $idx "Sorry, but I don't see $nick in $chan.\r"
		return 0
	}
	if {[strlwr $nick] == [strlwr $botnick]} {
            putdcc $idx "Sorry, but I can't addop myself.\r"
		return 0
	}
	if {[getting-users]} {
            putdcc $idx "Sorry, but I'm transferring the userfile, try later.\r"
		return 0
	}
	if {![validuser $hand]} {
		if {[validuser $nick] && $alternate == ""} {
                  putdcc $idx "The hand $nick already exists. \002Usage:\002 .addop <nick> <chan> <hand>\r"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        putdcc $idx "The hand $alternate already exists. Choose another. \002Usage:\002 .addop <nick> <chan> <hand>\r"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			chattr $alternate +p|+o $chan
			putdcc $idx "New user: $alternate ([maskhost $hostmask])\r"
                  putdcc $idx "$nick added to the $chan oplist and party-line with the hand: $alternate.\r"
                  puthelp "NOTICE $nick :You have been added to the $chan oplist and party-line by $handy with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			if {[botisop $chan]} {pushmode $chan +o $nick}
			return 0
		}
		adduser $nick [maskhost $hostmask]
		chattr $nick +p|+o $chan
		putdcc $idx "New user: $nick ([maskhost $hostmask])\r"
            putdcc $idx "$nick added to the $chan oplist and party-line with the hand: $nick.\r"
            puthelp "NOTICE $nick :You have been added to the $chan oplist and party-line by $handy with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		if {[botisop $chan]} {pushmode $chan +o $nick}
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  putdcc $idx "The hand $alternate already exists. \002Usage:\002 .addop <nick> <chan> <hand>\r"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		chattr $alternate +p|+o $chan
		putdcc $idx "New user: $alternate ([maskhost $hostmask])\r"
                putdcc $idx "$nick added to the $chan oplist and party-line with the hand: $alternate.\r"
                puthelp "NOTICE $nick :You have been added to the $chan oplist and party-line by $handy with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		if {[botisop $chan]} {pushmode $chan +o $nick}
		return 0
	}
	if {[matchattr $hand -|+o $chan]} {
                putdcc $idx "$nick is already an op in $chan with this hand: $hand\r"
	} {
		chattr $hand -|+o $chan
                putdcc $idx "$nick added to the $chan oplist with this hand: $hand.\r"
                puthelp "NOTICE $nick :You have been added to the $chan oplist by $handy."
	}
	if {[botisop $chan]} {pushmode $chan +o $nick}
	return 0
}

### .delop <nick> <chan>

proc dcc_lol_delop {handy idx arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] != 2} {
		putdcc $idx "\002Usage:\002 .delop <nick> <chan>\r"
		return 0
	}
	set nick [lindex $arg 0]
	set chan [strlwr [lindex $arg 1]]
	if {$chan != ""} {set chan [chanaddapt $chan]}

	if {![validchan $chan]} {
		putdcc $idx "I'm not on $chan "
		return 0
	}
	if {![matchattr $handy m|m $chan]} {
                putdcc $idx "Sorry, but you are not a master in $chan.\r"
		return 0
	}
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
                putdcc $idx "Sorry, but I don't see $nick in $chan.\r"
		return 0
	}
	if {[strlwr $nick] == [strlwr $botnick]} {
		putdcc $idx "Yeah right, like I'm going to let you delop ME!\r"
		return 0
	}
	if {![validuser $hand]} {
		putdcc $idx "$nick is not a registered user.\r"
		if {[botisop $chan]} {pushmode $chan -o $nick}
		return 0
	}
	if {[getting-users]} {
                putdcc $idx "Sorry, but I'm transferring the userfile, try later.\r"
		return 0
	}
	if {![matchattr $hand -|+o $chan]} {
                putdcc $idx "$nick is not an op in $chan\r"
	} {
		chattr $hand -|-o $chan
                putdcc $idx "$nick has been removed from the $chan oplist.\r"
                puthelp "NOTICE $nick :You have been removed from the $chan oplist by $handy."
	}
	if {[botisop $chan]} {pushmode $chan -o $nick}
	return 0
}

### .channel <chan>

proc dcc_lol_channel {a b arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 1} {
		putdcc $b "\002Usage:\002 .channel <chan>\r"
		return 0
	}
	set chan [lindex $arg 0]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {[validchan $chan]} {
		if {![isdynamic $chan]} {
			putdcc $b "$chan is a STATIC channel\r"
			if {![matchattr $a o|o $chan]} {
                                putdcc $b "You are not an operator in $chan.\r"
				return 0
			}
			*dcc:channel $a $b $chan
			return 0
		} {
			putdcc $b "$chan is a DYNAMIC channel\r"
			if {![matchattr $a o|o $chan]} {
                                putdcc $b "You are not an operator in $chan.\r"
				return 0
			}
			*dcc:channel $a $b $chan
			return 0
		}
	} {
		if {![matchattr $a o]} {
			putdcc $b "You need to be a global op to join a new chan.\r"
			return 0
		}
		putdcc $b "Joining $chan...\r"
		channel add $chan
		utimer 10 "*dcc:channel $a $b $chan"
		utimer 15 "partchan $b $chan"
	}
	return 0
}

proc partchan {b chan} {
	putdcc $b "Parting $chan...\r"
	channel remove $chan
}

### .mode <chan> <flags>

proc dcc_lol_mode {a b arg} {
	set arg [charfilter $arg]
	if {[llength $arg] < 2} {
		putdcc $b "\002Usage:\002 .mode <chan> <flags>\r"
		return 0
	}
	set chan [lindex $arg 0]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set flags [lrange $arg 1 end]
	if {![validchan $chan]} { putdcc $b "I'm not on $chan \r" ;	return 0 }
	if {![botisop $chan]} { putdcc $b "Sorry, I'm not an op in $chan\r" ; return 0 }
	if {[matchattr $a o|o $chan]} {
		putserv "MODE $chan $flags"
		putdcc $b "Mode of $chan changed.\r"
	} {
            putdcc $b "You are not an operator in $chan.\r"
	}
}

### .help

proc dcc_lol_help {a b c} {
	set arg [charfilter $c]
	global lol
	*dcc:help $a $b $c
	putdcc $b "\r"
      putdcc $b "!!! Type \002.help-lol\002 to see the special commands for $lol(version) !!!\r"
}

### .gpl-lol

proc dcc_lol_gpl-lol {hand idx arg} {
	set arg [charfilter $arg]
	global lol
	putdcc $idx "\r"
	putdcc $idx "Eggdrop TCL Script: $lol(version).\r"
	putdcc $idx "Copyright (C) 1998-2003 Ltd Productions.\r"
	putdcc $idx "\r"
	putdcc $idx "LoL's TooLz HomePage: http://www.leonini.net/\r"
	putdcc $idx "\r"
	putdcc $idx "This program is free software; you can redistribute it and/or\r"
	putdcc $idx "modify it under the terms of the GNU General Public License 2\r"
	putdcc $idx "\r"
	putdcc $idx "This program is distributed in the hope that it will be useful,\r"
	putdcc $idx "but WITHOUT ANY WARRANTY; without even the implied warranty of\r"
	putdcc $idx "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\r"
	putdcc $idx "GNU General Public License for more details.\r"
	putdcc $idx "\r"
	putdcc $idx "You should have received a copy of the GNU General Public License\r"
	putdcc $idx "along with this program; if not, write to the Free Software\r"
	putdcc $idx "Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.\r"
	putdcc $idx "\r"
}

### .help-lol

proc dcc_lol_help-lol {hand idx arg} {
	set arg [charfilter $arg]
	global lol
	if {[lindex $arg 0] == ""} {
		putdcc $idx "                  \002******************************************\r"
            putdcc $idx "                  \002* Party-line commands for LOL's Toolz ***\r" 
		putdcc $idx "                  \002******************************************\r"
		putdcc $idx "\r"
		putdcc $idx "\037TYPE |         COMMAND         |               DESCRIPTION              | FLAGS\r"
		putdcc $idx "DCC    .param <parameter> <value> Set a bot's global variable.              n\r"
		putdcc $idx "DCC    .enable <hand>            Enable chan commands for a disabled user.  n\r"
            putdcc $idx "DCC    .disable <hand>           Disable chan commands for a user.          n\r"
            putdcc $idx "DCC    .userlist \[flags\]         Sort the bot's users.                      n\r"
		putdcc $idx "DCC    .join <chan> \[chan pass\]  Join or create a new chan.                 n\r"
            putdcc $idx "DCC    .partyban <hand>          Boot a user and remove partyline flag.     m\r"
		putdcc $idx "DCC    .botnick <nick>           Change the botnick.                        m\r"
            putdcc $idx "DCC    .part <chan>              Parts a chan but doesn't delete the chan's userlist. m|m\r"
		putdcc $idx "DCC    .security                 Security risk with dynamic IP.             m|m\r"
            putdcc $idx "DCC    .addop <nick> <chan> \[hand\] Add op and partyline flags.          m|m\r"
            putdcc $idx "DCC    .delop <nick> <chan>      Remove op flag.                            m|m\r"
		putdcc $idx "DCC    .userlist <flags>         Show bot's userlist.                       o\r"
		putdcc $idx "DCC    .chanlist <chan>          Show bot's channels.                       o\r"
            putdcc $idx "DCC    .online                   Show bot's online info.                    o\r"
		putdcc $idx "DCC    .channel <chan>           Show who is in a chan.                     o|o\r"
            putdcc $idx "DCC    .mode <chan> <flags>      Change the channel attributes.             o|o\r"
		putdcc $idx "DCC    .unident                  Disable the chan commands.                 -\r"
            putdcc $idx "DCC    .seen <nick|hand>         Show the last time a user was online.      -\r"
            putdcc $idx "DCC    .permident <mask>         Set a permident mask.                      -\r"
            putdcc $idx "DCC    .unpermident              Remove the permident mask.                 -\r"
            putdcc $idx "DCC    .silent                   Disable ident alert for chan commands.     -\r"
            putdcc $idx "DCC    .unsilent                 Enable ident alert for chan commands.      -\r"
		putdcc $idx "DCC    .help-lol \[chan or msg\]   This help and more...                      -\r"
            putdcc $idx "DCC    .chanhelp                 Help on chan commands.                     -\r"
		putdcc $idx "DCC    .identhelp                Tutorial on ident system.                  -\r"
		putdcc $idx "\r"
		putdcc $idx "For chan commands type: .help-lol chan \r"
		putdcc $idx "For messages commands type: .help-lol msg \r"
		putdcc $idx "\r"
		putdcc $idx "Please report me the bugs to \002TeodOR@oo1corp.zzn.com\002. Thanks\r"
		return 0
	}
	if {[lindex $arg 0] == "chan"} {
		putdcc $idx "                     \002************************************\r"
            putdcc $idx "                     \002*** Chan commands for LOL's Toolz ***\r"
		putdcc $idx "                     \002************************************\r"
		putdcc $idx "\r"
		putdcc $idx "\037TYPE |         COMMAND         |               DESCRIPTION              | FLAGS\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]param <parameter> <value> Set a global bot variable    n\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]enable <nick>            Enable chan commands for a disabled user.  n\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]disable <nick>           Disable chan commands for a user.          n\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]deluser <nick|hand> \[chan\] Remove a user or a bot.                  n\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]addhost <nick|hand> \[host\] Add a host.                              n\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]delhost <nick|hand> <host> Delete a host.                           n\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]join <chan> \[chan pass\]  Join or create a new chan.                 n\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]remove <chan>            Remove a chan and it's userlist.           n\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]addmaster <nick> \[hand\]  Add chan masterflag.                    n|n\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]delmaster <nick>         Delete chan masterflag.                    n|n\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]jump <server> \[port\]     Jump to a new server.                      m\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]botnick <nick>           Change the botnick.                        m\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]adduser <nick> \[hand\] Add a user.                                   m|m\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]addbot <nick> \[port\] \[hand\] Add a bot.                              m|m\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]addop <nick> \[hand\]  See .addop.                                 m|m\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]delop <nick>             See .delop.                                m|m\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]findip <mask>            Search users that match IP mask.           m|m\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]online                   Show bot's online information.             o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]mode <flags>             Changes chan attributes.                   o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]ban <nick|mask> \[time\] \[reason\] Ban a user (time 0 = perm ban).     o|o\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]unban <mask|number>      Unban a mask.                              o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]broadcast <text>         Send text to all the chans you have ops on. o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]addvoice <nick> \[hand\]  Add voice and partyline flags.           o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]delvoice <nick>          Remove voice flag.                         o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]op \[nick\]                Op a user.                                 o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]deop \[nick\]              Deop a user.                               o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]whois <nick>             Show a user's handle.                      o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]quick <nick|mask> \[reason\] Kick a user and ban him 7 seconds.       o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]mirc                     Kick the mIRC users.                       o|o\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]eggdrop                  Kick the Eggdrops.                         o|o\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]ircii                    Kick the IRCII users.                      o|o\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]bitchx                   Kick the BitchX users.                     o|o\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]topic <topic>            Set a new topic.                           o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]chattr <nick> <flags>    Change a user's flags.                     o|o\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]voice \[nick\]             Voice a user.                              v|v\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]devoice \[nick\]           Devoice a user.                            v|v\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]kick <nick|mask> \[reason\] Kick a user.                              v|v\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]stats                    Show channel stats.                        v|v\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]cigarette \[nick\]         Offer a cigarette :)                       v|v\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]rose \[nick\]              Offer a beautiful rose :)                  v|v\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]pastaga \[nick\]           Give a glass of pastaga :)                 v|v\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]beer \[nick\]              Give a beer :)                             v|v\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]coke \[nick\]              Give a delicious coke :)                   v|v\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]penalty \[player\] \[ball\]  Shoot a penalty (french joke).             v|v\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]unident                  Disable the chan commands.                 -\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]unpermident              Remove the permident mask.                 -\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]seen <nick|hand>         Show the last time a user was online.      -\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]help                     Show a short help in chan.                 -\r"
		putdcc $idx "CHAN   [string trim $lol(cmdchar)]time                     Show the actual time.                      -\r"
            putdcc $idx "CHAN   [string trim $lol(cmdchar)]troubles                 A help to resolve certain problems.        -\r"
		putdcc $idx "\r"
		putdcc $idx "Try .chanhelp too ;) another version of this help.\r"
		putdcc $idx "For party-line commands type: .help-lol \r"
		putdcc $idx "For messages commands type: .help-lol msg \r"
		putdcc $idx "\r"
		putdcc $idx "$lol(version)\r"
		putdcc $idx "Report me the bugs, thanks. \002TeodOR@oo1corp.zzn.com\002\r"
		return 0
	}
	if {[lindex $arg 0] == "msg"} {
		putdcc $idx "                   \002****************************************\r"
            putdcc $idx "                   \002*** Messages commands for LOL's Toolz ***\r"
		putdcc $idx "                   \002****************************************\r"
		putdcc $idx "\r"
            putdcc $idx "\002 THE FIRST PARAMETER OF ALL THESE COMMANDS IS ALWAYS YOUR PASSWORD.\r"
		putdcc $idx "\r"
		putdcc $idx "\037TYPE |         COMMAND         |               DESCRIPTION              | FLAGS\r"
		putdcc $idx "MSG    param <parameter> <value> Set a global variable.                     n\r"
		putdcc $idx "MSG    enable <hand>             Enable chan commands for a disabled user.  n\r"
            putdcc $idx "MSG    disable <hand>            Disable chan commands for a user.          n\r"
		putdcc $idx "MSG    join <chan> \[chan pass\]   Join or create a new chan.                 n\r"
		putdcc $idx "MSG    remove <chan>             Remove a chan and chan's users.            n\r"
            putdcc $idx "MSG    deluser <hand>            Remove a user from the bot.                n\r"
		putdcc $idx "MSG    addhost <hand> <host>     See !addhost.                              n\r"
		putdcc $idx "MSG    delhost <hand> <host>     See !delhost.                              n\r"
		putdcc $idx "MSG    addmaster <nick> <chan> \[hand\]  See !addmaster.                   n|n\r"
		putdcc $idx "MSG    msg <chan or nick> <message> Send a message.                         m\r"
		putdcc $idx "MSG    botnick <nick>            Change the botnick.                        m\r"
            putdcc $idx "MSG    part <chan>               Part a chan but doesn't remove the userlist. m|m\r"
		putdcc $idx "MSG    addop <nick> <chan> \[hand\]  See !addop.                           m|m\r"
		putdcc $idx "MSG    adduser <nick> <chan> \[hand\] See !adduser.                           m|m\r"
		putdcc $idx "MSG    addbot <nick> <chan> \[port\] \[hand\] See !addbot.                      m|m\r"
		putdcc $idx "MSG    chattr <hand> <flags> \[chan\] See !chattr.                            o|o\r"
		putdcc $idx "MSG    broadcast <password> <text> See !broadcast.                          o|o\r"
		putdcc $idx "MSG    addvoice <nick> <chan> \[hand\]  See !addvoice.                     o|o\r"
		putdcc $idx "MSG    ban <nick|mask> <chan> \[time\] \[reason\] See !ban.                     o|o\r"
		putdcc $idx "MSG    unban <mask|number> <chan> See !unban.                               o|o\r"
		putdcc $idx "MSG    mode <chan> <flags>       See !mode.                                 o|o\r"
            putdcc $idx "MSG    key <chan>                Send the chan key if you have op there.    o|o\r"
		putdcc $idx "MSG    quick <nick|mask> <chan>  See !quick.                                o|o\r"
		putdcc $idx "MSG    banlist <chan>            See !banlist.                              o|o\r"
		putdcc $idx "MSG    unban <mask> <chan>       See !unban.                                o|o\r"
            putdcc $idx "MSG    whois <nick>              Show the hand of an user.                  o|o\r"
            putdcc $idx "MSG    invite \[chan\]             Invite you to a chan.                      v|v\r"
            putdcc $idx "MSG    seen <nick|hand>          Show the last time a user was online.      -\r"
		putdcc $idx "MSG    ident                     Enable the chan commands.                  -\r"
		putdcc $idx "MSG    unident                   Disable the chan commands.                 -\r"
		putdcc $idx "MSG    permident \[mask\]          Set a permident mask.                      -\r"
		putdcc $idx "MSG    unpermident               Disable the permident mask.                -\r"
            putdcc $idx "MSG    silent                    Disable bot alert for ident.               -\r"
            putdcc $idx "MSG    unsilent                  Enable bot alert for ident.                -\r"
		putdcc $idx "MSG    help                      Bot help + LoL's toolz msg quick help.     -\r"
		putdcc $idx "\r"
		putdcc $idx "For party-line commands type: .help-lol\r"
		putdcc $idx "For chan commands type: .help-lol chan\r"
		putdcc $idx "\r"
		putdcc $idx "$lol(version)\r"
            putdcc $idx "Report the bugs please, thanks. \002TeodOR@oo1corp.zzn.com\002\r"
		return 0
	}
	putdcc $idx "\002Usage\002: .help-lol \[chan or msg\]\r"
	return 0
}

### .chanhelp

proc dcc_lol_chanhelp {hand idx arg} {
	set arg [charfilter $arg]
	global lol botnick
	putdcc $idx "                         \002****************************\r"
	putdcc $idx "                         \002*** CHAN'S COMMANDS HELP ***\r"
	putdcc $idx "                         \002****************************\r"
	putdcc $idx "\r"
      putdcc $idx "Before to use the chan functions, you need to identify yourself:\r"
	putdcc $idx "\002/msg $botnick id <password>\002\r"
	putdcc $idx " \r"
	putdcc $idx "\037Global owners:\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]param <parameter> <value>\002 to set a global bot variable.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]enable <nick>\002 to enable chan commands for a disabled user.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]disable <nick>\002 to disable chan commands for a user.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]deluser <nick>\002 to delete a user or a bot.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]join <chan> \[chan pass\]\002 to join or create a new chan.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]remove \[chan\]\002 to remove a chan and it's userfile.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]jump <server> \[port\]\002 to jump to a new server.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]addhost <nick|hand> \[host\]\002 to add a host.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]delhost <nick|hand> <host>\002 to delete a host.\r"
	putdcc $idx " \r"
	putdcc $idx "\037Chan owners:\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]addmaster <nick> \[hand\] \002 to give master and partyline flags.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]delmaster <nick>\002 to remove master flag.\r"
	putdcc $idx " \r"
	putdcc $idx "\037Global masters:\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]jump <server> \[port\]\002 to jump to a new server.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]botnick <nick>\002 to change the botnick.\r"
	putdcc $idx " \r"
	putdcc $idx "\037Chan masters:\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]addop <nick> \[hand\] \002 to give op and partyline flags.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]delop <nick>\002 to remove op flag.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]adduser <nick> \[hand\]\002 to add a user.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]addbot <nick> \[port\] \[hand\]\002 to add a bot.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]findip <mask>\002 Search users that match IP mask.\r"
	putdcc $idx " \r"
	putdcc $idx "\037Chan ops:\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]chattr <nick> <flags>\002 to set specifics flags for a user.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]online\002 to see bot's online information.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]mode <flags>\002 to change the chan modes.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]banlist\002 show chan banlist.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]ban <nick|mask> \[time\]\002 to ban someone (time 0 = perm ban).\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]unban <mask|number>\002 to unban a mask.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]addvoice <nick> \[hand\] \002 to give voice and partyline flags.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]delvoice <nick>\002 to remove voice flag.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]op \[nick\]\002 to op.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]deop \[nick\]\002 to deop.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]broadcast <text>\002 to send a message to all the chans you have op on.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]topic <topic>\002 to change topic.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]whois <nick>\002 to see the a user's hand.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]quick <nick|mask> \[reason\]\002 to kick someone and ban him 7 seconds.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]mirc\002 to kick the mIRC users.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]eggdrop\002 to kick the Eggdrops.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]ircii\002 to kick the IRCII users.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]bitchx\002 to kick the BitchX users.\r"
	putdcc $idx " \r"
	putdcc $idx "\037Chan voiced:\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]voice \[nick\]\002 to voice.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]devoice \[nick\]\002 to devoice.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]kick <nick|mask> \[reason\]\002 to kick someone.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]stats\002 to see channel stats.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]cigarette \[nick\]\002 to offer a cigarette :)\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]rose \[nick\]\002 to offer beautiful rose :)\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]pastaga (or [string trim $lol(cmdchar)]pastis or [string trim $lol(cmdchar)]51) \[nick\]\002 to give a glass of pastaga :)\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]coke (or [string trim $lol(cmdchar)]coca-cola) \[nick\]\002 to give a delicious coke :)\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]beer \[nick\]\002 to give a beer :)\r"
	putdcc $idx " \r"
	putdcc $idx "\037Public:\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]unident\002 to disable the chan commands.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]unpermident\002 to disable the permident mask.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]time\002 to get time.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]seen <nick|hand>\002 to view when a user was last on irc.\r"
      putdcc $idx "\002[string trim $lol(cmdchar)]troubles\002 if you have certain problems with ident especially.\r"
	putdcc $idx "\002[string trim $lol(cmdchar)]help\002 to receive a short help.\r"
	putdcc $idx " \r"
	putdcc $idx "If some commands don't work, it's probably because the administrator has\r"
	putdcc $idx "disabled them.\r"
	putdcc $idx " \r"
      putdcc $idx "Report the bugs please, thanks. \002TeodOR@oo1corp.zzn.com\002\r"
	return 0
}

################# END OF DCC COMMANDS #################

################# START OF MSG COMMANDS #################

### seen <nick|hand>

proc msg_lol_seen {nick host hand arg} {
	set arg [charfilter $arg]
	if {$hand == "*"} {return 0}
	if {[llength $arg] != 1} {
		puthelp "PRIVMSG $nick :\002Usage\002: seen <nick|hand>"
		return 0
	}
	set who [lindex $arg 0]
	puthelp "PRIVMSG $nick :[lol_seen $nick $hand $who ""]"
	return 0
}

### silent <password>

proc msg_lol_silent {nick host hand arg} {
	set arg [charfilter $arg]
	if {$hand == "*"} {return 0}
	if {[llength $arg] != 1} {
		puthelp "PRIVMSG $nick :\002Usage:\002 silent <password>"
		return 0
	}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password. \002Usage:\002 silent <password>"
		return 0
	}
	setuser $hand xtra silent 1
        puthelp "PRIVMSG $nick :You are now in silent mode. You won't be notified if you try a command without first being identified. Use \002unsilent\002 to remove the silent mode."
}

### unsilent <password>

proc msg_lol_unsilent {nick host hand arg} {
	set arg [charfilter $arg]
	if {$hand == "*"} {return 0}
	if {[llength $arg] != 1} {
		puthelp "PRIVMSG $nick :\002Usage:\002 unsilent <password>"
		return 0
	}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password. \002Usage:\002 unsilent <password>"
		return 0
	}
	setuser $hand xtra silent 0
        puthelp "PRIVMSG $nick :You are no longer in silent mode. You will be notified if you try a command without first being identified. Use \002silent\002 to return in the silent mode."
}

### unpermident <password>

proc msg_lol_unpermident {nick host hand arg} {
	set arg [charfilter $arg]
	if {$hand == "*"} {return 0}
	if {[llength $arg] != 1} {
		puthelp "PRIVMSG $nick :\002Usage:\002 unpermident <password>"
		return 0
	}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password. \002Usage:\002 unpermident <password>"
		return 0
	}
	setuser $hand xtra permident ""
	if {[getuser $hand xtra auth] != "DEAD"} {
		setuser $hand xtra auth 0
	}
	chattr $hand -3
        puthelp "PRIVMSG $nick :You are no longer using a permident mask.\r"
}

### unident <password>

proc msg_lol_unident {nick host hand arg} {
	set arg [charfilter $arg]
	if {$hand == "*"} {return 0}
	if {[llength $arg] != 1} {
		puthelp "PRIVMSG $nick :\002Usage:\002 unident <password>"
		return 0
	}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password. \002Usage:\002 unident <password>"
		return 0
	}
	if {![check $hand $nick $host]} {
                puthelp "PRIVMSG $nick :You are already unidentified."
		return 0
	}
	if {[getuser $hand xtra auth] != "DEAD"} {
		setuser $hand xtra auth 0
	}
	chattr $hand -3
        puthelp "PRIVMSG $nick :You are no longer identified."
}

### botnick <password> <nick>

proc msg_lol_botnick {mynick host hand arg} {
	set arg [charfilter $arg]
	global nick
	if {[llength $arg] != 2} {
		puthelp "PRIVMSG $mynick :\002Usage:\002 botnick <password> <nick>"
		return 0
	}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $mynick :Invalid password. \002Usage:\002 botnick <password> <nick>"
		return 0
	}
	set nick [lindex $arg 1]
}

### addhost <password> <hand> <host>

proc msg_lol_addhost {nick host hand arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 3} {
		puthelp "PRIVMSG $nick :\002Usage:\002 addhost <password> <hand> <host>"
		return 0
	}
	set who [lindex $arg 1]
	set host [lindex $arg 2]
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password. \002Usage:\002 addhost <password> <hand> <host>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {[validuser $who] == "*"} {
		puthelp "PRIVMSG $nick :$who is not a registered user."
		return 0
	}
	if {![matchattr $hand m]} {
                puthelp "PRIVMSG $nick :Sorry, but you are not a global master."
		return 0
	}
	setuser $who hosts $host
	puthelp "PRIVMSG $nick :$host added for $who."
	return 0
}

### delhost <password> <hand> <host>

proc msg_lol_delhost {nick host hand arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 3} {
		puthelp "PRIVMSG $nick :\002Usage:\002 delhost <password> <hand> <host>"
		return 0
	}
	set who [lindex $arg 1]
	set host [lindex $arg 2]
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 delhost <password> <hand> <host>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {[validuser $who] == "*"} {
		puthelp "PRIVMSG $nick :$who is not a registered user."
		return 0
	}
	if {![matchattr $hand m]} {
                puthelp "PRIVMSG $nick :Sorry, but you are not a global master."
		return 0
	}
	if {[delhost $who $host]} {
		puthelp "PRIVMSG $nick :$host removed for $who."
		return 0
	} {
		puthelp "PRIVMSG $nick :I can't remove $host at $who."
		return 0
	}
}

### chattr <password> <hand> <flags> [chan]

proc msg_lol_chattr {nick host hand arg} {
	set arg [charfilter $arg]
	if {[llength $arg] < 3} {
		puthelp "PRIVMSG $nick :\002Usage:\002 chattr <password> <hand> <flags> \[chan\]"
		return 0
	}
	set who [lindex $arg 1]
	set flags [lindex $arg 2]
	set chan [lindex $arg 3]
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 chattr <password> <hand> <flags> \[chan\]"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {[validuser $who] == "*"} {
		puthelp "PRIVMSG $nick :$who is not a registered user."
		return 0
	}
	if {$chan != ""} {
		if {[matchattr $hand n|n $chan]} {
			set change [chattr $who -|$flags $chan]
			if {$change != ""} {
				set change [lindex [split $change "|"] 1]
                                puthelp "PRIVMSG $nick :$who now has these flags in $chan: $change"
				return 0
			}
			puthelp "PRIVMSG $nick :The flags for $who have not changed."
			return 0
		}
		regsub -all -- "n" $flags "" flags
		regsub -all -- "m" $flags "" flags
		if {[matchattr $hand m|m $chan]} {
			set change [chattr $who -|$flags $chan]
			if {$change != ""} {
				set change [lindex [split $change "|"] 1]
                                puthelp "PRIVMSG $nick :$who now has these flags in $chan: $change"
				return 0
			}
			puthelp "PRIVMSG $nick :The flags for $who have not changed."
			return 0
		}
		regsub -all -- "o" $flags "" flags
		if {[matchattr $hand o|o $chan]} {
			set change [chattr $who -|$flags $chan]
			if {$change != ""} {
				set change [lindex [split $change "|"] 1]
                                puthelp "PRIVMSG $nick :$who now has these flags in $chan: $change"
				return 0
			}
			puthelp "PRIVMSG $nick :The flags for $who have not changed."
			return 0
		}
	} {
		if {[matchattr $hand n]} {
			set change [chattr $who $flags]
			if {$change != ""} {
                                puthelp "PRIVMSG $nick :$who now has global flags: $change"
				return 0
			}
			puthelp "PRIVMSG $nick :The flags for $who have not changed."
			return 0
		}
		regsub -all -- "n" $flags "" flags
		regsub -all -- "m" $flags "" flags
		if {[matchattr $hand m]} {
			set change [chattr $who $flags]
			if {$change != ""} {
                        puthelp "PRIVMSG $nick :$who now has these global flags: $change"
				return 0
			}
			puthelp "PRIVMSG $nick :The flags for $who have not changed."
			return 0
		}
		regsub -all -- "o" $flags "" flags
		if {[matchattr $hand o]} {
			set change [chattr $who $flags]
			if {$change != ""} {
                        puthelp "PRIVMSG $nick :$who now has these global flags: $change"
				return 0
			}
			puthelp "PRIVMSG $nick :The flags for $who have not changed."
			return 0
		}
	}
      puthelp "PRIVMSG $nick :You do not have enough rights to use this function."
	return 0
}

### param <password> <parameter> <value>

proc msg_lol_param {nick host hand arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {[llength $arg] != 3} {
		puthelp "PRIVMSG $nick :\002Usage:\002 param <password> <parameter> <value>"
		return 0
	}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 param <password> <parameter> <value>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {[lindex $arg 2] == ""} {
		puthelp "PRIVMSG $nick :\002Usage:\002 [string trim $lol(cmdchar)]param <parameter> <value>"
		set param_display ""
		append param_display "\002cmdchar:\002 $lol(cmdchar)"
		append param_display "   "
		append param_display "\002security:\002 $lol(security)"
		append param_display "   "
		append param_display "\002nopass:\002 $lol(nopass)"
		append param_display "   "
		append param_display "\002chankey:\002 $lol(chankey)"
		append param_display "   "
		append param_display "\002silent:\002 $lol(silent)"
		append param_display "   "
		append param_display "\002ident:\002 $lol(ident)"
		append param_display "   "
		append param_display "\002id_confirm:\002 $lol(id_confirm)"
		append param_display "   "
		append param_display "\002clone:\002 $lol(clone)"
		append param_display "   "
		append param_display "\002jokes:\002 $lol(jokes)"
		append param_display "   "
		append param_display "\002help:\002 $lol(help)"
		append param_display "   "
		append param_display "\002troubles:\002 $lol(troubles)"
		append param_display "   "
		append param_display "\002seen:\002 $lol(seen)"
		append param_display "   "
		append param_display "\002time:\002 $lol(time)"
		append param_display "   "
		append param_display "\002chan_flood:\002 $lol(chan_flood)"
		append param_display "   "
		append param_display "\002join_flood:\002 $lol(join_flood)"
		append param_display "   "
		append param_display "\002deop_flood:\002 $lol(deop_flood)"
		append param_display "   "
		append param_display "\002ctcp_flood:\002 $lol(ctcp_flood)"
		append param_display "   "
		append param_display "\002kick_flood:\002 $lol(kick_flood)"
		append param_display "   "
		append param_display "\002chan_parameters:\002 $lol(chan_parameters)"
		puthelp "PRIVMSG $nick :$param_display"
		set param_display ""
		append param_display "\002ban_protect:\002 $lol(ban_protect)"
		append param_display "   "
		append param_display "\002chanmode:\002 $lol(chanmode)"
		append param_display "   "
		append param_display "\002server_flags:\002 $lol(server_flags)"
		append param_display "   "
		append param_display "\002welcome:\002 $lol(welcome)"
		append param_display "   "
		append param_display "\002idle_protect:\002 $lol(idle_protect)"
		append param_display "   "
		append param_display "\002warn_idle_time:\002 $lol(warn_idle_time)"
		append param_display "   "
		append param_display "\002max_idle_time:\002 $lol(max_idle_time)"
		append param_display "   "
		append param_display "\002kick_idle_time:\002 $lol(kick_idle_time)"
		append param_display "   "
		append param_display "\002idle_ban_time:\002 $lol(idle_ban_time)"
		append param_display "   "
		append param_display "\002no_kick_flags:\002 $lol(no_kick_flags)"
		append param_display "   "
		append param_display "\002no_ban_flags:\002 $lol(no_ban_flags)"
		append param_display "   "
		append param_display "\002no_idle_flags:\002 $lol(no_idle_flags)"
		puthelp "PRIVMSG $nick :$param_display"
		set param_display ""
		append param_display "\002welmsg:\002 $lol(welmsg)"
		puthelp "PRIVMSG $nick :$param_display"
		set param_display ""
		append param_display "\002away:\002 $lol(away)"
		puthelp "PRIVMSG $nick :$param_display"
		return 0
	}
	set lol([strlwr [lindex $arg 1]]) [lrange $arg 2 end]
        puthelp "PRIVMSG $nick :The new value for [strlwr [lindex $arg 1]] is [lrange $arg 2 end]."
	return 0
}

### enable <password> <hand>

proc msg_lol_enable {nick host hand arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] != 2} {
		puthelp "PRIVMSG $nick :\002Usage:\002 enable <password> <hand>"
		return 0
	}
	set who [lindex $arg 1]
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 enable <password> <hand>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {[validuser $who] == "*"} {
		puthelp "PRIVMSG $nick :$who is not a registered user."
		return 0
	}
	if {[getuser $who xtra auth] != "DEAD"} {
		puthelp "PRIVMSG $nick :$who is already enabled."
		return 0
	}
	setuser $who xtra auth 0
	puthelp "PRIVMSG $nick :$who is now enabled."
	return 0
}

### disable <password> <hand>

proc msg_lol_disable {nick host hand arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] != 2} {
		puthelp "PRIVMSG $nick :\002Usage:\002 disable <password> <hand>"
		return 0
	}
	set who [lindex $arg 1]
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 disable <password> <hand>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {[validuser $who] == "*"} {
		puthelp "PRIVMSG $nick :$who is not a registered user."
		return 0
	}
	if {[getuser $who xtra auth] == "DEAD"} {
		puthelp "PRIVMSG $nick :$who is already disabled."
		return 0
	}
	setuser $who xtra auth DEAD
	chattr $who -3
	puthelp "PRIVMSG $nick :$who is now disabled."
	return 0
}

### ident <password> [username]

proc msg_lol_ident {nick host hand arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {$hand == "*"} {
		if {[llength $arg] < 2 || [llength $arg] > 2} {return 0}
		set find 0
		foreach user [userlist] {
			if {[strlwr $user] == [strlwr [lindex $arg 1]]} {
				set find 1
				break
			}
		}
		if {$find == 0} {return 0}
		if {[passwdok [strlwr [lindex $arg 1]] [lindex $arg 0]]} {
			*msg:ident $nick $host $hand $arg
		}
		return 0
	}
	if {[llength $arg] > 2} {return 0}
	set pass [lindex $arg 0]
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a new password: pass <your_new_password>"
		return 0
	}
	if {[llength $arg] < 1} {
		puthelp "PRIVMSG $nick :\002Usage:\002 ident <password>"
		return 0
	}
	if {[llength $arg] > 1} {
		if {[strlwr [lindex $arg 1]] != [strlwr $hand]} {
			return 0
		} {
			if {![passwdok $hand $pass]} {return 0}
		}
		puthelp "PRIVMSG $nick :You are already recognized by the bot :-) Don't worry about your mask ! \002Usage:\002 ident <password>"
		return 0
	}
	if {![passwdok $hand $pass]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 ident <password>"
		return 0
	}
	if {[getuser $hand xtra auth] == "DEAD"} {
                puthelp "PRIVMSG $nick :Sorry, your chan commands are disabled."
		return 0
	}
	set find 0
	foreach ch [channels] {
		if {[onchan $nick $ch]} {
			set find 1
			break
		}
	}
	if {$find == 0} {
                puthelp "PRIVMSG $nick :You must be in one of my chans to be identified."
		return 0
	}
	setuser $hand xtra auth 1
	setuser $hand xtra authnick $nick
	set host [lindex [split $host "@"] 1]
	setuser $hand xtra authhost $host
	chattr $hand +3
	if {$lol(id_confirm) == 1} {
                puthelp "PRIVMSG $nick :You have been identified. You can unident yourself with \002unident\002, set a perm ident mask with \002permident\002 and remove chan ident alert with \002silent\002."
	}
	return 0
}

### permident <password> [nick!user@host]

proc msg_lol_permident {nick host hand arg} {
	set arg [charfilter $arg]
	if {$hand == "*"} {return 0}
	global botnick
	if {[llength $arg] < 1} {
		puthelp "PRIVMSG $nick :\002Usage:\002 permident <password> \[nick!user@host\]"
		return 0
	}
	set mask [lindex $arg 1]
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 permident <password> \[user@host\]"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	set find 0
	foreach ch [channels] {
		if {[onchan $nick $ch]} {
			set find 1
			break
		}
	}
	if {$find == 0 && $mask == ""} {
                puthelp "PRIVMSG $nick :You must be in one of my chans to be permidentified, or use: permident <password> <user@host>."
		return 0
	}
	if {$mask == ""} {
		setuser $hand xtra permident *!$host
	} {
		setuser $hand xtra permident $mask
	}
        puthelp "PRIVMSG $nick :You are now permidentified with this mask: [getuser $hand xtra permident]. Use \002unpermident\002 to remove it."
}

### online <password>

proc msg_lol_online {nick host hand arg} {
	set arg [charfilter $arg]
	global server {server-online} uptime
	if {[llength $arg] != 1} {
		puthelp "PRIVMSG $nick :\002Usage:\002 online <password>"
		return 0
	}
	set ip [lindex [split $server ":"] 0]
	set port [lindex [split [lindex [split $server ":"] 1] "-"] 0]
	set timeon [time_diff ${server-online}]
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 online <password>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	set numbots 0
	foreach bot [bots] { incr numbots }
	set numchans 0
	foreach ch [channels] { incr numchans }

	set msg ""
        append msg "*** ONLINE info !!! ***"
	append msg "I have not crashed since [time_diff $uptime] ;) "
	append msg "\002I'm on $ip since $timeon.\002 "
	if {![matchattr $hand o]} {
                append msg "I'm in $numchans chan(s)."
	} {
		if {$numchans != 0} {
                        append msg "I'm in these chans: [channels]. "
		} {
                        append msg "I'm not in any chans. "
		}
	}
	if {![matchattr $hand o]} {
		append msg "\002I'm linked with $numbots bot(s).\002 "
	} {
		if {$numbots != 0} {
                        append msg "\002I'm linked with these bots: [bots]\002 "
		} {
                        append msg "\002I'm not linked with any bots.\002 "
		}
	}
	puthelp "PRIVMSG $nick :$msg"
}

### broadcast <password> <text>

proc msg_lol_broadcast {nick host c arg} {
	set arg [charfilter $arg]
	if {[llength $arg] < 2} {
		puthelp "PRIVMSG $nick :\002Usage:\002 broadcast <password> <text>"
		return 0
	}
	set text [lrange $arg 1 end]
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 broadcast <password> <text>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	foreach chan [channels] {
		if {[matchattr $c o|o $chan]} {
			puthelp "PRIVMSG $chan :\002<$nick>:\002 $text"
		}
	}
}

### key <password> <chan>

proc msg_lol_key {nick host hand arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 2} {
		puthelp "PRIVMSG $nick :\002Usage\002: key <password> <chan>"
		return 0
	}
	set chan [lindex $arg 1]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 key <password> <chan>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
                puthelp "PRIVMSG $nick :I'm not in $chan "
		return 0
	}
	if {![matchattr $hand o|o $chan]} {
                puthelp "PRIVMSG $nick :Sorry, but you are not an operator in $chan."
		return 0
	}
	set mode [getchanmode $chan]
	if {[string first k [lindex $mode 0]] != -1} {
		set posmode [string first k [lindex $mode 0]]
		if {[string first l [lindex $mode 0]] != -1} {
			set poslim [string first l [lindex $mode 0]]
			if {$posmode < $poslim} {
                                puthelp "PRIVMSG $nick :The key for $chan is [lindex $mode 1]."
			} {
                                puthelp "PRIVMSG $nick :The key for $chan is [lindex $mode 2]."
			}
		} {
                        puthelp "PRIVMSG $nick :The key for $chan is [lindex $mode 1]."
		}
		return 0
	}
        puthelp "PRIVMSG $nick :$chan does not require a key to enter."
}

## kick <password> <nick|mask> <chan> [reason]

proc msg_lol_kick {nick host hand arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] < 2} {
		puthelp "PRIVMSG $nick :\002Usage:\002 kick <password> <nick|mask> <chan> \[reason\]"
		return 0
	}
	set who [lindex $arg 1]
	set chan [lindex $arg 2]
	set reason [lrange $arg 3 end]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {$reason == ""} {
		set reason "requested"
	}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 kick <password> <nick|mask> <chan> \[reason\]"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
                puthelp "PRIVMSG $nick :I'm not in $chan "
		return 0
	}
	if {![botisop $chan]} {
                puthelp "PRIVMSG $nick :Sorry, I'm not an op in $chan"
		return 0
	}
	if {![matchattr $hand ov|ov $chan]} {
                puthelp "PRIVMSG $nick :Sorry, but you are not an operator nor do you have voice in $chan."
		return 0
	}
### GLOBAL nick hand chan who
	if {[string first "*" $who] != -1 || [string first "?" $who] != -1} {
		if {![matchattr $hand o|o $chan]} {
			puthelp "PRIVMSG $nick :You need to be an op in $chan to use mask kick."
			return 0
		}
		if {$reason == "requested"} {set reason "MaskKick: $who"}
		set who [strlwr $who]
		set kickcount 0
	
		if {$kickcount == 0} {
                        puthelp "PRIVMSG $nick :Sorry but nobody matches this mask in $chan."
		}
	} {
		if {![onchan $who $chan]} {
                        puthelp "PRIVMSG $nick :Sorry, but I don't see $who in $chan."
			return 0
		}
		if {[strlwr $who] == [strlwr $botnick]} {
			puthelp "PRIVMSG $nick :Yeah right, like I'm going to let you kick ME!"
			return 0
		}
		if {[nick2hand $who $chan] != "*"} {
			if {$hand != [nick2hand $who $chan]} {
				if {[matchattr [nick2hand $who $chan] o|o $chan] && ![matchattr $hand o|o $chan]} {
					puthelp "PRIVMSG $nick :Sorry, you must to be an operator in $chan to kick an operator."
					return 0
				}
				if {([matchattr [nick2hand $who $chan] m|m $chan] || [matchattr [nick2hand $who $chan] b]) && ![matchattr $hand m|m $chan]} {
					puthelp "PRIVMSG $nick :Sorry, you must to be a master in $chan to kick a master or a bot."
					return 0
				}
			}
		}
		putserv "KICK $chan $who :$reason"
	}
	return 0
}

### quick <password> <nick|mask> <chan> [reason]

proc msg_lol_quick {nick host hand arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] < 2} {
		puthelp "PRIVMSG $nick :\002Usage:\002 quick <password> <nick|mask> <chan> \[reason\]"
		return 0
	}
	set who [lindex $arg 1]
	set chan [lindex $arg 2]
	set reason [lrange $arg 3 end]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {$reason == ""} {
		set reason "requested"
	}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 kick <password> <nick|mask> <chan> \[reason\]"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
                puthelp "PRIVMSG $nick :I'm not in $chan "
		return 0
	}
	if {![botisop $chan]} {
                puthelp "PRIVMSG $nick :Sorry, I'm not an op in $chan"
		return 0
	}
	if {![matchattr $hand ov|ov $chan]} {
                puthelp "PRIVMSG $nick :Sorry, but you are not an operator nor do you have voice in $chan."
		return 0
	}
### GLOBAL nick hand chan who
	if {[string first "*" $who] != -1 || [string first "?" $who] != -1} {
		if {![matchattr $hand o|o $chan]} {
			puthelp "PRIVMSG $nick :You need to be an op in $chan to use mask kick."
			return 0
		}
		if {$reason == "requested"} {set reason "MaskQuick: $who"}
		set who [strlwr $who]
		set kickcount 0
		foreach chanuser [strlwr [chanlist $chan -mnovfb&-mnovfb]] {
			if {[string match [strlwr $who] [strlwr $chanuser]] && $chanuser != [strlwr $botnick]} {
				incr kickcount
				set hostmask "*!*[getchanhost $chanuser $chan]"
				if {[isop $chanuser $chan]} {pushmode $chan -o $chanuser}
				putserv "MODE $chan +b $hostmask"
				putserv "KICK $chan $chanuser :$reason"
				utimer 7 "deban $chan $hostmask"
			}
		}
		if {$kickcount == 0} {
                        puthelp "PRIVMSG $nick :Sorry but nobody matches this mask in $chan."
		}
	} {
		if {![onchan $who $chan]} {
                        puthelp "PRIVMSG $nick :Sorry, but I don't see $who in $chan."
			return 0
		}
		if {[strlwr $who] == [strlwr $botnick]} {
			puthelp "PRIVMSG $nick :Yeah right, like I'm going to let you kick ME!"
			return 0
		}
		if {[nick2hand $who $chan] != "*"} {
			if {$hand != [nick2hand $who $chan]} {
				if {[matchattr [nick2hand $who $chan] o|o $chan] && ![matchattr $hand o|o $chan]} {
					puthelp "PRIVMSG $nick :Sorry, you must to be an operator in $chan to kick an operator."
					return 0
				}
				if {([matchattr [nick2hand $who $chan] m|m $chan] || [matchattr [nick2hand $who $chan] b]) && ![matchattr $hand m|m $chan]} {
					puthelp "PRIVMSG $nick :Sorry, you must to be a master in $chan to kick a master or a bot."
					return 0
				}
			}
		}
		set hostmask "*!*[getchanhost $who $chan]"
		if {[isop $who $chan]} {pushmode $chan -o $who}
		putserv "MODE $chan +b $hostmask"
		putserv "KICK $chan $who :$reason"
		utimer 7 "deban $chan $hostmask"
	}
	return 0
}

### banlist <password> <chan>

proc msg_lol_banlist {nick host hand arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 2} {
		puthelp "PRIVMSG $nick :\002Usage:\002 banlist <password> <chan>"
		return 0
	}
	set chan [lindex $arg 1]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 banlist <password> <chan>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
                puthelp "PRIVMSG $nick :I'm not in $chan "
		return 0
	}
	if {![matchattr $hand o|o $chan]} {
                puthelp "PRIVMSG $nick :Sorry, but you are not an operator in $chan."
		return 0
	}
	set num 1
        puthelp "PRIVMSG $nick :*** $chan BANS info !!! ***"
	foreach bans [banlist $chan] {
		set victim [lindex $bans 0]
		set why [lindex $bans 1]
		set expire [lindex $bans 2]
		set who [lindex $bans 5]
		set remain [expr $expire - [unixtime]]
		if {$remain > 0} {
			set remain "expire in [time_diff2 $expire]."
		} {
			set remain "PermBan"
		}
		puthelp "PRIVMSG $nick :\002BAN $num:\002 $victim, $remain"
		puthelp "PRIVMSG $nick :$who: $why"
		incr num
	}
        if {$num == 1} {puthelp "PRIVMSG $nick :There are no bans in $chan."}
	return 0
}

### ban <password> <nick> <chan> [time] [reason]

proc msg_lol_ban {nick host hand arg} {
	set arg [charfilter $arg]
	global botnick lol
	if {[llength $arg] < 3} {
		puthelp "PRIVMSG $nick :\002Usage:\002 ban <password> <nick|mask> <chan> \[time\] \[reason\]"
		return 0
	}
	set chan [lindex $arg 2]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set who [lindex $arg 1]
	set ti [lindex $arg 3]
	if {[isnumber $ti]} {
		set reason [lrange $arg 4 end]
	} {
		set ti ""
		set reason [lrange $arg 3 end]
	}

	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 ban <password> <nick> <chan> \[time\] \[reason\]"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
            puthelp "PRIVMSG $nick :I'm not in $chan "
		return 0
	}

	if {![matchattr $hand o|o $chan]} {
            puthelp "PRIVMSG $nick :Sorry, but you are not an op in $chan."
		return 0
	}

	if {$reason == ""} { set reason "requested" }
	
	if {[onchan $who $chan]} {
		if { $lol(bantype) == 0 } { 
			set ipmask [lindex [split [maskhost $who![getchanhost $who $chan]] "@"] 1]
			set usermask [lindex [split [getchanhost $who $chan] "@"] 0]		
			set banmask *!*$usermask@$ipmask
		} else { 
			set banmask [getchanhost $who $chan]
     	      	set banmask "*!*[string range $banmask [string first @ $banmask] e]" 
		}	
	} else {  		
		set banmask [lindex $arg 1]
		if {[string first "!" $banmask] == -1 && [string first "@" $banmask] == -1} {
			if {[isnumber [string index $banmask 0]]} { 
				set banmask *!*@$banmask 
			} else {
				 set banmask $banmask*!*@* 
			}
		}
		if {[string first "!" $banmask] == -1} { set banmask *!*$banmask }
		if {[string first "@" $banmask] == -1} { set banmask $banmask*@* }
	}
			   		
	if {![botisop $chan]} { return 0 }
	putserv "MODE $chan +b $banmask"

  	foreach chanuser [chanlist $chan] {
      	if {[string match [strlwr $banmask] [strlwr "$chanuser![getchanhost $chanuser $chan]"]] && $chanuser != $botnick } { 
			if {[nick2hand $chanuser $chan] != "*"} {
				if {$hand != [nick2hand $chanuser $chan]} {
					if {[matchattr [nick2hand $chanuser $chan] o|o $chan] && ![matchattr $hand o|o $chan]} {
                  	            puthelp "NOTICE $nick :Sorry, you must be an operator to ban an operator."
						return 0
					}
					if {([matchattr [nick2hand $chanuser $chan] m|m $chan] || [matchattr [nick2hand $who $chan] b]) && ![matchattr $hand m|m $chan]} {
            	                  puthelp "NOTICE $nick :Sorry, you must be a master to ban a master or a bot."
						return 0
					}
				}
			}
	    	   	putkick $chan $chanuser $reason
		}
       }	 

	switch $ti {
		""
		{
			newchanban $chan $banmask $nick $reason
			puthelp "NOTICE $nick :New mask added : $banmask"
		}
		0
		{
			newchanban $chan $banmask $nick $reason $ti
			puthelp "NOTICE $nick :New mask added permanently : $banmask"
		}
		default
		{
			newchanban $chan $banmask $nick $reason $ti
			puthelp "NOTICE $nick :New mask added for $ti minutes : $banmask"
		}
	}
	return 0
}

### unban <password> <mask|number> <chan>

proc msg_lol_unban {nick host hand arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 3} {
		puthelp "PRIVMSG $nick :\002Usage:\002 unban <password> <mask> <chan>"
		return 0
	}
	set mask [lindex $arg 1]
	set chan [lindex $arg 2]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 unban <password> <mask> <chan>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
		puthelp "PRIVMSG $nick :I'm not on $chan "
		return 0
	}
	if {![matchattr $hand o|o $chan]} {
            puthelp "PRIVMSG $nick :Sorry, but you are not an operator in $chan."
		return 0
	}

	if {[isnumber $mask]} {
		foreach bans [banlist $chan] {
			incr find
			if {$find == $mask} { set mask [lindex $bans 0] ; break }
		}
		if {[isnumber $mask]} {
			puthelp "NOTICE $nick :There is no ban number $mask in this chan, type !banlist."
			return 0
		} 
	} else {	if {[string first "!" $mask] == -1 && [string first "@" $mask] == -1} {
				if {[isnumber [string index $mask 0]]} { set mask *!*@$mask 
				} else { set mask $mask*!*@* }
			}
			if {[string first "!" $mask] == -1} {set mask *!*$mask}
			if {[string first "@" $mask] == -1} {set mask $mask*@*}
	}
	
	if {[isban $mask $chan]} { 
		killchanban $chan $mask
		killban $mask
		puthelp "NOTICE $nick :Ban successfully removed on $chan."
		return 0
	} 

	foreach bans [chanbans $chan] {
		set victim [lindex $bans 0]
		if {[strlwr $victim] == [strlwr $mask]} {set find 1}
	}

	if {[botisop $chan] && $find == 1} {
		pushmode $chan -b $mask
            puthelp "NOTICE $nick :Ban successfully removed."
		return 0
	}
		
	puthelp "NOTICE $nick :No such ban on $chan."
	return 0
}

### mode <password> <chan> <flags>

proc msg_lol_chan {nick host hand arg} {
	set arg [charfilter $arg]
	global lol
	if {[llength $arg] < 3} {
		puthelp "PRIVMSG $nick :\002Usage:\002 mode <password> <chan> <chan mode>"
		return 0
	}
	set chan [lindex $arg 1]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set mode [lrange $arg 2 end]
	if {![passwdok $hand [lindex $arg 0]]} {
		puthelp "PRIVMSG $nick :Invalid password \002Usage:\002 mode <password> <chan> <chan mode>"
		return 0
	}
	if {[passwdok $hand ""]} {
		puthelp "PRIVMSG $nick :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
            puthelp "PRIVMSG $nick :I'm not in $chan "
		return 0
	}
	if {![botisop $chan]} {
            puthelp "PRIVMSG $nick :Sorry, but I'm not an op in $chan"
		return 0
	}
	if {![matchattr $hand o|o $chan]} {
            puthelp "PRIVMSG $nick :Sorry, but you are not an operator in $chan."
		return 0
	}
	if {$lol(chankey) == 1} {
		if {[string first k [lindex $mode 0]] != -1} {
			set posmode [string first k [lindex $mode 0]]
			if {[string first l [lindex $mode 0]] != -1} {
				set poslim [string first l [lindex $mode 0]]
				if {$posmode < $poslim} {
					channel set $chan need-key "chankey $chan [lindex $mode 1]"
				} {
					channel set $chan need-key "chankey $chan [lindex $mode 2]"
				}
			} {
				channel set $chan need-key "chankey $chan [lindex $mode 1]"
			}
		}
	}
	putserv "MODE $chan $mode"
	puthelp "PRIVMSG $nick :Mode changed in $chan."
	return 0
}

### whois <password> <nick>

proc msg_lol_whois {a b c arg} {
	set arg [charfilter $arg]
	global lol_whois
	if {[llength $arg] != 2} {
		puthelp "PRIVMSG $a :\002Usage:\002 whois <password> <nick>"
		return 0
	}
	set who [lindex $arg 1]
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $a :Invalid password \002Usage:\002 whois <password> <nick>"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $a :You must set a password: pass <your_new_password>"
		return 0
	}
	set find 0
	foreach chan [channels] {
		foreach user [chanlist $chan] {
			if {[strlwr $user] == [strlwr $who]} {
				set find $chan
				break
			}
		}
	}
	if {$find != 0} {
		set handle [nick2hand $who $find]
		set host [getchanhost $who $find]
		puthelp "PRIVMSG $a :[lol_whois $who $host $handle ""]"
		return 0
	} {
		if {![matchattr $c o]} {
                        puthelp "PRIVMSG $a :Sorry $who is not in one of my chans right now. I can't analyze him."
			return 0
		}
	}
	if {$lol_whois != ""} {
                puthelp "PRIVMSG $a :Too much whois in queue, one moment please."
		return 0
	}
        puthelp "PRIVMSG $a :$who is not in one of my chans right now, I'll try a whois request to the server, hold on."
	putserv "whois $who"
	set lol_whois $a:$who
}

### adduser <password> <nick> <chan> [hand]

proc msg_lol_adduser {me b c arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] < 3} {
		puthelp "PRIVMSG $me :\002Usage:\002 adduser <password> <nick> <chan> \[hand\]"
		return 0
	}
	set nick [lindex $arg 1]
	set chan [strlwr [lindex $arg 2]]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set alternate [lindex $arg 3]]
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $me :Invalid password \002Usage:\002 adduser <password> <nick> <chan> \[hand\]"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $me :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
                puthelp "PRIVMSG $me :I'm not in $chan "
		return 0
	}
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
                puthelp "PRIVMSG $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == [strlwr $botnick]} {
                puthelp "PRIVMSG $me :Sorry, but I can't adduser myself."
		return 0
	}
	if {[getting-users]} {
                puthelp "PRIVMSG $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {[validuser $hand]} {
		puthelp "PRIVMSG $me :$nick is already recognized with this hand: $hand"
	} {
		if {[validuser $nick] && $alternate == ""} {
                        puthelp "PRIVMSG $me :The hand $nick already exists. \002Usage:\002 adduser <password> <nick> <chan>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "PRIVMSG $me :The hand $alternate already exists. Choose another. \002Usage:\002 adduser <password> <nick> <chan>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			puthelp "PRIVMSG $me :New user: $alternate ([maskhost $hostmask])"
                        puthelp "NOTICE $nick :You have been added to $botnick userlist by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			return 0
		}
		adduser $nick [maskhost $hostmask]
		puthelp "PRIVMSG $me :New user: $nick ([maskhost $hostmask])"
                puthelp "NOTICE $nick :You have been added to $botnick userlist by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "PRIVMSG $me :The hand $alternate already exists. \002Usage:\002 adduser <password> <nick> <chan>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		puthelp "PRIVMSG $me :New user: $alternate ([maskhost $hostmask])"
                puthelp "NOTICE $nick :You have been added to $botnick userlist by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		return 0
	}
	return 0
}

### deluser <password> <hand>

proc msg_lol_deluser {me b c arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] != 2} {
		puthelp "PRIVMSG $me :\002Usage:\002 deluser <password> <hand>"
		return 0
	}
	set hand [lindex $arg 1]
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $me :Invalid password \002Usage:\002 deluser <password> <hand>"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $me :You must set a password: pass <your_new_password>"
		return 0
	}
	if {[getting-users]} {
                puthelp "PRIVMSG $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		puthelp "PRIVMSG $me :$nick is not a registered user."
		return 0
	}
	if {[matchattr $hand n]} {
		puthelp "PRIVMSG $me :You can't delete a bot owner."
		return 0
	}
	deluser $hand
	boot $hand "You have been deleted of the bot userlist"
	puthelp "PRIVMSG $me :$hand has been removed from userlist."
	return 0
}

### addbot <password> <nick> <chan> [port] [hand]

proc msg_lol_addbot {me b c arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] < 3} {
		puthelp "PRIVMSG $me :\002Usage:\002 addbot <password> <nick> <chan> \[port\] \[hand\]"
		return 0
	}
	set nick [lindex $arg 1]
	set chan [strlwr [lindex $arg 2]]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set port [lindex $arg 3]
	if {[isnumber $port]} {
		set alternate [lindex $arg 4]
	} {
		set port 3333
		set alternate [lindex $arg 3]
	}
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $me :Invalid password \002Usage:\002 addbot <password> <nick> <chan> \[port\] \[hand\]"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $me :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
                puthelp "PRIVMSG $me :I'm not in $chan "
		return 0
	}
	set host [lindex [split [getchanhost $nick $chan] "@"] 1]
	set hostmask "*!*[getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![onchan $nick $chan]} {
                puthelp "PRIVMSG $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == [strlwr $botnick]} {
                puthelp "PRIVMSG $me :Sorry, but I can't addbot myself."
		return 0
	}
	if {[getting-users]} {
                puthelp "PRIVMSG $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {[validuser $hand]} {
		puthelp "PRIVMSG $me :$nick is already recognized with this hand: $hand"
		return 0
	} {
		if {[validuser $nick] && $alternate == ""} {
                        puthelp "PRIVMSG $me :The hand $nick already exists. \002Usage:\002 addbot <password> <nick> <chan> <port> <hand>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "PRIVMSG $me :The hand $alternate already exists. Choose another. \002Usage:\002 addbot <password> <nick> <chan> <port> <hand>"
				return 0
			}
			addbot $alternate $host:$port
			setuser $alternate hosts $hostmask
			puthelp "PRIVMSG $me :New bot: $alternate ($hostmask)"
			return 0
		}
		addbot $nick $host:$port
		setuser $nick hosts $hostmask
		puthelp "PRIVMSG $me :New bot: $nick ($hostmask)"
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "PRIVMSG $me :The hand $alternate already exists. \002Usage:\002 addbot <password> <nick> <chan> <port> <hand>"
			return 0
		}
		addbot $alternate $host:$port
		setuser $alternate hosts $hostmask
		puthelp "PRIVMSG $me :New bot: $alternate ($hostmask)"
		return 0
	}
	return 0
}

### addmaster <password> <nick> <chan> [hand] 

proc msg_lol_addmaster {me b c arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] < 3} {
		puthelp "PRIVMSG $me :\002Usage:\002 addmaster <password> <nick> <chan> \[hand\]"
		return 0
	}
	set nick [lindex $arg 1]
	set chan [strlwr [lindex $arg 2]]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set alternate [lindex $arg 3]
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $me :Invalid password \002Usage:\002 addmaster <password> <nick> <chan> \[hand\]"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $me :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
                puthelp "PRIVMSG $me :I'm not in $chan "
		return 0
	}
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![matchattr $c n|n $chan]} {
            puthelp "PRIVMSG $me :Sorry, but you are not an owner in $chan."
		return 0
	}
	if {![onchan $nick $chan]} {
            puthelp "PRIVMSG $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == [strlwr $botnick]} {
            puthelp "PRIVMSG $me :Sorry, but I can't addmaster myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "PRIVMSG $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		if {[validuser $nick] && $alternate == ""} {
                        puthelp "PRIVMSG $me :The hand $nick already exists. \002Usage:\002 addmaster <password> <nick> <chan> <hand> "
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "PRIVMSG $me :The hand $alternate already exists. Choose another. \002Usage:\002 addmaster <password> <nick> <chan> <hand>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			chattr $alternate +p|+m $chan
			puthelp "PRIVMSG $me :New user: $alternate ([maskhost $hostmask])"
                        puthelp "PRIVMSG $me :$nick added to the $chan masterlist and party-line with the hand: $alternate."
                        puthelp "NOTICE $nick :You have been added to the $chan masterlist and party-line by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			if {[botisop $chan]} {pushmode $chan +o $nick}
			return 0
		}
		adduser $nick [maskhost $hostmask]
		chattr $nick +p|+m $chan
		puthelp "PRIVMSG $me :New user: $nick ([maskhost $hostmask])"
                puthelp "PRIVMSG $me :$nick added to the $chan masterlist and party-line with the hand: $nick."
                puthelp "NOTICE $nick :You have been added to the $chan masterlist and party-line by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		if {[botisop $chan]} {pushmode $chan +o $nick}
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "PRIVMSG $me :The hand $alternate already exists. \002Usage:\002 addmaster <password> <nick> <chan> <hand>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		chattr $alternate +p|+m $chan
		puthelp "PRIVMSG $me :New user: $alternate ([maskhost $hostmask])"
                puthelp "PRIVMSG $me :$nick added to the $chan masterlist and party-line with the hand: $alternate."
                puthelp "NOTICE $nick :You have been added to the $chan masterlist and party-line by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		if {[botisop $chan]} {pushmode $chan +o $nick}
		return 0
	}
	if {[matchattr $hand -|+m $chan]} {
                puthelp "PRIVMSG $me :$nick is already a master in $chan with this hand: $hand"
	} {
		chattr $hand -|+m $chan
                puthelp "PRIVMSG $me :$nick added to the $chan masterlist with this hand: $hand."
                puthelp "NOTICE $nick :You have been added to the $chan masterlist by $me."
	}
	if {[botisop $chan]} {pushmode $chan +o $nick}
	return 0
}

### addop <password> <nick> <chan> [hand]

proc msg_lol_addop {me b c arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] < 3} {
		puthelp "PRIVMSG $me :\002Usage:\002 addop <password> <nick> <chan> \[hand\]"
		return 0
	}
	set nick [lindex $arg 1]
	set chan [strlwr [lindex $arg 2]]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set alternate [lindex $arg 3]
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $me :Invalid password \002Usage:\002 addop <password> <nick> <chan> \[hand\]"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $me :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
                puthelp "PRIVMSG $me :I'm not in $chan "
		return 0
	}
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![matchattr $c m|m $chan]} {
                puthelp "PRIVMSG $me :Sorry, but you are not a master in $chan."
		return 0
	}
	if {![onchan $nick $chan]} {
            puthelp "PRIVMSG $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == [strlwr $botnick]} {
            puthelp "PRIVMSG $me :Sorry, but I can't addop myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "PRIVMSG $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		if {[validuser $nick] && $alternate == ""} {
                        puthelp "PRIVMSG $me :The hand $nick already exists. \002Usage:\002 addop <password> <nick> <chan> <hand>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "PRIVMSG $me :The hand $alternate already exists. Choose another. \002Usage:\002 addop <password> <nick> <chan> <hand>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			chattr $alternate +p|+o $chan
			puthelp "PRIVMSG $me :New user: $alternate ([maskhost $hostmask])"
                        puthelp "PRIVMSG $me :$nick added to the $chan oplist and party-line with the hand: $alternate."
                        puthelp "NOTICE $nick :You have been added to the $chan oplist and party-line by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			if {[botisop $chan]} {pushmode $chan +o $nick}
			return 0
		}
		adduser $nick [maskhost $hostmask]
		chattr $nick +p|+o $chan
		puthelp "PRIVMSG $me :New user: $nick ([maskhost $hostmask])"
            puthelp "PRIVMSG $me :$nick added to the $chan oplist and party-line with the hand: $nick."
            puthelp "NOTICE $nick :You have been added to the $chan oplist and party-line by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		if {[botisop $chan]} {pushmode $chan +o $nick}
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "PRIVMSG $me :The hand $alternate already exists. \002Usage:\002 addop <password> <nick> <chan> <hand>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		chattr $alternate +p|+o $chan
		puthelp "PRIVMSG $me :New user: $alternate ([maskhost $hostmask])"
            puthelp "PRIVMSG $me :$nick added to the $chan oplist and party-line with the hand: $alternate."
            puthelp "NOTICE $nick :You have been added to the $chan oplist and party-line by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		if {[botisop $chan]} {pushmode $chan +o $nick}
		return 0
	}
	if {[matchattr $hand -|+o $chan]} {
                puthelp "PRIVMSG $me :$nick is already an op in $chan with this hand: $hand"
	} {
		chattr $hand -|+o $chan
            puthelp "PRIVMSG $me :$nick added to the $chan oplist with this hand: $hand."
            puthelp "NOTICE $nick :You have been added to the $chan oplist by $me."
	}
	if {[botisop $chan]} {pushmode $chan +o $nick}
	return 0
}

### addvoice <password> <nick> <chan> [hand] 

proc msg_lol_addvoice {me b c arg} {
	set arg [charfilter $arg]
	global botnick
	if {[llength $arg] < 3} {
		puthelp "PRIVMSG $me :\002Usage:\002 addvoice <password> <nick> <chan> \[hand\]"
		return 0
	}
	set nick [lindex $arg 1]
	set chan [strlwr [lindex $arg 2]]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set alternate [lindex $arg 3]
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $me :Invalid password \002Usage:\002 addvoice <password> <nick> <chan> \[hand\]"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $me :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
            puthelp "PRIVMSG $me :I'm not in $chan "
		return 0
	}
	set hostmask "$nick![getchanhost $nick $chan]"
	set hand [nick2hand $nick $chan]
	if {![matchattr $c o|o $chan]} {
            puthelp "PRIVMSG $me :Sorry, but you are not an operator in $chan."
		return 0
	}
	if {![onchan $nick $chan]} {
            puthelp "PRIVMSG $me :Sorry, but I don't see $nick in $chan."
		return 0
	}
	if {[strlwr $nick] == [strlwr $botnick]} {
            puthelp "PRIVMSG $me :Sorry, but I can't addvoice myself."
		return 0
	}
	if {[getting-users]} {
            puthelp "PRIVMSG $me :Sorry, but I'm transferring the userfile, try later."
		return 0
	}
	if {![validuser $hand]} {
		if {[validuser $nick] && $alternate == ""} {
                  puthelp "PRIVMSG $me :The hand $nick already exists. \002Usage:\002 addvoice <password> <nick> <chan> <hand>"
			return 0
		}
		if {$alternate != ""} {
			if {[validuser $alternate]} {
                        puthelp "PRIVMSG $me :The hand $alternate already exists. Choose another. \002Usage:\002 addvoice <password> <nick> <chan> <hand>"
				return 0
			}
			adduser $alternate [maskhost $hostmask]
			chattr $alternate +p|+v $chan
			puthelp "PRIVMSG $me :New user: $alternate ([maskhost $hostmask])"
                  puthelp "PRIVMSG $me :$nick added to the $chan voicelist and party-line with the hand: $alternate."
                  puthelp "NOTICE $nick :You have been added to the $chan voicelist and party-line by $me with the hand: $alternate."
			puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
			if {[botisop $chan]} {pushmode $chan +v $nick}
			return 0
		}
		adduser $nick [maskhost $hostmask]
		chattr $nick +p|+v $chan
		puthelp "PRIVMSG $me :New user: $nick ([maskhost $hostmask])"
            puthelp "PRIVMSG $me :$nick added to the $chan voicelist and party-line with the hand: $nick."
            puthelp "NOTICE $nick :You have been added to the $chan voicelist and party-line by $me with the hand: $nick."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick pass <your_password>\002"
		if {[botisop $chan]} {pushmode $chan +v $nick}
		return 0
	}
	if {$alternate != ""} {
		if {[validuser $alternate]} {
                  puthelp "PRIVMSG $me :The hand $alternate already exists. \002Usage:\002 addvoice <password> <nick> <chan> <hand>"
			return 0
		}
		adduser $alternate [maskhost $hostmask]
		chattr $alternate +p|+v $chan
		puthelp "PRIVMSG $me :New user: $alternate ([maskhost $hostmask])"
            puthelp "PRIVMSG $me :$nick added to the $chan voicelist and party-line with the hand: $alternate."
            puthelp "NOTICE $nick :You have been added to the $chan voicelist and party-line by $me with the hand: $alternate."
		puthelp "NOTICE $nick :You must set a password type: \002/msg $botnick PASS <your_password>\002"
		if {[botisop $chan]} {pushmode $chan +v $nick}
		return 0
	}
	if {[matchattr $hand -|+v $chan]} {
            puthelp "PRIVMSG $me :$nick already has voice in $chan with this hand: $hand"
	} {
		chattr $hand -|+v $chan
            puthelp "PRIVMSG $me :$nick added to the $chan voicelist with this hand: $hand."
            puthelp "NOTICE $nick :You have been added to the $chan voicelist by $me."
	}
	if {[botisop $chan]} {pushmode $chan +v $nick}
	return 0
}

### help

proc msg_lol_help {nick host hand arg} {
	set arg [charfilter $arg]
	if {$hand == "*"} {return 0}
	global lol
	append flags [chattr $hand]
	foreach chan [channels] { append flags [chattr $hand - $chan] }
	puthelp "PRIVMSG $nick :Msg commands of $lol(version):"
	set help ""
	if {[matchattr $hand n]} {
		append help "\002param\002 <parameter> <value>  \002enable\002 <hand>"
		append help "  "
		append help "\002disable\002 <hand>  \002deluser\002 <hand>"
		append help "  "
		append help "\002join\002 <chan> \[chanpassword\]  \002remove\002 <chan>"
		append help "  "
		append help "\002addhost\002 <hand> <host>"
		append help "  "
		append help "\002delhost\002 <hand> <host>"
		append help "  "
	}
	if {[string first n $flags] != -1} {
		append help "\002addmaster\002 <nick> <chan> \[hand\]"
		append help "  "
	}
	puthelp "PRIVMSG $nick :$help"
	set help ""
	if {[matchattr $hand m]} {
		append help "\002msg\002 <nick|chan> <message>"
		append help "  "
	}
	if {[string first m $flags] != -1} {
		append help "\002part\002 <chan>  \002banmask\002 <mask> <chan>"
		append help "  "
		append help "\002addop\002 <nick> <chan> \[hand\]"
		append help "  "
		append help "\002adduser\002 <nick> <chan> \[hand\]"
		append help "  "
		append help "\002addbot\002 <nick> <chan> \[port\] \[hand\]"
		append help "  "
	}
	puthelp "PRIVMSG $nick :$help"
	set help ""
	if {[string first o $flags] != -1} {
		append help "\002chattr\002 <hand> <flags> <chan>"
		append help "  "
		append help "\002broadcast\002 <text>  \002key\002 <chan>"
		append help "  "
		append help "\002addvoice\002 <nick> <chan> \[hand\]"
		append help "  "
		append help "\002quick\002 <nick\mask> <chan> \[reason\]"
		append help "  "
		append help "\002banlist\002 <chan>  \002ban\002 <nick|mask> <chan> \[time\] \[reason\]"
		append help "  "
		append help "\002unban\002 <mask|number> <chan>"
		append help "  "
		append help "\002online\002  \002mode\002 <chan> <flags>  \002whois\002 <nick>"
		append help "  "
	}
	if {[string first v $flags] != -1} {
		append help "\002invite\002 \[chan\]  \002kick\002 <nick|mask> <chan> \[reason\]"
		append help "  "
	}
	append help "\002ident\002  \002permident\002 \[nick!user@host\]  \002seen\002 <nick|hand>"
	puthelp "PRIVMSG $nick :$help"
        puthelp "PRIVMSG $nick :All these commands require your \002password\002 as first argument."
	*msg:help $nick $host $hand $arg
}

### invite <password> [chan]

proc msg_lol_invite {a b c arg} {
	set arg [charfilter $arg]
	if {[llength $arg] < 1} {
		puthelp "PRIVMSG $a :\002Usage:\002 invite <password> \[chan\]"
		return 0
	}
	set chan [strlwr [lindex $arg 1]]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $a :Invalid password \002Usage:\002 invite <password> \[chan\]"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $a :You must set a password: pass <your_new_password>"
		return 0
	}
	if {$chan != ""} {
		if {$chan != ""} {set chan [chanaddapt $chan]}
		if {![validchan $chan]} { puthelp "PRIVMSG $a :I'm not in $chan " ; return 0 }
		if {[onchan $a $chan]} { puthelp "PRIVMSG $a :You are already in $chan." ; return 0	}
		set flags [lindex [getchanmode $chan] 0]
		if {[string first i $flags] == -1} { puthelp "PRIVMSG $a :$chan is not invite only." ; return 0	}
		if {[matchattr $c o|o $chan]} { puthelp "INVITE $a $chan" ;	return 0 }
            puthelp "PRIVMSG $a :Sorry, you are not an op in $chan."
		return 0
	}
	set count 0
	foreach chan [channels] {
		set flags [lindex [getchanmode $chan] 0]
		if {[string first i $flags] != -1} {
			if {![onchan $a $chan]} {
				if {[matchattr $c o|o $chan]} {
					puthelp "PRIVMSG $a :You can be invited on $chan."
					set invitchan $chan
					incr count
				}
			}
		}
	}
	if {$count == 0} {
            puthelp "PRIVMSG $a :There are no invite only chans for you to be invited to."
		return 0
	} {
		puthelp "INVITE $a $invitchan"
		return 0
	}
        puthelp "PRIVMSG $a :You can be invited to $count chans, make your choice !"
	puthelp "PRIVMSG $a :\002Usage:\002 invite <password> \[chan\]"
}

### join <password> <chan> [chan pass]

proc msg_lol_join {a b c arg} {
	set arg [charfilter $arg]
	global lol botnick
	if {[llength $arg] < 2} {
		puthelp "PRIVMSG $a :\002Usage:\002 join <passsword> <chan> \[chan pass\]"
		return 0
	}
	set chan [lindex $arg 1]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	set pass [lindex $arg 2]
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $a :Invalid password \002Usage:\002 join <password> <chan> \[chan pass\]"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $a :You must set a password: pass <your_new_password>"
		return 0
	}
	if {[validchan $chan]} {
		puthelp "PRIVMSG $a :I'm already monitoring $chan."
		if {$pass != ""} {
			if {$lol(chankey) == 1} {
				puthelp "PRIVMSG $a :New pass set for $chan: $pass."
				channel set $chan need-key "chankey $chan $pass"
			} {
				puthelp "PRIVMSG $a :I can't memorize password to keep compatibility with getops.tcl\r"
			}
		}
		if {![onchan [strlwr $botnick] $chan]} {
			puthelp "PRIVMSG $a :I'll now try to join $chan."
			putserv "JOIN $chan $pass"
			return 0
		}
		puthelp "PRIVMSG $a :I'm already in $chan."
		return 0
	}
	puthelp "PRIVMSG $a :New chan monitoring: $chan."
	channel add $chan
	channel set $chan chanmode $lol(chanmode)
	channel set $chan flood-chan $lol(chan_flood)
	channel set $chan flood-deop $lol(deop_flood)
	channel set $chan flood-kick $lol(kick_flood)
	channel set $chan flood-join $lol(join_flood)
	channel set $chan flood-ctcp $lol(ctcp_flood)
	foreach param $lol(chan_parameters) { channel set $chan $param }
	if {$pass != ""} {
		if {$lol(chankey) == 1} {
			puthelp "PRIVMSG $a :New pass set for $chan: $pass."
			channel set $chan need-key "chankey $chan $pass"
		} {
			puthelp "PRIVMSG $a :I can't memorize password to keep compatibility with getops.tcl\r"
		}
	}
	puthelp "PRIVMSG $a :$chan is now configured. I'll now try to join it.\r"
	puthelp "PRIVMSG $a :Use \002.-chan\002 to remove a chan (chan userlist will be deleted)."
	putserv "JOIN $chan $pass"
}

### part <password> <chan>

proc msg_lol_part {a b c arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 2} {
		puthelp "PRIVMSG $a :\002Usage:\002 part <password> <chan>"
		return 0
	}
	set chan [lindex $arg 1]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $a :Invalid password \002Usage:\002 part <password> <chan>"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $a :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
		puthelp "PRIVMSG $a :I'm not monitoring $chan."
		return 0
	}
	if {![matchattr $c m|m $chan]} {
                puthelp "PRIVMSG $a :Sorry, but you are not a master in $chan."
		return 0
	}
	puthelp "PRIVMSG $a :I'll part $chan. \r"
	puthelp "PRIVMSG $a :To delete monitoring of this chan, use: remove <password> <chan>"
	puthelp "PART $chan"
}

### remove <password> <chan>

proc msg_lol_remove {a b c arg} {
	set arg [charfilter $arg]
	if {[llength $arg] != 2} {
		puthelp "PRIVMSG $a :\002Usage:\002 remove <password> <chan>"
		return 0
	}
	set chan [lindex $arg 1]
	if {$chan != ""} {set chan [chanaddapt $chan]}
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $a :Invalid password \002Usage:\002 remove <password> <chan<"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $a :You must set a password: pass <your_new_password>"
		return 0
	}
	if {![validchan $chan]} {
		puthelp "PRIVMSG $a :I'm not monitoring $chan."
		return 0
	}
	puthelp "PRIVMSG $a :$chan and $chan's users are deleted. \r"
	channel remove $chan
}

### msg <password> <chan or nick> <message>

proc msg_lol_msg {a b c arg} {
	set arg [charfilter $arg]
	if {[llength $arg] < 3} {
		puthelp "PRIVMSG $a :\002Usage:\002 msg <password> <chan or nick> <message>"
		return 0
	}
	set chan_nick [lindex $arg 1]
	set message [lrange $arg 2 end]
	if {![passwdok $c [lindex $arg 0]]} {
		puthelp "PRIVMSG $a :Invalid password \002Usage:\002 msg <password> <chan or nick> <message>"
		return 0
	}
	if {[passwdok $c ""]} {
		puthelp "PRIVMSG $a :You must set a password: pass <your_new_password>"
		return 0
	}
	puthelp "PRIVMSG $chan_nick :$message"
}

################# END OF MSG COMMANDS #################

################# START OF MISC #################

proc initserv {} {
	global lol botnick server lol_whois lol_mirc_kick remove_kickmirc_timer lol_bitchx_kick remove_kickbitchx_timer lol_ircii_kick remove_kickircii_timer lol_eggdrop_kick remove_kickeggdrop_timer lol_oldserver lol_newserver
	puthelp "MODE $botnick $lol(server_flags)"
# DETECT SERVER CHANGE BUT NOT SERVER DECONNECTION
#	set lol_newserver $server
#	if {[info exists lol_oldserver]} {
#		if {$lol_oldserver == $lol_newserver} {return 0}
#	}
	alldeident
	if {$lol(away) != ""} {
		utimer 20 {
			puthelp "AWAY :$lol(away)"
		}
	}
	set lol_whois ""
	set lol_mirc_kick ""
	set lol_bitchx_kick ""
	set lol_ircii_kick ""
	set lol_eggdrop_kick ""
	if {![info exist remove_kickmirc_timer]} { set remove_kickmirc_timer "" }
	if {![info exist remove_kickbitchx_timer]} { set remove_kickbitchx_timer "" }
	if {![info exist remove_kickircii_timer]} { set remove_kickircii_timer "" }
	if {![info exist remove_kickeggdrop_timer]} { set remove_kickeggdrop_timer ""	}
#	set lol_oldserver $server
}

proc lol_whois {who host2 handle chan} {
	if {$handle == "*"} {return "$who is not registered in the bot."}
	if {$handle != ""} {
		set msg "\002The hand of $who is $handle.\002 "
		if {$chan != ""} {
			set chanflags [lindex [split [chattr $handle - $chan] |] 1]
			if {$chanflags == "-"} {set chanflags "no flags"}
		}
		set globalflags [lindex [split [chattr $handle - ] |] 0]
		if {$globalflags == "-"} {set globalflags "no flags"}
		if {$chan != ""} {
                        append msg "He has these flags on this chan: \002$chanflags\002 "
                        append msg "and these global flags: \002$globalflags\002. "
		} {
                        append msg "He has these global flags: \002$globalflags\002 "
		}
		if {[check $handle $who $host2]} {
			if {[string match [strlwr [getuser $handle xtra permident]] [strlwr $who!$host2]]} {
				append msg "He is \002IDENTIFIED\002 right now, with his permident mask: \002[getuser $handle xtra permident]\002. "
			} {
				append msg "He is \002IDENTIFIED\002 right now (nick used for identification: [getuser $handle xtra authnick]). "
				if {[getuser $handle xtra permident] != ""} {
					append msg "Permident mask: \002[getuser $handle xtra permident]\002. "
				} {
					append msg "No permident mask. "
				}
			}
		} {
			append msg "He is not identified right now. "
			if {[getuser $handle xtra permident] != ""} {
				append msg "Permident mask: [getuser $handle xtra permident]. "
			} {
				append msg "No permident mask. "
			}
		}
		if {[getuser $handle xtra silent] == 1} {
			append msg "Silent mode \002ENABLED\002. "
		} {
			append msg "Silent mode \002DISABLED\002. "
		}
		if {$chan != ""} {
			if {[getchaninfo $handle $chan] != ""} {
				append msg "Info line: [getchaninfo $handle $chan]. "
			} {
				append msg "No info line. "
			}
		}
		return "$msg"
	} {
                return "I don't see $who."
	}
}

proc lol_whois_reply {from signal arg} {
	global lol_whois
	set arg [charfilter $arg]
	set nick [lindex $arg 1]
	set user [lindex $arg 2]
	set ip [lindex $arg 3]
	set c [lindex [split $lol_whois ":"] 0]
	if {[strlwr $nick] != [strlwr [lindex [split $lol_whois ":"] 1]]} {
		return 0
	}
	set who $nick!$user@$ip
	set handle [finduser $who]
	if {$handle != "*"} {
		puthelp "PRIVMSG $c :[lol_whois $nick $user@$ip $handle ""]"
	} {
                puthelp "PRIVMSG $c :$who is not recognized as one of my users."
	}
	set lol_whois ""
	return 0
}

proc lol_whois_unknow {from signal arg} {
	global lol_whois
	set arg [charfilter $arg]
	set nick [lindex $arg 1]
	set c [lindex [split $lol_whois ":"] 0]
	set nick2 [lindex [split $lol_whois ":"] 1]
	if {$lol_whois != "" && [strlwr $nick] == [strlwr $nick2]} {
                puthelp "PRIVMSG $c :$nick is on IRC but I have no information about this person."
		set lol_whois ""
	}
	return 0
}

proc lol_whois_nofound {from signal arg} {
	global lol_whois
	if {![info exists lol_whois]} {return 0}
	set arg [charfilter $arg]
	set nick [lindex $arg 1]
	set c [lindex [split $lol_whois ":"] 0]
	set nick2 [lindex [split $lol_whois ":"] 1]
	if {$lol_whois != "" && [strlwr $nick] == [strlwr $nick2]} {
		puthelp "PRIVMSG $c :$nick is not on IRC."
		set lol_whois ""
	}
	return 0
}

proc lol_seen {nick hand who chan} {
	global botnick
	if {[strlwr $who] == [strlwr $nick]} { return "Go look in a mirror. " }
	if {[strlwr $who] == [strlwr $botnick]} {	return "You found me ! " }
	if {$chan != ""} {
		if {[onchan $who $chan]} { return "Open your eyes, $who is in THIS chan !" }
		foreach user [chanlist $chan] {
			set userh [nick2hand $user $chan]
			if {[strlwr $userh] == [strlwr $who]} {
				if {[strlwr $hand] == [strlwr $who]} {
					return "$who is $user, and $user is YOU :P "
				} {
					return "$who is $user, and $user is on this chan ! "
				}
			}
		}
	} {
		if {[strlwr $hand] == [strlwr $who]} {return "$who is your hand :P "}
	}
	foreach fchan [channels] {
		if {[onchan $who $fchan]} {
			return "$who is actually on $fchan ! "
		}
		foreach user [chanlist $fchan] {
			set userh [nick2hand $user $fchan]
			if {[strlwr $userh] == [strlwr $who]} {
				return "$who is $user, and $user is on $fchan ! "
			}
		}
	}
	foreach fchan [channels] {
		if {[onchansplit $who $fchan]} {
			return "$who was in $fchan, but there was a netsplit... "
		}
	}
	if {[hand2idx $who] >= 0} {
                return "$who is actually in the party-line. "
	}
	if {[validuser $who]} {
		set info [getuser $who laston]
		if {$info == ""} { return "I have never seen $who. " }
		set time [lindex $info 0]
		set ochand [lindex $info 1]
		if {$ochand == "*"} {set ochand "party-line"}
		return "$who was in $ochand [time_diff $time] ago. "
	}
	return "Sorry, I don't know $who. "
}

proc lol_watch_mode {nick host hand chan mode who} {
	global lol botnick botname
	if {$mode != "+b" || ![botisop $chan] || $lol(ban_protect) == 0} {return 0}
	set victim ""

	set numbanlist [llength [chanbans $chan]]
      if {$numbanlist > 26 } {
            set banhost ""
	   	set b_count 0
		for {set loop 0} {$loop < 6} {incr loop} {
	   		set banhost "$banhost [lindex [lindex [chanbans $chan] $loop] 0]"
	   		set b_count [expr $b_count + 1]
			if {$loop == 5 } {	putserv "MODE $chan -bbbbbb $banhost"  
	                                    set banhost "" 
      	                              set b_count 0 
			}
	   	}
      }

	if {[string first "!" $who] == -1 && [string first "@" $who] == -1} {set who $who!*@*}
#	if {[string first "!" $who] == -1} {set who *!*$who}
	if {[string first "@" $who] == -1} {set who $who*@*}
	foreach user [userlist] {
		foreach userhost [getuser $user HOSTS] {
			if {[string match [strlwr $who] [strlwr $userhost]] && ([matchattr $user n|n $chan] || [matchattr $user m|m $chan] || [matchattr $user o|o $chan] || [matchattr $user v|v $chan])} {
				append victim "$user "
				break
			}
		}
	}
	foreach user [chanlist $chan] {
		set userhand [nick2hand $user $chan]
		if {$userhand != "*"} {
			set userhost $user![getchanhost $user $chan]
			if {[string match [strlwr $who] [strlwr $userhost]]} {
				if {[matchattr $userhand n|n $chan] || [matchattr $userhand m|m $chan] || [matchattr $userhand o|o $chan] || [matchattr $userhand v|v $chan]} {
					if {[string first $userhand $victim] == -1} {append victim "$userhand "}
				}
			}
		}
	}
	if {[string match [strlwr $who] [strlwr $botname]]} {
		if {![matchattr $hand m|m $chan] && !([matchattr $hand b] && [matchattr $hand o|o $chan])} {
			putserv "MODE $chan -b $who"
			puthelp "NOTICE $nick :Don't set bans that match me !"
			return 0
		} {
			append victim "$botnick"
		}
	}
	if {$victim != ""} {lol_ban_warn $nick $hand $who $chan $victim}
	return 0
}

proc lol_ban_warn {nick hand ban chan victims} {
	global lol
	if {![botisop $chan] || [strlwr $hand] == [string trimright [strlwr $victims] " "] || $lol(ban_protect) == 0} {return 0}
	if {$hand == "*"} {
		if {[string first +userbans [channel info $chan]] != -1} {
                  puthelp "NOTICE $nick :Your ban matches my users ! Be careful !"
			putserv "MODE $chan -b $ban"
		}
	return 0
	}
	set remove 0
	foreach user $victims {
		if {([matchattr $user m|m $chan] || [matchattr $user b]) && !([matchattr $hand m|m $chan] || ([matchattr $hand o|o $chan] && [matchattr $hand b]))} {
			set remove 1
			break
		}
		if {([matchattr $user o|o $chan] || [matchattr $user v|v $chan]) && ![matchattr $hand o|o $chan]} {
			set remove 1
			break
		}
	}
	if {$remove == 1} {putserv "MODE $chan -b $ban"}
	if {![matchattr $hand b]} {
		if {[llength $victims] > 1} {
            	puthelp "NOTICE $nick :Your ban in $chan ($ban), matches my users: $victims"
		} {
                  puthelp "NOTICE $nick :Your ban in $chan ($ban), matches one of my users: $victims"
		}
	}
	return 0
}

proc rmuser {hand idx arg} {
	boot $arg
	*dcc:-user $hand $idx [lindex $arg 0]
}

proc checksilent {hand} {
	set temp [getuser $hand xtra silent]
	if {$temp == 1} {return 1}
	return 0
}

proc check {hand nick host} {
	global lol
	if {$lol(ident) == 0} {return 1}
	if {[getuser $hand xtra auth] != "DEAD"} {
		set perm_host [getuser $hand xtra permident]
		if {[string match [strlwr $perm_host] [strlwr $nick!$host]]} { return 1	}
	}
	set host [lindex [split $host "@"] 1]
	if {[getuser $hand xtra auth] == 1} {
		if {$lol(clone) == 1} {
			if {[getuser $hand xtra authhost] == $host} { return 1 }
		}
		if {[getuser $hand xtra authnick] == $nick} { return 1 }
	}
	return 0
}

proc chidentnick {nick host hand chan newnick} {
	global botnick
	if {$hand == "*"} {return 0}
	if {[getuser $hand xtra auth] == 1} {
		if {[getuser $hand xtra authnick] == $nick} {
			setuser $hand xtra authnick $newnick
		}
	}
}

proc kickident {nick host hand chan kick arg} {
	global botnick
	if {$kick == $botnick} {
		foreach user [chanlist $chan] {
			set find 0
			foreach ch [channels] {
				if {[onchan $user $ch] && $ch != $chan} { incr find }
			}
			set userhand [nick2hand $user $chan]
			if {$userhand != "*"} {
				if {$find == 0} {
					if {[getuser $userhand xtra auth] != "DEAD"} {
						setuser $userhand xtra auth 0
					}
					chattr $userhand -3
				}
			}
		}
	}
	return 0
}

proc partident {nick host hand chan} {
	if {$hand == "*"} {return 0}
	set find 0
	foreach ch [channels] {
		if {[onchan $nick $ch] && $ch != $chan} { set find 1 }
	}
	if {$find == 0} {
		if {[getuser $hand xtra auth] != "DEAD"} { setuser $hand xtra auth 0 }
		chattr $hand -3
	}
}

proc rejnident {nick host hand chan} {
	if {$hand == "*"} {return 0}
	set find 0
	foreach ch [channels] {
		if {[onchan $nick $ch] && $ch != $chan} { incr find }
	}
	if {$find == 0} {
		if {[getuser $hand xtra auth] != "DEAD"} { setuser $hand xtra auth 0 }
		chattr $hand -3
	}
}

proc joinident {nick host hand chan} {
	if {$hand == "*"} { return 0 }
	set find 0
	foreach ch [channels] {
		if {[onchan $nick $ch] && $ch != $chan} { incr find }
	}
	if {$find == 0} {
		if {[getuser $hand xtra auth] != "DEAD"} { setuser $hand xtra auth 0 }
		chattr $hand -3
	}
}

proc alldeident {} {
	foreach user [userlist] {
		if {[getuser $user xtra auth] != "DEAD"} { setuser $user xtra auth 0 }
		chattr $user -3
	}
}

proc deident {nick host hand chan reason} {
	if {$hand == "*"} {return 0}
	if {[getuser $hand xtra auth] != "DEAD"} { setuser $hand xtra auth 0 }
	chattr $hand -3
}

proc chankey {chan pass} {
	putserv "JOIN $chan $pass"
}

proc chanaddapt {chan} {
	if {[string index $chan 0] != "#" && [string index $chan 0] != "&"} { set chan #$chan }
	return $chan
}

proc see_new_pass {a b c d e f} {
	global lol
	if {$lol(chankey) == 0} {return 0}
	set k [lindex $e 0]
	set pass [lindex $f 0]
	channel set $d need-key "chankey $d $pass"
}

proc time_diff2 {time} {
	set ltime [expr $time - [unixtime]]
	set seconds [expr $ltime % 60]
	set ltime [expr ($ltime - $seconds) / 60]
	set minutes [expr $ltime % 60]
	set ltime [expr ($ltime - $minutes) / 60]
	set hours [expr $ltime % 24]
	set days [expr ($ltime - $hours) / 24]
	set result ""
	if {$days} {
		append result "$days "
		if {$days} {
			append result "day "
		} {
			append result "days "
		}
	}
	if {$hours} {
		append result "$hours "
		if {$hours} {
			append result "hour "
		} {
			append result "hours "
		}
	}
	if {$minutes} {
		append result "$minutes "
		if {$minutes} {
			append result "minute"
		} {
			append result "minutes"
		}
	}
	if {$seconds} {
		append result " $seconds "
		if {$seconds} {
			append result "second"
		} {
			append result "seconds"
		}
	}
	return $result
}

proc time_diff {time} {
	set ltime [expr [unixtime] - $time]
	set seconds [expr $ltime % 60]
	set ltime [expr ($ltime - $seconds) / 60]
	set minutes [expr $ltime % 60]
	set ltime [expr ($ltime - $minutes) / 60]
	set hours [expr $ltime % 24]
	set days [expr ($ltime - $hours) / 24]
	set result ""
	if {$days} {
		append result "$days "
		if {$days} {
			append result "day "
		} {
			append result "days "
		}
	}
	if {$hours} {
		append result "$hours "
		if {$hours} {
			append result "hour "
		} {
			append result "hours "
		}
	}
	if {$minutes} {
		append result "$minutes "
		if {$minutes} {
			append result "minute"
		} {
			append result "minutes"
		}
	}
	if {$seconds} {
		append result " $seconds "
		if {$seconds} {
			append result "second"
		} {
			append result "seconds"
		}
	}
	return $result
}

proc charfilter {x {y ""} } {
	for {set i 0} {$i < [string length $x]} {incr i} {
		switch -- [string index $x $i] {
			"\"" {append y "\\\""}
			"\\" {append y "\\\\"}
			"\[" {append y "\\\["}
			"\]" {append y "\\\]"}
			"\} " {append y "\\\} "}
			"\{" {append y "\\\{"}
			default {append y [string index $x $i]}
		}
	}
	return $y
}

proc lol_idle_check {} {
	global lol botnick remove_lol_idle_check
	set remove_lol_idle_check [timer 1 lol_idle_check]
	if {$lol(idle_protect) == 0} { return 0 }
	set flags "-$lol(no_idle_flags)&-$lol(no_idle_flags)"
	foreach chan [channels] {
		if {![botisop $chan]} {continue}
		if {$lol(no_idle_flags) == ""} {
			set list [strlwr [chanlist $chan]]
		} {
			set list [strlwr [chanlist $chan $flags]]
		}
		foreach nick $list {
			if {[strlwr $nick] != [strlwr $botnick] && ![isop $nick $chan] && ![isvoice $nick $chan]} {
				set idle_time [getchanidle $nick $chan]
				if {$idle_time >= $lol(kick_idle_time)} {
					set reason "Idle Kick ($lol(kick_idle_time) minutes of idle time)."
					putserv "KICK $chan $nick :$reason"
					return 0
				}
				if {$idle_time == $lol(warn_idle_time) && $lol(max_idle_time) < $lol(kick_idle_time)} {
					puthelp "PRIVMSG $nick :You are idle on $chan since $idle_time minutes, after $lol(max_idle_time) minutes of idle, you'll be banned for $lol(idle_ban_time) minutes. Part the chan or make anything !"
					return 0
				}
				if {$idle_time >= $lol(max_idle_time)} {
					set ipmask [lindex [split [maskhost $nick![getchanhost $nick $chan]] "@"] 1]
					set userm [lindex [split [getchanhost $nick $chan] "@"] 0]
					set banmask *!*$userm@$ipmask
					set reason "Banned for $lol(idle_ban_time) minutes, because of $lol(max_idle_time) minutes idle."
					newchanban $chan $banmask IdleBan $reason $lol(idle_ban_time)
					putserv "MODE $chan +b $banmask"
					putserv "KICK $chan $nick :$reason"
					return 0
				}
			}
		}
	}
	return 0
}

if {[info exists remove_lol_idle_check]} { killtimer $remove_lol_idle_check }
lol_idle_check

### END OF SCRIPT

putlog "\r"
putlog "$lol(version), Copyright (C) 1998-2003 LL Productions.\r"
putlog "This software is free software under the terms of GNU GPL 2.\r"
putlog "Type \002.help-lol\002 for commands and \002.gpl-lol\002 for license.\r"
