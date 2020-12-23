#People 'known' by the bot, but without
#passes will be noticed on join.  Bots, as well as deop & auto-kick users
#will not be noticed (well there's no point really).
#+m users may use the dcc command ".checkpass" - returning a neat list of
#those without passes.  


#Bindings
bind join * * check_join
bind dcc m| checkpass check_pass

#Procs
proc check_join {nick uhost hand chan} {
  global botnick
  set ch [passwdok $hand ""]
    if {$ch == "1"} {
      if {([matchattr [nick2hand $nick $chan] b]) || ([matchattr [nick2hand $nick $chan] d]) || ([matchattr [nick2hand $nick $chan] k])} {return 0}
    putlog "12-=11 (3 $hand11 ) doesn't have a password set...sending notice. 12=-"
    putserv "notice $nick :12-=11 Hi,3 $nick,11 please set your password on the bot.12 =-"
    putserv "notice $nick :12-=11 Write: /msg3 $botnick 11pass <3password>. 12=-"
    putserv "notice $nick :12-= 11For DCC chat type: /ctcp3 $botnick 11chat 12=-"
    }
}

proc check_pass {hand idx arg} {
  set count 0
  foreach user [userlist] {
  set ch [passwdok $user ""] 
    if {$ch == "1"} {
    append list "$user, "
      incr count 1
    }
  }
    if {$count >= 1} {
    putdcc $idx "Users without a password ($count): [string trimright $list ", "]"
  } else {
    putdcc $idx "All users have a password set."
  }
  return 1
}

#Startup
#putlog "Loaded: passcheck.tcl"
