bind raw - MODE newmode_on
proc newmode_on {from key args} {
global botnick
  set date [strftime %d.%m.%Y@%H:%M]
  set args [lindex $args 0]
  set banmask "*!*[lindex [split [lindex [split $from "!"] 1] "@"] 0]*@[lindex [split [maskhost [lindex [split $from "!"] 1]] "@"] 1]"
  set mode_chan [lindex $args 0]
  set the_mode [lindex $args 1]
  set mode_args [lindex $args 2]
  scan $from "%\[^!]@%s" unick uhost
  set who_user [finduser $from]
  if {$who_user == $botnick} {
	return 0
  }
  if {$the_mode == "+d"} {
    if {[validuser $unick] && ![matchattr $who_user n|n $mode_chan]} {
	  chattr $nick -fopmtxh+dk	
	  save
	  setuser $unick hosts "*!*[lindex [split [lindex [split $from "!"] 1] "@"] 0]*@[lindex [split [maskhost [lindex [split $from "!"] 1]] "@"] 1]"    
      setuser $unick xtra Added "Try put mode (+d) in channel $mode_chan on <$date>"
    } else {
	  adduser $unick $unick!*@*
      chattr $unick -foptjxhm+d
k
	  setuser $unick hosts "*!*[lindex [split [lindex [split $from "!"] 1] "@"] 0]*@[lindex [split [maskhost [lindex [split $from "!"] 1]] "@"] 1]"
	  setuser $unick xtra Added "Try put mode (+d) in channel $mode_chan on <$date>"
    }
  putserv "MODE $mode_chan -o+b-d $unick $banmask $mode_args"
  putserv "KICK $mode_chan $unick :Forget for TakE OveR in this channel !" 
  }
  if {$the_mode == "+e"} {
    if {[validuser $unick] && ![matchattr $who_user n|n $mode_chan]} {
      chattr $nick -fopmtxh+d
	  save
	  setuser $unick hosts "*!*[lindex [split [lindex [split $from "!"] 1] "@"] 0]*@[lindex [split [maskhost [lindex [split $from "!"] 1]] "@"] 1]"
	  setuser $unick xtra Added "Try put mode (+e) in channel $mode_chan on <$date>"
    } else {
	  adduser $unick $unick!*@*
	  chattr $unick -foptjxhm+d
	  setuser $unick hosts "*!*[lindex [split [lindex [split $from "!"] 1] "@"] 0]*@[lindex [split [maskhost [lindex [split $from "!"] 1]] "@"] 1]"
	  setuser $unick xtra Added "Try put mode (+e) in channel $mode_chan on <$date>"
    }
  putserv "MODE $mode_chan -o-e+b $unick $mode_args $banmask" 
  putserv "KICK $mode_chan $unick :Forget for ImmunitY in this channel !"
  }
}
putlog "Anti +e/+d TCL bY dJ_TEDY Loaded."