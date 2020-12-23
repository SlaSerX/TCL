
set chat_setting(chan) "#Sofia"

set chat_setting(file) "/var/www/sofia/chat.htm"

set chat_setting(temp) "/var/www/sofia/chat/chat.tmp"

if {![file exists $chat_setting(file)]} {
	set filehand [open $chat_setting(file) w]
	puts -nonewline $filehand ""
	close $filehand
}

bind pubm - * chat_update

proc chat_update {nick uhost hand chan text} {
	global chat_setting
	if {![string match "* [string tolower $chan ]*" "l [string tolower $chat_setting(chan)] l"]} {
		return 0
	}
	set text_nick "($nick)"
	set text_form "$text_nick $text<BR>"
	chat_file $text_form
	return 0
}

proc chat_file {text} {
	global chat_setting
	set filehand [open $chat_setting(file) r]
	set filehandtemp [open $chat_setting(temp) w]
	set linenum 0
	while {![eof $filehand]} {
		set line [gets $filehand]
		set lines [incr linenum]
		puts $filehandtemp "$line"
	}
	puts -nonewline $filehandtemp "$text"
	close $filehand
	close $filehandtemp
	file rename -force $chat_setting(temp) $chat_setting(file)
}

putlog "Loaded:ChanLOG.tcl"
