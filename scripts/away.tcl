## Forget nicks in nickchange to deop. 
set forget "*"
 
bind nick - * proc_nkch 

proc proc_nkch {nick uhost hand chan newnick} {
global forget
    foreach forg [split $forget] { 
        if {[string match "*$forg*" $newnick]} { 
            if {[botisop $chan]} { 
                if {[isop $newnick $chan]} { 
                    pushmode $chan -o $newnick 
                } 
            } 
        } 
    }
} 

putlog "Away bY dJ_TEDY Loaded."

