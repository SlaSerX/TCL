# Begin - Entertainment, Advanced Auto-Greet. (ent_agreet.tcl)
#	Designed & Written by Ninja_baby (Jaysee@Jaysee.Tv), © November 2000

# Ok, I've made this TCL in order to follow many requests (including myself hehe)-
# about channel auto-greets. Well. I tried to make this one simple and user-friendly-
# (errr.. I think NOT quietly user-friend coz you need to read the variable explanation hehe)
# This TCL will have feature to greet you as owner or other users when you or them joined-
# a channel, well you can setup your own channelnames so the bot will NOT greet users-
# on WHOLE channels (except the owners hehe). Well this TCL has two types of auto-greet too,
# you can either make your bot greet users or you by giving a notice, or my msg to channel.
# As my previous TCLs does, I put same feature here for auto-greet messages, you can set-
# up any words at many lines here, and the bot will greet people randomly.

# NOTE that you must NOT be lazy on setting up varibles here hehe. Enjoy!

# Set this to "1" if you like the bot to greet You or other owners. Leave it to "0" if you-
# don't like to.
set greetowner 0

# Set this one to "1" if you like to bot to greet other users rather than what it has in-
# it userlist. The bot will greet people with flags "*" (non-bot-users), or regular people.
set greetreg 1

# Set this one as Owner Greet Type. If you set this to "0", the bot will greet you-
# or other owners by sending message to channel. If you set this this to "1", the bot-
# will greet you or other owners by giving notice. (Each greet types has different-
# message too ;)) NOTE that this variable is NOT related with channel variable, though-
# the bot will greet its owners on ALL channels that it currently joined.
set ogreettype 0

# Set this one as Regular Users Greet Type. If you set this to "0", the bot will greet-
# users by sending message to channel. If you set this this to "1", the bot will greet users-
# by giving notice. (Each greet types has different message too ;)) NOTE that this variable-
# related with channel variable, the bot will greet its people ONLY on channel that you sets below.
# (except you set "greetallchan" to "1")
set rgreettype 0

# Set this one to "1" if you like the bot to greet regular users on ALL channels that it-
# currently on right now. The below variable ("greetchan") will be ignored. Or you might-
# set this to "0" to let you decide on which channels the bot should greet users.
set greetallchan 1

# Fill this one with channels name you like the bot to greet users. You can set as-
# many as you wish, separated by lines. Do not worry about non-existent channels. The-
# bot will check its channel list before it greet users.
set greetchan {
  "#SweetHell"
  "#cNc"
}

# Fill this one with handle-names which you wish to be greeted as Owner (see above too).
# NOTE that you should not put random nickname here, yo check out your bot userlist first ;p
# the bot will check out the userlist before it sends greets. If it found the nickname below-
# NOT as it master, it will NOT send any greet ;pp hehe
set ownerlist {
  "dJ_TEDY"
}

# Let's set greet messages. NOTE that you have to READ this comment before you continue.
# I'll explain about HOW to set greet variables below.

# For NOTICE type of greet. There are two keys that will be changed in the real-
# notice. The 1st one is "%nick". This one will changed with the real nickname on the IRC of-
# the greet-target. You can place this "%nick" anywhere on the greet.
# Example: There's a nick called "LamerNick" and your set "Welcome back %nick, nice to see you".
# The bot will send notice like this "Welcome back LamerNick, nice to see you".
# The 2nd is "%channel". This will be changed with the channel name that the bot currently-
# on with the greet-target.
# Example: There's a channel called "#Lamers" and your set "Welcome to %channel".
# The bot will send notice like this "Welcome to #Lamers".

# Let's now go to the CHANNEL MESSAGE type of greet. There are three key that will-
# get changed in the real message. That is "%nick", "%channel", and "\001ACTION \001"
# The "%nick" and "%channel" are same with the previous explanation. The new one is-
# "001\ACTION \001". Please carefull on setting this one. This ACTION stuffs will-
# make your bot ACT, or /me in channel. please SEE THE EXAMPLE VERY CAREFULLY:
# Example: There's a channel called "#Lamers", and the current joined nick is "TheLamer".
# and you set "001\ACTION greet %nick, enjoy your stay in %channel. =) \001"
# The bot will do "/me greet TheLamer, enjoy your stay in #Lamers. =)" I'm sure you already-
# know what /me is =P. but DO NOT forget to include the last \001 behind. Otherwise your-
# bot action will not work. The format is: "\001ACTION <msgs> \001"

# Ah, this is primary greet messages for owners. And this greet msg type is NOTICE. So-
# if you like to set greet for channel message type, ignore this one ;p. You can set this-
# as many as you want.
set nownerjoin {
  "%nick: Welcome back mommy...=)"
}

# Ok, this is primary greet messages for regular users. And this greet msg type is NOTICE. So-
# if you like to set greet for channel message type, ignore this one ;p. You can set this-
# as many as you want.
set nregjoin {
  "%nick: Welcome to %channel, make yourself comfortable... =)"
}

# This is a greet message with CHANNEL MESSAGE type. For OWNERS only! set this following-
# the instruction up there. You can set this as many as you wish.
set mownerjoin {
  "\001ACTION bites %nick's nose.. *honk* *honk* ^-_^ =p\001"
  "%nick: Mommy.. bwEEEE =p~ ^_^"
  "\001ACTION pokes %nick.. Mommy!! =p\001"
}

# This is a greet message with CHANNEL MESSAGE type. For REGULAR USERS! set this following-
# the instruction up there. You can set this as many as you wish.
set mregjoin {
  "\001ACTION gives %nick a cup of coffee, enjoy your stay in %channel =)\001"
  "%nick: Welcome to %channel =)"
  "\001ACTION greets %nick, Welcome to %channel \001"
  "\001ACTION jumps to %nick's nap.. heya.. nice to meet u here in %channel\001"
  "%nick: hiyaa %nick, got any chocolate? =P"
}

# This is for your benefit hehe ;), you can either set your own LOGO here, your logo will appear-
# when the bot notice you, or when it makes msgs/notices/kicks or scripts loading. So keep smiling-
# and set this variable as you wish ;), you can either set this to "" to leave it blank.
set utlaglg "\[J-C\]:"

######### Please do not edit anything below unless you know what you are doing ;) #########

proc autogreet {nick uhost hand chan} {
	global botnick greetchan greetowner greetreg ownerlist ogreettype rgreettype greetallchan nownerjoin nregjoin mownerjoin mregjoin utlaglg
	if {[isbotnick $nick]} {return 0}
	if {[matchattr $hand n]} {
		if {$greetowner} {
			foreach ownernick [string toupper $ownerlist] {
				if {[string match *$ownernick* [string toupper $nick]]} {
					if {$ogreettype} {
						set ownergreet [lindex $nownerjoin [rand [llength $nownerjoin]]]
						if {[matchattr "*001ACTION*" $ownergreet]} {return 0}
					} else {set ownergreet [lindex $mownerjoin [rand [llength $mownerjoin]]]}
					regsub -all "%nick" $ownergreet "$nick" ownergreet
					regsub -all "%channel" $ownergreet "$chan" ownergreet
					if {$ogreettype} {set gtype "NOTICE" ; set gtarget $nick} else {set gtype "PRIVMSG" ; set gtarget $chan}
					putquick "$gtype $gtarget :$ownergreet"
					putlog "$utlaglg <<$nick>> !$hand! joining $chan." ; return 0
				}
			}
		} ; return 0
	}
	if {$greetreg} {
		if {$rgreettype} {
			set reggreet [lindex $nregjoin [rand [llength $nregjoin]]] ; if {[matchattr "*001ACTION*" $reggreet]} {return 0}
		} else {set reggreet [lindex $mregjoin [rand [llength $mregjoin]]]}
		regsub -all "%nick" $reggreet "$nick" reggreet
		regsub -all "%channel" $reggreet "$chan" reggreet
		if {$rgreettype} {set gtype "NOTICE" ; set gtarget $nick} else {set gtype "PRIVMSG" ; set gtarget $chan}
		if {$greetallchan && !$rgreettype} {putquick "PRIVMSG $chan :$reggreet" ; return 0}
		if {$greetallchan && $rgreettype} {putquick "NOTICE $nick :$reggreet" ; return 0}
		foreach x $greetchan {if {[string tolower $chan] == [string tolower $x]} {putquick "$gtype $gtarget :$reggreet"}}
	} ; return 0
}

bind join - * autogreet
putlog "Advanced Auto Greet. by dJ_TEDY Loaded."