
## Settings
set html(path) "/var/www/optilan/"
#-> Html settings
# Title of the main web page
set html(title) "irc.Lamzo.com логове"
# Background color
set html(background) "#000000"
# Font
set html(font) "Tahoma"
# Links' color
set html(link) "#80ff00"
# Active links' color
set html(alink) "#80ff00"
# Visited links' color
set html(vlink) "#80ff00"
# Page refresh time (in seconds)
set html(refreshtime) 10
## End of Settings

set scrver "1.1"

## binds
bind wall - "*OPERWALL*" operwall:log
bind wall - "*WALLOPS*" operwall:log
#bind wall - "*LOCOPS*" operwall:log
bind wall - "*ADMINWALL*" operwall:log

## procs
proc operwall:todaypage {} {
global html
if {![file exists "$html(path)"]} {
exec mkdir $html(path)
}
set date [clock format [clock seconds] -format {%d %m %Y}]
set filesuffix [clock format [clock seconds] -format {%d%m%Y}]
set fid [open "$html(path)operwall.$filesuffix.html" w]
puts $fid "<html>\n<head><title>irc.Lmazo.com Лог от $date</title>\n<meta\
http-equiv=\"refresh\" charset=\"windows-1251\" content=\"$html(refreshtime)\">\n</head>\n<body\
bgcolor=$html(background) font=$html(font)>"
close $fid
if {![file exists "$html(path)index.html"]} {
operwall:mainpage
}
set fid [open "$html(path)index.html" r]
while {![eof $fid]} {
set data [read $fid]
}
close $fid
set rl "\\n<br><br>\\n</td></tr>\\n</table>\\n</body>\\n</html>\\n"
regsub $rl $data {} data
file delete -force "$html(path)index.html"
set monthday [clock format [clock seconds] -format {%d %B %Y}]
set fid [open "$html(path)index.html" w]
foreach line [split "$data" \n] {
puts $fid "$line"
}
puts $fid "<a href=\"operwall.$filesuffix.html\">$monthday</a> \<font color=\"#b40000\">|</font>"
close $fid
}

proc operwall:mainpage {} {
global html
if {![file exists "$html(path)"]} {
exec mkdir $html(path)
}
set fid [open "$html(path)index.html" w]
puts $fid "<html>\n<head><title>$html(title)</title>\n</head>\n<body\
bgcolor=$html(background) link=$html(link) alink=$html(alink) vlink=$html(vlink)>"
puts $fid "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1251\"><center><img src=\"http://irc.lamzo.com/my/ow.jpg\"><br><table width=\"570\" border=\"0\" cellspacing=\"2\" cellpadding=\"0\">\n<tr>\n<td\
colspan=\"3\">\n<br><br>\n</td></tr>\n</table><center>\n</body>\n</html>"
close $fid
}

proc operwall:log {hand msg} {
global html
set date [clock format [clock seconds] -format {%d %m %Y}]
set filesuffix [clock format [clock seconds] -format {%d%m%Y}]
set timestamp [clock format [clock seconds] -format "(%H:%M:%S\)"]
if {![file exists "$html(path)operwall.$filesuffix.html"]} {
operwall:todaypage
set fid [open "$html(path)operwall.$filesuffix.html" a+]
puts $fid "<b><font color=\"#00ff00\">$timestamp</font> <font color=\"#df00df\">!</font><font color=\"#999999\">$hand</font><font color=\"#df00df\">!</font><font color=\"#00ff00\"> $msg</font></b><br>\n</body>\n</html>"
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
puts $fid "<b><font color=\"#00ff00\">$timestamp</font> <font color=\"#df00df\">!</font><font color=\"#999999\">$hand</font><font color=\"#df00df\">!</font><font color=\"#00ff00\"> $msg</b></font><br>"
puts $fid "</body>\n</html>"
close $fid
}
}

if {![file exists "$html(path)index.html"]} {
operwall:mainpage
}

putlog "Loaded:OperWall.tcl"