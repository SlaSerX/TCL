#####################################################
# Opcontrol.tcl                                     #
#####################################################
bind msg - login login:login
bind sign - * login:signcheck
bind msg - logout login:logout
bind pub O|O !disable pub:disable
bind pub O|O !enable pub:enable
proc say {who what} {
	puthelp "PRIVMSG $who :$what"
}
proc notice {who what} {
putserv "notice $who :$what"
}

proc pub:disable {nick host hand chan arg} {
	if {[llength $arg] < 1} {
		notice $chan "Izpolzwaj: !disable <username>"
		return 0
	}
	set who [lindex $arg 0]
	if {![validuser $who]} {
		notice $chan "$who is not a valid user."
		return 0
	}
	setuser $who XTRA LOGIN "DEAD"
	puthelp "PRIVMSG $chan :\001ACTION \[\002$nick\002\] You disabled \002$who\002.\001"
	notice $nick "Disabled $who"
	putcmdlog "<<$nick>> disable $who"
}

proc pub:enable {nick host hand chan arg} {
	if {[llength $arg] < 1} {
		notice $chan "Useage: .disable <username>"
		return 0
	}
	set who [lindex $arg 0]
	if {![validuser $who]} {
		notice $chan "$who is not a valid user."
		return 0
	}
	setuser $who XTRA LOGIN 0
	puthelp "PRIVMSG $chan :\001ACTION \[\002$nick\002\] You enabled \002$who\002.\001"
	putcmdlog "<<$nick>> enable $who"
}
#####################################################################
# За идентификация в бота използвай: /msg $botnick login <password> #
#####################################################################
proc login:login {nick uhost hand arg} {
	global botnick
	set found 0
	foreach n [channels] {
		if {[onchan $nick $n]} {
			set found 1
		}
	}
	if {$found == 0} {return 0}
	if {[llength $arg] <1} {
		notice $nick "Polzwajte: /msg $botnick login <washata parola>"
		return 0
	}
	set pass [lindex $arg 0]
	if {$hand == "*"} {
		say $nick ":: Vyvedenata parola e greshna ::"
		return 0
	}
	if {[getuser $hand XTRA LOGIN] == "DEAD"} {
		say $nick "Nqmate dostyp do mojte komandi."
		return 0
	}
	if {[passwdok $hand $pass]} {
		setuser $hand XTRA "LOGIN" "1"
		putcmdlog "#$nick# ($uhost) LOGIN ..."
		notice $nick ":: Successful ::LOGIN:: ::"
		return 0
	} else {
		notice $nick ":: Vyvedenata parola e greshna ::"
	}
}

proc login:signcheck {nick uhost hand chan reason} {
	if {$hand == "*"} {return 0}
	if {[getuser $hand XTRA LOGIN] == "DEAD"} {
		return 0
	}
	setuser $hand XTRA "LOGIN" "0"
}

proc login:check {hand} {
	set login [getuser $hand XTRA "LOGIN"]
	if {($login == "") || ($login == "0") || ($login == "DEAD")} {
		return 0
	} else { return 1}
}

proc login:logout {nick uhost hand arg} {
	if {[getuser $hand XTRA LOGIN] == "DEAD"} {
		say $nick "Nqmate dostyp do mojte komandi."
		return 0
	}
	if {$hand != "*"} {
		setuser $hand XTRA "LOGIN" "0"
		putcmdlog "#$nick# ($uhost) LOGOUT ..."
		notice $nick ":: Successful ::logout:: ::"
	}
}
#######################################
# Команди за потребители с флагове +о #
#######################################
bind pub o|o @ pub_op
bind pub o|o !op pub_op
proc pub_op {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {$txt == ""} {
    putserv "mode $chan +o $nick"
    putlog "#$nick#, !op on $chan"
    return 0
  }
  if {![onchan $txt $chan]} {
    putserv "notice $nick :$txt is not on $chan"
    putlog "#$nick# failed @ $txt on $chan"
    return 0
  }
  putserv "mode $chan +o $txt"
  putlog "#$nick# @ $txt on $chan"
}
bind pub o|o -@ pub_deop
bind pub o|o !deop pub_deop
proc pub_deop {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {$txt == ""} {
    putserv "mode $chan -o $nick"
    putlog "#$nick# -@ on $chan"
    return 0
  }
  if {![onchan $txt $chan]} {
    putserv "notice $nick :$txt is not on $chan"
    putlog "#$nick# failed -@ $txt on $chan"
    return 0
  }
  putserv "mode $chan -o $txt"
  putlog "#$nick# -@ $txt on $chan"
}
bind pub o|o + pub_voice
bind pub o|o !v pub_voice
proc pub_voice {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {$txt == ""} {
    putserv "mode $chan +v $nick"
    putlog "#$nick# !v on $chan"
    return 0
  }
  if {![onchan $txt $chan]} {
    putserv "notice $nick :$txt is not on $chan"
    putlog "#$nick# failed + $txt on $chan"
    return 0
  }
  putserv "mode $chan +v $txt"
  putlog "#$nick# + $txt on $chan"
}
bind pub o|o - pub_devoice
bind pub o|o !-v pub_devoice
proc pub_devoice {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {$txt == ""} {
    putserv "mode $chan -v $nick"
    putlog "#$nick# !-v on $chan"
    return 0
  }
  if {![onchan $txt $chan]} {
    putserv "notice $nick :$txt is not on $chan"
    putlog "#$nick# failed - $txt on $chan"
    return 0
  }
  putserv "mode $chan -v $txt"
  putlog "#$nick# - $txt on $chan"
}
bind pub o|o !k pub_kick
proc pub_kick {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_knick [lindex $txt 0]
  set opc_kreason [lrange $txt 1 end]
  if {![onchan $opc_knick $chan]} {
    putserv "notice $nick :$opc_knick is not on $chan"
    putlog "#$nick# failed !k $opc_knick on $chan"
    return 0
  }
  if {$opc_kreason == ""} {
    putserv "kick $chan $opc_knick :Requested by $nick"
    putlog "#$nick# kick $opc_knick on $chan"
    return 0
  }
  putserv "kick $chan $opc_knick :$opc_kreason"
  putlog "#$nick# kick $opc_knick with reason $opc_kreason on $chan"
}
bind pub o|o !b pub_ban
proc pub_ban {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {[onchan $txt $chan]} {
    set opc_uhost [getchanhost $txt $chan]
    set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
    set opc_bmask "*!*[string trimleft $opc_tmask *!]"
    putserv "mode $chan +b $opc_bmask"
    putlog "#$nick# ban $opc_bmask on $chan"
    return 0
  }
  putserv "mode $chan +b $txt"
  putlog "#$nick# !b $txt on $chan"
}
bind pub o|o !kb pub_kickban
proc pub_kickban {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_knick [lindex $txt 0]
  set opc_kreason [lrange $txt 1 end]
  if {![onchan $opc_knick $chan]} {
    putserv "notice $nick :$opc_knick is not on $chan"
    putlog "#$nick# failed kickban $opc_knick on $chan"
    return 0
  }
  if {$opc_kreason == ""} {
    set opc_uhost [getchanhost $opc_knick $chan]
    set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
    set opc_bmask "*!*[string trimleft $opc_tmask *!]"
    putserv "mode $chan +b $opc_bmask"
    putserv "kick $chan $opc_knick :Requested by $nick"
    putlog "#$nick# kickban $opc_knick on $chan"
    return 0
  }
  set opc_uhost [getchanhost $opc_knick $chan]
  set opc_tmask "*!*[string trimleft [maskhost $opc_uhost] *!]"
  set opc_bmask "*!*[string trimleft $opc_tmask *!]"
  putserv "mode $chan +b $opc_bmask"
  putserv "kick $chan $opc_knick :$opc_kreason"
  putlog "#$nick# kickban $opc_knick with reason $opc_kreason"
}
bind pub o|o !+ban pub_+ban
proc pub_+ban {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_bmask [lindex $txt 0]
  set opc_breason [lrange $txt 1 end]
  if {$opc_breason == ""} {
    newban $opc_bmask $hand "Requested by $nick ($hand)"
    putserv "privmsg $chan :Added $opc_bmask to bot bans list"
    putlog "#$nick# banned $opc_bmask on $chan"
    return 0
  }
  newban $opc_bmask $hand $opc_breason
  putserv "privmsg $chan :Added $opc_bmask to bot bans list with reason $opc_breason"
  putlog "#$nick# banned $opc_bmask on $chan with reason $opc_breason"
}
bind pub o|o !-ban pub_-ban
proc pub_-ban {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putserv "privmsg $chan :Removing $txt from bot global ban list..."
  killban $txt
  putlog "#$nick# removing $txt on $chan"
}
bind pub o|o !bans pub_bans
proc pub_bans {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putlog "#$nick#, използва !bans в $chan"
  putserv "notice $nick :Listing bans..."
  foreach opc_tmpban [banlist] {
    putserv "notice $nick :$opc_tmpban"
  }
  putserv "notice $nick :End of bans list"
}
bind pub o|o !ub pub_unban
proc pub_unban {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putserv "MODE $chan -b $txt"
  putlog "#$nick# unban $txt on $chan"
}
bind pub o|o !stats pub_status
proc pub_status {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  global server botname version
  putlog "#$nick#, !status on $chan"
  putserv "notice $nick :\002Bot statistics:\002" 
  putserv "notice $nick :Брой потребители: [countusers]"
  putserv "notice $nick :Канали: [channels]"
  putserv "notice $nick :Линкнати ботове: [bots]"
  putserv "notice $nick :Операционна с-ма: [unames]"
  putserv "notice $nick :Сървър: $server"
  putserv "notice $nick :Хост: $botname"
  putserv "notice $nick :Версия: [lindex $version 0]"
}
#########################################
# Команди за потребителите с флагове +m #
#########################################
bind pub m|m !+bot pub_+bot
proc pub_+bot {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_bothand [lindex $txt 0]
  set opc_bothost [lindex $txt 1]
  if {[llenght $txt] < 1} { 
    putserv "notice $nick :Error! Syntax: !+bot <handle> <address:port>"
    putlog "#$nick# failed !+bot $txt on $chan"
    return 0
  }
  if {[llength [split [lindex $txt 1] ":"]]!=2} {
    notice $nick "Usage: !+bot <handle> <address:port>"
    putlog "#$nick# failed !+bot $txt on $chan"
    return 0
  }
  set opc_err [addbot $opc_bothand $opc_bothost]
  if {$opc_err == 0} {
    putserv "notice $nick :This bot already exists!"
    putlog "#$nick# failed !+bot $opc_bothand $opc_bothost on $chan"
    return 0
  }
  putserv "privmsg $chan :Added $opc_bothand with address:port $opc_bothost"
  putlog "#$nick# added $txt on $chan"
}
bind pub m|m !-bot pub_-bot
proc pub_-bot {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {[islinked $txt]} {
    unlink $txt
    putserv "notice $nick :Unlinked $txt..."
  }
  deluser $txt
  putserv "privmsg $chan :Removed $txt from botlist"
  putlog "#$nick# removing $txt on $chan"
}
bind pub m|m !link pub_link
proc pub_link {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_err [link $txt]
  putserv "notice $nick :Trying to link to $txt..."
  if {!opc_err == 0} {
    putserv "notice $nick :Error! Can't link to $txt"
    putlog "#$nick# failed !link $txt on $chan"
    return 0
  }
  if {opc_err == 1} { 
    putserv "notice $nick :Successful link to $txt" 
    putlog "#$nick# link $txt"
  }
}
bind pub m|m !unlink pub_unlink
proc pub_unlink {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_err [unlink $txt]
  putserv "notice $nick :Trying to unlink from $txt..."
  if {$opc_err == 0} { 
    putserv "notice $nick :Error! Can't unlink from $txt"
    putlog "#$nick# failed unlink $txt on $chan"
  }
  if {$opc_err == 1} { 
    putserv "notice $nick :Unlinked from $txt successfull!"
    putlog "#$nick# unlink $txt on $chan"
  }
}
bind pub m|m !+host pub_+host
proc pub_+host {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_user [lindex $txt 0]
  set opc_host [lindex $txt 1]
  if {$opc_host == ""} {
    setuser $hand HOSTS $opc_host
    putserv "privmsg $chan :Added $opc_user to your hosts list."
    putlog "#$nick# addhost $opc_user on $chan"
    return 0
  }
  if {![validuser $opc_user]} {
    putserv "notice $nick :Error! User $opc_user doesn't exists"
    putlog "#$nick# failed addhost $opc_user $opc_host on $chan"
    return 0
  }
  setuser $opc_user HOSTS $opc_host
  putserv "privmsg $chan :Added $opc_host to $opc_user hosts"
  putlog "#$nick# addhost $opc_host to $opc_user on $chan"
}
bind pub m|m !-host pub_-host
proc pub_-host {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_user [lindex $txt 0]
  set opc_host [lindex $txt 1]
  if {$opc_host == ""} {
    delhost $hand $opc_host
    putserv "privmsg $chan :Removed $opc_user from your hosts."
    putlog "#$nick# !-host $opc_user on $chan"
    return 0
  }
  if {![validuser $opc_user]} {
    putserv "notice $nick :Error! User $opc_user doesn't exists"
    putlog "#$nick# failed !-host $opc_user $opc_host on $chan"
    return 0
  }
  delhost $opc_user $opc_host
  putserv "privmsg $chan :Removed $opc_host from $opc_user hosts"
  putlog "#$nick# !-host $opc_user $opc_host on $chan"
}
bind pub m|m !cb pub_clearbans
proc pub_clearbans {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putserv "privmsg $chan :Reseting bans on $chan..."
  putlog "#$nick# !cb on $chan"
  resetbans $chan
}
bind pub N|N !+user pub_+user
proc pub_+user {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  global botnick admin
  if {[llength $txt] < 0} {
    putserv "notice $nick :Error! Syntax: !+user <nick> [hostmask]"
    putlog "#$nick# failed !+user $txt on $chan"
    return 0
  }
  set opc_anick [lindex $txt 0]
  set opc_ahost [lindex $txt 1]
  if {$opc_ahost == ""} {
    adduser $opc_anick $opc_anick!*@*
    setuser $opc_anick xtra Added "by $hand as $opc_anick ([strftime %Y-%m-%d@%H:%M])"
    putserv "privmsg $chan :Added $opc_anick with hostmask $opc_anick!*@* with flags +fhlop"
    chattr $opc_anick +fhlop
    putlog "#$nick# !+user $opc_anick on $chan"
  }    
  if {$opc_ahost != ""} {
    adduser $opc_anick $opc_ahost
    setuser $opc_anick xtra Added "by $hand as $opc_anick ([strftime %Y-%m-%d@%H:%M])"
    putserv "privmsg $chan :Added $opc_anick with hostmask $opc_ahost with flags +fhlop"
    chattr $opc_anick +fhlop
    putlog "#$nick# !+user $opc_anick $opc_ahost on $chan"
  }
}
bind pub N|N !-user pub_-user
proc pub_-user {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {[llength $txt] < 0} {
    putserv "notice $nick :Error! Syntax: !-user <handle>"
    putlog "#$nick# failed !-user on $chan"
    return 0
  }
  set opc_anick [lindex $txt 0]
  set opc_err [deluser $opc_anick]
  if {$opc_err == 0} {
    putserv "notice $nick :Failed removing $opc_anick ."
    putlog "#$nick# failed !-user $opc_anick on $chan"
    return 0
  }
  putserv "privmsg $chan :Removed $opc_anick successfull!"
  putlog "#$nick# !-user $opc_anick on $chan"
}
bind pub N|N !save pub_save
proc pub_save {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putserv "privmsg $chan :Saving Channel file and User file..."
  putlog "#$nick# !save on $chan"
  save
}
bind pub N|N !+ignore pub_+ignore
proc pub_+ignore {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_ihost [lindex $txt 0]
  newignore $opc_ihost $hand Lame!
  putserv "privmsg $chan :Added $opc_ihost to ignorelist"
  putlog "#$nick# !+ignore $opc_ihost on $chan"
}
bind pub N|N !-ignore pub_-ignore
proc pub_-ignore {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {![isignore $txt]} {
    putserv "notice $nick :The hostmask $txt doesn't exists in my ignores"
    putlog "#$nick# failed !-ignore $txt on $chan"
    return 0
  }
  killignore $txt
  putserv "privmsg $chan :Removed $txt from ignorelist"
  putlog "#$nick# !-ignore $txt on $chan"
}
bind pub N|N !ignores pub_ignores
proc pub_ignores {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putlog "\-=|$nick|=- \ #($chan)# !ignores"
  putserv "notice $nick :Listing ignores..."
  foreach opc_lig [ignorelist] {
    putserv "notice $nick $opc_lig"
  }
  putserv "notice $nick :End of ignores."
}
bind pub N|N !mode pub_mode
proc pub_mode {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putserv "mode $chan $txt"
  putlog "#$nick# !mode $txt on $chan"
}
bind pub N|N !addop pub_addop
proc pub_addop {nick uhost hand chan usr} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  global botnick
  adduser $usr $usr!*@*
  chattr $usr +fhop
  setuser $usr xtra Added "by $hand as $usr ([strftime %Y-%m-%d@%H:%M])"
  putserv "privmsg $chan :Added $usr with flags +fhop"
  putlog "#$nick# !addop $usr on $chan"
}
##############################################
# Команди, достъпни до потребители с флаг +N #
##############################################
bind pub N|N !chattr pub_chattr
proc pub_chattr {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_auser [lindex $txt 0]
  set opc_aflags [lindex $txt 1]
  set opc_err [validuser $opc_auser]
  if {!$opc_err} { 
    putserv "notice $nick :Error: User $opc_auser was not found on my userlist"
    putlog "#$nick# failed !chattr $opc_auser on $chan"
    return 0 
  }
  chattr $opc_auser $opc_aflags
  putserv "privmsg $chan :Global flags for $opc_auser are now: [chattr $opc_auser]"
  putlog "#$nick# !chattr $opc_auser $opc_aflags on $chan"
}
bind pub N|N !rehash pub_rehash
proc pub_rehash {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putserv "privmsg $chan :Rehashing..."
  putlog "#$nick#!rehash on $chan"
  rehash
}
bind pub N|N !restart pub_restart
proc pub_restart {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putlog "#$nick# !restart on $chan"
  restart
}
bind pub N|N !+chan pub_+chan
proc pub_+chan {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {[validchan $txt] == 1} {
    putserv "notice $nick :This channel already exists!"
    putlog "#$nick# failed !+chan $txt on $chan"
    return 0
  }
  channel add $txt {+greet -bitch -autoop -bitch -stopnethack -revenge +shared +dontkickops}
  putserv "privmsg $chan :Added channel $txt ...joining"
  putlog "#$nick# !+chan $txt on $chan"
}
bind pub N|N !-chan pub_-chan
proc pub_-chan {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  if {[validchan $txt] == 0} {
    putserv "notice $nick :The channel $txt is not on my channels list"
    putlog "#$nick# failed !-chan $txt on $chan"
    return 0
  }
  channel remove $chan
  putserv "privmsg $chan :Channel $txt removed from channels list"
  putlog "#$nick# !-chan $txt on $chan"
}
bind pub N|N !chanset pub_chanset
proc pub_chanset {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  channel set $chan $txt
  putserv "privmsg $chan :Options for channel $chan has been changed ($txt)"
  putlog "#$nick# !chanset $chan $txt on $chan"
}
####################################
# Команди за които е нужен флаг +p #
####################################
bind pub P|P !bots pub_bots
proc pub_bots {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putlog "#$nick# !bots on $chan"
  putserv "notice $nick :Bots: [bots]"
}
bind pub P|P !topic pub_topic
proc pub_topic {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  putserv "topic $chan :$txt"
  putlog "#$nick# !topic $txt on $chan"
}

bind pub P|P !notes pub_notes
proc pub_notes {nick uhost hand chan txt} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set opc_cmd [lindex $txt 0]
  if {$opc_cmd == ""} {
    putserv "notice $nick :Error! Syntax: !notes <read/send/del>"
    putlog "#$nick# failed !notes $txt on $chan"
    return 0
  }
  if {$opc_cmd == "read"} {
    if {[notes $hand -] == 0} {
      putserv "notice $nick :You have no messages."
      return 0
    }
    putserv "notice $nick :Listing notes..."
    putlog "#$nick# !notes read on $chan"
    putserv "privmsg $nick :Notes:"
    foreach ntc [notes $hand -] {
      putserv "privmsg $nick :from [lindex $ntc 0] - \[\002[strftime "%b %d %H:%M" [lindex $ntc 1]]\002]\ [lrange $ntc 2 end]"
    }
    putserv "privmsg $nick :End of notes"  
  }
  if {$opc_cmd == "send"} {
    set ntc_to [lindex $txt 1]
    set ntc_text [lrange $txt 2 end]
    if {![validuser $ntc_to]} {
      putserv "notice $nick :Error: $ntc_to does not exists in my userlist"
      putlog "#$nick# failed !notes send $ntc_to on $chan"
      return 0
    }
    sendnote $hand $ntc_to $ntc_text
    putserv "notice $nick :Note sent to $ntc_to success!"
    putlog "#$nick# !notes send $ntc_to on $chan"
  }
  if {$opc_cmd == "del"} {
    erasenotes $hand -
    putserv "notice $nick :All notes deleted!"
    putlog "#$nick# !notes del on $chan"
  }
}
bind pub P|P !fnote opc_fnote
proc opc_fnote {nick uhost hand chan arg} {
 if {(![login:check $hand])} {puthelp "notice $nick :Ne ste lognat, za tova napishete /msg $::botnick login <vashata parola>";return 0}
  set to_flag [lindex $arg 0]
  set message [lrange $arg 1 end]
  set sentnotes 0
  if {$to_flag == "" || $message == ""} {
    putserv "notice $nick :Error! syntax: .fnote <flag> <message>"
    return 0
  }
  putserv "notice $nick :Sending notes users with flag $to_flag ..."
  foreach user [userlist] {
    if {![matchattr $user b] && $user != $hand} {
      if {[matchattr $user $to_flag]} {
        sendnote $hand $user "\002($to_flag)\002 $message"
        incr sentnotes
      }
    }
  }
  putserv "notice $nick : $sentnotes notes send to all users with flag $to_flag"
}
putlog "Инсталиран: Opcontrol.tcl"