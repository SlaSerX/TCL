## trqbva lodnesh alltools.tcl.
proc ispermowner {hand} {
  global owner
  regsub -all -- , [string tolower $owner] "" owners
  if {([matchattr $hand n]) && ([lsearch -exact $owners [string tolower $hand]] != -1)} {
	return 1
  }
  return 0
}

bind dcc m chattr dcc:chattr
proc dcc:chattr {hand idx paras} {
 global owner
 set user [lindex $paras 0]
 set flags [lindex $paras 1]
 set on_chan [lindex $paras 2]
 if {[regexp "K" $flags] && ($hand != $owner)} {
 putidx $idx "Only permanent owners can change attr with \[\002+K,\002\] Flags!"
} else {
 if {[validuser $user]} {
  *dcc:chattr $hand $idx $paras
   } else {
  *dcc:chattr $hand $idx $paras
 }
}
}

