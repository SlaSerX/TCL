 set password "PAROLATA"
 set nsnick "NS"
 set csnick "CS"
 set nsserv "NS!NickServ@UniBG.services"
 set csserv "CS!ChanServ@UniBG.services"
 #bind-BaMe ToBa OHoBa :P
 bind raw -|- NOTICE ident:NS
 proc ident:NS {from keyword arg} {
 global nsnick csnick password nsserv csserv
 set servresp [lindex $arg 1]
 set msg [lrange $arg 0 end]
 if {$from==$nsserv} {
 if {[lindex $arg 1]==":If"} {
 putserv "PRIVMSG $nsnick :ID $password"
 putserv "PRIVMSG $nsnick :LOGIN $password"
 putlog "$nsnick want IDENTIFY.."
 }
 }
 if {$from==$csserv} {
 if {[lindex $arg 1]==":Password"} {
 putserv "PRIVMSG $nsnick :IDENTIFY $password"
 putserv "PRIVMSG $nsnick :LOGIN $password"
 putlog "$csnick Permission Denied following is $nsnick IDENTIFY.."
 }
 }
 }
 putlog "\002\00315..::\003\002\0038NS Identify Loaded\003\002\00315::..\003\002"
