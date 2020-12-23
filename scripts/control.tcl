set r_chan "#ruse"
set r_time 60
# duration of ban, 0 for perm, in minutes
##########################################

bind pub o|o @ pub_op
bind pub o|o !op pub_op
bind pub o|o -@ pub_deop
bind pub o|o !deop pub_deop
bind pub o|o !dop pub_deop
bind pub o|o + pub_voice
bind pub o|o !v pub_voice
bind pub o|o !voice pub_voice
bind pub o|o - pub_devoice
bind pub o|o !-v pub_devoice
bind pub o|o !dev pub_devoice
bind pub o|o !dv pub_devoice
bind pub o|o !devoice pub_devoice

########################################
########################################
proc pub_op {nick uhost hand chan txt} {
  if {$txt == ""} {
    putserv "mode $chan +o $nick"
    putlog "#$nick#, !op on $chan"
    return 0
  }
}
proc pub_deop {nick uhost hand chan txt} {
  if {$txt == ""} {
    putserv "mode $chan -o $nick"
    putlog "#$nick# -@ on $chan"
    return 0
  }
}

proc pub_voice {nick uhost hand chan txt} {
  if {$txt == ""} {
    putserv "mode $chan +v $nick"
    putlog "#$nick# !v on $chan"
    return 0
  }
}

proc pub_devoice {nick uhost hand chan txt} {
  if {$txt == ""} {
    putserv "mode $chan -v $nick"
    putlog "#$nick# !-v on $chan"
    return 0
  }
}

#################################################
#################################################
bind pub n|n !del pub_-host
bind pub n|n !add pub_+host
#################################################
proc pub_+host {nick uhost hand chan txt} {
  set opc_user [lindex $txt 0]
  if {$opc_user != ""} {
    setuser Users HOSTS $opc_user
    putserv "privmsg $chan :Добавен е $opc_user в потребителите"
    putlog "#$nick# !add $opc_user в потребителите"
    return 0
  }
  if {![validuser $opc_user]} {
    putserv "notice $nick :Грешка! Потребител $opc_user не съществъва"
    putlog "#$nick# грешка при !add Users $opc_host"
    return 0
  }
}

proc pub_-host {nick uhost hand chan txt} {
  set opc_user [lindex $txt 0]
  if {$opc_user != ""} {
    delhost Users $opc_user
    putserv "privmsg $chan :Премахнат е $opc_user от потребителите"
    putlog "#$nick# !del $opc_user от потребителите"
    return 0
  }
  if {![validuser $opc_user]} {
    putserv "notice $nick :Грешка! Потребител $opc_user не съществъва"
    putlog "#$nick# грешка при !del Users $opc_host"
    return 0
  }
}
#####################################################
#####################################################
####################################
#  Values to modify
###################################

###################################
#  You may not modify it
##################################

bind join -|- * out

proc out { nick uhost hand chan } {
	global r_time r_chan
	 if {[matchattr $hand U] } {
		putquick "notice $nick :Vie ste addnat v bota. Za op napishete 15!op, za voice 15!voice"
	}
}
putlog "Инсталиран: Control.tcl"