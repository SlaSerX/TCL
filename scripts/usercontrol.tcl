## Some people tell me that I need help (so goto #Bulgaria :)), some people can fuck off and go to hell.
## S dwe dumi da se pokazwat li shitz?
set talkshits 1

## 99 little bugs in the code,
## 99 bugs in the code,
## Fix one bug, compile it again,
## 100 little bugs in the code.

## Potrebitel s kakwi flagowe ste moje da delva wsi4ki potrebiteli?
## Ostawete go "" za wsi4ki.
set delflag "W"

## Kolko dylgi psewdonimi polzwa bota wi?
set nicklength 9

## Kolko potrebitelq moje da dobawq edin owner (!ispermowner && ![matchattr $hand $delflag])
set ownerusers 8

## Kolko mastera moje da dobawq edin owner (see above)
set ownermasters 3

## Kolko potrebitelq moje da dobawq edin master
set masterusers 5




############################################################################################################################
### AKO NE ZNAETE KAKWO PRAWITE PO DOBRE NEDEITE DA SE MESITE S KODA PO NADOLU (W SLU4AI 4E ISKATE TCLA DA RABOTI :)     ###
############################################################################################################################





## Unbind up your ass.
unbind dcc m|m adduser *dcc:adduser 
unbind dcc m|m chattr *dcc:chattr
unbind dcc m|m deluser *dcc:deluser
unbind dcc m|- +user *dcc:+user
unbind dcc m|- -user *dcc:-user
unbind dcc t|- +bot *dcc:+bot
unbind dcc t|- chhandle *dcc:chhandle
unbind dcc t|- chnick *dcc:chnick
unbind dcc -|- handle *dcc:handle
unbind dcc -|- nick *dcc:nick
unbind dcc - botattr *dcc:botattr
unbind dcc - su *dcc:su
unbind dcc - +chan *dcc:+chan
unbind dcc - -chan *dcc:-chan
unbind dcc - binds *dcc:binds

## Now bind up.
bind dcc n listusers dcc:listusers
bind dcc n added dcc:added
bind dcc m|m adduser dcc:adduser
bind dcc m|m chattr dcc:chattr
bind dcc m|m deluser *dcc:deluser
bind dcc m|- +user dcc:+user
bind dcc m|- -user dcc:-user
bind dcc t|- +bot dcc:+bot
bind dcc t|- chhandle dcc:chhandle
bind dcc t|- chnick dcc:chhandle
bind dcc -|- handle dcc:handle
bind dcc -|- nick dcc:handle
bind dcc W botattr dcc:botattr
bind dcc n +chan dcc:+chan
bind dcc n -chan dcc:-chan
bind dcc n su dcc:su

## Initiliaze.
if {![info exists whois-fields]} {
  set whois-fields ""
}

set Changeapp 0
set Addedapp 0
set Usersapp 0
set Mastersapp 0
set Ownersapp 0
set Botsapp 0

foreach z [split ${whois-fields}] {
  if {[string tolower $z] == [string tolower "Changed"]} {
	set Changeapp 1
  }
  if {[string tolower $z] == [string tolower "Added"]} {
	set Addedapp 1
  }
  if {[string tolower $z] == [string tolower "Users"]} {
	set Usersapp 1
  }
  if {[string tolower $z] == [string tolower "Masters"]} {
	set Mastersapp 1
  }
  if {[string tolower $z] == [string tolower "Owners"]} {
	set Ownersapp 1
  }
  if {[string tolower $z] == [string tolower "Bots"]} {
	set Botsapp 1
  }
}

if {$Changeapp == 0} { append whois-fields " " "Changed" }
if {$Addedapp == 0} { append whois-fields " " "Added" }
if {$Usersapp == 0} { append whois-fields " " "Users" }
if {$Mastersapp == 0} { append whois-fields " " "Masters" }
if {$Ownersapp == 0} { append whois-fields " " "Owners" }
if {$Botsapp == 0} { append whois-fields " " "Bots" }

## dcc:adduser start
proc dcc:adduser {hand idx paras} {
  global delflag ownermasters masterusers ownerusers
  set user [lindex $paras 1]

  if {$user == ""} {
	if {[string index $paras 0] == "!"} {
	  set user [string range [lindex $paras 0] 1 end]
	} else {
	  set user [lindex $paras 0]
	}
  }

  if {![nicklencheck $user]} {
	set user [string range $user 0 8]
  }

  if {[validuser $user]} {
	*dcc:adduser $hand $idx $paras
  } else {
	if {$ownermasters != 0 && $ownerusers != 0 && $masterusers != 0} {
	  if {[ispermowner $hand] || ([matchattr $hand $delflag] && $delflag != "")} {
	  } elseif {[matchattr $hand n]} {
  		set u [string trimleft [getuser $hand xtra Users] (] ; set u [string trimright $u )]
		set m [string trimleft [getuser $hand xtra Masters] (] ; set m [string trimright $m )]
		if {$u == ""} {
		  set u 0
		}
		if {$m == ""} {
		  set m 0
		}
		if {[expr $u + $m] >= [expr $ownerusers + $ownermasters]} {
		  putdcc $idx "Ne mojete da addwate powe4e potrebiteli."
		  return 0
  		}
	  } elseif {[matchattr $hand m]} {
  	    set u [string trimleft [getuser $hand xtra Users] (] ; set u [string trimright $u )]
	    if {$u >= $masterusers} {
		  putdcc $idx "Ne mojete da addwate powe4e potrebiteli."
		  return 0
  		}
	  }
	}
	*dcc:adduser $hand $idx $paras

	if {[validuser $user]} {
  	  setuser $user xtra Added "$hand ([strftime %d-%m@%H:%M])"
      userxtra $hand "user" "+" ""
	  tellabout $hand $user "add"
	}
  }
}    
## dcc:adduser end

## dcc:deluser start
proc dcc:deluser {hand idx paras} {
  global botnick delflag

  set user [lindex $paras 0]

  if {[nick2hand $user]} {
	set user [nick2hand $user]
  }

  if {[validuser $user]} {
    set umaster "[lindex [getuser $user xtra Added] 0]"

	if {$delflag != "" && ($hand != $umaster || (![matchattr $hand $delflag] && $delflag != "") || ![ispermowner $hand])} {
	  putdcc $idx "Imate wyzmojnostta samo da triete sobstweni potrebiteli, a $user ne e ot tqh."
	  return 0
	}

    if {[matchattr $user b]} {
      set userorbot "bot"
    } else {
	  set userorbot "user"
    }

	if {[matchattr $user n]} {
	  set uormorn "owner"
	} elseif {[matchattr $user m]} {
	  set uormorn "master"
	} else {
	  set uormorn "user"
	}

    *dcc:deluser $hand $idx $paras

    if {![validuser $user]} {
	  tellabout $hand $user "del"
      if {[validuser $umaster]} {
        userxtra $umaster $userorbot "-" $uormorn
      }
    }
  } else {
    *dcc:deluser $hand $idx $paras
  }
}
## dcc:deluser end

## dcc:+user start
proc dcc:+user {hand idx paras} {
  global delflag masterusers ownermasters ownerusers
  set user [lindex $paras 0]

  if {![nicklencheck $user]} {
	set user [string range $user 0 8]
  }

  if {[validuser $user]} {
    *dcc:+user $hand $idx $paras
  } else {
	if {$ownermasters != 0 && $ownerusers != 0 && $masterusers != 0} {
	  if {[ispermowner $hand] || ([matchattr $hand $delflag] && $delflag != "")} {
	  } elseif {[matchattr $hand n]} {
    	set u [string trimleft [getuser $hand xtra Users] (] ; set u [string trimright $u )]
		set m [string trimleft [getuser $hand xtra Masters] (] ; set m [string trimright $m )]
		if {$u == ""} {
		  set u 0
		}
		if {$m == ""} {
		  set m 0
		}
		if {[expr $u + $m] >= [expr $ownerusers + $ownermasters]} {
		  putdcc $idx "Ne mojete da addwate powe4e potrebiteli."
		  return 0
  		}
	  } elseif {[matchattr $hand m]} {
  	    set u [string trimleft [getuser $hand xtra Users] (] ; set u [string trimright $u )]
	    if {$u == ""} {
		  set u 0
		}
		if {$u >= $masterusers} {
		  putdcc $idx "Ne mojete da addwate powe4e potrebiteli."
		  return 0
  		}
	  }
	}
	*dcc:+user $hand $idx $paras

	if {[validuser $user]} {
  	  setuser $user xtra Added "$hand ([strftime %d-%m@%H:%M])"
      userxtra $hand "user" "+" ""
	  tellabout $hand $user "add"
    }
  }
}
## dcc:+user end

## dcc:+bot start
proc dcc:+bot {hand idx paras} {
  set user [lindex $paras 0]

  if {![nicklencheck $user]} {
	set user [string range $user 0 8]
  }

  if {[validuser $user]} {
    *dcc:+bot $hand $idx $paras
  } else {
    *dcc:+bot $hand $idx $paras

    if {[validuser $user]} {
      setuser $user xtra Added "$hand ([strftime %d-%m@%H:%M])"
      userxtra $hand "bot" "+" ""
	  tellabout $hand $user "add"
    }
  }
}
## dcc:+bot end

## dcc:-user start
proc dcc:-user {hand idx paras} {
  global botnick delflag

  set user [lindex $paras 0]

  if {[validuser $user]} {
    set umaster "[lindex [getuser $user xtra Added] 0]"

	if {$delflag != "" && ($hand != $umaster && (![matchattr $hand $delflag] || ![ispermowner $hand]))} {
	  putdcc $idx "Imate wyzmojnostta samo da triete sobstweni potrebiteli, a $user ne e ot tqh."
	  return 0
	}

    if {[matchattr $user b]} {
      set userorbot "bot"
    } else {
	  set userorbot "user"
    }

	if {[matchattr $user n]} {
	  set uormorn "owner"
	} elseif {[matchattr $user m]} {
	  set uormorn "master"
	} else {
	  set uormorn "user"
	}

    *dcc:-user $hand $idx $paras

    if {![validuser $user]} {
	  tellabout $hand $user "del"
      if {[validuser $umaster]} {
        userxtra $umaster $userorbot "-" $uormorn
      }
    }
  } else {
    *dcc:-user $hand $idx $paras
  }
}
## dcc:-user end

## dcc:chattr start
proc dcc:chattr {hand idx paras} {
  global delflag ownermasters ownerusers masterusers

  set user [lindex $paras 0]
  set flags [lindex $paras 1]
  set on_chan [lindex $paras 2]

  if {[regexp -nocase "$delflag" $flags] && ![ispermowner $hand] && $delflag != ""} {
	putidx $idx "Samo permanentnite owneri mogat da slagat +$delflag"
  } else {
	if {[validuser $user]} {
      set plus 1
	  set range 0
	  if {$on_chan != "" && ![regexp -nocase "|" $flags]} {
		set range 1
	  }
      array set flagove ""
      array set lflagove ""
      foreach flag [split $flags ""] {
        if {$flag == "-"} {
          set plus -1
        } elseif {$flag == "+"} {
          set plus 1
        } elseif {$flag == "|"} {
		  set range 1
		} else {
		  if {$range == 1} {
			set lflagove($flag) $plus
		  } else {
      		set flagove($flag) $plus
		  }
        }
      }
      set pos "+"
      set neg "-"

      foreach flag [array names flagove] {
        if {$flagove($flag) == -1} {
          set neg "$neg$flag"
        } elseif {$flagove($flag) == 1} {
          set pos "$pos$flag"
        }
      }
	  set flagz ""
	  
	  if {$neg != "-"} {
		set flagz "$neg"
	  } elseif {$pos != "+"} {
		set flagz "$flagz$pos"
	  }

	  set neg "-"
	  set pos "+"

      foreach flag [array names lflagove] {
        if {$lflagove($flag) == -1} {
          set neg "$neg$flag"
        } elseif {$lflagove($flag) == 1} {
          set pos "$pos$flag"
        }
      }
	  if {$neg != "-" && $pos != "+"} {
		set flagz "$flagz|"
	  }

	  if {$neg != "-"} {
		set flagz "$flagz$neg"
	  } elseif {$pos != "+"} {
		set flagz "$flagz$pos"
	  }
	  if {[lsearch -exact [array names flagove] "n"] != -1} {
		if {$flagove(n) == -1} {
		  if {![ispermowner $hand] || (![matchattr $hand $delflag] && $delflag != "")} {
		    putdcc $idx "Ne mojete da mahate flagowe na potrebiteli, koito sa +n."
		    return 0
		  } else {
		    set master [lindex [getuser $user xtra Added] 0]
		    if {[lsearch -exact [array names flagove] "m"] == -1} {
			  if {[matchattr $user n]} {
				set m [string trimleft [getuser $master xtra Masters] (] ; set m [string trimright $m )]
			    setuser $master xtra Masters "([expr $m + 1])"
				set n [string trimleft [getuser $master xtra Owners] (] ; set n [string trimright $n )]
				if {$n != "" && $n != 0} {
				  setuser $master xtra Owners "([expr $n - 1])"
				}
			  }
			} else {
			  if {[matchattr $user n]} {
				set n [string trimleft [getuser $master xtra Owners] (] ; set n [string trimright $n )]
				if {$n != "" && $n != 0} {
			  	  setuser $master xtra Owners "([expr $n - 1])"
				}
			    set u [string trimleft [getuser $master xtra Users] (] ; set u [string trimright $u )]
			    setuser $master xtra Users "([expr $u + 1])"
			  } elseif {[matchattr $user m]} {
				set m [string trimleft [getuser $master xtra Masters] (] ; set m [string trimright $m )]
				if {$m != "" && $m != 0} {
			  	  setuser $master xtra Masters "([expr $m - 1])"
				}
			    set u [string trimleft [getuser $master xtra Users] (] ; set u [string trimright $u )]
			    setuser $master xtra Users "([expr $u + 1])"
			  }
			}
		  }
	    } elseif {$flagove(n) == 1} {
		  if {![ispermowner $hand] || (![matchattr $hand $delflag] && $delflag != "")} {
		    putdcc $idx "Ne mojete da slagate flag +n."
		    return 0
		  } else {
			set master [lindex [getuser $user xtra Added] 0]
			if {[matchattr $user m] && ![matchattr $user n]} {
			  set m [string trimleft [getuser $master xtra Masters] (] ; set m [string trimright $m )]
			  if {$m != "" && $m != 0} {
			    setuser $master xtra Masters "([expr $m - 1])"
			  }
			  set n [string trimleft [getuser $hand xtra Owners] (] ; set n [string trimright $n )]
			  setuser $hand xtra Owners "([expr $n + 1])"
			  setuser $user xtra Added "$hand ([strftime %d-%m@%H:%M])"
			} elseif {![matchattr $user n]} {
			  set u [string trimleft [getuser $master xtra Users] (] ; set u [string trimright $u )]
			  if {$u != "" && $u != 0} {
				setuser $master xtra Users "([expr $u - 1])"
			  }
			  set n [string trimleft [getuser $hand xtra Owners] (] ; set n [string trimright $n )]
			  setuser $hand xtra Owners "([expr $n + 1])"
			  setuser $user xtra Added "$hand ([strftime %d-%m@%H:%M])"
			}
		  }
		}
	  } elseif {[lsearch -exact [array names flagove] "m"] != -1} {
		if {$flagove(m) == -1} {
		  if {(![ispermowner $hand] || (![matchattr $hand $delflag] && $delflag != "")) ||
			  ([matchattr $hand n] &&
			   $hand != [lindex [getuser $user xtra Added] 0])} {
		    putdcc $idx "Ne mojete da mahate flag +m."
		    return 0
		  } else {
			if {![matchattr $user n]} {
			  set master [lindex [getuser $user xtra Added] 0]
			  if {[ispermowner $master] || ([matchattr $master $delflag] && $delflag != "")} {
				set m [string trimleft [getuser $master xtra Masters] (] ; set m [string trimright $m )]
				if {$m != "" && $m != 0} {
				  setuser $master xtra Masters "([expr $m - 1])"
				}
				set u [string trimleft [getuser $master xtra Users] (] ; set u [string trimright $u )]
				setuser $master xtra Users "([expr $u + 1])"
			  } else {
				set u [string trimleft [getuser $master xtra Users] (] ; set u [string trimright $u )]
				if {$u >= $ownerusers} {
				  putdcc $idx "$master we4e ima $u users, ne moje da ima powe4e."
				  return 0
				}
				setuser $master xtra Users "([expr $u + 1])"
				set m [string trimleft [getuser $master xtra Masters] (] ; set m [string trimright $m )]
				if {$m != "" && $m != 0} {
				  setuser $master xtra Masters "([expr $m - 1])"
				}
			  }
			}
		  }
		} elseif {$flagove(m) == 1} {
		  if {![ispermowner $hand] || (![matchattr $hand $delflag] && $delflag != "")} {
			if {[matchattr $hand n] && $hand == [lindex [getuser $user xtra Added] 0]} {
			  if {![matchattr $user m]} {
			    set m [string trimleft [getuser $hand xtra Masters] (] ; set m [string trimright $m )]
				if {$m >= $ownermasters} {
			  	  putdcc $idx "Ne mojete da addwate powe4e ot $ownermasters masteri."
				  return 0
				}
				setuser $hand xtra Masters "([expr $m + 1])"
			    set u [string trimleft [getuser $hand xtra Users] (] ; set u [string trimright $u )]
			    if {$u != "" && $u != 0} {
				  setuser $hand xtra Users "([expr $u - 1])"
			    }
			  }
			}
		  } else {
			if {![matchattr $user m]} {
			  set master [lindex [getuser $user xtra Added] 0]
			  set u [string trimleft [getuser $master xtra Users] (] ; set u [string trimright $u )]
			  if {$u != "" && $u != 0} {
				setuser $master xtra Users "([expr $u - 1])"
			  }
			  setuser $user xtra Added "$hand ([strftime %d-%m@%H:%M])"
			  set m [string trimleft [getuser $hand xtra Masters] (] ; set m [string trimright $m )]
			  setuser $hand xtra Masters "([expr $m + 1])"
			}
		  }
		}
	  } else {
		if {![ispermowner $hand] && ![matchattr $hand $delflag]  && $hand != [lindex [getuser $user xtra Added] 0]} {
		  putdcc $idx "Ne mojete da mahate/slagate flagove na potrebiteli, koito ne ste addwali."
		  return 0
		}
	  }
      set paras "$user $flagz $on_chan"
	  putlog "$flagz"
	  setuser $user xtra Changed "$hand ([strftime %d-%m@%H:%M]) $flags $on_chan"
	  *dcc:chattr $hand $idx $paras
	} else {
	  *dcc:chattr $hand $idx $paras
	}
  }
}
## dcc:chattr end

## dcc:handle start
proc dcc:handle {hand idx paras} {
  set newhand [lindex $paras 0]

  if {![nicklencheck $newhand]} {
	set newhand [string range $newhand 0 8]
  }

  if {$newhand == ""} {
	putidx $idx "Usage: handle <new-handle>"
  } else {
	if {[validuser $newhand]} {
	  *dcc:handle $hand $idx $paras
	} else {
	  foreach luzer [userlist -|-] {
		if {[lindex [getuser $luzer xtra Added] 0] == $hand} {
		  setuser $luzer xtra Added "$newhand [lindex [getuser $luzer xtra Added] 1]"
		}
	  }
	  *dcc:handle $hand $idx $paras
	}
  }
}
## dcc:handle end

## dcc:chhandle start
proc dcc:chhandle {hand idx paras} {
  set oldhand [lindex $paras 0]
  set newhand [lindex $paras 1]

  if {![nicklencheck $newhand]} {
	set newhand [string range $newhand 0 8]
  }

  if {$newhand == ""} {
	putidx $idx "Usage: chhandle <oldhandle> <newhandle>"
  } else {
	if {![validuser $oldhand] || [validuser $newhand]} {
	  *dcc:chhandle $hand $idx $paras
	} else {
	  foreach luzer [userlist -|-] {
		if {[lindex [getuser $luzer xtra Added] 0] == $oldhand} {
		  setuser $luzer xtra Added "$newhand [lindex [getuser $luzer xtra Added] 1]"
		}
	  }
	  *dcc:chhandle $hand $idx $paras
	}
  }
}
## dcc:chhandle end

## tellabout start
proc tellabout {hand user deloradd} {
  global botnick notify-newusers
  foreach ppl ${notify-newusers} {
	if {$deloradd == "del"} {
  	  sendnote $botnick $ppl "$user deleted. $hand ([strftime %d-%m@%H:%M])"
	} else {
	  sendnote $botnick $ppl "introduced to $user by $hand ([strftime %d-%m@%H:%M])"
	}
  }
}    
## tellabout end

## userxtra start
proc userxtra {hand arg minorplus uormorn} {
  if {$arg == "user"} {
	if {$uormorn == "owner"} {
  	  if {[getuser $hand xtra Owners] == ""} {
		if {$minorplus == "+"} {
    	  setuser $hand xtra Owners "(1)"
		}
	    return 0
	  } else {
    	set a [string trimleft [getuser $hand xtra Owners] (] ; set a [string trimright $a )]
	    if {$a == 0 && $minorplus == "-"} { return 0 }
    	setuser $hand xtra Owners "([expr $a $minorplus 1])"
  	  }
	} elseif {$uormorn == "master"} {
  	  if {[getuser $hand xtra Masters] == ""} {
		if {$minorplus == "+"} {
    	  setuser $hand xtra Masters "(1)"
		}
	    return 0
	  } else {
    	set a [string trimleft [getuser $hand xtra Masters] (] ; set a [string trimright $a )]
	    if {$a == 0 && $minorplus == "-"} { return 0 }
    	setuser $hand xtra Masters "([expr $a $minorplus 1])"
  	  }
	} else {
  	  if {[getuser $hand xtra Users] == ""} {
		if {$minorplus == "+"} {
    	  setuser $hand xtra Users "(1)"
		}
	    return 0
	  } else {
    	set a [string trimleft [getuser $hand xtra Users] (] ; set a [string trimright $a )]
	    if {$a == 0 && $minorplus == "-"} { return 0 }
    	setuser $hand xtra Users "([expr $a $minorplus 1])"
  	  }
	}
  }

  if {$arg == "bot"} {
    if {[getuser $hand xtra Bots] == ""} {
	  if {$minorplus == "+"} {
  		setuser $hand xtra Bots "(1)"
	  }
	  return 0
    } else {
      set a [string trimleft [getuser $hand xtra Bots] (] ; set a [string trimright $a )]
      if {$a == 0 && $minorplus == "-"} { return 0 }
      setuser $hand xtra Bots "([expr $a $minorplus 1])"
    }
  }
}
## userxtra end

## dcc:listusers start
proc dcc:listusers {hand idx param} {
  if {$param == ""} {
	putdcc $idx ">> Showing all users <<"

	if {[string match "* local *" [getuser $hand xtra optzii]]} {
	  foreach master [userlist m|m] {
	    added:usercheck $master $idx
  	  }
	} else {
	  foreach master [userlist m] {
	    added:usercheck $master $idx
  	  }
	}

	if {[string match "* local *" [getuser $hand xtra optzii]]} {
	  putdcc $idx "Total: [llength [userlist n|n]] owner(s), [expr [llength [userlist m|m]] - [llength [userlist n|n]]] master(s), [expr [llength [userlist p]] - [llength [userlist m|m]]] user(s) and [llength [userlist b]] bot(s)"
	} else {
	  putdcc $idx "Total: [llength [userlist n]] owner(s), [expr [llength [userlist m]] - [llength [userlist n]]] master(s), [expr [llength [userlist p]] - [llength [userlist m]]] user(s) and [llength [userlist b]] bot(s)"
	}

	putdcc $idx ">> List End <<"
  } else {
	if {$param == "help"} {
	  putdcc $idx "Usage: .listusers \[handle(s)\]"
	  return
	}
    set notknown ""
    set count 0

	foreach handly $param {
	  if {![validuser $handly]} {
		append notknown " $handly"
		incr count
	  } else {
		added:usercheck $handly $idx
	  }
	}

	if {$notknown != ""} {
	  regsub -all {^ } $notknown {} notknown
	  regsub -all { } $notknown {, } notknown

	  if {$count != 1} {
	    putdcc $idx "$notknown are not known to me."
	  } else {
	    putdcc $idx "$notknown is not known to me."
	  }
	}
  }
}
## dcc:listusers end

## added:usercheck start
proc added:usercheck {hand idx} {
  set UsersAdded [string trimleft [getuser $hand xtra Users] (]
  set UsersAdded [string trimright $UsersAdded )]

  if {$UsersAdded == ""} {
	set UsersAdded 0
  }
  set MastersAdded [string trimleft [getuser $hand xtra Masters] (]
  set MastersAdded [string trimright $MastersAdded )]
  set UsersAdded [expr $MastersAdded + $UsersAdded]
  set MastersAdded 0
  set MastersAdded [string trimleft [getuser $hand xtra Owners] (]
  set MastersAdded [string trimright $MastersAdded )]
  set UsersAdded [expr $MastersAdded + $UsersAdded]
  set globorloc ""

  if {[string match "* local *" [getuser $hand xtra optzii]]} {
    if {[matchattr $hand n]} {
	  set globorloc "*"
	} elseif {[matchattr $hand m]} {
	  set globorloc "+"
	} else {
	  foreach chanz [channels] {
		if {[matchattr $hand |n $chanz]} {
  		  set globorloc "*"
  	    } elseif {[matchattr $hand |m $chanz]} {
		  if {$globorloc != "*"} {
			set globorloc "+"
		  }
  		}
	  }
	}
  } else {
	if {[matchattr $hand n]} {
  	  set globorloc "*"
    } elseif {[matchattr $hand m]} {
	  set globorloc "+"
    }
  }

  set luzeri ""

  foreach luzer [userlist -|-] {
	if {[lindex [getuser $luzer xtra Added] 0] == $hand} {
	  if {![matchattr $luzer b]} {
		append luzeri " $luzer"
	  }
	}
  }

  regsub -all {^ } $luzeri {} luzeri
  regsub -all { } $luzeri {, } luzeri

  if {[string match "* showall *" [getuser $hand xtra optzii]]} {
	if {[string match "* local *" [getuser $hand xtra optzii]]} {
	  putdcc $idx "$globorloc$hand ($UsersAdded): $luzeri"
	} else {
	  if {$globorloc != ""} {
	    putdcc $idx "$globorloc$hand ($UsersAdded): $luzeri"
	  }
	}
  } else {
	if {[string match "* local *" [getuser $hand xtra optzii]]} {
	  putdcc $idx "$globorloc$hand ($UsersAdded)"
	} else {
	  if {$globorloc != ""} {
	    putdcc $idx "$globorloc$hand ($UsersAdded)"
	  }
	}
  }
}
## added:usercheck end

## dcc:added start.
proc dcc:added {hand idx param} {
  global talkshits
  if {$talkshits == 1} {
	global botnick
  }

  if {[llength $param] == 0} {
	putdcc $idx "Izpolzwane: .added \[none|all|local|global\]"
	putdcc $idx " "
	putdcc $idx "	S none nqma da wi se pokazwat dobawenite potrebiteli"
	putdcc $idx "	S all ste wi se pokazwat dobawenite potrebiteli"
	putdcc $idx "	S local ste se pokazwat local masteri/owneri"
	putdcc $idx "	S global nqma da se pokazwat local masteri/owneri"
    if {$talkshits == 1} {
	  putdcc $idx " "
	  putdcc $idx "I ne zabrawqjte... plastajte si danacite redowno, i to pri nas! :)"
	}
	return -1
  }
  if {[llength $param] > 2 || ([string match "* all *" $param] && [string match "* none *" $param]) ||
	  ([string match "* global *" $param] && [string match "* local *" $param])} {
	putdcc $idx "Ne mojete da zadadete powe4e ot dwe opcii i kombinacii ot local && global i none && all."
	putdcc $idx " "
	putdcc $idx "	Napishete: .added za help"
    if {$talkshits == 1} {
	  putdcc $idx " "
	  putdcc $idx "Who do you try to get crazy esse, don't you know I'm loco."
	}
	return -1
  }

  foreach parametyr $param {
	if {$parametyr == "none"} {
	  if {[string match "* showall *" [getuser $hand xtra optzii]]} {
		set optzii [getuser $hand xtra optzii]
		regsub { showall } $optzii {} optzii
		setuser $hand xtra optzii " $optzii "
		putdcc $idx "Optziq $parametyr e uspeshno dobawena."
		if {$talkshits == 1} {
		  putdcc $idx "cat /dev/null > /dev/$hand"
		}
	  } else {
		putdcc $idx "Wie we4e imate $parametyr."
		if {$talkshits == 1} {
		  putdcc $idx "my \$flag = \"none\";"
		}
	  }
	} elseif {$parametyr == "all"} {
	  if {[string match "* showall *" [getuser $hand xtra optzii]]} {
		putdcc $idx "Wie we4e imate $parametyr."
		if {$talkshits == 1} {
		  putdcc $idx "\$question = (2 * \$showall) || (not 2 * \$showall);"
		}
	  } else {
		setuser $hand xtra optzii " showall [getuser $hand xtra optzii]"
		putdcc $idx "Optziq $parametyr e uspeshno dobawena."
		if {$talkshits == 1} {
		  putdcc $idx "unblind $hand * showall *$hand:show_your_wife_make_sex_with_$botnick"
		}
	  }
	} elseif {$parametyr == "local"} {
	  if {[string match "* local *" [getuser $hand xtra optzii]]} {
		putdcc $idx "Wie we4e imate $parametyr."
		if {$talkshits == 1} {
		  putdcc $idx "perl -e'1 while print \"#LocOps sux\" x rand(65),\"\\n\"'"
		}
	  } else {
		setuser $hand xtra optzii " local [getuser $hand xtra optzii]"
		putdcc $idx "Optziq $parametyr e uspeshno dobawena."
		if {$talkshits == 1} {
		  putdcc $idx "&go(see->{_j3rks_}, \"in #LocOps\");"
		}
	  }
	} elseif {$parametyr == "global"} {
	  if {[string match "* local *" [getuser $hand xtra optzii]]} {
		set optzii [getuser $hand xtra optzii]
		regsub { local } $optzii {} optzii
		setuser $hand xtra optzii " $optzii "
		putdcc $idx "Optziq $parametyr e uspeshno dobawena."
		if {$talkshits == 1} {
		  putdcc $idx "\$GlobOps =~ s/lusers/lamerz/;"
		}
	  } else {
		putdcc $idx "Wie we4e imate $parametyr."
		if {$talkshits == 1} {
		  putdcc $idx "tell(all) => \"How much the GlobOps suck\";"
		}
	  }
	} else {
	  putdcc $idx "Nepoznata opciq $parametyr. fsck /dev/$hand!"
	}
  }
}
## dcc:added end.

proc dcc:+chan {h i p} {
  global owner
  if {[string match "*$h*" "$owner"]} {
    *dcc:+chan $h $i $p
  } else {
    putdcc $i "Only permanent owners can do that"
  }
}
proc dcc:su {h i p} {
  global owner
  if {[string match "*$h*" "$owner"]} {
    *dcc:su $h $i $p 
  } else {
    putdcc $i "Only permanent owners can do that"
  }
}

proc dcc:-chan {h i p} {
  global owner
  if {[string match "*$h*" "$owner"]} {
    *dcc:-chan $h $i $p
  } else {
    putdcc $i "Only permanent owners can do that"
  }
}

# dcc:botattr start
proc dcc:botattr {hand idx paras} {
 global owner
 set user [lindex $paras 0]
 set flags [lindex $paras 1]
 regsub -all -- , [string tolower $owner] "" owners
 if {[regexp "r" $flags] && (![string match "*$hand*" "$owners"])} {
 putidx $idx "Only permanent owners can change attr with \[\002+r\002\] Flags!"
} else {
 if {[validuser $user]} {
  *dcc:botattr $hand $idx $paras
  setuser $user xtra BotFlags "$hand ([strftime %d-%m@%H:%M]) $flags"
 } else {
  *dcc:botattr $hand $idx 
 }
}
}

## Thanks to alltools.tcl.
proc ispermowner {hand} {
  global owner

  regsub -all -- , [string tolower $owner] "" owners
  if {([matchattr $hand n]) && ([lsearch -exact $owners [string tolower $hand]] != -1)} {
	return 1
  }
  return 0
}

proc nicklencheck {nick} {
  global nicklength
  if {[string length $nick] > $nicklength} {
	return 0
  }
  return 1
}

if {$talkshits == 1} {
  putlog "Eat the worm esse!"
}

## TODO - hide (0) ; pri del na m/n u->unknown || suspend :))

putlog "TCL | User Control"
