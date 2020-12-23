# Begin - Entertainment, Message Auto-Reply. (ent_areply.tcl)
#	Designed & Written by Ninja_baby (Jaysee@Jaysee.Tv), © October 2000

# This TCL was made following the request of my friend Imran (ImRaN-- on DALnet) for his bot.
# This was a kewl idea, he ask how can his bots reply people who sent specific message-
# to the bot or to a channel, without getting lagged or stuffs. Thanks Imran ;) *hugs*
# Well as I said above, this TCL will make your bot reply people who send message-
# to it or to a channel (which listed in the variable). And that's the only purpose ;p
# but do not worry, the bot will auto-ignore people if it consider lines of messages-
# as excessive flood.

# Set this as reply channel. The bot will reply people ONLY in channels listed here. Eventhou-
# the words are same with what you sets below. You can set channelnames here as many as you-
# wish, but carefull you might make your bot getting lagged coz it has too many channels to-
# greet for ;p
set repchan {
  "#SweetHell"
}

# Ok fill this one with your words. Let me explain a little bit about HOW to set this variable.
# The one on the left side of the ":" sign is the trigger words. And words on the right side-
# of the ":" sign is what your bot will reply following the left one.
# Example: you set "hi :hello hello". Your bot will reply "hello hello" to people who said "hi"-
# in channel or to it.
# As my auto-greet does, you might set "%nick" here as replacement of the real nick the bot-
# will reply to. Example: there's a nick called "TheLamer" in channel, and you set-
# "hello :hi %nick". Then your bot will reply with words "hi TheLamer" when TheLamer guy said "hello"-
# in channel or to it.
# set this carefully and you might set this as many as you wish. ;)
set repwords {
  "hi :heya %nick, nice to see you ^_^"
  "hello:well hey there %nick.."
  "asl:I'm 11, f, Jakarta. and you?"
  "heh :%nick: eh?"
  "brb:be back soon!"
  "bye:%nick: hush! =P"
  "gtg:%nick: by3 by3, see ya'"
  "how r:fine thankie ^-_^, how r u?"
  "how are:fine thankie ^-_^, how r u?"
  "* bot:%nick: huh?"
}

# Set this as maximum trigger or lines before your bot consider the line of words as a flood.
# By setting this to "5:10", means if someone sent more than 5 lines within 10 seconds, the bot-
# will consider this as flood and will auto-ignore the person without giving any answers.
# So don't set this too low ;pp
set maxmsgrep 5:10

# Set this as messages which your bot will send to a user that just considered flooding.
# Set this as many as you wish, but remember, the key like %nick, etc. is NOT avalable in this-
# variable. I'm too lazy to convert those key in this variable, and will only get this script-
# work too hard ;pp hehe
set msgfloodm {
  "you're performing MSG which considered as FLOOD..."
}

# Set this as your bot auto-ignore time. Set this one in Minute(s) format.
set msgrepignore 1

# This is for your benefit hehe ;), you can either set your own LOGO here, your logo will appear-
# when the bot notice you, or when it makes msgs/notices/kicks or scripts loading. So keep smiling-
# and set this variable as you wish ;), you can either set this to "" to leave it blank.
set utlarlg "\[J-C\]:"

######### Please do not edit anything below unless you know what you are doing ;) #########

proc replyuser {nick uhost hand rest} {
	global botnick repwords msgcount maxmsgrep msgfloodm msgrepignore utlarlg
	if {[string match "#*" [lindex $rest 0]]} {set repto [lindex $rest 0] ; set rest [lrange $rest 1 end]} else {set repto $nick}
	set repperf 0
	foreach repwrd $repwords {
		set rquestion [lindex [split $repwrd :] 0]
		set ranswer [string trim [lrange [split $repwrd :] 1 end] "{}"]
		if {[string match [string tolower $rquestion]* [string tolower $rest]]} {
			regsub -all "%nick" $ranswer "$nick" ranswer
			set repperf 1 ; putquick "PRIVMSG $repto :$ranswer" ; return 0
		}
	}
	if {!$repperf && $repto != $nick} {return 0}
	set repperf 0 ; set n [string tolower *!*@[lindex [split $uhost @] 1]]
	if {[info exists msgcount($n)]} {
		set msgcount{$n} [incr msgcount($n)] ; set currmsgcount $msgcount($n) ; set maxmsgreprecv [lindex [split $maxmsgrep :] 0]
		if {$currmsgcount >= $maxmsgreprecv} {
			set msgingrep [lindex $msgfloodm [rand [llength $msgfloodm]]]
			foreach msgreptimer [utimers] {if {[string match "unset msgcount($n)" [lindex $msgreptimer 1]]} {killutimer [lindex $msgreptimer 2]}}
			if {$repto == $nick} {putquick "NOTICE $nick :$utlarlg $msgingrep. Ignored for: $msgrepignore min(s)."}
			newignore *!*@[lindex [split $uhost @] 1] $botnick "MSG flood" $msgrepignore
			putlog "$utlarlg MSG flood ($msgcount($n)), received from $nick. Message replies will be stopped for $msgrepignore min(s)." ; unset msgcount($n) ; return 1
		} else {
			foreach msgreptimer [utimers] {if {[string match "unset msgcount($n)" [lindex $msgreptimer 1]]} {return 1}}
			utimer [lindex [split $maxmsgrep :] 1] "unset msgcount($n)"
		}
	} else {set msgcount($n) 1}
}

proc replychan {nick uhost hand chan rest} {
	global botnick repchan
	foreach targchan $repchan {if {[string match *[string tolower $targchan]* [string tolower $chan]]} {append reps "$chan $rest" ; replyuser $nick $uhost $hand $reps ; return 0}}
}

bind msgm - * replyuser
bind pubm - * replychan
putlog "*** ${utlarlg} Entertainment, Entertainment, MSG Auto Reply + Query Flood Protection. Loaded."

# End of - Entertainment, Message Auto-Reply. (ent_areply.tcl)
