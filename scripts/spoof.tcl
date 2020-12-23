# Warning! C-style comments (/* and */) in vhostfile might confuse this script

# Location ot ircd's vhosts.conf - bot must be on the same shell, or have access to it
set vhostfile "/home/teodor/ircd/etc/spoof2.conf"

# Location of bot's vhost data file - it will be created on first run
set vdbfile "/home/teodor/eggs/scripts/spoofs/vhdb.dat"

# Vhost database refresh period in minutes
set vdbupdateinterval 60

# Vhost expiry time in days
set vhostexptime 100

# List of addresses (divided by spaces) to which vhost expiry alerts are mailed
set vhostexpnotifyaddrlist "TeodOR@Sellinet.net"

# List of vhosts (divided by spaces) exempt from reporting
set vhostexplist ""

# Bot's oper nick & password
set opernick "tcm"
set operpass "tcm911"

# Bot's umodes, at least +c
set opermodes "csy"


### End of user specific settings ###

set vhtrackver "VHTrack 1.5s"
set vhostlist ""

if { ![file exists $vhostfile] } { die "[file tail [info script]]: cannot locate $vhostfile" }

proc vdbmain { } {
		  global vdbupdateinterval
		  putlog "Updating and saving vhost tracking database..."
		  vlistrefresh
		  vdbupdate
		  vhostcheck
		  timer $vdbupdateinterval vdbmain
		 }

proc vdbcreate { } {
		global vhostfile vhostlist
		set vhostlist [vhflparse]
		vdbupdate
	       }

proc vdbload { } {
	      global vdbfile vhostlist
	      if { [catch {set vdbload_vdbfile [open $vdbfile r]}] == 0 } {
		  set vhostlist ""
		  set vdbload_vdbline ""
		  while { [set vdbload_vdbline [gets $vdbload_vdbfile]] != "" } {
			 lappend vhostlist $vdbload_vdbline
			}
		  close $vdbload_vdbfile
		 } else {
		  filerrmsg $vdbfile reading
		 }
	     }

proc vhflparse { } {
		global vhostfile
		set vhflparse_vhostlist ""
		if { [catch {set vhflparse_vhostfile [open $vhostfile r]}] == 0 } {
		    set vhflparse_time [clock seconds]
		    while { ![eof $vhflparse_vhostfile] } {
			   set vhflparse_line [gets $vhflparse_vhostfile]
			   if { [regexp -nocase {^([\s\t]*)spoof([\s\t]*)=([\s\t]*)\"([\s\t]*)} $vhflparse_line] } {
			       lappend vhflparse_vhostlist "[lindex [split $vhflparse_line \"] 1] $vhflparse_time 0"
			      }
			  }
		    close $vhflparse_vhostfile
		   } else {
		    filerrmsg $vhostfile reading
		   }
		return $vhflparse_vhostlist
	       }


proc vdbupdate { } {
		global vdbfile vhostlist
		if { [catch {set vdbupdate_vhostfile [open $vdbfile w 0600]}] == 0 } {
		    set vdbupdate_con 0
		    set vhostlist [lsort -integer -index 1 $vhostlist]
		    while { $vdbupdate_con < [llength $vhostlist] } {
			   puts $vdbupdate_vhostfile [lindex $vhostlist $vdbupdate_con]
			   incr vdbupdate_con
			  }
		    close $vdbupdate_vhostfile
		   } else {
		    filerrmsg $vdbfile writing
		   }
	       }

proc vlistrefresh { } {
		   global vhostlist
		   set vlistrefresh_refreshedvhostlist ""
		   set vlistrefresh_con 0
		   if { [set vlistrefresh_vhostlist [vhflparse]] == "" } { return }
		   while { $vlistrefresh_con < [llength $vlistrefresh_vhostlist] } {
			  if { [set vlistrefresh_dbfoundnum [lsearch -regexp $vhostlist "^[lindex [split [lindex $vlistrefresh_vhostlist $vlistrefresh_con] \ ] 0]\[\ \]1"]] > -1 } {
			      lappend vlistrefresh_refreshedvhostlist [lindex $vhostlist $vlistrefresh_dbfoundnum]
			     } else {
			      lappend vlistrefresh_refreshedvhostlist [lindex $vlistrefresh_vhostlist $vlistrefresh_con]
			     }				
			  incr vlistrefresh_con
			 }
		   set vhostlist $vlistrefresh_refreshedvhostlist
		  }

proc vhostentry { vhostentry_host vhostentry_pad vhostentry_text } {
		 global vhostlist
		 if { [lindex [split $vhostentry_text \ ] 5] == "connecting:" && [llength [split $vhostentry_host @]] == 1 } {
		     set vhostentry_dbindex [lsearch -regexp $vhostlist "^[set vhostentry_cnhost [lindex [split [string trim [lindex [split $vhostentry_text \ ] 7] \)] @] 1]]\[\ \]1"]
		     if { $vhostentry_dbindex < 0 } {
			 lappend vhostlist "$vhostentry_cnhost [clock seconds] 1"
			} else {
			 set vhostlist [lreplace $vhostlist $vhostentry_dbindex $vhostentry_dbindex "$vhostentry_cnhost [clock seconds] [expr [lindex [split [lindex $vhostlist $vhostentry_dbindex] \ ] 2] + 1]"]
			}
		    }
		}

proc vhostcheck { } {
		 global vhostlist vhostexplist vhostexptime vhostexpnotifyaddrlist botnick server
		 set vhostcheck_exptime [expr [clock seconds] - $vhostexptime * 86400]
		 set vhostcheck_newexps ""
		 foreach vhostcheck_vhost $vhostlist {
			  if { [lindex [split $vhostcheck_vhost \ ] 1] < $vhostcheck_exptime && [lsearch -exact $vhostexplist $vhostcheck_vhost] == -1 } {
			      lappend vhostexplist $vhostcheck_vhost
			      set vhostcheck_newexps "$vhostcheck_newexps \[[lindex [split $vhostcheck_vhost \ ] 2]\] [lindex [split $vhostcheck_vhost \ ] 0]\n"
			     }
			 }
		 if { $vhostcheck_newexps != "" && [regexp -nocase {[a-z0-9\.\-\_]+@[a-z0-9\.\-]*} $vhostexpnotifyaddrlist] } {
		     exec echo "Expired vhosts as monitored by $botnick on $server\:\n$vhostcheck_newexps" | mail $vhostexpnotifyaddrlist
		    }
		}

proc tracevhost { tracevhost_host tracevhost_pad tracevhost_text } {
		 vhostentry pad pad "pad pad pad pad pad connecting: pad [string trim [lindex [split $tracevhost_text \ ] 3] \]]"
		}


proc vhostadd { vhostadd_handle vhostadd_idx vhostadd_text } {
	       # arguments are: mask pass vhost
	       global vhostfile
	       set vhostadd_args [parsecline $vhostadd_text]
	       if { [regexp -nocase {^[a-z0-9\.\-\_\*\?\~]+@[a-z0-9\-\.\*\?]+} [lindex $vhostadd_args 0]] &&
		    [regexp -nocase {^[a-z0-9\-]+\.[a-z0-9\-\.]+$} [lindex $vhostadd_args 2]] && 
		    [string length [lindex $vhostadd_args 2]] < 63 } {
		   regexp {([^.]*\.[^.]*[.]*)$} [lindex $vhostadd_args 2] #vhostadd_domain
		   if { [catch {set vhostadd_hoststatus [exec host $vhostadd_domain]}] || [regexp -nocase {\ not\ found} $vhostadd_hoststatus] } {
		       if { [catch {set vhostadd_vhostfile [open $vhostfile a]}] == 0 } {
		           puts $vhostadd_vhostfile "#added by [idx2hand $vhostadd_idx] TS[clock seconds]\nauth \{\n	user = \"[lindex $vhostadd_args 0]\";\n		spoof = \"[lindex $vhostadd_args 2]\";\n  #password = \"[lindex $vhostadd_args 1]\";\n   flags = exceed_limit, spoof_notice, flood_exempt;\n    class = \"users\";\n\};\n"
			   close $vhostadd_vhostfile
			   putserv "REHASH"
			   putdcc $vhostadd_idx "Done."
			  } else {
			   filerrmsg $vhostfile concatenation
			  }
		      } else {
		       putdcc $vhostadd_idx "Resolver malfunction and/or domain $vhostadd_domain resolves!"
		      }
		  } else {
		   putdcc $vhostadd_idx "Invalid hostname(s) and/or sintax and/or vhost too long (max. 62 characters)\nUsage: spoof ident@host password vhost"
		  }
	      }

proc vhostdell {vhostadd_handle vhostadd_idx vhostdell_text} {
       global vhostfile 
	 if {$vhostdell_text== ""} { putdcc $vhostadd_idx "Write some spoofs for me!"; return 0}
	set temp [open $vhostfile r]; set vhostdata [split [read $temp] "\n"]; close $temp
	set lr [lsearch -regexp $vhostdata "spoof = \"$vhostdell_text\";"]
	if {$lr== -1} { putdcc $vhostadd_idx "spoof name is not in server databace!"; return 0}
	set wr [open $vhostfile w]
	foreach inrcd "[lrange $vhostdata 0 [expr $lr - 4]] [lrange $vhostdata [expr $lr + 5] end-1]" {
      puts $wr $inrcd 
    }
	flush $wr; close $wr
	putdcc $vhostadd_idx "Spoof $vhostdell_text deleted! Rehashing server!"
	putserv "REHASH"
	putdcc $vhostadd_idx "Done."
}
		  
proc parsecline { parsecline_text } {
		 set parsecline_clist ""
		 foreach parsecline_element [split $parsecline_text \ \	] {
			  if { $parsecline_element != "" } {
			      lappend parsecline_clist $parsecline_element
			     }
			 }
		 return $parsecline_clist
		}

proc filerrmsg { filerrmsg_file filerrmsg_mode } {
		global vhtrackver
		putlog "\[$vhtrackver\]: Error! Cannot open $filerrmsg_file for $filerrmsg_mode\."
	       }

proc why_the_hell_cant_i_stick_a_single_line_command_here_dammit { okok_pad freeow_pad pff_pad } {
								  putserv "TRACE"
								 }

proc operid { operid_host operid_pad operid_text } {
	     global opernick operpass opermodes
	     putserv "OPER $opernick $operpass"
	     putserv "MODE $opernick +$opermodes"
	    }

if { ![file exists $vdbfile] } { vdbcreate } else { vdbload }

bind raw - NOTICE vhostentry
bind raw - 001 operid
bind raw - 204 tracevhost
bind raw - 205 tracevhost
bind raw - 381 why_the_hell_cant_i_stick_a_single_line_command_here_dammit
bind dcc V spoof vhostadd
bind dcc V dellspoof vhostdell

while { [lsearch -regexp [timers] "\ vdbmain\ "] != -1 } {
       killtimer [lindex [split [lindex [timers] [lsearch -regexp [timers] "\ vdbmain\ "]] \ ] 2]
      }

timer $vdbupdateinterval vdbmain

putlog "Loaded:Spoofs.tcl"