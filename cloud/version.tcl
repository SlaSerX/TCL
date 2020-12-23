# randversion.tcl v2.00 [1 August 2000] 
# Copyright (C) 1999-2000 Teemu Hjelt <temex@iki.fi>
#
# Latest version can be found from http://www.iki.fi/temex/eggdrop/
# 
# If you have any suggestions, questions or you want to report 
# bugs, please feel free to send me email to temex@iki.fi
#
# This script gets a random ctcp-version reply from a 
# list and sends it to the person who requested it. 
#
# Tested on eggdrop1.4.4 with TCL 7.6
#
# Version history:
# v1.00 - The very first version!
# v1.01 - One version-reply was missing a quotation mark.
# v1.02 - Added a flood protection and ircN quotes.
# v1.03 - Modified the flood protection a bit and renamed the procs.
# v1.04 - Added few new versions and updated the version number of ircN.
# v1.50 - Now you can specify what kind of version-replies you want to use.
#         Added rvstyle command with what you can change what versions-replies 
#         you want to use.
# v2.00 - Rewrote everything and changed the name of this script to randversion.tcl

### General Settings ###

## Use what versions?
# NAME     DESCRIPTION
# -------  ----------------
# eggdrop  Eggdrop versions
# misc     Misc versions
# ircii    ircII versions
# bitchx   BitchX versions
# mirc     mIRC versions
# all      All versions
set rv_style "all"

## What users can use rvstyle command?
set rv_flag "n"

### Flood Protection Settings ###

## [0/1] Do you want to enable the flood protection?
# Note: This only protects your bot from ctcp-finger flood.
set rv_fludprot 1

## Answer how many ctcp-fingers in how many seconds?
set rv_maxctcps 2:40

## [0/1] Do you want to ignore the flooder?
set rv_ignore 0

## How long do you want to ignore the flooder (min)?
set rv_ignoretime 10

## The users with one of the following flags shouldn't be ignored.
# Note: Leave this empty if you want to ignore everybody.
set rv_flags "m n o"

###### You don't need to edit below this ######

### Misc Things ###

set rv_ver "2.00"
set rv_maxctcps [split $rv_maxctcps :]
set rv_style [string tolower $rv_style]

## mIRC versions.
set rv_desc(mirc) "mIRC"
set rv_versions(mirc) {
	"mIRC32 v2.1a K.Mardam-Bey"
	"mIRC32 v2.3a K.Mardam-Bey"
	"mIRC32 v2.4a K.Mardam-Bey"
	"mIRC32 v2.5a K.Mardam-Bey"
	"mIRC32 v2.6b K.Mardam-Bey"
	"mIRC32 v2.7a K.Mardam-Bey"
	"mIRC32 v2.8b K.Mardam-Bey"
	"mIRC32 v2.8c K.Mardam-Bey"
	"mIRC32 v3.1 K.Mardam-Bey"
	"mIRC32 v3.2 K.Mardam-Bey"
	"mIRC32 v3.3 K.Mardam-Bey"
	"mIRC32 v3.4 K.Mardam-Bey"
	"mIRC32 v3.42 K.Mardam-Bey"
	"mIRC32 v3.5 K.Mardam-Bey"
	"mIRC32 v3.51 K.Mardam-Bey"
	"mIRC32 v3.6 K.Mardam-Bey"
	"mIRC32 v3.64 K.Mardam-Bey"
	"mIRC32 v3.7 K.Mardam-Bey"
	"mIRC32 v3.72 K.Mardam-Bey"
	"mIRC32 v3.8 K.Mardam-Bey"
	"mIRC32 v3.9 K.Mardam-Bey"
	"mIRC32 v3.92 K.Mardam-Bey"
	"mIRC32 v4.0 K.Mardam-Bey"
	"mIRC32 v4.1 K.Mardam-Bey"
	"mIRC32 v4.5 K.Mardam-Bey"
	"mIRC32 v4.52 K.Mardam-Bey"
	"mIRC32 v4.6 K.Mardam-Bey"
	"mIRC32 v4.7 K.Mardam-Bey"
	"mIRC32 v4.72 K.Mardam-Bey"
	"mIRC32 v5.0 K.Mardam-Bey"
	"mIRC32 v5.02 K.Mardam-Bey"
	"mIRC32 v5.1 K.Mardam-Bey"
	"mIRC32 v5.11 K.Mardam-Bey"
	"mIRC32 v5.3 K.Mardam-Bey"
	"mIRC32 v5.31 K.Mardam-Bey"
	"mIRC32 v5.4 K.Mardam-Bey"
	"mIRC32 v5.41 K.Mardam-Bey"
	"mIRC32 v5.5 K.Mardam-Bey"
	"mIRC32 v5.51 K.Mardam-Bey"
	"mIRC32 v5.6 K.Mardam-Bey"
	"mIRC32 v5.61 K.Mardam-Bey"
	"mIRC32 v5.7 K.Mardam-Bey"
	"mIRC32 v5.71 K.Mardam-Bey"
}

## ircII versions.
set rv_desc(ircii) "ircII"
set rv_versions(ircii) {
	"ircII 2.9_roof Linux 2.0.35 :debian-ircii 2.9: This is It."
	"ircII 2.8.2 Linux 2.0.35 :ircii 2.8: almost there..."
	"ircII 2.9_roof Linux 2.0.35 :Rhz v2.0 by Mason."
	"ircII 2.9_base Linux 2.0.35 :this is a bug free client. honest"
	"ircII 2.8.2-EPIC4pre0.038 Linux 2.0.35 - All the things phone wont include....."
	"ircII EPIC4pre2.001-NR7 Linux 2.0.35 - (can we scratch beneath this?)"
	"ircII 2.8.2-EPIC3.004 *IX - Version allowed only with Pass.. :-P"
	"ircII 4.4 IRIX 6.2 :ircii 2.9: AT&T you will (ojnk!)"
	"ircII 2.8.2 IRIX64 6.4 :SrfRoG's LiCe v2.6.3"
	"ircII 4.4 Linux 2.0.35 :SrfRoG's LiCe v2.5.2+Beta"
	"ircII 2.9beta2 Linux 2.0.35 : Using TinyIrcrc v5.34 (13.8.1997) by Tommi \[Hazor\] Lahtonen "
	"ircII 2.9alpha6 + ScrollZ v1.8e5 (27.3.97) by Flier + Cdcc v1.5 - Accept no limits!"
	"ircII 4.4A+ScrollZ v1.8i2/Public (12.09.98)+Cdcc v1.7 - Feel the power!"
	"ircII 4.4+ScrollZ v1.8h3 (31.03.98)+Cdcc v1.6 - storm\[sz\]"
	"ircII 4.4A+ScrollZ v1.8i2/Public (12.09.98)+Cdcc v1.7 - \[tantan.sz 0.4\]"
	"ircII 2.9alpha8+ScrollZ v1.8g1/public (31.8.97) by Flier + Cdcc v1.5 - delusion by scorpi0n (06/19/98)"
}

## BitchX versions.
set rv_desc(bitchx) "BitchX"
set rv_versions(bitchx) {
	"BitchX-75+Tcl1.5 by panasync - Linux 2.0.36 : Keep it to yourself!"
	"BitchX-75p1+Tcl1.5 by panasync - Linux 2.0.36 : Keep it to yourself!"
	"BitchX-75p2-9+Tcl1.6 by panasync - Linux 2.0.36 : Keep it to yourself!"
	"BitchX-75p2-10+Tcl1.6 by panasync - Linux 2.0.36 : Keep it to yourself!"
	"BitchX-75p2+Tcl2.0 by panasync - Linux 2.0.36 : Keep it to yourself!"
	"BitchX-75p3+Tcl2.0 by panasync - Linux 2.0.36 : Keep it to yourself!"
	"BitchX-74p4+ by panasync - Linux 2.0.34 : Keep it to yourself!"
	"BitchX-75p1+ by panasync - Linux 2.0.36 : Keep it to yourself!"
	"BitchX-75p3+ by panasync - Linux 2.0.36 : Keep it to yourself!"
	"BitchX-74p2+ by panasync - Linux 2.0.35 : Keep it to yourself!"
	"BitchX-74p1+Tcl1.3f by panasync - Linux 2.0.35 : Keep it to yourself!"
	"BitchX-75p1 by panasync - Linux 2.0.35 + win.irc v1.2.2 - by reflux : Keep it to yourself!"
	"BitchX-72p1+Tcl1.1/Linux 2.0.35 : (c)rackrockb/bX \[3.0.1á1\] : Keep it to yourself!"
	"BitchX-74a9/Linux 2.0.35 Tcl:(c)rackrock/bX\[3.0.1á2\] : Keep it to yourself!"
	"BitchX-74p1+Tcl1.3f by panasync - Linux 2.0.35 : Keep it to yourself!"
	"BitchX-74p4+1.3g/Linux 2.0.35 :(c)rackrock/bX \[3.0.1á9\] : Keep it to yourself!"
	"BitchX-75p2-8+ by panasync - CYGWIN32_NT 4.0 : Keep it to yourself!"
	"BitchX-75p1+ by panasync - CYGWIN32_95 4.0 : Keep it to yourself!"
}

## Misc versions.
set rv_desc(misc) "Misc"
set rv_versions(misc) {
	"cypress.01d -forced- / bitchx-75p1 :insane in the membrane"
	"#@!<( BitchX-75p1+ by panasync ) / ( hydroIRC 1.4-3 by hornet / hydrogen)>!@# -//-  :=-"
	"bitchx-74p1 + tunnelvision/1.2"
	"(ScrollZ\[v1.8h3\], sZ/oS\[0.9i2\], Linux\[2.0.35\])"
	"\[DyNaMiRc\] (v3.7) http://www.nonsolokick.com/data.htm"
	"In Command of VeNoM v2.01 by Dethnite"
	"core:dump 0.054i+p4 by guppy"
	"\[AtlantiS(v1.3a)\] by Dethnite"
	"KoiRa v. 5.38 ircII script by Terror Software"
	"Running Phoenix v2.27 by Vassago with Fluff Mods v1.8.6"
	"\[Decade v1.63 by drwit\] - she is me"
	"(%SmUrF%) v1.1.3-(B-Fixed) by ZaNaGa?"
	"(%schlong%) v2.4a by openface?"
	"(%schlong%) v2.2c by openface?"
	"perplex\[2.01!erawtic\] perplex"
	"(ircle 3.0b) Millennivm 2:0 (chemlab)"
	"Ircle 3.0b9 US PPC 09/21/1997 20:06:29 PM. #9???????"
	"PIRCH32:WIN 95/WIN NT:Beta Version 0.92:97.01.11"
	"PIRCH98:WIN 95/98/WIN NT:1.0 (build 1.0.1.1187)"
	"XiRCON 1.0B4"
	"Running Visual IRC '97 1.00. Get your copy today!! http://www.megalith.co.uk/virc"
	"Running Visual IRC '97 1.00almost-final3c. Get your copy today!! http://www.megalith.co.uk/virc"
	"AmIRC/AmigaOS 2.0 by Oliver Wagner <owagner@vapor.com> : http://www.vapor.com/ : \[#000000D0\] : This space for rent. Mail <ads@vapor.com> for more info."
	"Microsoft Chat 2.5 (4.71.2302) (comics mode)"
	"Microsoft Chat 2.1a (4.71.2201) (comics mode)"
	"Zircon 1.18 Pl: 187 *IX : tcl 8.0 tk 8.0"
	"Running KVirc 0.8.0 by Szymon 'Pragma@rv_ircnet' Stefanek <kvirc@tin.it> No script"
}

### Bindings ###

bind ctcp - VERSION ctcp:rv_version
bind dcc $rv_flag rvstyle dcc:rv_rvstyle

### Procs ###

proc dcc:rv_rvstyle {hand idx arg} {
global rv_style rv_desc rv_versions
set style [lindex [split $arg] 0]
	putcmdlog "#$hand# rvstyle $arg"
	if {$style == ""} {
		putidx $idx "Currently using: $rv_desc($rv_style) versions"
		putidx $idx "To get help, type: rvstyle -help"
	} elseif {[string tolower $style] == "-help"} {
		putidx $idx "NAME     DESCRIPTION"
		putidx $idx "-------  ----------------"
		foreach name [array names rv_versions] {
			putidx $idx "[format "%-8s %s" $name "$rv_desc($name) versions"]"
		}
		putidx $idx "To change the version-reply list, type: rvstyle <name>"
	} elseif {[lsearch -exact [array names rv_versions] [string tolower $style]] == -1} {
		putidx $idx "Version-reply list '$style' is invalid."
	} else {
		set rv_style [string tolower $style]
		putidx $idx "Version-reply list changed to: $rv_desc($rv_style) versions"
	}
}

proc ctcp:rv_version {nick uhost hand dest key arg} {
global rv_versions rv_style rv_fludprot rv_maxctcps rv_ignore rv_ignoretime rv_flags rv_flooded rv_ctcpcount
set hostmask "*!*[string range $uhost [string first "@" $uhost] end]"
	if {$rv_fludprot} {
		if {![info exists rv_ctcpcount]} { set rv_ctcpcount 0 }
		if {![info exists rv_flooded]} { set rv_flooded 0 }
		if {$rv_flooded} { return 1 }
		incr rv_ctcpcount
		utimer [lindex $rv_maxctcps 1] "incr rv_ctcpcount -1"
		if {$rv_ctcpcount > [lindex $rv_maxctcps 0]} {
			utimer [lindex $rv_maxctcps 1] "set rv_flooded 0"
			set rv_flooded 1
			putlog "randversion: Blocking ctcp-versions for [lindex $rv_maxctcps 1] seconds." 
			if {$rv_ignore} { 
				foreach flag $rv_flags { if {[matchattr $hand $flag]} { return 1 } }
				if {![isignore $hostmask]} { 
					newignore $hostmask $botnick "ctcp-version flood" $rv_ignoretime 
					putlog "randversion: Ignoring $hostmask for ctcp-version flood for $rv_ignoretime mins."
				}
			}
			return 1
		}
	}
	putserv "NOTICE $nick :\001VERSION [lindex $rv_versions($rv_style) [rand [llength $rv_versions($rv_style)]]]\001"
	return 1
}

proc rv_setversions { } {
global rv_desc rv_versions rv_style
	set rv_desc(eggdrop) "Eggdrop"
	set rv_versions(eggdrop) ""
	for {set i 0} {$i <= 28} {incr i} { lappend rv_versions(eggdrop) "eggdrop v1.3.${i}" }
	for {set i 0} {$i <= 4} {incr i} { lappend rv_versions(eggdrop) "eggdrop v1.4.${i}" }

	set rv_desc(all) "All"
	set rv_versions(all) ""
	foreach name [array names rv_versions] { 
		if {[string tolower $name] != "all"} {
			foreach version $rv_versions($name) {
				lappend rv_versions(all) $version
			}
		}
	}

	if {[lsearch -exact [array names rv_versions] $rv_style] == -1} {
		return 0
	} else {
		return 1
	}
}

### End ###

putlog "TCL loaded: randversion.tcl v$rv_ver by Sup <temex@iki.fi>"
if {[rv_setversions]} {
	putlog "   - Versions: $rv_desc($rv_style) versions"
} else {
	putlog "   - Versions: $rv_desc(all) versions (because '$rv_style' is invalid)"
	set rv_style "all"
}
if {$rv_fludprot} {
	putlog "   - Flood Protection: enabled. (Answering to [lindex $rv_maxctcps 0] ctcps in [lindex $rv_maxctcps 1] seconds)" 
} else {
	putlog "   - Flood Protection: disbaled." 
}