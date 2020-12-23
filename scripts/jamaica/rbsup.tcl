# created by Yxaaaaaaa ( http://www.egghelp-bg.com/ )
# rbsup.tcl - identifikaciq v NS i support za 
# op, unban i invite ako imate predlojeniq moje da gi izprashtate
# na email Yxaaaaaaa@gmail.com ili na nashiq forum http://forums.egghelp-bg.com
#
# Chrez komandata .rbsup #kanal botyt shte se op/unban/invite v kanala
# s .rbsup #kanal off shte izkliuchite tezi ekstri

# tuk vuvedete vashata parola
set nsparola "k1k2k3"
set nsnick "NS"
set csnick "CS"
set nshost "NS!NickServ@UniBG.Services"
set cshost "CS!ChanServ@UniBG.services"

bind notc - * e:rbsup
proc e:rbsup {n u h t d} {
	if {([string tolower $n!$u] == [string tolower $::cshost]) && ([string match "You must be logged*" $t])} { identify  x}
	if {([string tolower $n!$u] == [string tolower $::nshost]) && ([string match "This nickname has kill protection*" $t])} { identify x}
	if {[string match "Login successful" $t]} { set ::identified id }
	if {[string match "Insufficient access on*" $t]} { set ::notadded([lindex $t 3]) x; timer 10 [list unset ::notadded([lindex $t 3])]
	putlog "No acces to [lindex $t 3]"
	}
}

bind dcc n rbsup e:dccrbsup
proc e:dccrbsup {h i a} {
	set c [lindex $a 0]
	if {$c == ""} { putdcc $i "Please specify a channel";return }
	if {![validchan $c]} {putdcc $i "That channel doesnt't exist!"; return}
	if {[string tolower [lindex $a 1]] == "off"} {
		channel set $c need-op ""
		channel set $c need-unban ""
		channel set $c need-invite ""
		putdcc $i "rbsup is off"
	} {
		channel set $c need-op "rbsup_op $c"
        	channel set $c need-unban "rbsup_unban $c"
	        channel set $c need-invite "rbsup_inv $c"
		putdcc $i "rbsup successful setted to $c"
	}
}
bind evnt - init-server identify
proc identify {type} {
	if {[info exists ::identified]} {return}
	if {$::botnick != $::nick} {putserv "$::nsnick :regain $::nick $::nsparola"; putlog "regain";return}
	putserv "$::nsnick :id $::nsparola"
	putlog "Identifying"
	return
}
proc rbsup_op {c} {
	if {![info exists ::identified]} { identify x }
	if {[info exists ::notadded($c)]} { return }
	putserv "$::csnick :op $c"
	return
}
proc rbsup_unban {c} {
        if {![info exists ::identified]} { identify x }
        if {[info exists ::notadded($c)]} { return }
	putserv "$::csnick :unban $c"
	putserv "JOIN $c"
}
proc rbsup_inv {c} {
        if {![info exists ::identified]} { identify x }
        if {[info exists ::notadded($c)]} { return }
	putserv "$::csnick :invite $c"
}
#proverka za +r
bind raw - 477 e:rqclear
proc e:rqclear {a b c} {
	set c [lindex $c 1]
	if {![info exists ::identified]} { identify x }
        if {[info exists ::notadded($c)]} { return }
	putserv "CS :clearmodes $c"
	putserv "JOIN $c"	
}

#putlog "rbsup.tcl loaded , supported by http://www.egghelp-bg.com"
