# OnJoinMsg.tcl v1.0 (16 Nov 2006)
# Copyright by Kiril Georgiev a.k.a Arkadietz
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################

bind join - "*" e:onjoincheck
proc e:onjoincheck {n u h c} {
        putserv "PRIVMSG $n :Zdraveite sajeqlvame za bezpokoistvoto! Tova e proverka. Jelaem vi priqten chat :)"
}

putlog "TCL | On Join Msg"
