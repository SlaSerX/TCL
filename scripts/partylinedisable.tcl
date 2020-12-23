bind chon - * disableparty
proc disableparty {hand idx} {
    if {[matchattr $hand n} return
	putdcc $idx "#$hand# 4*** 14Сканирам потребителя, влязал в Partyline" 
boot $hand "Влизането в partyline в този бот е строго забранено. Връзката ще бъде прекъсната."
}
putlog "Инсталиран: partylinedisable.tcl"