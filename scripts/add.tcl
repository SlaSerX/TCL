setudef flag acc
bind notc - "*ACCESS*ADD*" csaccess
bind notc - "*ACCESS*DEL*" csdelacc
proc csdelacc {n u h t d} {
global CSuh
if {[strlwr "$n!$u"] == [strlwr $CSuh]} {
 set c [string replace [lindex $t [expr [llength $t] -3]] 0 0 ""]
 set c [string range $c 0 [expr [string length $c] - 2]]
 set nickh [lindex $t 0]
 set nick [lindex $t 4]
  if {[lsearch -exact [channel info $c] +acc] != -1} {
  chattr $nick |-hfjlmnoptxEPX $c 
  putlog "maham flagovete na $nick za kanala $c"
  return 0
}}}


proc csaccess {n u h t d} {
global CSuh
if {[strlwr "$n!$u"] == [strlwr $CSuh]} {
		set c [string replace [lindex $t [expr [llength $t] -4]] 0 0 ""]
		set c [string range $c 0 [expr [string length $c] - 2]]
 set nickh [lindex $t 0]
 set acc [lindex $t 1]
 set nick [lindex $t 4]
 set level [lindex $t 5]
 set uhost [getchanhost $nick $c]
set host [chost $uhost]
if {$host == "*!*@"} {set host $nick!*@*}
  if {[lsearch -exact [channel info $c] +acc] != -1} {
 if {$level < 21 || $level == 21} {
 adduser $nick;chattr $nick |+fEP $c;setuser $nick hosts $host
putlog "Zapisah $nick sus flagove +fEP za kanal $c.Sus host $host.";return 0}
 if {$level < 40 || $level == 25} {adduser $nick;chattr $nick |+foEP $c;setuser $nick hosts $host
putlog "Zapisah $nick sus flagove +foEP za kanal $c.Sus host $host";return 0}
 if {$level > 40 || $level == 40} {adduser $nick;chattr $nick |+mfoEP $c;setuser $nick hosts $host
putlog "Zapisah $nick sus flagove +mfoEP za kanal $c.Sus host $host";return 0}     
}}}
set CSuh "ChanServ!ChanServ@services.bg"