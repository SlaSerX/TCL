package require http
bind pub - ?wetter L:wetter
proc L:wetter {nick host hand chan arg} {
	set webstring "http://www.google.de/ig/api?weather=[lrange $arg 0 end]"
	catch {exec wget -O scripts/wetter.data $webstring} err
	set fp [open "scripts/wetter.data" r]; set wetterdata [read $fp]; close $fp
	regexp {(?i)<city data=\"(.*?)\"/>} $wetterdata -> wetter(stadt)
	regexp {(?i)<postal_code data=\"(.*?)\"/>} $wetterdata -> wetter(plz)
	regexp {(?i)temp_c data=\"(.*?)\"/>} $wetterdata -> wetter(current_celsius)
	regexp {(?i)humidity data=\"(.*?)\"/>} $wetterdata -> wetter(current_feuchtigkeit)
	regexp {(?i)wind_condition data=\"(.*?)\"/>} $wetterdata -> wetter(current_wind)
	regexp {(?i)condition data=\"(.*?)\"/>} $wetterdata -> wetter(current_weather)
	if {$wetter(current_weather) == ""} { set wetter(current_weather) "Aktuelle Wetterlage unklar" }
	putserv "privmsg $chan :Wetter für $wetter(stadt) \($wetter(plz)\) - Temp: $wetter(current_celsius) °C - $wetter(current_wind) - $wetter(current_feuchtigkeit) - $wetter(current_weather)"
}
putlog "GoogleWeather by LuZ1 loaded"