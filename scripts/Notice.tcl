# Notice.tcl v1.0 (30 Apr 2008)
# Copyright by Kiril Georgiev a.k.a Arkadietz
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################


set notc_chanadv_chans { #SweetHell }

#######

bind notc - "*" notc_chanadv
proc notc_chanadv {nick uhost hand text {dest ""}} {
     global botnick notc_chanadv_chans
     set dest [string tolower $dest]
     set nick [string tolower $nick]
     if { $dest == [string tolower $botnick] } {
                return 0
                }
     if { [lsearch $notc_chanadv_chans $dest] == -1 || [matchattr $hand f|f $dest] } {
        putlog "notice: $nick!$uhost ($dest) $text"
        return 0
        }
     putlog "notice: $nick!$uhost ($dest) $text"
     set bhost *!*@[lindex [split $uhost "@"] 1]
     newchanban $dest $bhost notice "Ohh, Notice ? Go to hell!" 120
     return 0
}

putlog "TCL | Notice"
