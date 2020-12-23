#################################
# Perfect Protection system     #
# Contact me: paco@unix-bg.org  #
# Copy right 2008 - 2009        #
#################################

########################
# Start Ban Protection # - Protected users -> owners & bots
########################

bind mode - *+b* e:bprot 
proc e:bprot {n u h c m w} {
	if {[matchattr $h P] || [matchattr $h b]} return
	if {[string match "$w" "$::botname"]} {
        putquick "CS :acc $c del $n"
		putquick "CS :clear $c all"
		putquick "CS :op"
		if {[validuser [nick2hand $n]]} {
        setuser [nick2hand $n] COMMENT "Protection System:Banned me at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
		putlog "Protection System: $n!$u Ban me ($w) in $c"
		 } else {
		adduser $n [maskhost $u]
        setuser [nick2hand $n] COMMENT "Protection System:Banned me at [ctime [unixtime]]"		
        chattr [nick2hand $n] +dk|+dk $c
		putlog "Protection System: $n!$u Ban me ($w) in $c"		
		 }
		}
#	set prlist [chanlist $c P]
#	foreach pr $prlist {
#	if {[string match "$w" "$pr![getchanhost $pr $c]"]} {
#        putquick "CS :acc $c del $n"
#		putquick "CS :clear $c all"
#		putquick "CS :op"
#		if {[validuser [nick2hand $n]]} {
#       setuser [nick2hand $n] COMMENT "Protection System:Banned protect user $pr at [ctime [unixtime]]"
#       chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
#		putlog "Protection System: $n!$u Ban $pr ($w) in $c"
#		 } else {
#		adduser $n [maskhost $u]
#       setuser [nick2hand $n] COMMENT "Protection System:Banned protect user $pr at [ctime [unixtime]]"
#       chattr [nick2hand $n] +dk|+dk $c
#		putlog "Protection System: $n!$u Ban protect user $pr ($w) in $c"		
#		 }
#	   }
#	}
	set prlst [chanlist $c b]
	foreach pr $prlst {
	if {[string match "$w" "$pr![getchanhost $pr $c]"]} {
        putquick "CS :acc $c del $n"
		putquick "CS :clear $c all"
		putquick "CS :op"
		if {[validuser [nick2hand $n]]} {
        setuser [nick2hand $n] COMMENT "Protection System:Banned owner $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
		putlog "Protection System: $n!$u Ban owner $pr ($w) in $c"
		 } else {
		adduser $n [maskhost $u]
        setuser [nick2hand $n] COMMENT "Protection System:Banned bot $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk|+dk $c
		putlog "Protection System: $n!$u Ban bot $pr ($w) in $c"		
		 }
		}
	}
	set prl1st [chanlist $c n]
	foreach pr $prl1st {
	if {[string match "$w" "$pr![getchanhost $pr $c]"]} {
        putquick "CS :acc $c del $n"
		putquick "CS :clear $c all"
		putquick "CS :op"
		if {[validuser [nick2hand $n]]} {
        setuser [nick2hand $n] COMMENT "Protection System:Banned owner $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
		putlog "Protection System: $n!$u Ban owner $pr ($w) in $c"
		 } else {
		adduser $n [maskhost $u]
        setuser [nick2hand $n] COMMENT "Protection System:Banned owner $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk|+dk $c
		putlog "Protection System: $n!$u Ban owner $pr ($w) in $c"		
		 }
		}
	}
}

#########################
# Start Kick Protection # - Protected users -> owners & bots
#########################

bind kick - * e:kprot 
proc e:kprot {n u h c w r} {
	if {[matchattr $h P] || [matchattr $h b]} return
	if {$w == $::botnick} {
        putquick "CS :acc $c del $n"
        putquick "CS :clear $c all"
		putquick "CS :op"
		if {[validuser [nick2hand $n]]} {
        setuser [nick2hand $n] COMMENT "Protection System:Kicked me at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
		putlog "Protection System: $n!$u Kicked me ($w) in $c"
		 } else {
		adduser $n [maskhost $u]
        setuser [nick2hand $n] COMMENT "Protection System:Kicked me at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk|+dk $c
		putlog "Protection System: $n!$u Kicked me ($w) in $c"		
		 }
		}
#	set prlist [chanlist $c P]
#	foreach pr $prlist {
#	if {$w == $pr} {
#        putquick "CS :acc $c del $n"
#        putquick "CS :op"
#		 putquick "MODE $c +o $pr"
#        if {[validuser [nick2hand $n]]} {
#        setuser [nick2hand $n] COMMENT "Protection System:Kicked protect user $pr at [ctime [unixtime]]"
#        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
#		 putlog "Protection System: $n!$u Kicked protect user $pr ($w) in $c"
#		 } else {
#		 adduser $n [maskhost $u]
#        setuser [nick2hand $n] COMMENT "Protection System:Kicked protect user $pr [ctime [unixtime]]"
#        chattr [nick2hand $n] +dk|+dk $c
#		 putlog "Protection System: $n!$u Kicked protect user $pr ($w) in $c"		
#		 }
#     }
#	}
    set prlst [chanlist $c b]
    foreach pr $prlst {
    if {[string match "$w" "$pr![getchanhost $pr $c]"]} {
        putquick "CS :acc $c del $n"
		putquick "CS :clear $c all"
        putquick "CS :op"
		putquick "MODE $c +o $pr"
        if {[validuser [nick2hand $n]]} {
        setuser [nick2hand $n] COMMENT "Protection System:Kicked bot $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
		putlog "Protection System: $n!$u Kicked bot $pr ($w) in $c"
		 } else {
		adduser $n [maskhost $u]
        setuser [nick2hand $n] COMMENT "Protection System:Kicked bot $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk|+dk $c
		putlog "Protection System: $n!$u Kicked bot $pr ($w) in $c"		
		 }
     }
   }
    set prl1st [chanlist $c n]
    foreach pr $prl1st {
    if {[string match "$w" "$pr![getchanhost $pr $c]"]} {
        putquick "CS :acc $c del $n"
		putquick "CS :clear $c all"
        putquick "CS :op"
		putquick "MODE $c +o $pr"
        if {[validuser [nick2hand $n]]} {
        setuser [nick2hand $n] COMMENT "Protection System:Kicked owner $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
		putlog "Protection System: $n!$u Kicked owner $pr ($w) in $c"
		 } else {
		adduser $n [maskhost $u]
        setuser [nick2hand $n] COMMENT "Protection System:Kicked owner $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk|+dk $c
		putlog "Protection System: $n!$u Kicked owner $pr ($w) in $c"		
		 }
     }
   }
}
#########################
# Start Deop Protection # - Protected users -> owners & bots
#########################

bind mode - *-o* e:dprot 
proc e:dprot {n u h c m w} {
	if {[matchattr $h P] || [matchattr $h b]} return
	if {$w == $::botnick} {
        putquick "CS :acc $c del $n"	
		putquick "CS :clear $c all"
		putquick "CS :op $c"
        if {[validuser [nick2hand $n]]} {
        setuser [nick2hand $n] COMMENT "Protection System:Deoped me at [ctime [unixtime]]"		
        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
		putlog "Protection System: $n!$u Deoped me ($w) in $c"
		 } else {
		adduser $n [maskhost $u]
        setuser [nick2hand $n] COMMENT "Protection System:Deoped me at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk|+dk $c
		putlog "Protection System: $n!$u Deoped me ($w) in $c"		
		 }
    } 
#	set prlist [chanlist $c P]
#	foreach pr $prlist {
#	if {$w == $pr} {
#        putquick "CS :acc $c del $n"
#		putquick "CS :clear $c all"
#		putquick "CS :op $c"
#        if {[validuser [nick2hand $n]]} {
#        setuser [nick2hand $n] COMMENT "Protection System:Deoped preotect user $pr at [ctime [unixtime]]"
#        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
#		putlog "Protection System: $n!$u Deoped preotect user $pr ($w) in $c"
#		 } else {
#		adduser $n [maskhost $u]
#        setuser [nick2hand $n] COMMENT "Protection System:Deoped preotect user $pr at [ctime [unixtime]]"
#       chattr [nick2hand $n] +dk|+dk $c
#		putlog "Protection System: $n!$u Deoped preotect user $pr ($w) in $c"		
#		 }
#     }
#	}
    set prlst [chanlist $c b]
	foreach pr $prlst {
	if {$w == $pr} {
        putquick "CS :acc $c del $n"
		putquick "CS :clear $c all"
		putquick "CS :op $c"
        if {[validuser [nick2hand $n]]} {
        setuser [nick2hand $n] COMMENT "Protection System:Deoped bot $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
		putlog "Protection System: $n!$u Deoped bot $pr ($w) in $c"
		 } else {
		adduser $n [maskhost $u]
        setuser [nick2hand $n] COMMENT "Protection System:Deoped bot $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk|+dk $c
		putlog "Protection System: $n!$u Deoped bot $pr ($w) in $c"		
		 }
     }
	}
    set prl1st [chanlist $c n]
	foreach pr $prl1st {
	if {$w == $pr} {
		putquick "CS :clear $c all"
		putquick "CS :op"
        if {[validuser [nick2hand $n]]} {
        setuser [nick2hand $n] COMMENT "Protection System:Deoped owner $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk-fhjlmnoptwxzFGINO|+dk-fhjlmnoptwxzFGINO $c
		putlog "Protection System: $n!$u Deoped owner $pr ($w) in $c"
		 } else {
		adduser $n [maskhost $u]
		setuser [nick2hand $n] COMMENT "Protection System:Deoped owner $pr at [ctime [unixtime]]"
        chattr [nick2hand $n] +dk|+dk $c
		putlog "Protection System: $n!$u Deoped owner $pr ($w) in $c"		
		 }
     }
	}
}
############################################################################################
################################# End Bot & Owner Protection ###############################
############################################################################################


#bind notc - * notc:ban
#proc notc:ban {nick uhost hand chan args} {
#global botnick
#set reason "Notice is NOT Allowed HeRe!"
#set banmask "*!*@[lindex [split $uhost "@"] 1]"
#set time "60"
#if {[matchattr $hand f] || [matchattr $hand b] || $nick == $botnick} {return 0}	
#foreach c [channels] {
#putquick "KICK $c $nick :$reason"
#putquick "MODE $c +b $banmask"
#newchanban $c $banmask $botnick $reason $time
# }
#}
