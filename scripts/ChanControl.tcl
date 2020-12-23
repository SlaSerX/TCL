# Begin - Commands & Control, Channel Control. (cmd_chan.tcl)
#	Designed & Written by TCP-IP (Vicky@Vic.ky), © April 1999
#	Developed by Ninja_baby (Jaysee@Jaysee.Tv), © March 2000

# This script was made by TCP-IP in middle of 1999, I develop this script since he passes this script-
# to me in middle of 2000. I made few changes, add some features, and fixed some bugs that were remain-
# here in this script package.

# This TCL contains some public / msg commands related to channel's stuffs.. such as to ban, kick, op-
# deop, etc... simpy do /msg <yourbotnick> chanhelp or do `chanhelp in channel to see what commands-
# did this script has.. I set 2 types of commands.. /msg commands and public (channel) commands.
# NOTE: not much.. even almost has no DCC command stuffs here.. I will make the DCC commands very soon ;)
#       so please support ;)

# Set this as your Public (channel) command character. For example: you set this to "!".. means you must-
# type !mycommand in channel to activate public commands.
set CHPRM "`"

# This is for network compatiblity (be sure your IRC network using SirvServces) with ChanServ arround.
# I set this with DALnet's ChanServ's nickname.. you can set it according to your ChanServ's nickname-
# in your IRC network ;)
set cmdsvrnick "ChanServ@UniBG.services"

if {[info exist ban-time]} {
	# Checking whenever the "ban-time" variable is exist on your bot conf file. (Default)
	set gbantime ${ban-time}
} else {
	# Set this as global ban time.. this will be use when you trigger +ban / +gban command to ban ppl-
	# out of channel.. when you're not typing a ban time.. the bot will set the ban time according with-
	# what you set here.. set this variable in Minute(s) format.
	# Remember that if "ban-time" variable (which taken from your eggdrop.conf.dist file) already-
	# exist, you do not need to set the bantime from here, this script will automaticly add the-
	# variable from your bot conf file.
	set gbantime 15
}

# This is for your benefit hehe ;), you can either set your own LOGO here, your logo will appear-
# when the bot notice you, or when it makes msgs/notices/kicks or scripts loading. So keep smiling-
# and set this variable as you wish ;), you can either set this to "" to leave it blank.
set cmdchnlg "\[J-C\]:"

######### Please do not edit anything below unless you know what you are doing ;) #########

proc msg_masuk {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0] ; set chankey [lindex $rest 1]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick join <#channel> \[join-key\]" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {[validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am already on $chan." ; return 0}
	channel add $chan ; utimer 1 save
	if {$chankey == ""} {putquick "NOTICE $nick :$cmdchnlg Joining myself to channel: $chan. Updating channel list." ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Join $chan." ; return 0}
	putquick "JOIN $chan $chankey"
	putquick "NOTICE $nick :$cmdchnlg Joining myself to channel: $chan with Join-key: $chankey. Updating channel list."
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Join $chan (Join-key: $chankey)." ; return 0
}

proc pub_masuk {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set channel [lindex $rest 0] ; if {$channel == "#" || $channel == ""} {putquick "NOTICE $nick :$cmdchnlg Command: \[${CHPRM}join <#channel> \[join-key\]\]" ; return 0}
	msg_masuk $nick $uhost $hand $rest
}

proc msg_cabut {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick leave <#channel>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![isdynamic $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I cannot part from $chan, coz' it is not a dynamic channel." ; return 0}
	channel remove $chan ; utimer 1 save
	putquick "NOTICE $nick :$cmdchnlg I am now leaving channel: $chan. Updating channel list."
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Leave $chan." ; return 0
}

proc pub_cabut {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set rest [lindex $rest 0] ; if {$rest == "#" || $rest == ""} {set rest $chan}
	msg_cabut $nick $uhost $hand $rest
}

proc msg_cycle {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#"} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick cycle \[#channel\]" ; return 0}
	if {$chan == ""} {set chan "ALL"
	} else {if {![string match "#*" $chan]} {set chan "#$chan" ; if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}}}
	if {$chan != "ALL"} {
		putquick "PART $chan :$chan" ; putquick "JOIN $chan" ; putquick "NOTICE $nick :$cmdchnlg Cycling: $chan."
	} else {
		foreach pchan [channels] {
			putquick "PART $pchan :Cycling" ; putquick "JOIN $pchan" ; putquick "NOTICE $nick :$cmdchnlg Cycling: $pchan."
		}
	} ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Cycle." ; return 0
}

proc pub_cycle {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; if {$rest == ""} {msg_cycle $nick $uhost $hand $chan} else {msg_cycle $nick $uhost $hand $rest}
}

proc msg_konci {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick lock <#channel>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	set currmode [getchanmode $chan] ; set lockmode ""
	if {![string match "*m*" $currmode]} {append lockmode "m"}
	if {![string match "*i*" $currmode]} {append lockmode "i"}
	if {$lockmode == ""} {putquick "NOTICE $nick :$cmdchnlg Channel $chan already locked. I will not lock that channel twice." ; return 0}
	putquick "MODE $chan $lockmode"
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Lock $chan." ; return 0
}

proc pub_konci {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set rest [lindex $rest 0] ; if {$rest == "#" || $rest == ""} {set rest $chan}
	msg_konci $nick $uhost $hand $rest
}

proc msg_buka {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick unlock <#channel>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	set currmode [getchanmode $chan] ; set lockmode ""
	if {[string match "*m*" $currmode]} {append lockmode "m"}
	if {[string match "*i*" $currmode]} {append lockmode "i"}
	if {$lockmode == ""} {putquick "NOTICE $nick :$cmdchnlg Channel $chan is not locked." ; return 0}
	putquick "MODE $chan -$lockmode"
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Unlock $chan." ; return 0
}

proc pub_buka {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set rest [lindex $rest 0] ; if {$rest == "#" || $rest == ""} {set rest $chan}
	msg_buka $nick $uhost $hand $rest
}

proc msg_cmode {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0] ; set mlock [lrange $rest 1 end]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick cmode <#channel> <+/-modelocks>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {$mlock == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick cmode $chan <+/-modelocks>" ; return 0}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	putquick "MODE $chan $mlock"
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Mode change: $rest on channel: $chan." ; return 0
}

proc pub_cmode {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	set cmodes [lindex $chans 1]
	if {$cmodes == ""} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}cmode \[#channel\] <+/-modelocks>" ; return 0}
	msg_cmode $nick $uhost $hand $chans
}

proc msg_opbot {nick uhost hand rest} {
	global CHPRM botnick cmdsvrnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {$cmdsvrnick == ""} {putquick "NOTICE $nick :$cmdchnlg This network doesn't have any channel services, or you set its nick blank, I cannot Op myself." ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick up <#channel>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {[botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I am already Opped on channel: $chan." ; return 0}
	if {$cmdsvrnick == ""} {putquick "NOTICE $nick :$cmdchnlg This network doesn't have any channel services, or you set its nick blank, I cannot Op myself." ; return 0}
	putquick "PRIVMSG $cmdsvrnick :op $chan $botnick"
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Self-Op on channel: $chan." ; return 0
}

proc pub_opbot {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set rest [lindex $rest 0] ; if {$rest == "#" || $rest == ""} {set rest $chan}
	msg_opbot $nick $uhost $hand $rest
}

proc msg_deopbot {nick uhost hand rest} {
	global CHPRM botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick down <#channel>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	putquick "MODE $chan +v-o $botnick $botnick"
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Self-DeOp on channel: $chan." ; return 0
}

proc pub_deopbot {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set rest [lindex $rest 0] ; if {$rest == "#" || $rest == ""} {set rest $chan}
	msg_deopbot $nick $uhost $hand $rest
}

proc msg_naekin {nick uhost hand rest} {
	global botnick cmdsvrnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0] ; set opnick [lrange $rest 1 end]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick op <#channel> <nickname(s)>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {$opnick == ""} {
		if {[isop $nick $chan]} {putquick "NOTICE $nick :$cmdchnlg You are already Opped on channel: $chan." ; return 0}
		if {![botisop $chan]} {
			if {$cmdsvrnick == ""} {putquick "NOTICE $nick :$cmdchnlg This network doesn't have any channel services, or you set its nick blank, I cannot Op you since I'm not opped." ; return 0}
			putquick "PRIVMSG $cmdsvrnick :op $chan $nick" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! $cmdsvrnick Op: $nick on channel: $chan." ; return 0
		}
		if {![onchan $nick $chan]} {putquick "NOTICE $nick :$cmdchnlg You are not on channel: $chan." ; return 0}
		putquick "MODE $chan +o $nick" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Op: $nick on channel: $chan." ; return 0
	}
	set opnicks "" ; set gopnicks "" ; set nonenicks "" ; set gotop 0
	foreach x $opnick {
		if {(![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {[string toupper $x] == "ME"} {set x $nick}
			if {$gotop < 6} {if {[isop $x $chan]} {append gopnicks " $x"} else {if {![onchan $x $chan]} {append nonenicks " $x"} else {append opnicks " $x" ; set gotop [expr $gotop + 1]}}}
			if {$gotop == 6} {
				set gotop 0
				if {$opnicks != ""} {
					if {![botisop $chan]} {
						if {$cmdsvrnick == ""} {putquick "NOTICE $nick :$cmdchnlg This network doesn't have any channel services, or you set its nick blank, I cannot Op anyone since I'm not opped." ; return 0}
						putquick "PRIVMSG $cmdsvrnick :op $chan $opnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! $cmdsvrnick Op: $opnicks on channel: $chan."
					} else {
						putquick "MODE $chan +oooooo $opnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Op: $opnicks on channel: $chan."
					}
					set opnicks "" ; append opnicks " $x" ; set gotop 1
				}
			}
		}
	}
	if {$nonenicks != ""} {putquick "NOTICE $nick :$cmdchnlg $nonenicks is not on channel: $chan."}
	if {$gopnicks != ""} {putquick "NOTICE $nick :$cmdchnlg $gopnicks already Oped on channel: $chan."}
	if {$opnicks != ""} {
		if {![botisop $chan]} {
			if {$cmdsvrnick == ""} {putquick "NOTICE $nick :$cmdchnlg This network doesn't have any channel services, or you set its nick blank, I cannot Op anyone since I'm not opped." ; return 0}
			putquick "PRIVMSG $cmdsvrnick :op $chan $opnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! $cmdsvrnick Op: $opnicks on channel: $chan."
		} else {
			putquick "MODE $chan +oooooo $opnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Op: $opnicks on channel: $chan."
		}
	} ; return 0
}

proc pub_naekin {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	msg_naekin $nick $uhost $hand $chans
}

proc msg_turunin {nick uhost hand rest} {
	global botnick cmdsvrnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0] ; set deopnick [lrange $rest 1 end]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick deop <#channel> <nickname(s)>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {$deopnick == ""} {
		if {![isop $nick $chan]} {putquick "NOTICE $nick :$cmdchnlg You are not Opped on channel: $chan." ; return 0}
		if {![botisop $chan]} {
		if {$cmdsvrnick == ""} {putquick "NOTICE $nick :$cmdchnlg This network doesn't have any channel services, or you set its nick blank, I cannot DeOp you since I'm not opped." ; return 0}
			putquick "PRIVMSG $cmdsvrnick :deop $chan $nick" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! $cmdsvrnick DeOp: $nick on channel: $chan." ; return 0
		}
		if {![onchan $nick $chan]} {putquick "NOTICE $nick :$cmdchnlg You are not on channel: $chan." ; return 0}
		putquick "MODE $chan -o $nick" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! DeOp: $nick on channel: $chan." ; return 0
	}
	set deopnicks "" ; set nopnicks "" ; set nonenicks "" ; set ownicks "" ; set gotdeop 0
	foreach x $deopnick {
		if {(![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {[string toupper $x] == "ME"} {set x $nick}
			if {$gotdeop < 6} {if {![isop $x $chan]} {append nopnicks " $x"} else {if {![onchan $x $chan]} {append nonenicks " $x"} else {if {[matchattr [nick2hand $x $chan] m]} {append ownicks " $x"} else {append deopnicks " $x" ; set gotdeop [expr $gotdeop + 1]}}}}
			if {$gotdeop == 6} {
				set gotdeop 0
				if {$deopnicks != ""} {
					if {![botisop $chan]} {
						if {$cmdsvrnick == ""} {putquick "NOTICE $nick :$cmdchnlg This network doesn't have any channel services, or you set its nick blank, I cannot DeOp anyone since I'm not opped." ; return 0}
						putquick "PRIVMSG $cmdsvrnick :deop $chan $deopnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! $cmdsvrnick DeOp: $deopnicks on channel: $chan."
					} else {
						putquick "MODE $chan -oooooo $deopnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! DeOp: $deopnicks on channel: $chan."
					}
					set deopnicks "" ; append deopnicks " $x" ; set gotdeop 1
				}
			}
		}
	}
	if {$nonenicks != ""} {putquick "NOTICE $nick :$cmdchnlg $nonenicks is not on channel: $chan."}
	if {$nopnicks != ""} {putquick "NOTICE $nick :$cmdchnlg $nopnicks already DeOped on channel: $chan."}
	if {$ownicks != ""} {putquick "NOTICE $nick :$cmdchnlg $ownicks are my \[Master(s)\], and will I will not DeOp them on channel: $chan."}
	if {$deopnicks != ""} {
		if {![botisop $chan]} {
			if {$cmdsvrnick == ""} {putquick "NOTICE $nick :$cmdchnlg This network doesn't have any channel services, or you set its nick blank, I cannot DeOp anyone since I'm not opped." ; return 0}
			putquick "PRIVMSG $cmdsvrnick :deop $chan $deopnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! $cmdsvrnick DeOp: $deopnicks on channel: $chan."
		} else {
			putquick "MODE $chan -oooooo $deopnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! DeOp: $deopnicks on channel: $chan."
		}
	} ; return 0
}

proc pub_turunin {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	msg_turunin $nick $uhost $hand $chans
}

proc msg_massop {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick mop <#channel>" ; return 0}
	set massopnick [chanlist $chan]
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	set massopnicks "" ; set gotop 0
	foreach x $massopnick {
		if {(![isop $x $chan]) && (![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {$gotop < 6} {append massopnicks " $x" ; set gotop [expr $gotop + 1]}
			if {$gotop == 6} {
				set gotop 0
				if {$massopnicks != ""} {
					putquick "MODE $chan +oooooo $massopnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! MassOp on channel: $chan by: $nick."
					set massopnicks "" ; append massopnicks " $x" ; set gotop 1
				}
			}
		}
	}
	if {$massopnicks != ""} {putquick "MODE $chan +oooooo $massopnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! MassOp on channel: $chan by: $nick."} ; return 0
}

proc pub_massop {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set channel [lindex $rest 0]
	if {$channel == ""} {set channel $chan} else {if {![string match "#*" $channel]} {set channel "#$channel"}}
	msg_massop $nick $uhost $hand $channel
}

proc msg_massdeop {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick mdeop <#channel>" ; return 0}
	set massdeopnick [chanlist $chan]
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	set massdeopnicks "" ; set ownicks "" ; set gotdeop 0
	foreach x $massdeopnick {
		if {([isop $x $chan]) && (![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {$gotdeop < 6} {if {[matchattr [nick2hand $x $chan] m]} {append ownicks " $x"} else {append massdeopnicks " $x" ; set gotdeop [expr $gotdeop + 1]}}
			if {$gotdeop == 6} {
				set gotdeop 0
				if {$massdeopnicks != ""} {
					putquick "MODE $chan -oooooo $massdeopnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Mass DeOp on channel: $chan by: $nick."
					set massdeopnicks "" ; append massdeopnicks " $x" ; set gotdeop 1
				}
			}
		}
	}
	if {$ownicks != ""} {putquick "NOTICE $nick :$cmdchnlg $ownicks are my \[Master(s)\], and will I will not DeOp them on channel: $chan."}
	if {$massdeopnicks != ""} {putquick "MODE $chan -oooooo $massdeopnicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Mass DeOp on channel: $chan by: $nick."} ; return 0
}

proc pub_massdeop {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set channel [lindex $rest 0]
	if {$channel == ""} {set channel $chan} else {if {![string match "#*" $channel]} {set channel "#$channel"}}
	msg_massdeop $nick $uhost $hand $channel
}

proc msg_pois {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0] ; set vonick [lrange $rest 1 end]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick voice <#channel> <nickname(s)>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	if {$vonick == ""} {
		if {[isvoice $nick $chan]} {putquick "NOTICE $nick :$cmdchnlg You are already Voiced on channel: $chan." ; return 0}
		if {![onchan $nick $chan]} {putquick "NOTICE $nick :$cmdchnlg You are not on channel: $chan." ; return 0}
		putquick "MODE $chan +v $nick" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Voice: $nick on channel: $chan." ; return 0
	}
	set vonicks "" ; set gvonicks "" ; set nonenicks "" ; set gotvoiced 0
	foreach x $vonick {
		if {(![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {[string toupper $x] == "ME"} {set x $nick}
			if {$gotvoiced < 6} {if {[isvoice $x $chan]} {append gvonicks " $x"} else {if {![onchan $x $chan]} {append nonenicks " $x"} else {append vonicks " $x" ; set gotvoiced [expr $gotvoiced + 1]}}}
			if {$gotvoiced == 6} {
				set gotvoiced 0
				if {$vonicks != ""} {
					putquick "MODE $chan +vvvvvv $vonicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Voice: $vonicks on channel: $chan."
					set vonicks "" ; append vonicks " $x" ; set gotvoiced 1
				}
			}
		}
	}
	if {$nonenicks != ""} {putquick "NOTICE $nick :$cmdchnlg $nonenicks is not on channel: $chan."}
	if {$gvonicks != ""} {putquick "NOTICE $nick :$cmdchnlg $gvonicks already Voiced on channel: $chan."}
	if {$vonicks != ""} {putquick "MODE $chan +vvvvvv $vonicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Voice: $vonicks on channel: $chan."} ; return 0
}

proc pub_pois {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	msg_pois $nick $uhost $hand $chans
}

proc msg_depois {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0] ; set dvonick [lrange $rest 1 end]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick devoice <#channel> <nickname(s)>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	if {$dvonick == ""} {
		if {![isvoice $nick $chan]} {putquick "NOTICE $nick :$cmdchnlg You are already DeVoiced on channel: $chan." ; return 0}
		if {![onchan $nick $chan]} {putquick "NOTICE $nick :$cmdchnlg You are not on channel: $chan." ; return 0}
		putquick "MODE $chan -v $nick" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! DeVoice: $nick on channel: $chan." ; return 0
	}
	set dvonicks "" ; set gdvonicks "" ; set nonenicks "" ; set devoiced 0
	foreach x $dvonick {
		if {(![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {[string toupper $x] == "ME"} {set x $nick}
			if {$devoiced < 6} {if {![isvoice $x $chan]} {append gdvonicks " $x"} else {if {![onchan $x $chan]} {append nonenicks " $x"} else {append dvonicks " $x" ; set devoiced [expr $devoiced + 1]}}}
			if {$devoiced == 6} {
				set devoiced 0
				if {$dvonicks != ""} {
					putquick "MODE $chan -vvvvvv $dvonicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! DeVoice: $dvonicks on channel: $chan."
					set dvonicks "" ; append dvonicks " $x" ; set devoiced 1
				}
			}
		}
	}
	if {$nonenicks != ""} {putquick "NOTICE $nick :$cmdchnlg $nonenicks is not on channel: $chan."}
	if {$gdvonicks != ""} {putquick "NOTICE $nick :$cmdchnlg $gdvonicks are not Voiced on channel: $chan."}
	if {$dvonicks != ""} {putquick "MODE $chan -vvvvvv $dvonicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! DeVoice: $dvonicks on channel: $chan."} ; return 0
}

proc pub_depois {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	msg_depois $nick $uhost $hand $chans
}

proc msg_massvo {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick mvoice <#channel>" ; return 0}
	set massvonick [chanlist $chan]
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	set massvonicks "" ; set gmvoiced 0
	foreach x $massvonick {
		if {(![isvoice $x $chan]) && (![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {$gmvoiced < 6} {append massvonicks " $x" ; set gmvoiced [expr $gmvoiced + 1]}
			if {$gmvoiced == 6} {
				set gmvoiced 0
				if {$massvonicks != ""} {
					putquick "MODE $chan +vvvvvv $massvonicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Mass Voice on channel: $chan by: $nick."
					set massvonicks "" ; append massvonicks " $x" ; set gmvoiced 1
				}
			}
		}
	}
	if {$massvonicks != ""} {putquick "MODE $chan +vvvvvv $massvonicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Mass Voice on channel: $chan by: $nick."} ; return 0
}

proc pub_massvo {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set channel [lindex $rest 0]
	if {$channel == ""} {set channel $chan} else {if {![string match "#*" $channel]} {set channel "#$channel"}}
	msg_massvo $nick $uhost $hand $channel
}

proc msg_massdevo {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick mdevo <#channel>" ; return 0}
	set massdevonick [chanlist $chan]
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	set massdevonicks "" ; set gmdvoice 0
	foreach x $massdevonick {
		if {([isvoice $x $chan]) && (![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {$gmdvoice < 6} {append massdevonicks " $x" ; set gmdvoice [expr $gmdvoice + 1]}
			if {$gmdvoice == 6} {
				set gmdvoice 0
				if {$massdevonicks != ""} {
					putquick "MODE $chan -vvvvvv $massdevonicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Mass DeVoice on channel: $chan by: $nick."
					set massdevonicks "" ; append massdevonicks " $x" ; set gmdvoice 1
				}
			}
		}
	}
	if {$massdevonicks != ""} {putquick "MODE $chan -vvvvvv $massdevonicks" ; putcmdlog "$cmdchnlg <<$nick>> !$hand! Mass DeVoice on channel: $chan by: $nick."} ; return 0
}

proc pub_massdevo {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set channel [lindex $rest 0]
	if {$channel == ""} {set channel $chan} else {if {![string match "#*" $channel]} {set channel "#$channel"}}
	msg_massdevo $nick $uhost $hand $channel
}

proc msg_tendang {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0] ; set knick [lrange $rest 1 end]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick kick <#channel> <nickname(s)> \[!reason\]" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {$knick == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick kick $chan <nickname(s)> \[!reason\]" ; return 0}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	set knicks "" ; set ownicks "" ; set nonenicks "" ; set reason ""
	foreach x $knick {
		if {(![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {[string match "!*" $x]} {set reason "4$cmdchnlg $x"} else {if {[matchattr [nick2hand $x $chan] m]} {append ownicks " $x"} else {if {![onchan $x $chan]} {append nonenicks " $x"} else {append knicks "$x,"}}}
		}
	}
	if {$nonenicks != ""} {putquick "NOTICE $nick :$cmdchnlg $nonenicks is not on channel: $chan."}
	if {$ownicks != ""} {putquick "NOTICE $nick :$cmdchnlg $ownicks are my \[Master(s)\], and will I will not Kick them from channel: $chan."}
	if {$knicks != ""} {
		if {$reason == ""} {set reason "4$cmdchnlg Requested by: $nick"} ; putkick $chan $knicks $reason
		putcmdlog "$cmdchnlg <<$nick>> !$hand! Kick: ${knicks} from channel: $chan. Reason: $reason."
	} ; return 0
}

proc pub_tendang {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	set knicks [lindex $chans 1]
	if {$knicks == ""} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}kick $chan <nickname(s)> \[!reason\]" ; return 0}
	msg_tendang $nick $uhost $hand $chans
}

proc msg_mtendang {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick mkick <#channel> \[!reason\]" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	set knick [chanlist $chan]
	set knicks "" ; set ownicks "" ; set reason ""
	foreach x $knick {
		if {(![onchansplit $x $chan]) && (![isbotnick $x])} {
			if {[string match "!*" $x]} {set reason "4$cmdchnlg $x"} else {if {[matchattr [nick2hand $x $chan] m]} {append ownicks " $x"} else {append knicks "$x,"}}
		}
	}
	if {$ownicks != ""} {putquick "NOTICE $nick :$cmdchnlg $ownicks are my \[Master(s)\], and will I will not Kick them from channel: $chan."}
	if {$knicks != ""} {
		if {$reason == ""} {set reason "4$cmdchnlg Mass Kick by: $nick"} ; putkick $chan $knicks $reason
		putcmdlog "$cmdchnlg <<$nick>> !$hand! Mass Kick on channel: $chan. Reason: $reason."
	} ; return 0
}

proc pub_mtendang {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	msg_mtendang $nick $uhost $hand $chans
}

proc msg_+ban {nick uhost hand rest} {
	global botnick gbantime cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick +ban <#channel> <nickname/hostname> \[ban time (minute(s))\] \[reason\]" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	set rest [lrange $rest 1 end]
	if {$rest == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick +ban <#channel> <nickname/hostname> \[ban time (minute(s))\] \[reason\]" ; return 0}
	set bntime [lindex $rest 1] ; set reason [lrange $rest 2 end]
	set bntime [string trim $bntime "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+|~,./;'<>?:{}"]
	if {$bntime == ""} {if {$gbantime <= 0} {set gbantime 15} ; set bntime $gbantime}
	if {$reason == ""} {set reason "4$cmdchnlg Requested by: $nick"}
	set bannick [lindex $rest 0]
	if {[string match "*@*" $bannick]} {
		set host $bannick ; set banhost $host ; set banhand $host
	} else {
		if {![onchan $bannick $chan]} {putquick "NOTICE $nick :$cmdchnlg $bannick is not on channel: $chan." ; return 0
		} else {set host [getchanhost $bannick $chan] ; set banhost *!*@[lindex [split $host @] 1]}
		set banhand [nick2hand $bannick $chan]
	}
	if {[string tolower $bannick] == [string tolower $botnick]} {putquick "NOTICE $nick :$cmdchnlg I will not ban on myself." ; return 0}
	if {[matchattr $banhand f]} {putquick "NOTICE $nick :$cmdchnlg I will not place ban on $bannick coz a hostmask of this user is included in my user list." ; return 0}
	foreach x [userlist] {
		if {[string match *$x* $banhost]} {putquick "NOTICE $nick :$cmdchnlg I will not place ban on $bannick coz this hostmask belongs to me or one of my users." ; return 0}
		if {[getchanhost $x $chan] != ""} {
			set rhostmem [lindex [split [getchanhost $x $chan] @] 1] ; set rhostban [string trim [lindex [split $banhost @] 1] "\*\."]
			set lhostmem [lindex [split [getchanhost $x $chan] @] 0] ; set lhostban [string trim [lindex [split $banhost @] 0] "\*\!\."]
			if {[string match *$rhostban* $rhostmem] && [string match *$lhostban* $lhostmem]} {putquick "NOTICE $nick :$cmdchnlg I will not place ban on $bannick coz this hostmask belongs to me or one of my users." ; return 0}
		}
	}
	if {[ischanban $banhost $chan]} {putquick "NOTICE $nick :$cmdchnlg A local ban already exist on channel: $chan for: $banhost" ; return 0}
	putquick "NOTICE $nick :$cmdchnlg Creating new ban on channel: $chan for: $banhost"
	newchanban $chan $banhost $hand $reason $bntime
	set bmembers [chanlist $chan]
	foreach banmember $bmembers {
		set bselectedhost [getchanhost $banmember $chan]
		set ubanhost *!*@[lindex [split $bselectedhost @] 1]
		if {$ubanhost == $banhost} {putkick $chan $banmember $reason}
	}
	putcmdlog "$cmdchnlg <<$nick>> !$hand! ($chan) +ban $host $bntime $reason" ; return 0
}

proc pub_+ban {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	set bnicks [lindex $chans 1]
	if {$bnicks == ""} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}+ban \[#channel\] <nickname/hostname> \[ban time (minute(s))\] \[reason\]" ; return 0}
	msg_+ban $nick $uhost $hand $chans
}

proc msg_-ban {nick uhost hand rest} {
	global botnick banlist cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick -ban <#channel> <nickname/hostname>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	set rest [lrange $rest 1 end]
	if {$rest == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick -ban <#channel> <nickname/hostname>" ; return 0}
	if {![string match "*@*" $rest]} {
		if {![onchan $rest $chan]} {putquick "NOTICE $nick :$cmdchnlg $rest is not on channel: $chan." ; return 0
		} else {set rest [getchanhost $rest $chan] ; set rest *!*@[lindex [split $rest @] 1]}
	}
	if {[string match *$rest* [lrange [banlist $chan] 0 end]]} {
		putquick "NOTICE $nick :$cmdchnlg Releasing current ban: $rest on channel: $chan"
		killchanban $chan $rest
	} else {
		putquick "NOTICE $nick :$cmdchnlg There are no Bans for: $rest on channel: $chan. Perhaps it was a Global Ban." ; return 0
	}
	putcmdlog "$cmdchnlg <<$nick>> !$hand! ($chan) -ban $rest" ; return 0
}

proc pub_-ban {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	set bnicks [lindex $chans 1]
	if {$bnicks == ""} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}-ban \[#channel\] <nickname/hostname>" ; return 0}
	msg_-ban $nick $uhost $hand $chans
}

proc msg_+gban {nick uhost hand rest} {
	global botnick gbantime cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set rest [lindex $rest 0]
	if {[string match "#*" $rest]} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick +gban <nickname/hostname> \[ban time (minute(s))\] \[reason\]" ; return 0}
	if {$rest == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick +gban <nickname/hostname> \[ban time (minute(s))\] \[reason\]" ; return 0}
	set bntime [lindex $rest 1] ; set reason [lrange $rest 2 end]
	set bntime [string trim $bntime "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+|~,./;'<>?:{}"]
	if {$bntime == ""} {if {$gbantime <= 0} {set gbantime 15} ; set bntime $gbantime}
	if {$reason == ""} {set reason "4$cmdchnlg \[GLOBAL Ban\] Requested by: $nick"}
	set bannick [lindex $rest 0]
	if {[string match "*@*" $bannick]} {set host $bannick ; set banhost $host ; set banhand $host} else {set host "" ; set banhost "" ; set banhand ""}
	foreach x [channels] {
		set chan $x
		if {[onchan $bannick $chan]} {if {$host == "" || $banhost == "" || $bannick == ""} {set host [getchanhost $bannick $chan] ; set banhost *!*@[lindex [split $host @] 1] ; set banhand [nick2hand $bannick $chan]}}
	}
	if {$host == "" || $banhost == "" || $banhand == ""} {putquick "NOTICE $nick :$cmdchnlg $bannick is not on any of my channel(s)." ; return 0}
	if {[string tolower $bannick] == [string tolower $botnick]} {putquick "NOTICE $nick :$cmdchnlg I will not ban on myself." ; return 0}
	if {[matchattr $banhand f]} {putquick "NOTICE $nick :$cmdchnlg I will not place ban on $bannick coz a hostmask of this user is included in my user list." ; return 0}
	foreach x [userlist] {
		if {[string match *$x* $banhost]} {putquick "NOTICE $nick :$cmdchnlg I will not place ban on $bannick coz this hostmask belongs to me or one of my users." ; return 0}
		if {[getchanhost $x $chan] != ""} {
			set rhostmem [lindex [split [getchanhost $x $chan] @] 1] ; set rhostban [string trim [lindex [split $banhost @] 1] "\*\."]
			set lhostmem [lindex [split [getchanhost $x $chan] @] 0] ; set lhostban [string trim [lindex [split $banhost @] 0] "\*\!\."]
			if {[string match *$rhostban* $rhostmem] && [string match *$lhostban* $lhostmem]} {putquick "NOTICE $nick :$cmdchnlg I will not place ban on $bannick coz this hostmask belongs to me or one of my users." ; return 0}
		}
	}
	if {[isban $banhost]} {putquick "NOTICE $nick :$cmdchnlg A Global ban already exist for: $banhost" ; return 0}
	putquick "NOTICE $nick :$cmdchnlg Creating new Global ban for: $banhost"
	newban $banhost $hand $reason $bntime
	putcmdlog "$cmdchnlg <<$nick>> !$hand! +gban $host $bntime $reason" ; return 0
}

proc pub_+gban {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set banhost [lindex $rest 0]
	if {[string match "#*" $banhost]} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}+gban <nickname/hostname> \[ban time (minute(s))\] \[reason\]" ; return 0}
	if {$banhost == ""} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}+gban <nickname/hostname> \[ban time (minute(s))\] \[reason\]" ; return 0}
	msg_+gban $nick $uhost $hand $banhost
}

proc msg_-gban {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set rest [lindex $rest 0]
	if {[string match "#*" $rest]} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick -gban <nickname/hostname>" ; return 0}
	if {$rest == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick -gban <nickname/hostname>" ; return 0}
	if {![isban $rest]} {putquick "NOTICE $nick :$cmdchnlg There are no Global Bans for: $rest." ; return 0}
	putquick "NOTICE $nick :$cmdchnlg Releasing Global ban for: $rest"
	killban $rest ; regsub -all " " [channels] ", " chans
	putcmdlog "$cmdchnlg <<$nick>> !$hand! -gban $rest" ; return 0
}

proc pub_-gban {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set banhost [lindex $rest 0]
	if {[string match "#*" $banhost]} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}-gban <nickname/hostname>" ; return 0}
	if {$banhost == ""} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}-gban <nickname/hostname>" ; return 0}
	msg_-gban $nick $uhost $hand $banhost
}

proc msg_infoban {nick uhost hand rest} {
	global botnick cmdchnlg
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {if {[string toupper $chan] != "GLOBAL"} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick baninfo <#channel|GLOBAL>" ; return 0}}
	if {[string toupper $chan] != "GLOBAL"} {if {![string match "#*" $chan]} {set chan "#$chan"}}
	set banlistchan ""
	if {[string toupper $chan] != "GLOBAL"} {
		if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
		foreach x [banlist $chan] {set banlister [lindex $x 0] ; set banlistchan "$banlistchan $banlister"}
		if {[banlist $chan] == ""} {set banlistchan "empty"}
		putquick "NOTICE $nick :$cmdchnlg Ban records for channel: $chan: $banlistchan."
		putcmdlog "$cmdchnlg <<$nick>> !$hand! List Bans on: $banlistchan." ; return 0
	}
	set banlist ""
	if {[string toupper $chan] == "GLOBAL"} {
		foreach x [banlist] {set banlisting [lindex $x 0] ; set banlist "$banlist $banlisting"}
		if {$banlist == ""} {set banlist "empty"}
		putquick "NOTICE $nick :$cmdchnlg Global Ban records: $banlist."
		putcmdlog "$cmdchnlg <<$nick>> !$hand! List Global Bans." ; return 0
	}
}

proc pub_infoban {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set channel [lindex $rest 0]
	if {$channel == "" && [string toupper $channel] != "GLOBAL"} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}baninfo <#channel|GLOBAL>" ; return 0}
	msg_infoban $nick $uhost $hand $channel
}

proc msg_lepasban {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick rlbans <#channel>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {![botisop $chan]} {putquick "NOTICE $nick :$cmdchnlg I appologize, but I am not an Operator on channel: $chan. Your command cannot be perform." ; return 0}
	set ban "" ; foreach ban [banlist $chan] {putquick "MODE $chan +b [lindex $ban 0]"} ; putquick "MODE $chan +b"
	putquick "NOTICE $nick :$cmdchnlg Releasing all Bans on channel: $chan. Updating Ban records."
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Release Bans on: $chan." ; return 0
}

proc pub_lepasban {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set channel [lindex $rest 0]
	if {$channel == ""} {set channel $chan} else {if {![string match "#*" $channel]} {set channel "#$channel"}}
	msg_lepasban $nick $uhost $hand $channel
}

proc msg_inpait {nick uhost hand rest} {
	global botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	if {![matchattr $hand Q]} {putquick "NOTICE $nick :$cmdchnlg You haven't authenticate Yourself. Type: \[/msg $botnick auth <password>\] to do so." ; return 0}
	set chan [lindex $rest 0] ; set inick [lindex $rest 1]
	if {$chan == "#" || $chan == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick invite <#channel> <nickname>" ; return 0}
	if {![string match "#*" $chan]} {set chan "#$chan"}
	if {![validchan $chan]} {putquick "NOTICE $nick :$cmdchnlg I am not on channel: $chan, check out my channel list." ; return 0}
	if {$inick == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick invite $chan <nickname>" ; return 0}
	if {[onchan $inick $chan]} {putquick "NOTICE $nick :$cmdchnlg $inick already on channel: $chan. Invites are not needed." ; return 0}
	putquick "INVITE $inick $chan"
	putquick "NOTICE $nick :$cmdchnlg $inick are now invited to join channel: $chan."
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Inviting: $inick to channel: $chan." ; return 0
}

proc pub_inpait {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	set chans "" ; set channel [lindex $rest 0]
	if {![string match "#*" $channel]} {set channel $chan ; append chans "$channel $rest "} else {append chans " $rest"}
	set inicks [lindex $chans 1]
	if {$inicks == ""} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}invite $channel <nickname>" ; return 0}
	msg_inpait $nick $uhost $hand $chans
}

proc msg_chanhelp {nick uhost hand rest} {
	global CHPRM botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	set chlptype [string toupper [lindex $rest 0]]
	if {$chlptype == ""} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick chanhelp PUB or /msg $botnick chanhelp MSG" ; return 0}
	if {[string toupper $chlptype] != "PUB" && [string toupper $chlptype] != "MSG"} {putquick "NOTICE $nick :$cmdchnlg Command: /msg $botnick chanhelp PUB or /msg $botnick chanhelp MSG" ; return 0}
	putquick "NOTICE $nick :$cmdchnlg Channel Control Commands $cmdchnlg"
	putquick "NOTICE $nick : "
	putquick "NOTICE $nick :NOTES:"
	putquick "NOTICE $nick :<> sign means you MUST fill the value."
	putquick "NOTICE $nick :\[\] sign means you can either fill the value or leave it blank."
	putquick "NOTICE $nick :| sign means you MUST choose one between value placed on the left side of | sign, or on the right side."
	putquick "NOTICE $nick : "
	if {$chlptype == "PUB"} {
		putquick "NOTICE $nick :Public Commands:"
		putquick "NOTICE $nick : "
		if {[matchattr $hand n]} {
			putquick "NOTICE $nick :${CHPRM}join <#channel> \[join-key\]"
			putquick "NOTICE $nick :${CHPRM}leave <#channel>"
			putquick "NOTICE $nick :${CHPRM}cycle \[#channel\]"
		}
		putquick "NOTICE $nick :${CHPRM}lock \[#channel\]"
		putquick "NOTICE $nick :${CHPRM}unlock \[#channel\]"
		putquick "NOTICE $nick :${CHPRM}cmode \[#channel\] <+/-modelocks>"
		putquick "NOTICE $nick :${CHPRM}up \[#channel\]"
		putquick "NOTICE $nick :${CHPRM}down \[#channel\]"
		putquick "NOTICE $nick :${CHPRM}op \[#channel\] <nickname(s)>"
		putquick "NOTICE $nick :${CHPRM}deop \[#channel\] <nickname(s)>"
		if {[matchattr $hand m]} {
			putquick "NOTICE $nick :${CHPRM}mop \[#channel\]"
			putquick "NOTICE $nick :${CHPRM}mdeop \[#channel\]"
		}
		putquick "NOTICE $nick :${CHPRM}voice \[#channel\] <nickname(s)>"
		putquick "NOTICE $nick :${CHPRM}devoice \[#channel\] <nickname(s)>"
		if {[matchattr $hand m]} {
			putquick "NOTICE $nick :${CHPRM}mvoice \[#channel\]"
			putquick "NOTICE $nick :${CHPRM}mdevo \[#channel\]"
		}
		putquick "NOTICE $nick :${CHPRM}kick \[#channel\] <nickname(s)> \[!reason\]"
		if {[matchattr $hand m]} {
			putquick "NOTICE $nick :${CHPRM}mkick \[#channel\] \[!reason\]"
		}
		putquick "NOTICE $nick :${CHPRM}+ban \[#channel\] <nickname/hostname> \[ban-time (minute(s))\] \[reason\]"
		putquick "NOTICE $nick :${CHPRM}-ban \[#channel\] <nickname/hostname>"
		if {[matchattr $hand m]} {
			putquick "NOTICE $nick :${CHPRM}+gban <nickname/hostname> \[ban-time (minute(s))\] \[reason\]"
			putquick "NOTICE $nick :${CHPRM}-gban <nickname/hostname>"
		}
		putquick "NOTICE $nick :${CHPRM}baninfo <#channel|GLOBAL>"
		putquick "NOTICE $nick :${CHPRM}rlbans \[#channel\]"
		putquick "NOTICE $nick :${CHPRM}invite \[#channel\] <nickname>"
		putquick "NOTICE $nick : "
	}
	if {$chlptype == "MSG"} {
		putquick "NOTICE $nick :MSG Commands:"
		putquick "NOTICE $nick : "
		if {[matchattr $hand n]} {
			putquick "NOTICE $nick :/msg $botnick join <#channel> \[join-key\]"
			putquick "NOTICE $nick :/msg $botnick leave <#channel>"
			putquick "NOTICE $nick :/msg $botnick cycle \[#channel\]"
		}
		putquick "NOTICE $nick :/msg $botnick lock <#channel>"
		putquick "NOTICE $nick :/msg $botnick unlock <#channel>"
		putquick "NOTICE $nick :/msg $botnick cmode <#channel> <+/-modelocks>"
		putquick "NOTICE $nick :/msg $botnick up <#channel>"
		putquick "NOTICE $nick :/msg $botnick down <#channel>"
		putquick "NOTICE $nick :/msg $botnick op <#channel> <nickname(s)>"
		putquick "NOTICE $nick :/msg $botnick deop <#channel> <nickname(s)>"
		if {[matchattr $hand m]} {
			putquick "NOTICE $nick :/msg $botnick mop <#channel>"
			putquick "NOTICE $nick :/msg $botnick mdeop <#channel>"
		}
		putquick "NOTICE $nick :/msg $botnick voice <#channel> <nickname(s)>"
		putquick "NOTICE $nick :/msg $botnick devoice <#channel> <nickname(s)>"
		if {[matchattr $hand m]} {
			putquick "NOTICE $nick :/msg $botnick mvoice <#channel>"
			putquick "NOTICE $nick :/msg $botnick mdevo <#channel>"
		}
		putquick "NOTICE $nick :/msg $botnick kick <#channel> <nickname(s)> \[!reason\]"
		if {[matchattr $hand m]} {
			putquick "NOTICE $nick :/msg $botnick mkick <#channel> \[!reason\]"
		}
		putquick "NOTICE $nick :/msg $botnick +ban <#channel> <nickname/hostname> \[ban-time (minute(s))\] \[reason\]"
		putquick "NOTICE $nick :/msg $botnick -ban <#channel> <nickname/hostname>"
		if {[matchattr $hand m]} {
			putquick "NOTICE $nick :/msg $botnick +gban <nickname/hostname> \[ban-time (minute(s))\] \[reason\]"
			putquick "NOTICE $nick :/msg $botnick -gban <nickname/hostname>"
		}
		putquick "NOTICE $nick :/msg $botnick baninfo <#channel|GLOBAL>"
		putquick "NOTICE $nick :/msg $botnick rlbans <#channel>"
		putquick "NOTICE $nick :/msg $botnick invite <#channel> <nickname>"
		putquick "NOTICE $nick : "
	}
	putquick "NOTICE $nick :Other Commands:"
	putquick "NOTICE $nick : "
	putquick "NOTICE $nick :${CHPRM}chanhelp PUB or ${CHPRM}chanhelp MSG"
	putquick "NOTICE $nick :/msg $botnick chanhelp PUB or /msg $botnick chanhelp MSG"
	putquick "NOTICE $nick : "
	putcmdlog "$cmdchnlg <<$nick>> !$hand! Channel Control Commands Help." ; return 0
}

proc pub_chanhelp {nick uhost hand chan rest} {
	global CHPRM botnick cmdchnlg
	if {![matchattr $hand p]} {putquick "NOTICE $nick :$cmdchnlg You have +o privelage but you don't have +p, you need +p flag to set your password and authenticate before phrasing commands. Ask my owner/master to set that flag for you =)" ; return 0}
	set chlptype [string toupper [lindex $rest 0]]
	if {$chlptype == ""} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}chanhelp PUB or ${CHPRM}chanhelp MSG" ; return 0}
	if {[string toupper $chlptype] != "PUB" && [string toupper $chlptype] != "MSG"} {putquick "NOTICE $nick :$cmdchnlg Command: ${CHPRM}chanhelp PUB or ${CHPRM}chanhelp MSG" ; return 0}
	msg_chanhelp $nick $uhost $hand $chlptype
}

# Set this to "1" if you like the script to be loaded.. and set it to "0" to unload.
set cmdchanloaded 1

if {[info exist cmdchanloaded]} {
	if {${cmdchanloaded}} {
		bind pub n ${CHPRM}join pub_masuk
		bind msg n leave msg_cabut
		bind pub n ${CHPRM}leave pub_cabut
		bind msg n join msg_masuk
		bind pub n ${CHPRM}cycle pub_cycle
		bind msg n cycle msg_cycle
		bind pub o|o ${CHPRM}lock pub_konci
		bind msg o|o lock msg_konci
		bind pub o|o ${CHPRM}unlock pub_buka
		bind msg o|o unlock msg_buka
		bind pub o|o ${CHPRM}cmode pub_cmode
		bind msg o|o cmode msg_cmode
		bind pub o|o ${CHPRM}up pub_opbot
		bind msg o|o up msg_opbot
		bind pub o|o ${CHPRM}down pub_deopbot
		bind msg o|o down msg_deopbot
		bind pub o|o ${CHPRM}op pub_naekin
		bind msg o|o op msg_naekin
		bind pub o|o ${CHPRM}deop pub_turunin
		bind msg o|o deop msg_turunin
		bind pub m ${CHPRM}mop pub_massop
		bind msg m mop msg_massop
		bind pub m ${CHPRM}mdeop pub_massdeop
		bind msg m mdeop msg_massdeop
		bind pub o|o ${CHPRM}voice pub_pois
		bind msg o|o voice msg_pois
		bind pub o|o ${CHPRM}devoice pub_depois
		bind msg o|o devoice msg_depois
		bind pub m ${CHPRM}mvoice pub_massvo
		bind msg m mvoice msg_massvo
		bind pub m ${CHPRM}mdevo pub_massdevo
		bind msg m mdevo msg_massdevo
		bind pub o|o ${CHPRM}kick pub_tendang
		bind msg o|o kick msg_tendang
		bind pub m ${CHPRM}mkick pub_mtendang
		bind msg m mkick msg_mtendang
		bind pub o|o ${CHPRM}+ban pub_+ban
		bind msg o|o +ban msg_+ban
		bind pub o|o ${CHPRM}-ban pub_-ban
		bind msg o|o -ban msg_-ban
		bind pub m ${CHPRM}+gban pub_+gban
		bind msg m +gban msg_+gban
		bind pub m ${CHPRM}-gban pub_-gban
		bind msg m -gban msg_-gban
		bind pub o|o ${CHPRM}baninfo pub_infoban
		bind msg o|o baninfo msg_infoban
		bind pub o|o ${CHPRM}rlbans pub_lepasban
		bind msg o|o rlbans msg_lepasban
		bind pub o|o ${CHPRM}invite pub_inpait
		bind msg o|o invite msg_inpait
		bind pub o|o ${CHPRM}chanhelp pub_chanhelp
		bind msg o|o chanhelp msg_chanhelp
	} else {
		unbind pub n ${CHPRM}join pub_masuk
		unbind msg n leave msg_cabut
		unbind pub n ${CHPRM}leave pub_cabut
		unbind msg n join msg_masuk
		unbind pub n ${CHPRM}cycle pub_cycle
		unbind msg n cycle msg_cycle
		unbind pub o|o ${CHPRM}lock pub_konci
		unbind msg o|o lock msg_konci
		unbind pub o|o ${CHPRM}unlock pub_buka
		unbind msg o|o unlock msg_buka
		unbind pub o|o ${CHPRM}cmode pub_cmode
		unbind msg o|o cmode msg_cmode
		unbind pub o|o ${CHPRM}up pub_opbot
		unbind msg o|o up msg_opbot
		unbind pub o|o ${CHPRM}down pub_deopbot
		unbind msg o|o down msg_deopbot
		unbind pub o|o ${CHPRM}op pub_naekin
		unbind msg o|o op msg_naekin
		unbind pub o|o ${CHPRM}deop pub_turunin
		unbind msg o|o deop msg_turunin
		unbind pub m ${CHPRM}mop pub_massop
		unbind msg m mop msg_massop
		unbind pub m ${CHPRM}mdeop pub_massdeop
		unbind msg m mdeop msg_massdeop
		unbind pub o|o ${CHPRM}voice pub_pois
		unbind msg o|o voice msg_pois
		unbind pub o|o ${CHPRM}devoice pub_depois
		unbind msg o|o devoice msg_depois
		unbind pub m ${CHPRM}mvoice pub_massvo
		unbind msg m mvoice msg_massvo
		unbind pub m ${CHPRM}mdevo pub_massdevo
		unbind msg m mdevo msg_massdevo
		unbind pub o|o ${CHPRM}kick pub_tendang
		unbind msg o|o kick msg_tendang
		unbind pub m ${CHPRM}mkick pub_mtendang
		unbind msg m mkick msg_mtendang
		unbind pub o|o ${CHPRM}+ban pub_+ban
		unbind msg o|o +ban msg_+ban
		unbind pub o|o ${CHPRM}-ban pub_-ban
		unbind msg o|o -ban msg_-ban
		unbind pub m ${CHPRM}+gban pub_+gban
		unbind msg m +gban msg_+gban
		unbind pub m ${CHPRM}-gban pub_-gban
		unbind msg m -gban msg_-gban
		unbind pub o|o ${CHPRM}baninfo pub_infoban
		unbind msg o|o baninfo msg_infoban
		unbind pub o|o ${CHPRM}rlbans pub_lepasban
		unbind msg o|o rlbans msg_lepasban
		unbind pub o|o ${CHPRM}invite pub_inpait
		unbind msg o|o invite msg_inpait
		unbind pub o|o ${CHPRM}chanhelp pub_chanhelp
		unbind msg o|o chanhelp msg_chanhelp
	}
	putlog "Commands & Control, Channel Control.bY dJ_TEDY Loaded."
}

# End of - Commands & Control, Channel Control. (cmd_chan.tcl)
