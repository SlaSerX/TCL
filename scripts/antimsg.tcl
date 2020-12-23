unbind dcc o|o msg *dcc:msg
bind dcc o|o msg denied:msg
proc denied:msg {hand idx arg} {
set msg [string tolower [lindex $arg 0]]
set text [lrange $arg 1 end]
if {[matchattr $hand n]} {
if {$msg=="ns" || $msg=="cs" } {
if {$hand=="Faithless" } {
putserv "PRIVMSG $msg :$text"
putdcc $idx "msg to $msg: $text"
} else {
putdcc $idx "Access Denied"
}
} else {
putserv "PRIVMSG $msg :$text"
putdcc $idx "msg to $msg: $text"
}
} else {
putdcc $idx "Access Denied"
}
}