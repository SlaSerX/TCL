# badvergline.tcl v.69 [3 April 2005]
# Copyright (C) 2005 tehVibeh <tehvibeh@gmail.com>
#
# This script makes your bot ask ctcp-version from the people  
# who join a channel where the bot is. The bot punishs the 
# user with a gline if his/her ctcp-version reply matches one
### Settings ###

## Punish the people who have one of the following words in the ctcp-version reply.
set bv_versions {"*spambuster*" "*Zafeiris Melas*"} 

## Ask ctcp-version if user joins one of these channels.
# Note: Set this to "" to enable punishing on all channels.
set bv_chans ""

## [0/1] If user has a lame IRC-client/script then punish him/her only on $bv_chans?
# Note: If this is set to 0 then the bot punish user on all channels where the bot and the user are.
set bv_onlynvchans 1

## What is the reason for the punishment?
set bv_reason "Zarazen ste s mnogo opasen backdoor. Smenete clienta i zapowqdajte pak sled 2h"

## [0/1] GLine the user?
set bv_gline 1

## Ban for how long time (min)?
set bv_bantime 120

## What users can use the nvcheck command?
set bv_chkflag "N"

## Don't ask ctcp-version from Masters, Owners, Bots, or Ops ##
set bv_globflags "N"

## Don't ask ctcp-version from Masters, Owners, or Ops ##
set bv_chanflags "N"

###### DONT`T FLIPPIN` EDIT ANYTHING BELOW HERE ######

### Misc Things ###

set bv_ver "0.69"

### Bindings ###

bind join - * join:bv_askver
bind ctcr - VERSION ctcr:bv_ctcp
bind notc - * notc:bv_notice
bind dcc $bv_chkflag nvcheck dcc:nvcheck

### Main Procs ###

proc join:bv_askver {nick uhost hand chan} {
global botnick bv_chans bv_globflags bv_chanflags
	if {[string tolower $nick] != [string tolower $botnick]} {
		foreach globflag $bv_globflags { if {[matchattr $hand $globflag]} { return 1 } }
		foreach chanflag $bv_chanflags { if {[matchattr $hand |$chanflag $chan]} { return 1 } }
		if {($bv_chans == "") || ([lsearch -exact [split [string tolower $bv_chans]] [string tolower $chan]] != -1)} {
			putquick "PRIVMSG $nick :\001VERSION\001"
		}
	}
}

proc ctcr:bv_ctcp {nick uhost hand dest key arg} {
global botnick bv_versions bv_globflags bv_chanflags
	if {[string tolower $nick] != [string tolower $botnick]} {
		foreach version $bv_versions {
			if {[string match "*[string tolower $version]*" [string tolower $arg]]} { 
				bv_punish $nick $uhost 
			}
		}
	}
}

proc notc:bv_notice {nick uhost hand text {dest ""}} {
global botnick bv_versions bv_globflags bv_chanflags
if {$dest == ""} { set dest $botnick }
	if {([string tolower $nick] != [string tolower $botnick]) && ([string match "*version*" [lindex [string tolower $text] 0]])} {
		foreach version $bv_versions {
			if {[string match "*[string tolower $version]*" [lrange [string tolower $text] 1 end]]} { 
				bv_punish $nick $uhost 
			}
		}
	}
}

proc dcc:nvcheck {hand idx arg} {
set target [lindex [split $arg] 0]
	putcmdlog "#$hand# nvcheck $arg"
	if {$target == ""} {
		putidx $idx "Usage: .nvcheck <nick|channel>"
	} else {
		putidx $idx "Asking ctcp-version from $target..."
		putquick "PRIVMSG $target :\001VERSION\001"
	}
}

### Other Procs ###

proc bv_punish {nick uhost} {
global botnick bv_chans bv_onlynvchans bv_reason bv_gline bv_bantime
set hostmask "[lindex [split $uhost "@"] 0]*@[lindex [split $uhost "@"] 1]"
set hostmask1 "*[string range $uhost [string first "@" $uhost] end]"
set dowhat ""
	if {[string tolower $nick] != [string tolower $botnick]} {
		foreach chan [channels] {
			if {($bv_onlynvchans) && ([lsearch -exact [split [string tolower $bv_chans]] [string tolower $chan]] == -1)} { continue }
			if {($bv_gline)} { 
				if {![string match "*GLINING*" $dowhat]} { lappend dowhat "glining" }
				#putlog "KLINE $bv_bantime $hostmask $bv_reason"
				#putquick "KLINE $bv_bantime $hostmask $bv_reason"
			}
		}
		if {$dowhat != ""} {
			set dowhat "-- [join $dowhat " & "]"
		}
		putquick "kick $chan $nick $bv_reason"
		putquick "mode $chan +b $hostmask1"
		newban $hostmask1 BADCTCP $bv_reason $bv_bantime
		putlog "KLINE $hostmask1 :$bv_reason"
		putquick "KLINE $hostmask1 :$bv_reason"
	}
}

### End ###
set ver "IS-BG Team"
bind dcc n ctcp ctcp
global ver
set ctcp-finger ""
set ctcp-userinfo ""
set ctcp-ping ""
set ctcp-version "tcm-hybrid-v3.1.1-pre(20021229_0)"
bind ctcr - TIME { return }
putlog "Инсталиран: BADCTCP.tcl"