# Identify.tcl v1.0 (4 Nov 2006)
# Copyright by Kiril Georgiev a.k.a Arkadietz
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################

# Arkadietz' unique Identify.tcl
# predi da dade op proverqva dali chovekut e identificiran v NS

unbind msg o op *msg:op
bind msg o op e:isid
bind raw - 330 e:realcheckid
proc e:isid {n u h t} {
        if {[passwdok $h [lindex $t 0]]} {
                putserv "WHOIS $n"
        } {
                putserv "NOTICE $n :Wrong Pass!"
        }
}
proc e:realcheckid {a b c} {
        set n [lindex $c 1]
        foreach c [channels] {
                pushmode $c +o $n
        }
}

putlog "TCL | Identify"
