####################################################################################
# Seen.tcl: Gets information about seen nick/hostmask and puts it on a channel.    #
#                                                                                  #
# Copyright (C) 2004-2006  Grigor Josifov (gogo@forci.com) [Grisha@UniBG]          #
#                                                                                  #
# This program is free software; you can redistribute it and/or                    #
# modify it under the terms of the GNU General Public License                      #
# as published by the Free Software Foundation; either version 2                   #
# of the License, or (at your option) any later version.                           #
#                                                                                  #
# This program is distributed in the hope that it will be useful,                  #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                   #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                    #
# GNU General Public License for more details.                                     #
#                                                                                  #
# You should have received a copy of the GNU General Public License                #
# along with this program; if not, write to the Free Software                      #
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.  #
#                                                                                  #
####################################################################################
# For more TCLs and IRC stuff visit: http://irc.forci.com/                         #
####################################################################################

# UniBG's Seen (irc.spnet.net)
set seennick "seen"
set seenhost "seen@seen-client.unibg.org"

# BOM's Seen (irc.forci.com)
#set seennick "Seen"
#set seenhost "Seen@BOM.Seen"

####################################################################################
#          DON'T EDIT ANYTHING BELOW UNLESS YOU KNOW WHAT YOU ARE DOING!           #
####################################################################################

#set ctcp-version "${ctcp-version} (seen.tcl by irc.forci.com)"

bind pub - seen pub:seen
bind pub - s33n pub:seen
bind pub - !seen pub:seen
bind pub - !s33n pub:seen
bind msgm - * msg:checkseen

proc cleanarg {arg} {
	set temp ""
	for {set i 0} {$i < [string length $arg]} {incr i} {
		set char [string index $arg $i]
		if {($char != "\12") && ($char != "\15")} {
			append temp $char
		}
	}
	set temp [string trimright $temp "\}"]
	set temp [string trimleft $temp "\{"]
	return $temp
}

proc pub:seen {nick host hand chan arg} {
	global seennick tmpchan
	set arg [charfilter $arg]
	if {[llength $arg] != 1} { return 0 }
	set seenfornick [lindex $arg 0]
	set tmpchan $chan
	putquick "PRIVMSG $seennick :seen $seenfornick f"
}

proc msg:checkseen {nick uhost hand arg} {
	global seennick seenhost tmpchan
	if {$nick==$seennick && $uhost==$seenhost} {
		putquick [format "PRIVMSG %s :%s" $tmpchan [string trimleft [string trimleft $arg "\[1\]"]]]
	}
	return 0;
}

proc charfilter {x {y ""} } {
	for {set i 0} {$i < [string length $x]} {incr i} {
		switch -- [string index $x $i] {
			"\"" {append y "\\\""}
			"\\" {append y "\\\\"}
			"\[" {append y "\\\["}
			"\]" {append y "\\\]"}
			"\} " {append y "\\\} "}
			"\{" {append y "\\\{"}
			default {append y [string index $x $i]}
		}
	}
	return $y
}

putlog "Инсталиран: Seen.tcl"
