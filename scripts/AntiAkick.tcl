# AntiAkick.tcl v1.0 (23 Sep 2007)
# Idea by Kiril Georgiev a.k.a Arkadietz
# created by Yxaaaaaaa ( http://www.egghelp-bg.com )
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################


namespace eval eantiglobban {
    # informaciq za tcl-a
    variable version "antiglobban.tcl"
    # informaciq za avtora
    variable author "Yxaaaaaaa ( http://www.egghelp-bg.com/ )"
    
    # ako ne razbirash nedei pipa nadolu :)
    bind mode - *+b* [namespace current]::e:lookban
    proc e:lookban {n u h c m w} {
        if {$n == "CS" && ($w == "\*@\*" || $w == "\*!\*@\*")} {
            putserv "CS :listbans $c"
            putserv "CS :delban $c $w"
        }
    }
    bind notc - *\[mod:* [namespace current]::e:whoban
    bind notc - *channel*ban*list:* [namespace current]::e:chan
    proc e:chan {n u h t d} {
        variable echanak
        set echanak [lindex $t 1]
    }
    proc e:whoban {n u h t d} {
        variable echanak
        if {$n != "CS"} return
        if {[lindex $t 0] == "\*!\*@\*"} {
            set victim [string map [list "]" ""] [lindex $t 4]]
            putserv "CS :addban $echanak $victim 199 rm -rf *"
			putserv "CS :deluser $echanak $victim"
            newban "*!*@[lindex [split [getchanhost $victim] "@"] 1]" $::botnick "rm -rf *" 10
        }
    }
    putlog "TCL | Anti Akick"
}

