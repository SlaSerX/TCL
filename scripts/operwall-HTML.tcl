############################################################################
#                                                                          #
# operwall-html.tcl -- v1.0 by ZiDaNe <ZiDaNe@EggTcl.Org> <www.EggTcl.org> #
#                                                                          #
# This script logs WALLOPS/OPERWALL to a web page, so people can read      #
# it in real time (same as operwall.tcl, but writing logs in html format)  #
#                                                                          #
# NOTE: Your bot must be oper identified and must use +z user mode         #
#                                                                          #
############################################################################

## Settings
# Directory where logs will be saved (ex: /home/blabla/public_html/ow/")
set html(path) "/var/www/OPERWALL/"
#-> Html settings
# Title of the main web page
set html(title) "irc.LAMZO.com UniBG/OperWall"
# Background color
set html(background) "#CCCCCC"
# Font
set html(font) "Arial"
# Links' color
set html(link) "#000000"
# Active links' color
set html(alink) "#000000"
# Visited links' color
set html(vlink) "#000000"
# Page refresh time (in seconds)
set html(refreshtime) 5
## End of Settings

set scrver "1.1"

## binds
bind wall - "*OPERWALL*" operwall:log
bind wall - "*WALLOPS*"  operwall:log
bind wall - "*LOCOPS*"  operwall:log
#bind wall - "*ADMINWALL*"  operwall:log

## procs
proc operwall:todaypage {} {
	global html
	if {![file exists "$html(path)"]} {
		exec mkdir $html(path)
	}
	set date [clock format [clock seconds] -format {%d/%m/%Y}]
	set filesuffix [clock format [clock seconds] -format {%d%m%Y}]
	set fid [open "$html(path)operwall.$filesuffix.html" w]
	puts $fid "<html>\n<head><title>OperWall Log $date</title>\n<meta\
http-equiv=\"refresh\" content=\"$html(refreshtime)\">\n</head>\n<body\
bgcolor=$html(background) font=$html(font)>"
	close $fid
	if {![file exists "$html(path)operwall.html"]} {
		operwall:mainpage
	}
	set fid [open "$html(path)operwall.html" r]
	while {![eof $fid]} {
		set data [read $fid]
	}
	close $fid
	set rl "\\n<br><br>\\n</td></tr>\\n</table>\\n</body>\\n</html>\\n"
	regsub $rl $data {} data
	file delete -force "$html(path)operwall.html"
	set monthday [clock format [clock seconds] -format {%b %d}]
	set fid [open "$html(path)operwall.html" w]
	foreach line [split "$data" \n] {
		puts $fid "$line"
	}
	puts $fid "<a href=operwall.$filesuffix.html>$monthday</a> \|"
	puts $fid "<br><br>\n</td></tr>\n</table>\n</body>\n</html>"
	close $fid
}

proc operwall:mainpage {} {
	global html
        if {![file exists "$html(path)"]} {
                exec mkdir $html(path)
        }
	set fid [open "$html(path)operwall.html" w]
	puts $fid "<html>\n<head><title>$html(title)</title>\n</head>\n<body\
bgcolor=$html(background) link=$html(link) alink=$html(alink) vlink=$html(vlink)>"
	puts $fid "<table width=\"570\" border=\"0\" cellspacing=\"2\" cellpadding=\"0\">\n<tr>\n<td\
colspan=\"3\">\n<br><br>\n</td></tr>\n</table>\n</body>\n</html>"
	close $fid
}

proc operwall:log {hand msg} {
	global html
	set date [clock format [clock seconds] -format {%d/%m/%Y}]
	set filesuffix [clock format [clock seconds] -format {%d%m%Y}]
	set timestamp [clock format [clock seconds] -format "($date) \[%H:%M:%S\]"]
	if {![file exists "$html(path)operwall.$filesuffix.html"]} {
		operwall:todaypage
		set fid [open "$html(path)operwall.$filesuffix.html" a+]
		puts $fid "$timestamp $hand $msg<br>\n</body>\n</html>"
		close $fid
	} else {
		set fid [open "$html(path)operwall.$filesuffix.html" r]
		while {![eof $fid]} {
			set data [read $fid]
		}
		close $fid
		set rl "\\n</body>\\n</html>\\n"
		regsub $rl $data {} data
		file delete -force "$html(path)operwall.$filesuffix.html"
		set fid [open "$html(path)operwall.$filesuffix.html" w]
		foreach line [split "$data" \n] {
			puts $fid "$line"
		}
		puts $fid "$timestamp $hand $msg<br>"
		puts $fid "</body>\n</html>"
		close $fid
	}
}

if {![file exists "$html(path)operwall.html"]} {
	operwall:mainpage
}

## info
putlog "Loaded:OperWall.tcl"