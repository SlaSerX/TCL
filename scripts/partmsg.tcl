## Random Phrases, please if the phrase have " make it with \"
set phrases {
    "Thanks for visiting, come again soon!"
    "Bye, see you again soon!"
    "Please come again!"
}
bind part - * part_proc

proc part_proc {nick uhost hand chan msg} {
global phrases
    set text [lindex $phrases [rand [llength $phrases]]]
    puthelp "NOTICE $nick :$text"
}
putlog "PartMSG by dJ_TEDY Loaded."