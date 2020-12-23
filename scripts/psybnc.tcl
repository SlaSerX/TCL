#########################################################
#							#
#		Psybnc Proxy By Thule			#
# This tcl will let you to join by a psybnc and to set  #
# psy's parameters as pass - vhost or proxy - server    #
# and obtain some info as listserver by partyline.      #
# For info and suggests cmanzione@tin.it		#
#							#
# Ded to my love karma^@ircnet				#
#########################################################

bind dcc w|- psy dcc:bounce

set psynotice "*IRC Client did not support a password*"

bind raw -|- NOTICE psy_connect

set psystat "off"
set psyusername "username"
set psypass "pass"
set psyawaymsg "some st00pid away reason"
set psyvhost "some.c00l.31337.vhost"
set psyproxy ""
set psyaddserver "irc.server.com:6667"
set psydelserver ""
set psyrev ""
set psyrev1 "1.1"
set psyconf "$botnick.bounce"
 
proc psy_save {} {
    global psystat psyusername psypass psyawaymsg psyvhost psyaddserver psyrev psyconf psyproxy
    set fileid [open $psyconf w]
    puts $fileid "set psystat \"$psystat\""
    puts $fileid "set psyusername $psyusername"
    puts $fileid "set psypass $psypass"
    puts $fileid "set psyvhost $psyvhost"
    puts $fileid "set psyproxy $psyproxy"
    puts $fileid "set psyaddserver $psyaddserver"
    puts $fileid "set psyrev \"$psyrev\""
    close $fileid
}
if {![file exist $psyconf]} {
    set psyrev $psyrev1
    psy_save
    putlog "PsyProxy configuration file not found : generating defalut..."
}

source $psyconf

if {$psyrev1 != $psyrev} {
    set psyrev $psyrev1
    psy_save
}

proc dcc:bounce {hand idx arg} {
global psystat psyproxy psyusername psypass psyawaymsg psyvhost psyaddserver psydelserv psyrev psyconf owner
set command [string tolower [lindex $arg 0]]
set bounce $command
putcmdlog ""
if { $command == "" } {
	putdcc $idx "+-+------=\ .:PsyProxy Status:. /=----+>"
	putdcc $idx "+-+-=-=-+"
	putdcc $idx "| |-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+>"
	putdcc $idx "| | PsyProxy ver\t: $psyrev"
	putdcc $idx "| | PsyProxy is\t: $psystat"
	putdcc $idx "| | PsyProxy pass\t: $psypass"
	putdcc $idx "| | PsyProxy awaymsg\t: $psyawaymsg"
	putdcc $idx "| | PsyProxy vhost\t: $psyvhost"
	putdcc $idx "| | PsyProxy proxy\t: $psyproxy"
	putdcc $idx "| | PsyProxy username\t: $psyusername"
	putdcc $idx "| | PsyProxy server\t: $psyaddserver"
        putdcc $idx "+-+"
	putdcc $idx "| |-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+>"
	putdcc $idx "+-+------=\ .:PsyProxy Status:. /=----+>"
}
switch -exact $command {
	"on" {
	    if {$command == $psystat} {
		putdcc $idx "PsyProxy is already $command."
		return 0
	    }
	    set psystat "on"
	    putcmdlog "$hand has turn on..."
	    set bounce $command
	    if {$psystat != "off"} {
	    putdcc $idx "PsyProxy System enabled by $hand."
	    psy_connect
	    psy_save
	    }
	    if {$psypass == "h1tp4r4d3!"} {
		putdcc $idx "Now use '.psy pass <password>' to set the psypass password"
	    }
	}
	"off" {
	    if {$command == $psystat} {
		putdcc $idx "PsyProxy is already $command."
		return 0
	    }
	    set psystat "off"
	    putcmdlog "$hand has turn off"
	    set bounce $command
	    if {$psystat != "on"} {
	    putdcc $idx "PsyProxy System disabled by $hand."
	    psy_save
	    psy_stop
	    }
	}
	"pass" {
	    putcmdlog "$hand bounce pass \[something..\]"
	    if {$psypass == [lindex $arg 1]} {
		putdcc $idx "PsyProxy pass is already [lindex $arg 1]."
		return 0
	    }
	    set psypass [lindex $arg 1]
	    if {$psypass != ""} {
		putdcc $idx "PsyProxy pass set to $psypass."
		set psypass [encrypt $psypass $psypass]
		putdcc $idx "PsyProxy password set by $hand."
	    } else {
		putdcc $idx "PsyProxy pass removed."
		putdcc $idx "PsyProxy password disabled by $hand."
	    }
	    psy_save
	}
	"username" {
	    putcmdlog "$hand username..."
	    if {$psyusername == [lindex $arg 1]} {
		putdcc $idx "PsyProxy username is $psyusername."
		return 0
	    }
	    set psyusername [lindex $arg 1]
	    if {$psyusername != ""} {
		putdcc $idx "PsyProxy username set as $psyusername."
		putdcc $idx "PsyProxy username set by $hand."
		
	    } 
	    psy_save
	}
	"vhost" {
	    putcmdlog "$hand changes vhost..."
	    if {$psyvhost == [lindex $arg 1]} {
		putdcc $idx "PsyProxy vhost is $psyvhost."
		return 0
	    }
	    set psyvhost [lindex $arg 1]
	    if {$psyvhost != ""} {
		putdcc $idx "PsyProxy vhost set is $psyvhost."
		putdcc $idx "PsyProxy vhost set by $hand."
	        psy_vhost
	    } 
	    psy_save
	}
	"proxy" {
	    putcmdlog "$hand changes proxy..."
	    if {$psyproxy == [lindex $arg 1]} {
		putdcc $idx "PsyProxy proxy is $psyproxy."
		return 0
	    }
	    set psyproxy [lindex $arg 1]
	    if {$psyproxy != ""} {
		putdcc $idx "PsyProxy proxy set is $psyvhost."
		putdcc $idx "PsyProxy proxy set by $hand."
	        psy_proxy
	    } 
	    psy_save
	}
	
	"addserver" {
	    putcmdlog "$hand add server $psyaddserver"
	    if {$psyaddserver == [lindex $arg 1]} {
		putdcc $idx "The new server is $psyaddserver."
		return 0
	    }
	    set psyaddserver [lindex $arg 1]
	    if {$psyaddserver != ""} {
		putdcc $idx "PsyProxy server set to $psyaddserver."
		putdcc $idx "PsyProxy server set by $hand."
	        psy_server
	    } 
	    psy_save
	}
	
	"delserver" {
	    set psydelserv [lindex $arg 1]
	    if {$psydelserv == "" } {
		putdcc $idx "Number is not valid choice from 1-9."
		return 0
            }
	    set psydelserv [lindex $arg 1]
	    if {$psydelserv == "0" } {
		putdcc $idx "Number is not valid."
		return 0
	    }
	    if {$psydelserv == [lindex $arg 1]} {
		putcmdlog "$hand delete server..."	
		psy_delserver
	    }
	             }
	"awaymsg" {
	    putcmdlog "$hand awaymsg..."
	    if {$psyawaymsg == [lindex $arg 1]} {
		putdcc $idx "Bouncer awaymsg is $psyawaymsg."
		return 0
	    }
	    set psyvhost [lindex $arg 1]
	    if {$psyusername != ""} {
		putdcc $idx "PsyProxy awaymsg set is $psyawaymsg."
		putdcc $idx "PsyProxy awaymsg set by $hand."
	        putserv "setawaynick $botnick"
	    } 
	    psy_save
	}
	"ver" {
	    putcmdlog "$hand PsyProxy ver"
	    putdcc $idx "PsyProxy version $psy_rev1 by ThuLe."

	    }
	"listserver" {
	    putcmdlog "$hand request PsyProxy list."
	    psy_list
	    }
	 "help" {
	    putdcc $idx "+-+--------------------=\ .:PsyProxy HeLP:. /=---------------------+>"
	    putdcc $idx "+-+-=-=-=-=-+"
	    putdcc $idx "| |-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+>"
	    putdcc $idx "| |.Psy on		       - To set on the PsyProxy"
            putdcc $idx "| |.Psy off                   - To set off the PsyProxy"
	    putdcc $idx "| |.Psy pass pass             - To set the pass in the Psybnc"
	    putdcc $idx "| |.Psy addserver server:port - To set the server in the Psybnc"
	    putdcc $idx "| |.Psy listserver	       - To obtain the listservers on Psybnc"
	    putdcc $idx "| |.Psy vhost vhost.com       - To set the vhost in the Psybnc"
	    putdcc $idx "| |.Psy proxy ip:port         - To set the proxy in the Psybnc"
	    putdcc $idx "| |.Psy username RealName     - To set the RealName in the Psybnc"
	    putdcc $idx "| |.Psy ver		       - To show the version of PsyProxy"
	    putdcc $idx "| |-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+>"
	    putdcc $idx "+-+"
	    putdcc $idx "+-+--------------------=\ .:PsyProxy HeLP:. /=---------------------+>"
	    return 0	
         }
}
}


proc psy_connect {from key arg} { 
global psypass botnick psyusername psynotice
  if {[string match "*Your IRC Client did not support a password*" $arg]} {
	putserv "PASS $psypass" 
	putserv "setusername $psyusername"
  }
  if {[string match "*no server add*" $arg]} {
	psy_server
  }
} 

proc psy_vhost {} {
global psyvhost jump
	putserv "vhost $psyvhost"
	putserv "BCONNECT"
	putserv "JUMP"
}

proc psy_proxy {} {
global psyproxy jump
	putserv "proxy $psyproxy"
	putserv "BCONNECT"
	putserv "JUMP"
}

proc psy_stop {} {
     putserv "BQUIT"
     jump
     putdcc $idx "Out from Psybnc server."
}

proc psy_server {} {
global psyaddserver
	putserv "addserver [lindex [split $psyaddserver :] 0] :[lindex [split $psyaddserver :] 1]"
}

proc psy_list {} {
	putserv "LISTSERVERS"
}

proc psy_delserver {} {
global psydelserv
	putserv "delserver $psydelserv"
}
putlog "-ProxyPsyBnC by ThuLe fixed by IRCHelp.UniBG.Org Loaded"