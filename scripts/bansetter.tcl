bind mode N "* +b" bansetter
proc bansetter {nick uhost hand chan args} {
  global botnick
  set bancheto [lindex $args 1]
  newban "$bancheto" "BanSetter" "Banned by permanent owner (@$hand)"
  putquick "notice $nick :The hostmask 4$bancheto is now permanently banned"
}

bind mode N "* -b" unbansetter
proc unbansetter {nick uhost hand chan args} {
  global botnick
  set unbancheto [lindex $args 1]
  killban $unbancheto
  putquick "notice $nick :The hostmask 4$unbancheto is now unbanned"
}

putlog "Инсталиран: BanSetter.tcl"