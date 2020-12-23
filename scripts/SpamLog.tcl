set logdir "/home/user/public_html/spam"

# logging binds
bind pubm - "* #*" log:chat
bind pubm - "*www*" log:chat
bind pubm - "*http*" log:chat


bind notc - *#* log:notc
bind notc - *www* log:notc
bind notc - *http* log:notc

bind msgm - *#* log:private
bind msgm - *www* log:private
bind msgm - *http* log:private



# logging procs
proc log:chat {nick host hand chan text} {
  global logdir
  if {[matchattr $hand f]} {
  return 0 
  }
  set date [clock format [clock seconds] -format {%d.%m.%Y}]
  set logstr "<title>Спам статистика на мрежата</title><b>Дата</b>: <font color=\"#535353\"><b>\[$date\]</b></font>  <b>Час</b>: <font color=\"#535353\"><b>\[[strftime %H:%M:%S]\]</b></font> <b>Ник</b>: <font color=\"#ffffff\"><b>$nick</b></font> (<font color=\"#00ff00\"><b>$host</b></font>) каза в (<font color=\"#ff0000\"><b>$chan</b></font>): $text<br> "
  set addlog [open $logdir/[string range [string tolower iindex] 1 end].html a]
  puts $addlog "<body bgcolor=\"#000000\" text=\"#CCCCCC\">"
  puts $addlog "<meta http-equiv=\"content-type\" content=\"text/html; charset=windows-1251\" />"
  puts $addlog "<meta http-equiv=\"refresh\" content=\"10;URL=http://irc.is-bg.com/spam\">"
  puts $addlog "$logstr"
  close $addlog
}

proc log:private {nick host hand text} {
  global logdir
  if {[matchattr $hand f]} {
  return 0 
  }
  set date [clock format [clock seconds] -format {%d.%m.%Y}]
  set logstr "<title>Спам статистика на мрежата</title><b>Дата</b>: <font color=\"#535353\"><b>\[$date\]</b></font>  <b>Час</b>: <font color=\"#535353\"><b>\[[strftime %H:%M:%S]\]</b></font> <font color=\"#ffffff\"><b>$nick</b></font> (<font color=\"#00ff00\"><b>$host</b></font>) каза на (<font color=\"#ff0000\"><b>PRIVATE</b></font>): $text<br> "
  set addlog [open $logdir/[string range [string tolower iindex] 1 end].html a]
  puts $addlog "<body bgcolor=\"#000000\" text=\"#CCCCCC\">"
  puts $addlog "<meta http-equiv=\"content-type\" content=\"text/html; charset=windows-1251\" />"
  puts $addlog "<meta http-equiv=\"refresh\" content=\"10;URL=http://irc.is-bg.com/spam\">"
  puts $addlog "$logstr"
  close $addlog
}

proc log:notc {nick host hand args} {
  global logdir
  if {[matchattr $hand f]} {
  return 0 
  }
  set date [clock format [clock seconds] -format {%d.%m.%Y}]
  set logstr "<b>Дата</b>: <font color=\"#535353\"><b>\[$date\]</b></font>  <b>Час</b>: <font color=\"#535353\"><b>\[[strftime %H:%M:%S]\]</b></font> <font color=\"#ffffff\"><b>$nick</b></font> (<font color=\"#00ff00\"><b>$host</b></font>) прати (<font color=\"#ff0000\"><b>NOTICE</b></font>): $args<br> "
  set addlog [open $logdir/[string range [string tolower iindex] 1 end].html a]
  puts $addlog "<title>Спам статистика на мрежата</title><body bgcolor=\"#000000\" text=\"#CCCCCC\">"
  puts $addlog "<meta http-equiv=\"content-type\" content=\"text/html; charset=windows-1251\" />"
  puts $addlog "<meta http-equiv=\"refresh\" content=\"10;URL=http://irc.is-bg.com/spam\">"
  puts $addlog "$logstr"
  close $addlog
}

putlog "Инсталиран: SpamLog.tcl"