### Anti-Spam v1.4
### by demon <polatcho@jabse.com>
### AzzurraNet - #Sexy (TCL & Eggdrop)

set ver "1.4"

### Durata del ban (in minuti)
set btime 60
### Reason del kick
set bkick "Banned $btime minuti poradi spam."
### Canali in cui non kickare per spam
set dontban "#gyuvetch#gyuvetch"
### Canali o stringhe non ritenuti "spam"
set safestrings "#gyuvetch"
###Escriba los modos a bloquear / set mode lock.
set lockm "rm"



bind pubm - "*http://*" banspam
bind pubm - "*www.*" banspam
bind pubm - "*venite" banspam
bind pubm - "*vieni" banspam
bind pubm - "*visit" banspam
bind pubm - "*andiamo" banspam
bind pubm - "*andate" banspam
bind pubm - "*invita" banspam
bind pubm - "*join*" banspam
bind pubm - "*#*" banspam

bind pub n|n !unban unban
set dontban [string tolower $dontban]

proc unban {nick uhost hand chan argv} {
	if [killchanban $chan $argv]==0 {
	putserv "NOTICE $nick :$argv isn't in my Spammer Ban List."
	} else {
	putserv "MODE $chan -b $argv"
	}
}

proc banspam {nick uhost hand chan argv} {
global btime bkick dontban safestrings

set safe 0
set argv [string tolower $argv]
foreach safestring $safestrings {
 if  {[lsearch $argv [string tolower $safestring]]!=-1} {set safe 1}
}

if {[isop $nick $chan]==0 && [lsearch $dontban [string tolower $chan]]==-1 && $safe==0} {
	set banlamer $uhost
	set why "No Spam"
	set creator "Anti-Spam"
	newchanban $chan $uhost $creator $why $btime
	putserv "MODE $chan +b *!$uhost"
	putserv "mode $chan +m"
	putserv "KICK $chan $nick :$bkick"
	dccbroadcast "Anti-Spam TCL: Banned $nick from $chan"
}

}

putlog "TCL Loaded: Anti-Spam $ver by demon"
