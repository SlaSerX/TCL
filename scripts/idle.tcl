###############################################################################################
#	Име на скрипта : AntiIdleOpVoice.tcl			                              #
#	Oписание       : Деопва и девойсва всички оператори с определен айдъл в канала.       #
# Автор              : EsCaPeR (#mIRCInfo@UniBG)                                              #
# Дата на написване  : 13 октомври  2007						      #    																						  #                            																				#
# Version     : Final                            		       			      #
###############################################################################################



set list_of_chans "#ruse"


global botnick username

# interval in minutes between checks.
set check_interval  5  

# allowed time in minutes for an op to be idle.
set op_allowed_time 60	

# allowed time in minutes for a voiced user to be idle.
set vo_allowed_time 60

# nicks to be exempted from Deop/devoice
set exclude_nicks "1;2;3;4;"

set exclude_nicks [string tolower $exclude_nicks]

proc inactive_checker { chan } {
	global exclude_nicks op_allowed_time  vo_allowed_time  botnick
	if {![botisop $chan]} { return 0 } 
	foreach user [chanlist $chan] { 
	set user [string tolower $user]
  
   	if {![string match "*$user;*" $exclude_nicks] && ![matchattr [nick2hand $user $chan] I]  } {
			if {[isvoice $user $chan] && ![onchansplit $user $chan] && ($user != $botnick) && ([getchanidle $user $chan] >= $vo_allowed_time)} {
 				putquick "mode $chan -v $user"
				putlog "**> Махам войса на $user, защото не е писал от $vo_allowed_time минути"
				putquick "NOTICE $user :You have been $vo_allowed_time minutes voice idle (+v)"
 			} 
 			if {[isop $user $chan] && ![onchansplit $user $chan] &&  ([getchanidle $user $chan] >= $op_allowed_time)} {
 					putquick "mode $chan -o $user"
					putlog "**> Махам опа на $user, защото не е писал от $op_allowed_time минути"
					putquick "NOTICE $user :You have been $op_allowed_time minutes op idle (+o)"
 			}
		} 
	}
}

proc run_checking_timer { } {
	global list_of_chans check_interval 

	foreach check_chan [split $list_of_chans] {
		inactive_checker $check_chan
	}
	timer $check_interval run_checking_timer
}

timer $check_interval run_checking_timer

putlog "Инсталиран: idle.tcl"