# Commands.tcl v1.0 (18 Jul 2007)
# Copyright by Kiril Georgiev a.k.a Arkadietz
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################

proc ownercheck {checkhand} {
 global owner
 foreach i [split $owner " ,"] {
  if {[string tolower $i] == [string tolower $checkhand]} { return 1 }
  }
 return 0
}

bind dcc -|- msg e:msgfilter
proc e:msgfilter {h i a} {
	if {[ownercheck [idx2hand $i]]} { *dcc:msg $h $i $a } else { putdcc $i "Access Denied!"}
}

bind dcc -|- say e:sayfilter
proc e:sayfilter {h i a} {
	if {[ownercheck [idx2hand $i]]} { *dcc:say $h $i $a } else { putdcc $i "Access Denied!"}
}	
bind dcc -|- +chan e:+chanfilter
proc e:+chanfilter {h i a} {
	if {[ownercheck [idx2hand $i]]} { *dcc:+chan $h $i $a } else { putdcc $i "Access Denied!"}
}

bind dcc -|- -chan e:-chanfilter
proc e:+chanfilter {h i a} {
	if {[ownercheck [idx2hand $i]]} { *dcc:-chan $h $i $a } else { putdcc $i "Access Denied!"}
}	

putlog "TCL | Commands"
