#hostcheck.tcl by toot :)  <toot@melnet.co.uk>
#use .hostcheck x, and it will give you a list
#of people with more than x hostnames on the bot.

bind dcc m|m hostcheck dcc:hostcheck

proc dcc:hostcheck {handle idx arg} {
   set hosts $arg
   if {$hosts == ""} {
      putdcc $idx "usage: .hostcheck <hosts>"
      return
   }
   append list ""
   putcmdlog "#$handle# hostcheck $hosts"
   set usercount 0
   foreach user [userlist] {
      set hostcount 0
      foreach host [getuser $user hosts] {
         incr hostcount 1
      }
      if {$hostcount >= $hosts} {
         append list "$user, "
         incr usercount 1
      }
   }
   if {$list >= 1} {
      putdcc $idx "$usercount users with $hosts or more hosts: [string trimright $list ", "]"
   } else {
      putdcc $idx "no users found with $hosts or more hosts"
   }
}