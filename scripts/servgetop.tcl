#
#   Services GetOps by benbe <benbe@dprime.net>
#
#   http://www.dprime.net/eggdrop/
#
#   report bug to benbe@dprime.net
#   
#   Work on 1.4.2
#
#####################
##  CONFIGURATION  ##
#####################
#
#  Set the bot's password and e-mail  
#
#  .SETBOTPASS
#
#  For all your channels
#
#  .OPCONF <#CHANNEL>
#

###################################
## SET THE BOTNICK PASSWORD      ##
###################################

#set nick_pass "monpass"

###################################
## SET THE BOTNICK E-MAIL        ##
###################################

set bot_email "TeodOR@SweetHell.org"

###################################
## REMOVE THE DIE LINE           ##
###################################

#die "Please read the configuration of the Services GetOps ..."

######################################################################
## STOP STOP STOP STOP STOP STOP STOP STOP STOP STOP STOP STOP STOP ##
## STOP STOP STOP STOP STOP STOP STOP STOP STOP STOP STOP STOP STOP ##
######################################################################

set ver "1.0"
bind dcc n opconf config_set
bind notc - "This nickname is owned by someone else. Please choose another." ident_nick
bind dcc n setbotpass config_pass

proc config_pass {hand idx arg} {
	global nick_pass bot_email
	putlog "#$hand# .setbotpass"
	putidx $idx "Nickname registration ...\r"
	putserv "PRIVMSG NickServ :REGISTER $nick_pass $bot_email"
}
proc ident_nick {nick host hand arg} {
	global nick_pass
	if {$nick_pass == ""} {
		putlog "Error no password !"
		return 0
	}
	putserv "PRIVMSG NickServ :IDENTIFY $nick_pass"
}

proc wantop {channel} {
	global botnick
	putlog "$botnick want op on $channel"
	putserv "PRIVMSG Chanserv :OP $channel $botnick"
}

proc config_set {hand idx arg} {
	set channel [lindex $arg 0]
	if {$channel == ""} {
		putidx $idx "USAGE: .opconf <#channel>\r"
		return 0
	}
	putlog "#$hand# .opconfig $channel"
	putdcc $idx "Fixing need-op of $channel ...\r"
	channel set $channel need-op "wantop $channel"
}

proc fixchan {} {
	foreach channel [channels] {
		channel set $channel need-op "wantop $channel"
	}
	timer 10 fixchan
}
timer 1 fixchan
foreach timer [timers] {
    if {[lindex $timer 1] == "fixchan"} {
      killtimer [lindex $timer 2]
    }
}

putlog "Services GetOps v$ver by dJ_TEDY Loaded."