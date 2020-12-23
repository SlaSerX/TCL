## This is the full path where the userfile should go i.e /home/dlh/user.html.
set userlistfile "/home/hate/public_html/userlist.html"

## Makes the userlist every 1 minute.
bind time - "1 * * * *" userlist_built
bind time - "2 * * * *" userlist_built
bind time - "3 * * * *" userlist_built
bind time - "4 * * * *" userlist_built
bind time - "5 * * * *" userlist_built
bind time - "6 * * * *" userlist_built
bind time - "7 * * * *" userlist_built
bind time - "8 * * * *" userlist_built
bind time - "9 * * * *" userlist_built
bind time - "10 * * * *" userlist_built
bind time - "11 * * * *" userlist_built
bind time - "12 * * * *" userlist_built
bind time - "13 * * * *" userlist_built
bind time - "14 * * * *" userlist_built
bind time - "15 * * * *" userlist_built
bind time - "16 * * * *" userlist_built
bind time - "17 * * * *" userlist_built
bind time - "18 * * * *" userlist_built
bind time - "19 * * * *" userlist_built
bind time - "20 * * * *" userlist_built
bind time - "21 * * * *" userlist_built
bind time - "22 * * * *" userlist_built
bind time - "23 * * * *" userlist_built
bind time - "24 * * * *" userlist_built
bind time - "25 * * * *" userlist_built
bind time - "26 * * * *" userlist_built
bind time - "27 * * * *" userlist_built
bind time - "28 * * * *" userlist_built
bind time - "29 * * * *" userlist_built
bind time - "30 * * * *" userlist_built
bind time - "31 * * * *" userlist_built
bind time - "32 * * * *" userlist_built
bind time - "33 * * * *" userlist_built
bind time - "34 * * * *" userlist_built
bind time - "35 * * * *" userlist_built
bind time - "36 * * * *" userlist_built
bind time - "37 * * * *" userlist_built
bind time - "38 * * * *" userlist_built
bind time - "39 * * * *" userlist_built
bind time - "40 * * * *" userlist_built
bind time - "41 * * * *" userlist_built
bind time - "42 * * * *" userlist_built
bind time - "43 * * * *" userlist_built
bind time - "44 * * * *" userlist_built
bind time - "45 * * * *" userlist_built
bind time - "46 * * * *" userlist_built
bind time - "47 * * * *" userlist_built
bind time - "48 * * * *" userlist_built
bind time - "49 * * * *" userlist_built
bind time - "50 * * * *" userlist_built
bind time - "51 * * * *" userlist_built
bind time - "52 * * * *" userlist_built
bind time - "53 * * * *" userlist_built
bind time - "54 * * * *" userlist_built
bind time - "55 * * * *" userlist_built
bind time - "56 * * * *" userlist_built
bind time - "57 * * * *" userlist_built
bind time - "58 * * * *" userlist_built
bind time - "59 * * * *" userlist_built
bind time - "00 * * * *" userlist_built

bind dcc n userlist dcc_userlist

proc dcc_userlist {hand 1 arg} {
global userlistfile
    set i "1"
    set file [open "$userlistfile" w]
    puts $file "<html>"
    puts $file ""
    puts $file "<head>"
    puts $file "<meta name\=\"GENERATOR\" content\=\"Microsoft FrontPage 5.0\">"
    puts $file "<meta name\=\"ProgId\" content\=\"FrontPage.Editor.Document\">"
    puts $file "<meta http-equiv\=\"Content-Type\" content\=\"text/html\; charset=windows-1252\">"
    puts $file "<title>Number Of Users In The Database: [countusers]</title>"
    puts $file "</head>"
    puts $file "<body bgcolor\=\"\#000000\">"
    puts $file "<table height\=\"323\" width\=\"909\" align\=\"center\" borderColor=\"\#FFFFFF\" border\=\"1\">"

    foreach user [userlist -] {
	puts $file "  <tr>"
	puts $file "    <td noWrap colSpan\=\"2\" height\=\"19\" width\=\"899\">"
        puts $file "    \&nbsp\;</td>"
        puts $file "  </tr>"
	puts $file "  <tr>"
	puts $file "    <td noWrap borderColor\=\"#FFFFFF\" width\=\"120\" height\=\"19\">"
	puts $file "    <font color\=\"\#00dc68\" size=\"2\"> </font><font size\=\"2\" color\=\"\#00dc68\">"
	puts $file "    [getuser $user HANDLE]</font><font size\=\"2\"><font color\=\"\#00dc68\"> </font><font color\=\"\#666666\"></font></font></td>"
	puts $file "    <td noWrap height\=\"19\" width\=\"674\">\&nbsp\;</td>"
	puts $file "  </tr>"
	puts $file "  <tr>"
	puts $file "  <td noWrap borderColor\=\"\#FFFFFF\" width\=\"219\" bgColor\=\"\#666666\" height=\"19\">"
	puts $file "  <font color\=\"\#00dc68\" size=\"2\"></font><font size\=\"2\">"
	puts $file "  <font color\=\"\#00dc68\">Description </font></font><font color\=\"\#000000\" size\=\"2\"></font></td>"
	puts $file "  <td noWrap borderColor\=\"\#FFFFFF\" width\=\"674\" bgColor\=\"\#666666\" height\=\"19\">"
	puts $file "  \&nbsp\;</td>"
	puts $file "  </tr>"
	puts $file "  <tr>"
	puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	puts $file "      <font color\=\"\#00dc68\">Flags</font></td>"
	puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
		    
	if {[chattr $user] == "-"} {
	    puts $file "      <font color\=\"\#00dc68\">No Current Global Flags Set "
	    foreach channels [channels] {
	        if {[lindex [split [chattr $user $channels] |] 1] == ""} {		
	        } elseif {[lindex [split [chattr $user $channels] |] 1] == "-"} {
	        } elseif {[lindex [split [chattr $user $channels] |] 1] == "-|-"} {
		} else {
	            set chflags [lindex [split [chattr $user $channels] |] 1]
		    puts $file "/ \[$channels\] $chflags "
	        }
    	    }
	    puts $file "</font></td>"
    	} elseif {[chattr $user] == ""} {
	    puts $file "      <font color\=\"\#00dc68\">No Current Global Flags Set "
    	    foreach channels [channels] {
		if {[lindex [split [chattr $user $channels] |] 1] == ""} {		
	        } elseif {[lindex [split [chattr $user $channels] |] 1] == "-"} {
		} elseif {[lindex [split [chattr $user $channels] |] 1] == "-|-"} {
	        } else {
		    set chflags [lindex [split [chattr $user $channels] |] 1]
		    puts $file "/ \[$channels\] $chflags "
	        }
	    }
	    puts $file "</font></td>"
	} else {
	    puts $file "      <font color\=\"\#00dc68\">[chattr $user] "
    	    foreach channels [channels] {
	        if {[lindex [split [chattr $user $channels] |] 1] == ""} {		
    		} elseif {[lindex [split [chattr $user $channels] |] 1] == "-"} {
		} elseif {[lindex [split [chattr $user $channels] |] 1] == "-|-"} {
		} else {
		    set chflags [lindex [split [chattr $user $channels] |] 1]
		    puts $file "/ \[$channels\] $chflags "
	        }
	    }
	    puts $file "</font></td>"
    	}
	puts $file "  </tr>"

	if {[getuser $user BOTFL] == ""} {
	} elseif {[getuser $user BOTFL] == ""} {
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Bot Flags</font></td>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user BOTFL]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA BF] == ""} {
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">BoyFriend</font></td>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA BF]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA GF] == ""} {
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">GirlFriend</font></td>"
    	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA GF]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA URL] == ""} {
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Home Page</font></td>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA URL]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA EMAIL] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">E-Mail</font></td>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA EMAIL]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA ICQ] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">ICQ Number</font></td>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA ICQ]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA DOB] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap borderColor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Date Of Birth</font></td>"
	    puts $file "      <td noWrap borderColor\=\"\#666666\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA DOB]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA IRL] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Real Name</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA IRL]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA LOCATION] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Location</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA LOCATION]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA Added] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Added by</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA Added]</font></td>"
	    puts $file "  </tr>"
	}    

	if {[getuser $user INFO] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Global Info</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user INFO]</font></td>"
	    puts $file "  </tr>"
	}

        foreach channels [channels] {
	    if {[getchaninfo $user $channels] == ""} {		
	    } else {
		puts $file "  <tr>"
		puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
		puts $file "      <font color\=\"\#00dc68\">Info $channels</font></td>"
    		puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
		puts $file "      <font color\=\"\#00dc68\">[getchaninfo $user $channels]</font></td>"
		puts $file "  </tr>"
	    }
        }
    incr i
    puts $file "<P></P>"
    puts $file ""    
    puts $file "<P></P>"
    }
    puts $file "    </table></body></html>"
    close $file
#    putlog "User List Built in $userlistfile, happy birthday \;\-\)"
}

proc userlist_built {1 2 3 4 5} {
global userlistfile
    set i "1"
    set file [open "$userlistfile" w]
    puts $file "<html>"
    puts $file ""
    puts $file "<head>"
    puts $file "<meta name\=\"GENERATOR\" content\=\"Microsoft FrontPage 5.0\">"
    puts $file "<meta name\=\"ProgId\" content\=\"FrontPage.Editor.Document\">"
    puts $file "<meta http-equiv\=\"Content-Type\" content\=\"text/html\; charset=windows-1252\">"
    puts $file "<title>Number Of Users In The Database: [countusers]</title>"
    puts $file "</head>"
    puts $file "<body bgcolor\=\"\#000000\">"
    puts $file "<table borderColor\=\"\#FFFFFF\" height\=\"323\" width\=\"909\" align\=\"center\" border\=\"1\">"

    foreach user [userlist -] {
	puts $file "  <tr>"
	puts $file "    <td noWrap colSpan\=\"2\" height\=\"19\" width\=\"899\">"
        puts $file "    \&nbsp\;</td>"
        puts $file "  </tr>"
	puts $file "  <tr>"
	puts $file "    <td noWrap bordercolor\=\"#FFFFFF\" width\=\"120\" height\=\"19\">"
	puts $file "    <font color\=\"\#666666\" size=\"2\"></font><font size\=\"2\" color\=\"\#00dc68\">"
	puts $file "    [getuser $user HANDLE]</font><font size\=\"2\"><font color\=\"\#00dc68\"> </font><font color\=\"\#666666\"></font></font></td>"
	puts $file "    <td noWrap height\=\"19\" width\=\"674\">\&nbsp\;</td>"
	puts $file "  </tr>"
	puts $file "  <tr>"
	puts $file "  <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" bgColor\=\"\#666666\" height=\"19\">"
	puts $file "  <font color\=\"\#000000\" size=\"2\">\[</font><font size\=\"2\">-"
	puts $file "  <font color\=\"\#00dc68\">Description </font>-</font><font color\=\"\#000000\" size\=\"2\">\]</font></td>"
	puts $file "  <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" bgColor\=\"\#666666\" height\=\"19\">"
	puts $file "  \&nbsp\;</td>"
	puts $file "  </tr>"
	puts $file "  <tr>"
	puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	puts $file "      <font color\=\"\#00dc68\">Flags</font></td>"
	puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
		    
	if {[chattr $user] == "-"} {
	    puts $file "      <font color\=\"\#00dc68\">No Current Global Flags Set "
	    foreach channels [channels] {
	        if {[lindex [split [chattr $user $channels] |] 1] == ""} {		
	        } elseif {[lindex [split [chattr $user $channels] |] 1] == "-"} {
	        } elseif {[lindex [split [chattr $user $channels] |] 1] == "-|-"} {
		} else {
	            set chflags [lindex [split [chattr $user $channels] |] 1]
		    puts $file "/ $channels $chflags "
	        }
    	    }
	    puts $file "</font></td>"
    	} elseif {[chattr $user] == ""} {
	    puts $file "      <font color\=\"\#00dc68\">No Current Global Flags Set "
    	    foreach channels [channels] {
		if {[lindex [split [chattr $user $channels] |] 1] == ""} {		
	        } elseif {[lindex [split [chattr $user $channels] |] 1] == "-"} {
		} elseif {[lindex [split [chattr $user $channels] |] 1] == "-|-"} {
	        } else {
		    set chflags [lindex [split [chattr $user $channels] |] 1]
		    puts $file "/ $channels $chflags "
	        }
	    }
	    puts $file "</font></td>"
	} else {
	    puts $file "      <font color\=\"\#00dc68\">[chattr $user] "
    	    foreach channels [channels] {
	        if {[lindex [split [chattr $user $channels] |] 1] == ""} {		
    		} elseif {[lindex [split [chattr $user $channels] |] 1] == "-"} {
		} elseif {[lindex [split [chattr $user $channels] |] 1] == "-|-"} {
		} else {
		    set chflags [lindex [split [chattr $user $channels] |] 1]
		    puts $file "/ $channels $chflags "
	        }
	    }
	    puts $file "</font></td>"
    	}
	puts $file "  </tr>"

	if {[getuser $user BOTFL] == ""} {
	} elseif {[getuser $user BOTFL] == ""} {
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Bot Flags</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user BOTFL]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA BF] == ""} {
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">BoyFriend</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA BF]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA GF] == ""} {
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">GirlFriend</font></td>"
    	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA GF]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA URL] == ""} {
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Home Page</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA URL]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA EMAIL] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">E-Mail</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA EMAIL]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA ICQ] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">ICQ Number</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA ICQ]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA DOB] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Date Of Birth</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA DOB]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA IRL] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Real Name</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA IRL]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA LOCATION] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Location</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA LOCATION]</font></td>"
	    puts $file "  </tr>"
	}

	if {[getuser $user XTRA Added] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Added by</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user XTRA Added]</font></td>"
	    puts $file "  </tr>"
	}    

	if {[getuser $user INFO] == ""} {	
	} else {
	    puts $file "  <tr>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">Global Info</font></td>"
	    puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
	    puts $file "      <font color\=\"\#00dc68\">[getuser $user INFO]</font></td>"
	    puts $file "  </tr>"
	}

        foreach channels [channels] {
	    if {[getchaninfo $user $channels] == ""} {		
	    } else {
		puts $file "  <tr>"
		puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"219\" height\=\"19\">"
		puts $file "      <font color\=\"\#00dc68\">Info $channels</font></td>"
    		puts $file "      <td noWrap bordercolor\=\"\#FFFFFF\" width\=\"674\" height\=\"19\">"
		puts $file "      <font color\=\"\#00dc68\">[getchaninfo $user $channels]</font></td>"
		puts $file "  </tr>"
	    }
        }
    incr i
    puts $file "<P></P>"
    puts $file ""    
    puts $file "<P></P>"
    }
    puts $file "    </table></body></html>"
    close $file
}

putlog "\002\006Userlist 2 html\002\006 script by \002\006IRCHelp.UniBG.Net+LHG Crew\002\006, loaded sucessfully"

