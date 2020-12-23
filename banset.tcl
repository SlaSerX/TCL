####################################################
# ban.tcl -> TCL kojto dobavq kum reasona na bana  #
# data, chas i handle, ot kojto e postaven bana.   #
####################################################


unbind dcc o|o +ban *dcc:+ban;
bind dcc o|o +ban ban:+ban

proc ban:+ban {handle idx arg} {
  if {$arg == ""} {
    *dcc:+ban $handle $idx $arg
    return 0
  }
  set date [strftime %d/%m/%Y@%H:%M]
  *dcc:+ban $handle $idx "$arg (set by 9$handle on $date)"
}


