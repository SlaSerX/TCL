bind join - * dk:search
proc dk:search {nick uhost hand chan} {
    if {![matchattr $hand f] && [matchattr $hand DK|DK $chan]} {
        set bmask "*!*@[lindex [split $uhost "@"] 1]"
        set rzn [getuser $hand COMMENT]
        putserv "mode $chan +b $bmask"
        putserv "kick $chan $nick :$rzn"
    }
}
