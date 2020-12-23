# -------------------------------------------------------------------- #
#  /////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  #
# ||||||||||||||| International Weather Script v0.72 ||||||||||||||||| #
#  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/////////////////////////////////  #
# -------------------------------------------------------------------- #
# 			By Ycarus - yews@ifrance.com
# All scripts are available at : http://yews.fr.st/
# Tous les scripts sont disponibles sur : http://yews.fr.st/
# 

# This script is in english and french.
# Vous devez avoir http.tcl - You must have http.tcl

# You should read this file with a monospaced font.
# ======================================================================
# English comments of the script - Commentaires du script en anglais
#--------------------------------------------------------------------
# With this script you can see the weather of a city in the world.
# You can see the actual weather and the weather you will have.
# This script use the site : http://www.weather.com/
# You can have the weather in english (uk or us), french, spanish, deutch,
# and brezilian.
#
#Usage: !weather [-d] [help] [prev] [lng] <city,state|zip> [country]                 
#       or /msg bot !weather [-d] <city,state|zip> [country]
# 	"-d" will set a default allowing user to just type !weather. 
#	"prev" for forecast weather.
#	"lng" put here the language you want (us, fr, uk, es, br, de)
#
# You can enter locations in a number of ways. 
# - Zip Code 
# - City name (e.g., Atlanta, New York, Paris, etc.) 
# - City, State (e.g., Atlanta, GA or Atlanta, Georgia) 
# - City, Country (e.g., Paris, France) 
#
# If you want a city in germany, france, us,... If your script isn't in this
# language by default you should write : .wz lng city (where lng is the country
# of the city). For exemple : .wz fr nanterre display the result in french of
# the city "nanterre", and you can't find this city if the default language is
# "us"...
#
# If you have a problem you can put : !weather debug <your problem>
# Then you only have to send to me the generated file :)
#
# This script work with Eggdrop and Windrop.
#
# History :
#----------
# V0.72 (22 january 2003)
# * Little change in html for us language this time...
#
# V0.71 (10 january 2003)
# * Little change in html for uk language.
#
# V0.7 (9 january 2003)
# * You can now update the script directly by the command !update
#     with this, the update can keep all your settings.
# * Bugfixes
#
# V0.657 (8 january 2003)
# * They change again some html code in the US version... Again...
# * Now the script support when ° is <0
# * Happy new year !
#
# V0.656 (23 november 2002)
# * They change again some html code in the US version...
#
# V0.655 (10 september 2002)
# * Little change in the html code of the site
#
# V0.654 (10 august 2002)
# * Translation of the help in german by Binzi
#
# V0.653 (16 july 2002)
# * A little bug with the site... (strange redirection...)
#
# V0.652 (20 june 2002)
# * I hope this time it's ok...
#
# V0.651 (19 june 2002)
# * a little small bug ;)
#
# V0.65 (19 june 2002)
# * Bugfixes... (thank to McGuyver, Tommy Dool, Thornes, Aser,... to send me the bugs :)
# * A redirector if there is an error 301 or 302.
#
# V0.64 (15 june 2002)
# * The site change some html code
# * You can now see °C and °F (for all languages) also you can see mph and km/h (only if default is us)
#
# vx.xx (some other version, but too long history...)
#
# v0.5B
# * First public version
#
# Todo :
#-------
# * Give weather for the day you want...
# * Possibility to choose some other website
# * Script can auto adpat himself when there is a html code change

# Sorry for my very bad english, I'm french...

# ======================================================================
# Commentaires du script en français - French comments of the script
#--------------------------------------------------------------------
# Ce script permet d'afficher la météo d'une ville n'importe où dans
# le monde. Vous pouvez voir la météo actuelle ou les prévisions pour
# les 10 prochains jours.
# Vous pouvez avoir la météo en anglais (uk ou us), français, espagnol,
# brésilien, et allemand.
#
#Usage: !meteo [-d] [aide] [prev] [lng] <ville,état> [pays]                 
#       or /msg bot !meteo [-d] [aide] [prev] [lng] <ville,état> [pays]
# 	"-d" pour mettre un argument par défaut pour l'utilisateur. 
#	"prev" pour les prévisions météo.
#	"lng" mettez ici la langue que vous voulez (us, fr, uk, es, br, de)
#
# Si vous voulez une ville en allemagne, france, us, uk,... et si le script est
# par défaut dans une autre langue, vous devrier tapez :.wz lng ville (où lng
# est le pays de la ville). Par exemple : .wz fr nanterre va afficher en français
# le résultat pour la ville de "nanterre", ce que vous n'aurez par si votre langue
# par defaut est "us"...
#
# En cas de problème tapez : !meteo debug <description rapide du prob>
# Le script générera un fichier que vous devrez ensuite m'envoyeer par mail.
#
# Comme l'ensemble de mes scripts (ou presque) ce script est compatible
# avec Eggdrop et Windrop (et normalement tous les portages possibles).
#
# Historique :
#-------------
# V0.72 (22 janvier 2003)
# * Petit changement dans le code html de la version us (encore...)
#
# V0.71 (10 janvier 2003)
# * Petit changement dans le code html de la version uk
#
# V0.7 (9 janvier 2003)
# * Possibilité de mise à jour directement à partir du script (!update) avec
#     récupération de la configuration.
# * Correction de quelques bugs...
#
# V0.657 (8 janvier 2003)
# * Pareil, un changement ds le code html du site US
# * Le script gére maintenant les températures négatives
# * Bonne année :)
#
# V0.656 (23 novembre 2002)
# * Encore un changement du code html de la version US du site...
#
# V0.655 (10 septembre 2002)
# * Petit changement dans le code html du site...
#
# V0.654 (10 août 2002)
# * Traduction de l'aide en allemand par Binzi
#
# V0.653 (16 juillet 2002)
# * Un ptit bug du site... (redirection étrange...)
#
# V0.652 (20 juin 2002)
# * J'espère que ce coup ci c bon
#
# V0.651 (19 juin 2002)
# * un petit bug :)
#
# V0.65 (19 juin 2002)
# * Correction de bugs... (merci à McGuyver, Tommy Dool, Thornes, Aser,... pour 
# m'avoir envoyer les bugs :)
# * Ajout d'un redirecteur en cas de pages avec redirection (erreur 301 & 302)
#
# V0.64 (15 juin 2002)
# * Le site a changé du code HTML
# * Possibilité de voir dans les résultats en °C et °F (pour toutes les langues) 
#  et aussi en km/h et mph (pour la us seulement).
#
# vx.xx (Quelques autres versions, mais après l'historique devient vraiment trop long...)
#
# V0.5B
# * Premiere version publique
#
# Projets :
#----------
# * Afficher la météo détaillé pour le jour que l'on veut.
# * Pouvoir gérer d'autres sites
# * Capacité d'adaptation lors de changement de code html


# ======================================================================
# Ce programme est sous la licence GNU GPL v2 de la FSF.
# This script is under the GNU General Public License v2 of the FSF
# ------------------------------------------------------------------------
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; version 2 of the License.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
# ------------------------------------------------------------------------
# En résumer vous pouvez faire ce que vous voulez de ce script tant
# que vous précisez l'auteur original donc Ycarus et que vous le laissez sous
# la licence GNU v2 de la FSF.

#----------------
# Configuration :
#----------------
# .debconf
set iws(lang) "fr"; # régler ici la langue par défaut : fr,us, uk, br, es ou de. - Default language. (set this to "us" for weather of the USA in english)
set iws(allowdefuser) "1"; # Pour autoriser les utilisateurs à régler une ville par défaut - To set if user can save a default city ("1" for on)
set iws(trigger) "!"; # The charactère juste avant la commande. "" marche également. - The char before the cmd.
set iws(tmpfile) "tmpweatherinfo.txt"; # Le fichier temporaire - The temporary file
set iws(debugfile) "debugiwsfile.txt"; # Le fichier en cas de bugs - The file if there is a bug...
set iws(alwaysdebugon) "0"; # génére toujours le rapport de bug - Make always the file of bug even if there is no bugs...

set iws(celsiusfahrenheitandkmhmph) "1"; # pour afficher à la fois les °C, °F, mph et km/h -  To display at the same time °C, °F, mph and km/h
# To set how we can display the result (\002 = Bold), For the actual weather (%var% = variable; §word§ = word that change for every lnaguages)
# You can use %botnick% to put the nick of the bot.
#"\002 ---===> Weather Service <===---\002"
set iws(displaylook) {"\002 §Weather§ %nameofcity%: \002 %weather%, %temp%§°C§  \002§Wind§ : \002 %vent%" "\002 §Humidity§: \002 %humidite% \002§Barometer§: \002 %pression%. \002§Sun Index§: \002 %indUV% (%qtUV%)"}
# It's the same but for the forecast weather.
set iws(displaylookpre) {"\002 §Forecast§ %nameofcity%:\002" "%weather1%" "%weather2%" "%weather3%"}
# The separator between days for the forecast weather.
set iws(dayseparator) "-"

# Here you can but for what chan this script work (you can put "*" for all chan, don't forget the " " after the channel name :)
# Réglez ici les channels pour lesquelles ce script marche. Vous pouvez mettre '*' pour tous les chans.
set iws(activeon) "*"

# Here you put the channel where the result is in notice (don't forget the " " after the channel name :) You can also put "*"
# Pour que le résultat soit afficher en 'notice'. Vous pouvez aussi mettre "*" pour tous les chans.
set iws(notice) "#SweetHell"


# Here you put the channel where the result is on the chan (don't forget the " " after the channel name :) You can also put "*"
# Pour que le résultat soit afficher sur le chan. Vous pouvez aussi mettre "*" pour tous les chans.
set iws(channel) "#SweetHell"

# Here you put the channel where the result is in private (don't forget the " " after the channel name :) You can also put "*"
# Pour que le résultat soit afficher en 'private', Vous pouvez aussi mettre "*" pour tous les chans.
set iws(pv) "#SweetHell"

set iws(scriptpath) "scripts/"; # Path of the script.
# .endconf
# Here you can change the link where you can auto update the script.
# Ici vous pouvez changer le liens où le script se met à jour automatiquement.
set iwsupdate(lnk) "http://yews.dyndns.org/~yews/scripts/"; # Only the link, without any filename.
set iwsupdate(filename) "meteo"; # Only the name, without any extension.


#---------------------------------------
# Début du script - Start of the script
#---------------------------------------
# You MUST have http.tcl - Vous DEVEZ avoir http.tcl (v2.x?)

package require http

set iws(ver) "0.72"

# The cmd of Weather v3.2 of Murf (For compatibility):
bind pub - .wz pub_iws
bind pub - .wzc pub_iws
bind pub - .wzf pub_previws
bind msg - .wz msg_iws
bind msg - .wzc msg_iws
bind msg - .wzf msg_previws
# pub cmd of this script (you can disable some of them) :
bind pub - ${iws(trigger)}10day pub_iws
bind pub - ${iws(trigger)}tenday pub_iws
bind pub - ${iws(trigger)}weather pub_iws
bind pub - ${iws(trigger)}wetter pub_iws
bind pub - ${iws(trigger)}meteo pub_iws
bind pub - ${iws(trigger)}previsions pub_previws
bind pub - ${iws(trigger)}prevision pub_previws
bind pub - ${iws(trigger)}forecast pub_previws
# msg cmd of this script (you can disable some of them) :
bind msg - ${iws(trigger)}meteo msg_iws
bind msg - ${iws(trigger)}weather msg_iws
bind msg - ${iws(trigger)}wetter msg_iws
bind msg - ${iws(trigger)}previsions msg_previws
bind msg - ${iws(trigger)}prevision msg_previws
bind msg - ${iws(trigger)}forecast msg_previws
bind msg m ${iws(trigger)}update iws_auto_update
#--------------------------------------
proc msg_iws  { nick uhost handle arg } {
	set arg [check_string $arg]
	pub_iws $nick $uhost $handle $nick $arg
}

proc msg_previws  { nick uhost handle arg } {
	set arg [check_string $arg]
	pub_previws $nick $uhost $handle $nick $arg
}

proc pub_previws {nick uhost hand chan arg} {
	set arg [check_string $arg]
	set arg "prev $arg"
	pub_iws $nick $uhost $hand $chan $arg
}

proc pub_iws {nick uhost hand chan arg} {
	global iws numversion tcl_version tcl_platform token
	set token ""
	set weatherlnk ""
	set arg [check_string $arg]
	set iwsdisplayby "channel"
	if {$chan != $nick} {
		if {(![string match "*[string tolower $chan] *" [string tolower $iws(activeon)]] && $iws(activeon) != "*")} {
			putlog "Ask for weather on $chan by $nick, but script not active here"
			return 0
		}
		if {([string match "*[string tolower $chan] *" $iws(notice)] || $iws(notice) == "*")} {
			set iwsdisplayby "notice"
		}
		if {([string match "*[string tolower $chan] *" $iws(pv)] || $iws(pv) == "*")} {
			set iwsdisplayby "pv"
		}
		if {([string match "*[string tolower $chan] *" $iws(channel)] || $iws(channel) == "*")} {
			set iwsdisplayby "channel"
		}
		
	}
	# If you want to know when someone run this script :
	#putlog "Ask for weather by $nick for : $arg"
	
	# Procedures to put out all thinks we don't like :)
	proc virecharschiantsiws {s} {
		regsub -all -- \\\\ $s "" s
		regsub -all -- \\\[ $s "" s
		regsub -all -- \\\] $s "" s
		regsub -all -- \\\} $s "" s
		regsub -all -- \\\{ $s "" s
		regsub -all -- \\\" $s "" s
		if {[string first $s "\]"] == 0} { set s [string trimleft $s \]] }
		if {[string last $s "\["] == [expr [string length $s] - 1]} { set s [string trimright $s \[] }
		return $s
	}
	proc virehtmletrefoustrucnormaliws {s} {
		regsub -all -- "&eacute;" $s "é" s
		regsub -all -- "&egrave;" $s "è" s
		regsub -all -- "&quot;" $s "\"" s
		regsub -all -- "&amp;" $s "\&" s
		regsub -all -- "&nbsp;" $s " " s
		regsub -all -- "&#39;s" $s "" s
		return $s
	}
	# reset the language to default language
	set langiws $iws(lang)
	# for the debug script :
	set askuserfor "$arg"
	set iwsdebugon "0"
	set arg [string tolower $arg]
	set arg [virecharschiantsiws $arg]
	set prevmeteo "0"
	set displayhelp "0"
	if {([lindex $arg 0] == "-d" && $iws(allowdefuser) == "1")} {
		set arg [lrange $arg 1 end]
		setuser $hand XTRA iws.location $arg
	}
	if {([lindex $arg 0] == "help" || [lindex $arg 0] == "aide")} {
		set displayhelp "1"
	}
	if {[lindex $arg 0] == "debug"} {
		set iwsdebugon "1"
		set arg "paris france"
	}
	
	if {[lindex $arg 0] == "prev"} {
		set prevmeteo "1"
		set arg [lrange $arg 1 end]
	}
	if {[lindex $arg 0] == "de"} {
		set langiws "de"
		set arg [lrange $arg 1 end]
	}
	if {[lindex $arg 0] == "fr"} {
		set langiws "fr"
		set arg [lrange $arg 1 end]
	}
	if {[lindex $arg 0] == "uk"} {
		set langiws "uk"
		set arg [lrange $arg 1 end]
	}
	if {[lindex $arg 0] == "us"} {
		set langiws "us"
		set arg [lrange $arg 1 end]
	}
	if {[lindex $arg 0] == "br"} {
		set langiws "br"
		set arg [lrange $arg 1 end]
	}
	if {[lindex $arg 0] == "es"} {
		set langiws "es"
		set arg [lrange $arg 1 end]
	}
	# pour les prévisions météo - For weather forecast :
	if {[lindex $arg 0] == "prev"} {
		set prevmeteo "1"
		set arg [lrange $arg 1 end]
	}
	if {[string length $arg] == 0} {
		if {[validuser $hand] && $iws(allowdefuser) == 1} {
			set arg [getuser $hand XTRA iws.location]
		}
	}
	regsub -all -- " " $arg "%20" arg
	# All language and strings
	if {$langiws == "fr"} {
		set weatherlnk "http://fr.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
		set txtiws {
			"Veuillez préciser une ville. Tapez !meteo nomdelaville pays. (le nom du pays est requis si il y a plusieurs villes dans le monde avec le même nom)."
			"La ville que vous demandez n'est pas disponible."
			"Le serveur de météo est surchargé."
			"Météo de"
			"°C"
			"Vent"
			"Humidité"
			"Pression"
			"Indice UV"
			"mini"
			"Prévisions de"
			"\002Usage\002: !weather \[-d\] \[prev\] \[lng\]\[help\] <city,state|zip> \[country\]."
			"\002-d\002 will set a default allowing user to just type !weather. \002prev\002 for forecast weather. \002lng\002 put here the language you want (us, fr, uk, es, br, de). The result can also be better if 'lng' is the country where the city is."
		}
	}
	if {$langiws == "de"} {
		set weatherlnk "http://de.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
		# Someone translated this and I'm really happy now ;)
		set txtiws {
			"Bitte geben Sie eine Stadt an (und das Land, sollte der Name der Stadt nicht eindeutig sein)."
			"Sorry, fuer die gesuchte Stadt liegen uns leider keine Wetterdaten vor."
			"Der Wetter-Server ist zur Zeit leider ueberlastet, bitte versuchen Sie es spaeter erneut."
			"Wetterlage"
			"°C"
			"Wind"
			"Luftfeuchtigkeit"
			"Luftdruck"
			"UV-Index"
			"mini"
			"Wettervorhersage"
			"\002Syntax\002: !weather \[-d\] \[prev\] \[lng\]\[help\] <Stadt,Staat|PLZ> \[Land\]."
			"\002-d\002 setzt eine Stadt als Standard, deren Wetterlage ab dann mit der Eingabe von !weather abgerufen werden kann. \002prev\002 Zeigt die Wettervorhersage der naechsten Tage an. \002lng\002 Legt die gewuenschte Sprache fest (us, fr, uk, es, br, de). Setzen Sie 'lng' auf das Land der entsprechenden Stadt, um Ihr Suchergebnis zu verbessern."
		}
	}
	if {$langiws == "uk"} {
		set weatherlnk "http://uk.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
		set txtiws {
			"Please put the name of a city (and the country if there is some other city with the same name)."
			"Sorry we don't have the weather of the city you ask for."
			"Too many traffic on the weather server."
			"Weather"
			"°C"
			"Wind"
			"Humidity"
			"Barometer"
			"Sun Index"
			"mini"
			"Forecast Weather"
			"\002Usage\002: !weather \[-d\] \[prev\] \[lng\]\[help\] <city,state|zip> \[country\]."
			"\002-d\002 will set a default allowing user to just type !weather. \002prev\002 for forecast weather. \002lng\002 put here the language you want (us, fr, uk, es, br, de). The result can also be better if 'lng' is the country where the city is."
		}
	}
	if {$langiws == "us"} {
		set weatherlnk "http://www.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
		set txtiws {
			"Please put the name of a city (and the country if there is some other city with the same name)."
			"Sorry we don't have the weather of the city you ask for."
			"Too many traffic on the weather server."
			"Weather"
			"°F"
			"Wind"
			"Humidity"
			"Barometer"
			"Sun Index"
			"mini"
			"Forecast Weather"
			"\002Usage\002: !weather \[-d\] \[prev\] \[lng\]\[help\] <city,state|zip> \[country\]."
			"\002-d\002 will set a default allowing user to just type !weather. \002prev\002 for forecast weather. \002lng\002 put here the language you want (us, fr, uk, es, br, de). The result can also be better if 'lng' is the country where the city is."
		}
	}
	if {$langiws == "br"} {
		set weatherlnk "http://br.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
		# If someone can translate this I will be really happy :)
		set txtiws {
			"Please put the name of a city (and the country if there is some other city with the same name)."
			"Sorry we don't have the weather of the city you ask for."
			"Too many traffic on the weather server."
			"Condições Atuais"
			"°C"
			"Vento"
			"Umidade"
			"Barômetro"
			"Índice UV"
			"mini"
			"Forecast Weather"
			"\002Usage\002: !weather \[-d\] \[prev\] \[lng\]\[help\] <city,state|zip> \[country\]."
			"\002-d\002 will set a default allowing user to just type !weather. \002prev\002 for forecast weather. \002lng\002 put here the language you want (us, fr, uk, es, br, de). The result can also be better if 'lng' is the country where the city is."
		}
	}
	if {$langiws == "es"} {
		set weatherlnk "http://espanol.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
		# If someone can translate this I will be really happy :)
		set txtiws {
			"Please put the name of a city (and the country if there is some other city with the same name)."
			"Sorry we don't have the weather of the city you ask for."
			"Too many traffic on the weather server."
			"Condiciones actuales"
			"°C"
			"Viento"
			"Humedad relativa"
			"Barómetro"
			"Índice UV"
			"mini"
			"Forecast Weather"
			"\002Usage\002: !weather \[-d\] \[prev\] \[lng\]\[help\] <city,state|zip> \[country\]."
			"\002-d\002 will set a default allowing user to just type !weather. \002prev\002 for forecast weather. \002lng\002 put here the language you want (us, fr, uk, es, br, de). The result can also be better if 'lng' is the country where the city is."
		}
	}
	if {$displayhelp == "1"} {
		putserv "PRIVMSG $nick : [lindex $txtiws 11]"
		putserv "PRIVMSG $nick : [lindex $txtiws 12]"
		return 0
	}
	# There is no arg....
	if {[string length $arg] == 0} {
		putserv "PRIVMSG $nick : [lindex $txtiws 0]"
		return 0
	}
	# For user who can't put correctly the language of the script...
	if {($weatherlnk == "" || $langiws == "")} {
		set langiws "us"
		set weatherlnk "http://www.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
	}
	
	set search1ok "0"
	set iwssearchcityok "0"
	while {$iwssearchcityok == "0"} {
		# search for the city name
		set erroronconnection "0"
		set connectionok "0"
		while {$connectionok == "0"} {
			#putlog "méteo : recherche ville"
			if { [catch {http::geturl $weatherlnk -timeout 30000} token] } {
				if { [catch {http::geturl $weatherlnk -timeout 20000} token] } {
					putlog "Problem when we want to connect to : $weatherlnk"
					return 0
				}
			}
			#set token [http::geturl $weatherlnk -timeout 30000]
			if {([::http::status $token] == "ok")} {
				#puts stderr ""
				upvar #0 $token state
				foreach {name value} $state(meta) {
					if {[regexp -nocase ^location$ $name]} {
						set weatherlnk "[string trim $value]"
					}
				}
				set connectionok "1"
			} {
				if {$erroronconnection == "1"} {
					if {[::http::status $token] == "timeout"} {
						#prob
						putserv "PRIVMSG $nick : Connection Timeout..."
						return 0
					} {
						putlog "Connection error... to : $weatherlnk"
						return 0
					}
				}
				set finishhttp [http::Finish $token]
				set erroronconnection "1"
			}
		}
		
		#putlog "le lien 1 : $weatherlnk"
		# There are more than one city...	
		if {[string match "*search*" $weatherlnk]} {
			#<a href="/weather/local/FRXX0076">Paris, France</a><br>
			# choix entre plusieurs.
			set tmpweatherinfo [http::data $token]
			if { [catch {open "$iws(tmpfile)" w} tmpweatherfile] } {
				putlog "The script can't write the file : $iws(tmpfile) (make sure you have all the corrects right or the path is ok...)"
				return 0
			}
			puts $tmpweatherfile $tmpweatherinfo
			close $tmpweatherfile
			set tmpweatherinfile [open "$iws(tmpfile)" r]
			set endfile "0"
			while {![eof $tmpweatherinfile] && $endfile == "0"} {
				gets $tmpweatherinfile poi
				set poi [string trim $poi]
				if {[string match "*<a href=\"/weather/local/*\">*</a><br>*" $poi]} {
					set endfile "1"
					set weatherlnk [string range [string trim $poi] [expr [string first "<a href=" $poi] + 9] [expr [string first "\">" $poi] - 1]]
					if {$langiws == "fr"} {
						set weatherlnk "http://fr.weather.com$weatherlnk"
					} elseif {$langiws == "de"} {
						set weatherlnk "http://de.weather.com$weatherlnk"
					} elseif {$langiws == "uk"} {
						set weatherlnk "http://www.weather.co.uk$weatherlnk"
					} elseif {$langiws == "us"} {
						set weatherlnk "http://www.weather.com$weatherlnk?go=go&where=$arg&whatprefs="
					} elseif {$langiws == "br"} {
						set weatherlnk "http://br.weather.com$weatherlnk"
					} elseif {$langiws == "es"} {
						set weatherlnk "http://espanol.weather.com$weatherlnk"
					}
				}
				if {[string match "*Severe Weather Mode Index*" $poi]} {
					putserv "PRIVMSG $nick : Too many traffic on the server : There is a Weather Alert."
					close $tmpweatherinfile
					return 0
				}
			}
			#exemple : http://fr.weather.com/weather/local/FRXX0076 (for Paris)
			close $tmpweatherinfile
			
		}
		set finishhttp [http::Finish $token]
		# We can't find the city...
		if {[string match "*search*" $weatherlnk]} {
			if {$search1ok == "1"} {
				putserv "PRIVMSG $nick : \002[lindex $txtiws 1]\002"
				return 0
			}
			if {[string match "*%20de*" $arg]} {
				set arg [string range [string trim $arg] 0 [expr [string first "%20" $arg] - 1]]
				set weatherlnk "http://de.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
				set langiws "de"
				set search1ok "1"
			} elseif {[string match "*%20es*" $arg]} {
				set arg [string range [string trim $arg] 0 [expr [string first "%20" $arg] - 1]]
				set weatherlnk "http://espanol.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
				set langiws "es"
				set search1ok "1"
			} elseif {[string match "*%20br*" $arg]} {
				set arg [string range [string trim $arg] 0 [expr [string first "%20" $arg] - 1]]
				set weatherlnk "http://br.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
				set langiws "br"
				set search1ok "1"
			} elseif {[string match "*%20uk*" $arg]} {
				set arg [string range [string trim $arg] 0 [expr [string first "%20" $arg] - 1]]
				set weatherlnk "http://www.weather.co.uk/search/search?what=WeatherLocalUndeclared&where=$arg"
				set langiws "uk"
				set search1ok "1"
			} elseif {[string match "*%20fr*" $arg]} {
				set arg [string range [string trim $arg] 0 [expr [string first "%20" $arg] - 1]]
				set weatherlnk "http://fr.weather.com/search/search?what=WeatherLocalUndeclared&where=$arg"
				set langiws "fr"
				set search1ok "1"
			} elseif {[string match "*%20us*" $arg]} {
				set arg [string range [string trim $arg] 0 [expr [string first "%20" $arg] - 1]]
				set weatherlnk "http://www.weather.com/search/search?what=WeatherLocalUndeclared"
				set langiws "us"
				set search1ok "1"
			} {
				putserv "PRIVMSG $nick : \002[lindex $txtiws 1]\002"
				return 0
			}
		} {
			set iwssearchcityok "1"
		}
		# A weather alert or too many users.
		if {[string match "*newscenter*" $weatherlnk]} {
			putserv "PRIVMSG $nick : \002[lindex $txtiws 2]\002"
			return 0
		}
	}
	
	# For weather forecast :
	if {$prevmeteo == "1"} {
		#http://fr.weather.com/weather/tenday/FRXX0076?day=0&vert=WeatherCity
		regsub -all -- "local" $weatherlnk "tenday" weatherlnk
		set weatherlnk "$weatherlnk?day=0&vert=WeatherCity"
		#set token [http::geturl $weatherlnk -timeout 10000]
		if { [catch {http::geturl $weatherlnk -timeout 30000} token] } {
			if { [catch {http::geturl $weatherlnk -timeout 20000} token] } {
				putlog "Problem when we want to connect to : $weatherlnk"
				return 0
			}
		}
		set weatherinfo [http::data $token]
		#puts stderr ""
		upvar #0 $token state
		foreach {name value} $state(meta) {
			if {[regexp -nocase ^location$ $name]} {
				set weatherlnk "[string trim $value]"
			}
		}
		# A weather alert or too many users.
		if {[string match "*newscenter*" $weatherlnk]} {
			putserv "PRIVMSG $nick : [lindex $txtiws 2]"
			return 0
		}
		set finishhttp [http::Finish $token]
		set weatherfile [open "$iws(tmpfile)" w]
		puts $weatherfile $weatherinfo
		close $weatherfile
		set weatherinfile [open "$iws(tmpfile)" r]
		set prevtotal ""
		set nameofcitynear "0"
		set nameofcity ""
		set tempmax ""
		set tempmini ""
		set meteoprob ""
		while {![eof $weatherinfile]} {
			gets $weatherinfile poi
			set poi [string trim $poi]
			if {$nameofcitynear == "1"} {
				set nameofcitynear "0"
				set nameofcity "$poi"
			}
			if {[string match "*<IMG SRC=\"http://image.weather.com/web/blank.gif\" WIDTH=\"5\" HEIGHT=\"1\" BORDER=\"0\" ALT=\"\">*" $poi]} {
				set nameofcitynear "1"
			}
			if {[string match "*<IMG SRC=\"http://image.weather.com/web/common/*\" WIDTH=\"31\" HEIGHT=\"31\" BORDER=\"0\" ALT=\"*\">*" $poi]} {
				set weather [string range [string trim $poi] [expr [string first "BORDER=\"0\" ALT=" $poi] + 16] [expr [string first "\">" $poi] - 1]]
				set prevtotal "$prevtotal $weather"
			}
			# For us language
			if {$langiws == "us"} {
				if {[string match "*&deg;F" $poi]} {
					set temp [string range [string trim $poi] 0 [expr [string first "&deg;F" $poi] - 1]]
					if {$tempmax == ""} {
						set tempmax "$temp"
					} {
						set tempmini "$temp"
					}
				}
				if {[string match "*<BR>*" $poi]} {
					if {[string match "*</A><BR>*" $poi]} {
						set dayofmeteo [string range [string trim $poi] 0 [expr [string first "</A><BR>" $poi] - 1]]
						set nbandmonthofmeteo [string range [string trim $poi] [expr [string first "</A><BR>" $poi] + 8] [string length $poi]]
						if {$prevtotal == ""} {
							set prevtotal "$dayofmeteo $nbandmonthofmeteo :"
						} {
							if {$tempmini == ""} {
								if {($iws(celsiusfahrenheitandkmhmph) == "1" && [string is digit -strict $tempmax])} {
									set prevtotal "$prevtotal ([lindex $txtiws 9] : $tempmax°F/[expr (($tempmax - 32) * 10) / 18]°C) §§ $dayofmeteo $nbandmonthofmeteo :"
								} {
									set prevtotal "$prevtotal ([lindex $txtiws 9] : $tempmax°F) §§ $dayofmeteo $nbandmonthofmeteo :"
								}	
							} {
								if {($iws(celsiusfahrenheitandkmhmph) == "1"  && [string is digit -strict $tempmax])} {
									set prevtotal "$prevtotal ($tempmax°F/[expr (($tempmax - 32) * 10) / 18]°C-$tempmini°F/[expr (($tempmini - 32) * 10) / 18]°C) §§ $dayofmeteo $nbandmonthofmeteo :"
								} {
									set prevtotal "$prevtotal ($tempmax°F-$tempmini°F) §§ $dayofmeteo $nbandmonthofmeteo :"
								}
								
							}
							
							set tempmax ""
							set tempmini ""
							
						}
					} {
						set dayofmeteo [string range [string trim $poi] 0 [expr [string first "<BR>" $poi] - 1]]
						set nbandmonthofmeteo [string range [string trim $poi] [expr [string first "<BR>" $poi] + 4] [string length $poi]]
						if {$prevtotal == ""} {
							set prevtotal "$dayofmeteo $nbandmonthofmeteo :"
						} {
							if {$tempmini == ""} {
								if {($iws(celsiusfahrenheitandkmhmph) == "1" && [string is digit -strict $tempmax])} {
									set prevtotal "$prevtotal ([lindex $txtiws 9] : $tempmax°F/[expr (($tempmax - 32) * 10) / 18]°C) §§ $dayofmeteo $nbandmonthofmeteo :"
								} {
									set prevtotal "$prevtotal ([lindex $txtiws 9] : $tempmax°F) §§ $dayofmeteo $nbandmonthofmeteo :"
								}
							} {
								if {($iws(celsiusfahrenheitandkmhmph) == "1"  && [string is digit -strict $tempmax])} {
									set prevtotal "$prevtotal ($tempmax°F/[expr (($tempmax - 32) * 10) / 18]°C-$tempmini°F/[expr (($tempmini - 32) * 10) / 18]°C) §§ $dayofmeteo $nbandmonthofmeteo :"
								} {
									set prevtotal "$prevtotal ($tempmax°F-$tempmini°F) §§ $dayofmeteo $nbandmonthofmeteo :"
								}
							}
							set tempmax ""
							set tempmini ""
						}
					}
				}
			
			} {
			# for other language :
				if {[string match "*&deg;C*" $poi]} {
					set temp [string range [string trim $poi] 0 [expr [string first "&deg;C" $poi] - 1]]
					if {$tempmax == ""} {
						set tempmax "$temp"
					} {
						set tempmini "$temp"
					}
				}
				if {[string match "*</A><BR>*" $poi]} {
					set dayofmeteo [string range [string trim $poi] 0 [expr [string first "</A><BR>" $poi] - 1]]
					set nbandmonthofmeteo [string range [string trim $poi] [expr [string first "</A><BR>" $poi] + 8] [string length $poi]]
					if {$prevtotal == ""} {
						set prevtotal "$dayofmeteo $nbandmonthofmeteo : "
					} {
						if {$tempmini == ""} {
							if {($iws(celsiusfahrenheitandkmhmph) == "1" && [string is digit -strict $tempmax])} {
								set prevtotal "$prevtotal ([lindex $txtiws 9] : $tempmax°C/[expr ($tempmax * 1.8) + 32]°F) §§ $dayofmeteo $nbandmonthofmeteo :"
							} {
								set prevtotal "$prevtotal ([lindex $txtiws 9] : $tempmax°C) §§ $dayofmeteo $nbandmonthofmeteo :"
							}
						} {
							if {($iws(celsiusfahrenheitandkmhmph) == "1" && [string is digit -strict $tempmax])} {
								set prevtotal "$prevtotal ($tempmax°C/[expr ($tempmax * 1.8) + 32]°F-$tempmini°C/[expr ($tempmini * 1.8) + 32]°F) §§ $dayofmeteo $nbandmonthofmeteo :"
							} {
								set prevtotal "$prevtotal ($tempmax°C-$tempmini°C) §§ $dayofmeteo $nbandmonthofmeteo :"
							}
						}
						set tempmax ""
						set tempmini ""
					}
				}
				if {[string match "*.<BR>*" $poi]} {
					set dayofmeteo [string range [string trim $poi] 0 [expr [string first "<BR>" $poi] - 1]]
					set nbandmonthofmeteo [string range [string trim $poi] [expr [string first "<BR>" $poi] + 4] [string length $poi]]
					if {$prevtotal == ""} {
						set prevtotal "$dayofmeteo $nbandmonthofmeteo : "
					} {
						if {$tempmini == ""} {
							if {($iws(celsiusfahrenheitandkmhmph) == "1" && [string is digit -strict $tempmax])} {
								set prevtotal "$prevtotal ([lindex $txtiws 9] : $tempmax°C/[expr ($tempmax * 1.8) + 32]°F) §§ $dayofmeteo $nbandmonthofmeteo :"
							} {
								set prevtotal "$prevtotal ([lindex $txtiws 9] : $tempmax°C) §§ $dayofmeteo $nbandmonthofmeteo :"
							}
						} {
							if {($iws(celsiusfahrenheitandkmhmph) == "1" && [string is digit -strict $tempmax])} {
								set prevtotal "$prevtotal ($tempmax°C/[expr ($tempmax * 1.8) + 32]°F-$tempmini°C/[expr ($tempmini * 1.8) + 32]°F) §§ $dayofmeteo $nbandmonthofmeteo :"
							} {
								set prevtotal "$prevtotal ($tempmax°C-$tempmini°C) §§ $dayofmeteo $nbandmonthofmeteo :"
							}
						}
						set tempmax ""
						set tempmini ""
					}
				}
			}
			
		}
		close $weatherinfile
		# we display the result and we cut it in 3 parts
		set prevtotal [split $prevtotal "§§"]
		set weather1 [join [lrange $prevtotal 0 [expr ([llength $prevtotal] / 3)]]]
		set weather2 [join [lrange $prevtotal [expr [expr ([llength $prevtotal] / 3)] + 1] [expr (2 * [expr ([llength $prevtotal] / 3)])]]]
		set weather3 [join [lrange $prevtotal [expr [expr (2 * [expr ([llength $prevtotal] / 3)])] + 1] end]]
		regsub -all -- "   " $weather1 " $iws(dayseparator) " weather1
		regsub -all -- "   " $weather2 " $iws(dayseparator) " weather2
		regsub -all -- "   " $weather3 " $iws(dayseparator) " weather3
		set countelement "0"
		set prevweatherlook [putdisplayokpreviws $iws(displaylookpre) [lindex $txtiws 10] $nameofcity $weather1 $weather2 $weather3]
		while {$countelement != [llength $prevweatherlook]} {
			if {$iwsdisplayby == "notice"} {
				putquick "NOTICE $nick : [lindex $prevweatherlook $countelement]"
			} elseif {$iwsdisplayby == "pv"} {
				putquick "PRIVMSG $nick : [lindex $prevweatherlook $countelement]"
			} {
				putquick "PRIVMSG $chan : [lindex $prevweatherlook $countelement]"
			}
			incr countelement
		}
		return 0
	}
	
	# The actual weather
	#set token [http::geturl $weatherlnk -timeout 30000]
	#set weatherinfo [http::data $token]
	#set finishhttp [http::Finish $token]
	

	set erroronconnection "0"
	set connectionok "0"
	while {$connectionok == "0"} {
		#set token [http::geturl $weatherlnk -timeout 10000]
		if { [catch {http::geturl $weatherlnk -timeout 30000} token] } {
			if { [catch {http::geturl $weatherlnk -timeout 20000} token] } {
				putlog "Problem when we want to connect to : $weatherlnk"
				return 0
			}
		}
		# If there is redirect error (301 or 302) by Neil Madden.
		while {([http::ncode $token] == 301) || ([http::ncode $token] == 302)} {
			upvar #0 $token state
			array set meta $state(meta)
			http::cleanup $token
			set token [http::geturl $meta(Location)]
		}
		if {([::http::status $token] == "ok")} {
			set weatherinfo [http::data $token]
			set finishhttp [http::Finish $token]
			set connectionok "1"
		} {
			if {$erroronconnection == "1"} {
				if {[::http::status $token] == "timeout"} {
					#prob
					putserv "PRIVMSG $nick : Connection Timeout..."
					return 0
				} {
					putlog "Connection error... to : $weatherlnk"
					return 0
				}
			}
			set finishhttp [http::Finish $token]
			set erroronconnection "1"
		}
	}

	set weatherfile [open "$iws(tmpfile)" w]
	puts $weatherfile $weatherinfo
	close $weatherfile
		
	set weatherinfile [open "$iws(tmpfile)" r]
	# put all var to "" because if there is a problem and we can't detect something, then there is an error...
	set vent ""
	set pointderos ""
	set humidite ""
	set visibilite ""
	set weather ""
	set pression ""
	set temp ""
	set indUV ""
	set qtUV ""
	set nameofcity ""
	set meteoprob ""
	set themeteoprob ""
	set uv ""
	set wind ""
	set ihavecityname "0"
	while {![eof $weatherinfile]} {
		gets $weatherinfile poi
		set poi [string trim $poi]
		#putlog "$poi"
		if {[string match "*<TITLE>*</TITLE>*" $poi]} {
			set nameofcity [string range [string trim $poi] [expr [string last " - " $poi] + 3] [expr [string first "</TITLE>" $poi] - 1]]
			if {$nameofcity == "Local Weather Page"} {
				set nameofcity "$arg"
				regsub -all -- "%20" $nameofcity " " nameofcity
			} elseif {$nameofcity == "Local Travel Page"} {
				set nameofcity "$arg"
				regsub -all -- "%20" $nameofcity " " nameofcity
			}
		}
		if {[string match "*<TITLE>weather.com*" $poi]} {
			set langiws "us"
		}
		# if there is a weather alert...
		if {[string match "*<TD WIDTH=\"490\" CLASS=\"moduleTitle\">*</TD>*" $poi]} {
			set meteoprob [string range [string trim $poi] [expr [string first "CLASS=\"moduleTitle\">" $poi] + 20] [expr [string first "</TD>" $poi] - 1]]
		}
		if {[string match "*var marqueecontents=*Alert*/weather/alerts/?alertId=*/weather/alerts/?alertId=*,scrollbars')*" $poi]} {
			set themeteoprob [string range [string trim $poi] [expr [string first ",scrollbars')\\\">" $poi] + 16] [expr [string first "</A>&nbsp;&nbsp;&nbsp;" $poi] - 1]]
		}
		# for the us language
		if {$langiws == "us"} {
			# for us :
			#putlog "us language"
			if {([string match -nocase "*<b>* Forecast for*</b>*" $poi] && $ihavecityname =="0")} {
				set nameofcity [string range [string trim $poi] [expr [string first "for" $poi] + 3] [expr [string first "</B>" $poi] - 1]]
				set ihavecityname "1"
				#putlog "j'ai le nom de la ville :) : $nameofcity - $poi"
			}
			if {[string match -nocase "*Temp*>*&deg;F</B>*" $poi]} {
				#set poi [string tolower $poi]
				set temp [string range [string trim $poi] [expr [string first "obsTempTextA>" $poi] + 13] [expr [string first "&deg;" $poi] - 1]]
				
			}
			#if {[string match "*<!-- insert forecast*" $poi]} {
			#	set weather [string range [string trim $poi] [expr [string first "-->" $poi] + 3] [expr [string first "</TD>" $poi] - 1]]
			#}
			
			if {([string match "*<B CLASS=obsTextA>*</B></TD>*" $poi] && $weather == "")} {
				set weather [string range [string trim $poi] [expr [string first "obsTextA>" $poi] + 9] [expr [string first "</B>" $poi] - 1]]
				set weather [virehtmletrefoustrucnormaliws $weather]
			}
			#if {[string match "*>From*&nbsp;mph</TD>*" $poi]} {
			#	set vent [string range [string trim $poi] [expr [string first "obsTextBlue\">" $poi] + 13] [expr [string first "</TD>" $poi] - 1]]
			#	set vent [virehtmletrefoustrucnormaliws $vent]
			#	#putlog "j'ai le vent : $vent"
			#}
			if {[string match "*obsInfo2*" $poi] && $wind == "1"} {
				set vent [string range [string trim $poi] [expr [string first "obsInfo2>" $poi] + 9] [expr [string first "</TD>" $poi] - 1]]
				set vent [virehtmletrefoustrucnormaliws $vent]
			}
			if {[string match "*Wind:*" $poi]} {
				set wind "1"
			}
			if {[string match "*>*%</TD>*" $poi]} {
				set humidite [string range [string trim $poi] [expr [string first "obsInfo2>" $poi] + 9] [expr [string first "</TD>" $poi] - 1]]
			}
			if {[string match "*>*inches*</TD>" $poi]} {
				set pression [string range [string trim $poi] [expr [string first "obsInfo2>" $poi] + 9] [expr [string first "</TD>" $poi] - 1]]
				set pression [virehtmletrefoustrucnormaliws $pression]
			}
			if {[string match "*obsInfo2*" $poi] && $uv == "1"} {
				set qtUV [string range [string trim $poi] [expr [string first "obsInfo2>" $poi] + 9] [expr [string first "&nbsp;" $poi] - 1]]
				set indUV [string range [string trim $poi] [expr [string first "&nbsp;" $poi] + 6] [expr [string first "</TD>" $poi] - 1]]
				set indUV [virehtmletrefoustrucnormaliws $indUV]
				set uv "0"
			}
			if {[string match "*UV Index*" $poi]} {
				set uv "1"
			}
			
		} {
		# for the other language :)
			if {[string match "*align=\"center\" CLASS=\"obsText\">*" $poi]} {
				set weather [string range [string trim $poi] [expr [string first "CLASS=\"obsText\">" $poi] + 16] [expr [string first "<BR>" $poi] - 1]]
			}
			if {[string match "*<TD COLSPAN=\"2\" CLASS=\"obsTempText\" VALIGN=\"TOP\">&nbsp;*" $poi]} {
				set temp [string range [string trim $poi] [expr [string first ">&nbsp;" $poi] + 7] [expr [string first "&deg;C</TD>" $poi] - 1]]
			}
			if {[string match "*<TD CLASS=\"currentObsText\">*" $poi]} {
			
				if {$vent == ""} {
					set vent [string range [string trim $poi] [expr [string first "<TD CLASS=\"currentObsText\">" $poi] + 27] [expr [string first "</TD>" $poi] - 1]]
					set vent [virehtmletrefoustrucnormaliws $vent]
				} elseif {$pointderos == ""} {
					set pointderos [string range [string trim $poi] [expr [string first "<TD CLASS=\"currentObsText\">" $poi] + 27] [expr [string first "</TD>" $poi] - 1]]
				} elseif {$humidite == ""} {
					set humidite [string range [string trim $poi] [expr [string first "<TD CLASS=\"currentObsText\">" $poi] + 27] [expr [string first "</TD>" $poi] - 1]]
				} elseif {$visibilite == ""} {
					set visibilite [string range [string trim $poi] [expr [string first "<TD CLASS=\"currentObsText\">" $poi] + 27] [expr [string first "</TD>" $poi] - 1]]
				} {
					set pression [string range [string trim $poi] [expr [string first "<TD CLASS=\"currentObsText\">" $poi] + 27] [expr [string first "</TD>" $poi] - 1]]
				}
			}
			if {[string match "*<FONT CLASS=\"obsTempText\">*" $poi]} {
				set indUV [string range [string trim $poi] [expr [string first "<FONT CLASS=\"obsTempText\">" $poi] + 26] [expr [string first "</FONT" $poi] - 1]]
				set qtUV [string range [string trim $poi] [expr [string first "<BR>" $poi] + 4] [expr [string first "</TD>" $poi] - 1]]
			}
		}
		# We now have all weather info we need :)
	}
	close $weatherinfile
	
	# Debug proc
	if {($weather == "" || $temp == "" || $iws(alwaysdebugon) == "1" || $iwsdebugon == "1")} {
		if {[matchchanattr $nick m|m $chan] || [matchchanattr $nick n|n $chan]} {
			putserv "PRIVMSG $nick : You are the master of this eggdrop. This script can't work correctly, there is a bug or something else..."
			set writeindebugfile [open "$iws(debugfile)" w]
			puts $writeindebugfile "***** International Weather Script (IWS) by Ycarus *****"
			puts $writeindebugfile " IWS version : $iws(ver) - Eggdrop version : $numversion - TCL version : $tcl_version"
			puts $writeindebugfile "Platform : $tcl_platform(platform) - Machine : $tcl_platform(machine) - OS : $tcl_platform(os) - Version : $tcl_platform(osVersion)"
			puts $writeindebugfile "Language : $langiws"
			puts $writeindebugfile "The user ask for : $askuserfor"
			puts $writeindebugfile "The link we use is : $weatherlnk"
			puts $writeindebugfile "The tmp file is : $iws(tmpfile)"
			puts $writeindebugfile "var : weather : $weather - temp : $temp - wind : $vent - humidity : $humidite - barometer : $pression - uv : $indUV - meteoprob : $meteoprob"
			puts $writeindebugfile "lng $iws(lang) - defuser $iws(allowdefuser) - alwaysdebugon $iws(alwaysdebugon)"
			puts $writeindebugfile "display look : $iws(displaylook)"
			puts $writeindebugfile "display prev look : $iws(displaylookpre)"
			puts $writeindebugfile "separator : $iws(dayseparator) - chan actif : $iws(activeon) - notice : $iws(notice) - channel : $iws(channel) - pv : $iws(pv)"
			puts $writeindebugfile "---------- iwstmpfile : $iws(tmpfile) ----------------"
			set weatherinfile [open "$iws(tmpfile)" r]
			while {![eof $weatherinfile]} {
				gets $weatherinfile poi
				set poi [string trim $poi]
				puts $writeindebugfile "$poi"
			}
			close $weatherinfile
			puts $writeindebugfile "------------ End of the file -----------"
			close $writeindebugfile
			putserv "PRIVMSG $nick : You can test if there is a new version : ${iws(trigger)}update (in private with YOUR bot)"
			putserv "PRIVMSG $nick : If there is no new version, please, send the file : $iws(debugfile) to yews@ifrance.com"
		}
		
	}
	# putlog "conversion"
	# we can now put this info on the chan :)
	if {($meteoprob == "" || $temp != "")} {
		set countelement "0"
		if {$iws(celsiusfahrenheitandkmhmph) == "1"} {
			if {$langiws == "us"} {
				if  {[string is integer -strict $temp]} {
					set temp "[expr (($temp - 32) * 10) / 18]°C/$temp°F"
				}
				if {$vent != ""} {
					if {[string match "*calm mph*" $vent]} {
						regsub -all -- "mph" $vent "" vent
					}
					if {[string match "*mph*" $vent]} {
						set ventprevious $vent
						set vent [string range [string trim $vent] 0 [expr [string first "mph" $vent] - 3]]
						#putlog "vent1 : .$vent."
						set commentvent [string range [string trim $vent] 0 [expr [string last " " $vent] - 1]]
						set vent [string range [string trim $vent] [expr [string last " " $vent] + 1] [string length $vent]]
						# If there is a bug here : update to TCL 8.3...
						# I want to find if it's a number (0123456789)
						if {(![string is digit -strict $vent] || $vent == "calm")} {
							set vent $ventprevious
						} {
							set vent "$commentvent [expr ($vent * 8) / 5] km/h - $vent mph"
						}
					}
				}
			} {
				if  {[string is integer -strict $temp]} {
					set temp "$temp°C/[expr ($temp * 1.8) + 32]°F"
				}
				# There is a problem with the wind : it's not the same think for all languages. 
				#So I will correct that in the next version of this script.
				#set vent [string range [string trim $vent] 0 [expr [string first "km" $vent] - 2]]
				#set commentvent [string range [string trim $vent] 0 [expr [string last " " $vent] - 1]]
				#set vent [string range [string trim $vent] [expr [string last " " $vent] + 1] [string length $vent]]
				#set vent "$commentvent $vent km/h - [expr ($vent / 8) * 5] mph"
			}
			set actualweatherlook [putdisplayokiws $iws(displaylook) [lindex $txtiws 3] $nameofcity $weather $temp "" [lindex $txtiws 5] $vent [lindex $txtiws 6] $humidite [lindex $txtiws 7] $pression [lindex $txtiws 8] $indUV $qtUV]
		} {
			set actualweatherlook [putdisplayokiws $iws(displaylook) [lindex $txtiws 3] $nameofcity $weather $temp [lindex $txtiws 4] [lindex $txtiws 5] $vent [lindex $txtiws 6] $humidite [lindex $txtiws 7] $pression [lindex $txtiws 8] $indUV $qtUV]
		}
		while {$countelement != [llength $actualweatherlook]} {
				if {$iwsdisplayby == "notice"} {
					putquick "NOTICE $nick : [lindex $actualweatherlook $countelement]"
				} elseif {$iwsdisplayby == "pv"} {
					putquick "PRIVMSG $nick : [lindex $actualweatherlook $countelement]"
				} {
					putquick "PRIVMSG $chan : [lindex $actualweatherlook $countelement]"
				}
			incr countelement
		}
	} {
		putserv "PRIVMSG $chan :\002 [lindex $txtiws 3] $nameofcity \002: $meteoprob $themeteoprob"
	}
}




# this 2 procedure are to use the look we set at the beginning of the script. It's the only way I found to do this...
proc putdisplayokpreviws {prevweatherlook forecast nameofcity weather1 weather2 weather3} {
	global botnick
	regsub -all -- "%botnick%" $prevweatherlook "$botnick" prevweatherlook
	regsub -all -- "%nameofcity%" $prevweatherlook "$nameofcity" prevweatherlook
	regsub -all -- "§Forecast§" $prevweatherlook "$forecast" prevweatherlook
	regsub -all -- "%weather1%" $prevweatherlook "$weather1" prevweatherlook
	regsub -all -- "%weather2%" $prevweatherlook "$weather2" prevweatherlook
	regsub -all -- "%weather3%" $prevweatherlook "$weather3" prevweatherlook
	regsub -all -- \\\} $prevweatherlook "" prevweatherlook
	regsub -all -- \\\{ $prevweatherlook "" prevweatherlook
	return $prevweatherlook
}

proc putdisplayokiws {actualweatherlook wordweather nameofcity weather temp degfar wordvent vent wordhumidite humidite wordpression pression wordinduv indUV qtUV} {
	global botnick
	regsub -all -- "%botnick%" $actualweatherlook "$botnick" actualweatherlook
	regsub -all -- "§Weather§" $actualweatherlook "$wordweather" actualweatherlook
	regsub -all -- "%nameofcity%" $actualweatherlook "$nameofcity" actualweatherlook
	regsub -all -- "%weather%" $actualweatherlook "$weather" actualweatherlook
	regsub -all -- "%temp%" $actualweatherlook "$temp" actualweatherlook
	regsub -all -- "§°C§" $actualweatherlook "$degfar" actualweatherlook
	regsub -all -- "§Wind§" $actualweatherlook "$wordvent" actualweatherlook
	regsub -all -- "%vent%" $actualweatherlook "$vent" actualweatherlook
	regsub -all -- "§Humidity§" $actualweatherlook "$wordhumidite" actualweatherlook
	regsub -all -- "%humidite%" $actualweatherlook "$humidite" actualweatherlook
	regsub -all -- "§Barometer§" $actualweatherlook "$wordpression" actualweatherlook
	regsub -all -- "%pression%" $actualweatherlook "$pression" actualweatherlook
	regsub -all -- "§Sun Index§" $actualweatherlook "$wordinduv" actualweatherlook
	regsub -all -- "%indUV%" $actualweatherlook "$indUV" actualweatherlook
	regsub -all -- "%qtUV%" $actualweatherlook "$qtUV" actualweatherlook
	return $actualweatherlook
}

# There is a problem without this... You can send something to a file...
proc check_string {text} { 
  regsub -all ">" $text "" text 
  regsub -all "<" $text "" text 
  regsub -all "|" $text "" text 
  regsub -all "&" $text "" text 
  return $text 
} 

proc iws_auto_update { nick uhost handle arg } {
	global iwsupdate iws
	putserv "PRIVMSG $nick : Search for a new version..."
	set newversion "0"
	set linkupdate "$iwsupdate(lnk)$iwsupdate(filename).txt"
	if { [catch {http::geturl $linkupdate -timeout 30000} token] } {
		putserv "PRIVMSG $nick : Can't connect to the update site..."
	}
	# If there is redirect error (301 or 302) by Neil Madden.
	while {([http::ncode $token] == 301) || ([http::ncode $token] == 302)} {
		upvar #0 $token state
		array set meta $state(meta)
		http::cleanup $token
		set token [http::geturl $meta(Location)]
	}
	if {([::http::status $token] == "ok")} {
		set scriptversion [http::data $token]
		set finishhttp [http::Finish $token]
	} {
		if {$erroronconnection == "1"} {
		if {[::http::status $token] == "timeout"} {
				#prob
				putserv "PRIVMSG $nick : Connection Timeout..."
				return 0
			} {
				putlog "Connection error... to : $weatherlnk"
				return 0
			}
		}
		set finishhttp [http::Finish $token]
	}
	set scriptversiontmp [open "$iws(tmpfile)" w]
	puts $scriptversiontmp $scriptversion
	close $scriptversiontmp
	set scriptversionfile [open "$iws(tmpfile)" r]
	while {![eof $scriptversionfile]} {
		gets $scriptversionfile poi
		set poi [string trim $poi]
		if {!($poi == $iws(ver) || $poi == "")} {
			putserv "PRIVMSG $nick : There is a new version of the script : This is version $poi (you have version $iws(ver))."
			putserv "PRIVMSG $nick : Downloading..."
			set newversion "1"
		}
	}
	if {$newversion == "1"} {
		set linkupdate "$iwsupdate(lnk)$iwsupdate(filename).tcl"
		if { [catch {http::geturl $linkupdate -timeout 30000} token] } {
			putserv "PRIVMSG $nick : Can't connect to the update site..."
		}
		# If there is redirect error (301 or 302) by Neil Madden.
		while {([http::ncode $token] == 301) || ([http::ncode $token] == 302)} {
			upvar #0 $token state
			array set meta $state(meta)
			http::cleanup $token
			set token [http::geturl $meta(Location)]
		}
		if {([::http::status $token] == "ok")} {
			set thescript [http::data $token]
			set finishhttp [http::Finish $token]
		} {
			if {$erroronconnection == "1"} {
				if {[::http::status $token] == "timeout"} {
					#prob
					putserv "PRIVMSG $nick : Connection Timeout..."
					return 0
				} {
					putlog "Connection error... to : $weatherlnk"
					return 0
				}
			}
			set finishhttp [http::Finish $token]
		}
		set scriptfinal [open "$iws(tmpfile)" w]
		puts $scriptfinal $thescript
		close $scriptfinal
		set scriptfinal [open "$iws(tmpfile)" r]
		set finalfile [open "$iws(scriptpath)$iwsupdate(filename).tcl" w]
		putserv "PRIVMSG $nick : Download OK !!! Now update of the script configuration..."
		set debconfig "0"
		while {![eof $scriptfinal]} {
			gets $scriptfinal poi
			set poi [string trim $poi]
			if {([string match "*set*iws*" $poi] && $debconfig == "1")} {
				set varname [string range [string trim $poi] [expr [string first "iws" $poi] + 4] [expr [string first "\)" $poi] - 1]]
				if {[string match "*\{*\}*" $poi]} {
					set poi [string replace $poi [expr [string first "\{" $poi] + 1] [expr [string first "\}" $poi [expr [string first "\{" $poi] + 1]] - 1] $iws($varname)]
				} {
					set poi [string replace $poi [expr [string first "\"" $poi] + 1] [expr [string first "\"" $poi [expr [string first "\"" $poi] + 1]] - 1] $iws($varname)]
				}
			}
			if {[string match "*.debconf*" $poi]} {
				set debconfig "1"
			}
			if {[string match "*.endconf*" $poi]} {
				set debconfig "0"
			}
			puts $finalfile $poi
		}
		close $scriptfinal
		close $finalfile
		putserv "PRIVMSG $nick : Update OK!!! (the script rehash the conf)"
		rehash
	} {
		putserv "PRIVMSG $nick : No new version of the script..."
	}
}

# ------------------------------------------
# --- Fin du script -- End of the script ---
# ------------------------------------------
putlog "Weather Script bY dJ_TEDY Loaded."