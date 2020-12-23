## Bind

unbind dcc m|m adduser *dcc:adduser 
unbind dcc m|- +user *dcc:+user
unbind dcc m|- -user *dcc:-user
unbind dcc t|- +bot *dcc:+bot
bind dcc m|m adduser dcc:adduser
bind dcc m|- +user dcc:+user
bind dcc m|- -user dcc:-user
bind dcc t|- +bot dcc:+bot

## Initiliaze

if {![info exists whois-fields]} {
    set whois-fields ""
}
set Addedapp 0
set Usersapp 0
set Botsapp 0
foreach z [split ${whois-fields}] {
    if {[string tolower $z] == [string tolower "Added"]} {
        set Addedapp 1
    }
    if {[string tolower $z] == [string tolower "Users"]} {
        set Usersapp 1
    }
    if {[string tolower $z] == [string tolower "Bots"]} {
        set Botsapp 1
    }
}

if {$Addedapp == 0} { append whois-fields " " "Added" }
if {$Usersapp == 0} { append whois-fields " " "Users" }
if {$Botsapp == 0} { append whois-fields " " "Bots" }

## dcc:adduser start

proc dcc:adduser {hand idx paras} {
  global botnick
    set user [lindex $paras 1]
    set userorbot "user"
    if {$user == ""} {
	if {[string index $paras 0] == "!"} {
	    set user [string range [lindex $paras 0] 1 end]
	} else {
	    set user [lindex $paras 0]
	}
    }
    if {[validuser $user]} {
	*dcc:adduser $hand $idx $paras
    } else {
	*dcc:adduser $hand $idx $paras
	if {[validuser $user]} {
            setuser $user xtra Added "by $hand"
          userxtra $hand $userorbot
	    tellabout $hand $user
	}
    }
}    

## dcc:adduser end

## dcc:+user start

proc dcc:+user {hand idx paras} {
  global botnick
    set user [lindex $paras 0]
    set userorbot "user"
    if {[validuser $user]} {
        *dcc:+user $hand $idx $paras
    } else {
        *dcc:+user $hand $idx $paras
        if {[validuser $user]} {
            setuser $user xtra Added "by $hand"
          userxtra $hand $userorbot
	    tellabout $hand $user
        }
    }
}

## dcc:+user end

## dcc:+bot start

proc dcc:+bot {hand idx paras} {
  global botnick
    set user [lindex $paras 0]
    set userorbot "bot"
    if {[validuser $user]} {
        *dcc:+bot $hand $idx $paras
    } else {
        *dcc:+bot $hand $idx $paras
        if {[validuser $user]} {
            setuser $user xtra Added "by $hand"
          userxtra $hand $userorbot
	    tellabout $hand $user
        }
    }
}

## dcc:+bot end

## dcc:-user start

proc dcc:-user {hand idx paras} {
  global botnick
  set user [lindex $paras 0]
  if {[validuser $user]} {
    set umaster "[lindex [getuser $user xtra Added] 1]"
    if {[matchattr $user b]} {
      set userorbot "bot"
    } else { set userorbot "user" }
    *dcc:-user $hand $idx $paras
    if {![validuser $user]} {
      if {[validuser $umaster]} {
        sendnote $botnick $umaster "$user deleted. $hand ($botnick)"
        userxtradel $umaster $userorbot
      }
    }
  } else {
    *dcc:-user $hand $idx $paras
  }
}

## dcc:-user end

## tellabout start

proc tellabout {hand user} {
    global nick notify-newusers
    foreach ppl ${notify-newusers} {
	sendnote $nick $ppl "introduced to $user by $hand"
    }
}    

## tellabout end

## xtras start
proc userxtra {hand arg} {
  if {$arg == "user"} {
    if {[getuser $hand xtra Users] == ""} {
      setuser $hand xtra Users "(1)"
    } else {
      set a [string trimleft [getuser $hand xtra Users] (] ; set a [string trimright $a )]
      setuser $hand xtra Users "([expr $a + 1])"
    }
  }
  if {$arg == "bot"} {
    if {[getuser $hand xtra Bots] == ""} {
      setuser $hand xtra Bots "(1)"
    } else {
      set a [string trimleft [getuser $hand xtra Bots] (] ; set a [string trimright $a )]
      setuser $hand xtra Bots "([expr $a + 1])"
    }
  }
}

proc userxtradel {hand arg} {
  if {$arg == "user"} {
    if {[getuser $hand xtra Users] == ""} {
      return 0
    } else {
      set a [string trimleft [getuser $hand xtra Users] (] ; set a [string trimright $a )]
      if {$a == 0} { return 0 }
      setuser $hand xtra Users "([expr $a - 1])"
    }
  }
  if {$arg == "bot"} {
    if {[getuser $hand xtra Bots] == ""} {
      return 0
    } else {
      set a [string trimleft [getuser $hand xtra Bots] (] ; set a [string trimright $a )]
      if {$a == 0} { return 0 }
      setuser $hand xtra Bots "([expr $a - 1])"
    }
  }
}
putlog "Added.tcl by www.mIRCbg.net loaded"

