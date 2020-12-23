## НАСТРОЙКИ ##

# Колко време да стои банът (в Минути)
set ban_time "60"

######################################
##  От тук надолу не редактирайте   ##
######################################


bind bot Z kb kbspam

proc kbspam {botnc kb inviter} {
 global ban_time
 set nick [lindex $inviter 0]
 #set bmask [lindex $inviter 1]
 set nickhand [nick2hand $nick]
 set bmask "[lindex [split $inviter] 1]"
 if {[matchattr $nickhand f] || [matchattr $nickhand b]} {
  putlog "14Защитен потребител:15 $nick ($bmask)" 
  return 0
 }
 putlog "14Засечен нарушител:4 $nick ($bmask)" 
 foreach chan [channels] {
 putquick "KICK $chan $nick :Засечен e СПАМ от вашият хост 15($bmask15). Моля, заповядайте отново след $ban_time минути."
 putquick "MODE $chan +b $bmask"
 newban "$bmask" "CHECK" "$nick 15($bmask15) Всякакъв вид спам в канала не се толерира." "$ban_time"
 #putquick "PRIVMSG $nick :Засечен e СПАМ от вашият хост 15($bmask15). Моля, заповядайте отново след $ban_time минути."
 }
}

putlog "Инсталиран: SpamKicker.tcl"
