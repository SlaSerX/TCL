set reason "Banned: Sets bad channel modes"
set reasons "Sets bad channel modes"
bind mode - *+r* protmodes
bind mode - *+q* protmodes
bind mode - *+i* protmodes
bind mode - *+k* protmodes
bind mode - *+m* protmodes
bind mode - *+c* protmodes
bind mode - *-n* protmodes
bind mode - *-t* protmodes
bind mode - *-c* protmodes
bind mode - *-l* protmodes
# Lets protect channel #
proc protmodes {nick host hand chan args} {
global botnick reason reasons
set mask [maskhost $host]
set mask1 "$nick!*@*"
if {(![matchattr $hand n]) && (![matchattr $hand b])} {
putquick "CS :access $chan d $nick"
putquick "CS :clear $chan all"
putquick "CS :op"
putquick "mode $chan -ikmpsrntcl+ntb $mask1"
putquick "mode $chan +b $mask"
putquick "kick $chan $nick :$nick ($mask) слагането на тези модове е забранено (Expire: 3h)"
newban "$mask" "Badmodes" "$nick ($mask) слагането на тези модове е забранено (Expire: 3h)" "360"
}
}
putlog "Инсталиран: modes.tcl"