########################################################################
#     nomodes.tcl - {[fully modified by demon]} (demon@freebg.tk)     #
#                 (Tested on eggdrop1.6.19 DALnet)                     #
########################################################################
#                                                                      #
#  Tova tcl e pisano ot Polat Chakarov a.k.v demon mail:demon@freebg.tk#
#  Ako Imate Problemi pishete mi :)                                    #
########################################################################

#------------------#
# Code begins here #
#------------------#

bind raw - MODE newmode_on
proc newmode_on { from key args } {
global botnick
set args [lindex $args 0]
set mode_chan [lindex $args 0]
set the_mode [lindex $args 1]
set mode_args [lindex $args 2]
scan $from "%\[^!]@%s" unick uhost
set who_user [finduser $from]
if {$who_user == $botnick} {return 0}
if {$the_mode == "+e"} {
if { [matchattr $who_user m|m $mode_chan] } {return 0}
putquick "MODE $mode_chan -e $mode_args"
putquick "MODE $mode_chan -o $unick"
putquick "KICK $mode_chan $unick :you can't do that"
putquick "MODE $mode_chan +b $unick" 
adduser $unick $unick!*@*
chattr $unick -foptjxh+d
}
if {$the_mode == "+b"} {
if { [matchattr $who_user X|X $mode_chan] } {return 0}
putquick "MODE $mode_chan -b $mode_args"
putquick "MODE $mode_chan -o $unick"
putquick "KICK $mode_chan $unick :...and jackass of the week award goes to $unick"
putquick "MODE $mode_chan +b $unick"
}
if {$the_mode == "+S"} {
if { [matchattr $who_user X|X $mode_chan] } {return 0}
putquick "MODE $mode_chan -S $mode_args"
putquick "MODE $mode_chan -o $unick"
putquick "KICK $mode_chan $unick :Zabranen Mod!!! $unick"
putquick "MODE $mode_chan +b $unick"
putquick "privmsg chanserv@services.dal.net :aop $mode_chan del $unick"
putquick "privmsg chanserv@services.dal.net :akick $mode_chan add $unick" 
putserv "PRIVMSG $unick :Ari Ve Seriozno Li Iskash Toq Mod ???EEE Nesi POZNAL :)"
adduser $unick $unick!*@*
chattr $unick -fptjxho+dk
}
if {$the_mode == "+H"} {
if { [matchattr $who_user X|X $mode_chan] } {return 0}
putquick "MODE $mode_chan -H $mode_args"
putquick "MODE $mode_chan -o $unick"
putquick "KICK $mode_chan $unick :Zabranen Mod!!! $unick"
putquick "MODE $mode_chan +b $unick"
putserv "PRIVMSG $unick :Ari Ve Seriozno Li Iskash Toq Mod ???EEE Nesi POZNAL :)"
adduser $unick $unick!*@*
chattr $unick -fptjxho+dk
}

if {$the_mode == "+N"} {
if { [matchattr $who_user X|X $mode_chan] } {return 0}
putquick "MODE $mode_chan -N $mode_args"
putquick "MODE $mode_chan -o $unick"
putquick "KICK $mode_chan $unick :Zabranen Mod!!! $unick"
putquick "MODE $mode_chan +b $unick"
putserv "PRIVMSG $unick :Ari Ve Seriozno Li Iskash Toq Mod ???EEE Nesi POZNAL :)"
adduser $unick $unick!*@*
chattr $unick -fptjxho+dk
}
if {$the_mode == "+A"} {
if { [matchattr $who_user X|X $mode_chan] } {return 0}
putquick "MODE $mode_chan -A $mode_args"
putquick "MODE $mode_chan -o $unick"
putquick "KICK $mode_chan $unick :Zabranen Mod!!! $unick"
putquick "MODE $mode_chan +b $unick"
putserv "PRIVMSG $unick :Ari Ve Seriozno Li Iskash Toq Mod ???EEE Nesi POZNAL :)"
adduser $unick $unick!*@*
chattr $unick -fptjxhmo+d
}
if {$the_mode == "+i"} {
if { [matchattr $who_user X|X $mode_chan] } {return 0}
putquick "MODE $mode_chan -i $mode_args"
putquick "MODE $mode_chan -o $unick"
putquick "KICK $mode_chan $unick :Zabranen Mod!!! $unick"
putquick "MODE $mode_chan +b $unick"
putquick "privmsg chanserv@services.dal.net :aop $mode_chan del $unick"
putquick "privmsg chanserv@services.dal.net :akick $mode_chan add $unick" 
putserv "PRIVMSG $unick :Ari Ve Seriozno Li Iskash Toq Mod ???EEE Nesi POZNAL :)"
adduser $unick $unick!*@*
chattr $unick -fptjxho+dk
}
if {$the_mode == "+l"} {
if { [matchattr $who_user X|X $mode_chan] } {return 0}
putquick "MODE $mode_chan -l $mode_args"
putquick "MODE $mode_chan -o $unick"
putquick "KICK $mode_chan $unick :Zabranen Mod!!! $unick"
putquick "MODE $mode_chan +b $unick"
putquick "privmsg chanserv@services.dal.net :aop $mode_chan del $unick"
putquick "privmsg chanserv@services.dal.net :akick $mode_chan add $unick" 
putserv "PRIVMSG $unick :Ari Ve Seriozno Li Iskash Toq Mod ???EEE Nesi POZNAL :)"
adduser $unick $unick!*@*
chattr $unick -fptjxho+dk
}
if {$the_mode == "+rq"} {
if { [matchattr $who_user X|X $mode_chan] } {return 0}
putquick "MODE $mode_chan -rq $mode_args"
putquick "MODE $mode_chan -o $unick"
putquick "KICK $mode_chan $unick :Zabranen Mod!!! $unick"
putquick "MODE $mode_chan +b $unick"
putquick "privmsg chanserv@services.dal.net :aop $mode_chan del $unick"
putquick "privmsg chanserv@services.dal.net :akick $mode_chan add $unick" 
putserv "PRIVMSG $unick :Ari Ve Seriozno Li Iskash Toq Mod ???EEE Nesi POZNAL :)"
adduser $unick $unick!*@*
chattr $unick -fptjxho+dk
}

}

#-----#
# End #
#-----#

putlog "nomodes.tcl modified by demon loaded"
