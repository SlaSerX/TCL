
bind pub n|n "!up" show_uptime

proc show_uptime {nick host handle chan text} {
global uptime version

catch {exec uptime} box(uptime)
catch {exec uname -sr} box(uname)
catch {exec hostname} box(hostname)

set eggdrop(version) [lindex [split $version " "] 0]
set eggdrop(uptime) [alt_duration [expr { [unixtime] - $uptime } ]]

putquick "PRIVMSG $chan :\002$nick\002: \002Machine uptime\002:$box(uptime) (\002TCM uptime\002: $eggdrop(uptime))"
}

proc alt_duration {time} {
if {[regexp {^[0-9]+$} $time]} { set time [duration $time] }

set time [string map { " years" "y" " year" "y" " months" "m" " month" "m" " days" "d" " day" "d" } $time]
set time [string map { " hours" "h" " hour" "h" " minutes" "m" " minute" "m" " seconds" "s" " second" "s" } $time]
set time [string map { " weeks" "w" " week" "w" } $time]

return $time
}




bind pub N "!up" show_uptime

proc show_uptime {nick host handle chan text} {
global uptime version

catch {exec uptime} box(uptime)
catch {exec uname -sr} box(uname)
catch {exec hostname} box(hostname)

set eggdrop(version) [lindex [split $version " "] 0]
set eggdrop(uptime) [alt_duration [expr { [unixtime] - $uptime } ]]

putquick "PRIVMSG $chan :\002$nick\002: \002Machine uptime\002:$box(uptime) (\002TCM uptime\002: $eggdrop(uptime))"
}

proc alt_duration {time} {
if {[regexp {^[0-9]+$} $time]} { set time [duration $time] }

set time [string map { " years" "y" " year" "y" " months" "m" " month" "m" " days" "d" " day" "d" } $time]
set time [string map { " hours" "h" " hour" "h" " minutes" "m" " minute" "m" " seconds" "s" " second" "s" } $time]
set time [string map { " weeks" "w" " week" "w" } $time]

return $time
}



