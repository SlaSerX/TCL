##########################
######## Settings ########
##########################
# NUJEN E http.tcl #
##########################

# Stream URL (e.g. http://domain.tld:port OR http://IP:port)
set url "servera:porta"
# Playlist URL (Leave empty for default stream playlist)
set playlist ""
# Public/User Channel
set streamch "#NEPROMENIAITUK"
# Private/DJ Channel
set djch "#KANALNADJ-te"
package require http


######## Показване песента, която свири ###############
#######################################################

bind pub -|- !song get_shoutcast_song 
bind pub -|- !np get_shoutcast_song
bind pub -|- !pesen get_shoutcast_song
 
proc get_shoutcast_song {nick uhost hand chan arg} {
   global url streamch
   set streamch [string tolower $streamch]
   ::http::config -useragent "Mozilla/5.0; Shoutinfo"
   if {[string tolower $chan] != "$streamch"} { 
   	set http_req [::http::geturl $url -timeout 2000]
	if {[::http::status $http_req] != "ok"} {
		putquick "PRIVMSG $chan :Радиото в момента не работи. Моля, проверете по-късно";
	}
	set data [::http::data $http_req]
	::http::cleanup $http_req
	if {[regexp {<font class=default>Current Song: </font></td><td><font class=default><b>([^<]+)</b>} $data x title]} {
		putquick "PRIVMSG $chan :\002В момента слушате\002: $title"
	} else {
		putquick "PRIVMSG $chan :Не получавам информация. Проверявам от сървъра..."
		get_shoutcast_server $nick $uhost $hand $chan $arg
	}
   }
}

######## Показване водещия, които води  ###############
#######################################################

bind pub -|- !vodi get_shoutcast_title
bind pub -|- !title get_shoutcast_title
bind pub -|- !dj get_shoutcast_title

proc get_shoutcast_title {nick uhost hand chan arg} {
   global url streamch
   set streamch [string tolower $streamch]
   ::http::config -useragent "Mozilla/5.0; Shoutinfo"
   if {[string tolower $chan] != "$streamch"} { 
   	set http_req [::http::geturl $url -timeout 2000]
	if {[::http::status $http_req] != "ok"} {
		putquick "PRIVMSG $chan :DJ-те са отпуска";
	}
	set data [::http::data $http_req]
	::http::cleanup $http_req
	if {[regexp {<font class=default>Stream Title: </font></td><td><font class=default><b>([^<]+)</b>} $data x title]} {
		putquick "PRIVMSG $chan :$title"
	} else {
		putquick "PRIVMSG $chan :Не получавам информация. Проверявам от сървъра..."
		get_shoutcast_server $nick $uhost $hand $chan $arg
	}
   }
}

######## Показване състоянието на радиото  ###############
##########################################################

bind pub -|- !status get_shoutcast_status
bind pub n|n !vgz get_shoutcast_status

proc get_shoutcast_status {nick uhost hand chan arg} {
   global url streamch
   set streamch [string tolower $streamch]
   ::http::config -useragent "Mozilla/5.0; Shoutinfo"
   if {[string tolower $chan] != "$streamch"} { 
   	set http_req [::http::geturl $url -timeout 2000]
	if {[::http::status $http_req] != "ok"} {
		putquick "PRIVMSG $chan :Радиото в момента не работи. Моля, проверете по-късно";
	}
	set data [::http::data $http_req]
	::http::cleanup $http_req
	if {[regexp {B>([^<]+) of} $data x title]} {
		regexp { of ([^<]+) listeners} $data x title2
		regexp {listeners ([^<]+)} $data x title3
		regexp {Stream is up at ([^<]+) with} $data x title4
		putquick "PRIVMSG $chan :Слушат ни\002 $title \002слушателя на честота $title4"
	} else {
		putquick "PRIVMSG $chan :Не получавам информация. Проверявам от сървъра..."
		get_shoutcast_server $nick $uhost $hand $chan $arg
	}
   }
}

######## Показване състоянието на сървъра  ###############
##########################################################

bind pub -|- !server get_shoutcast_server

proc get_shoutcast_server {nick uhost hand chan arg} {
   global url streamch
   set streamch [string tolower $streamch]
   ::http::config -useragent "Mozilla/5.0; Shoutinfo"
   if {[string tolower $chan] != "$streamch"} { 
   	set http_req [::http::geturl $url -timeout 2000]
	if {[::http::status $http_req] != "ok"} {
		putquick "PRIVMSG $chan :Радиото в момента не работи. Моля, проверете по-късно";
	}
	set data [::http::data $http_req]
	::http::cleanup $http_req
	if {[regexp {<font class=default>Server Status: </font></td><td><font class=default><b>([^<]+)</b>} $data x title]} {
		putquick "PRIVMSG $chan :\002Сървър\002: $title"
	} else {
		putquick "PRIVMSG $chan :Не получавам информация. Проверявам от сървъра..."
	}
   }
}

######## Показване уебсайта на радиото  ###############
#######################################################

bind pub -|- !site get_shoutcast_site
bind pub -|- !sait get_shoutcast_site
bind pub -|- !url get_shoutcast_site
bind pub -|- !website get_shoutcast_site

proc get_shoutcast_site {nick uhost hand chan arg} {
   global url streamch
   set streamch [string tolower $streamch]
   ::http::config -useragent "Mozilla/5.0; Shoutinfo"
   if {[string tolower $chan] != "$streamch"} { 
   	set http_req [::http::geturl $url -timeout 2000]
	if {[::http::status $http_req] != "ok"} {
		putquick "PRIVMSG $chan :Радиото в момента не работи. Моля, проверете по-късно";
	}
	set data [::http::data $http_req]
	::http::cleanup $http_req
	if {[regexp {>http://([^<]+)</a></b>} $data x title]} {
		putquick "PRIVMSG $chan :\002Нашият уеб сайт е\002: http://RadioErotic.NET/play.pls"
	} elseif {[regexp {>www.([^<]+)</a></b>} $data x title]} {
		putquick "PRIVMSG $chan :\002Нашият уеб сайт е\002: http://RadioErotic.NET/play.pls"
	} else {
		putquick "PRIVMSG $chan :Не получавам информация. Проверявам от сървъра..."
		get_shoutcast_server $nick $uhost $hand $chan $arg
	}
   }
}

######## Показване броят на слушателите  ###############
########################################################

bind pub -|- !record get_shoutcast_peak
bind pub -|- !peaks get_shoutcast_peak
bind pub -|- !max get_shoutcast_peak

proc get_shoutcast_peak {nick uhost hand chan arg} {
   global url streamch
   set streamch [string tolower $streamch]
   ::http::config -useragent "Mozilla/5.0; Shoutinfo"
   if {[string tolower $chan] != "$streamch"} { 
   	set http_req [::http::geturl $url -timeout 2000]
	if {[::http::status $http_req] != "ok"} {
		putquick "PRIVMSG $chan :Радиото в момента не работи. Моля, проверете по-късно";
	}
	set data [::http::data $http_req]
	::http::cleanup $http_req
	if {[regexp {<font class=default>Listener Peak: </font></td><td><font class=default><b>([^<]+)</b>} $data x title]} {
		putquick "PRIVMSG $chan :\002Има ли сме най-много \002$title\002 слушателя"
	} else {
		putquick "PRIVMSG $chan :Не получавам информация. Проверявам от сървъра..."
		get_shoutcast_server $nick $uhost $hand $chan $arg
	}
   }
}
 
##########    Може да ни слушате на:   #################
########################################################

bind pub -|- !radio get_shoutcast_listen
bind pub -|- !listen get_shoutcast_listen
bind pub -|- !play get_shoutcast_listen
bind pub -|- !link get_shoutcast_listen

proc get_shoutcast_listen {nick uhost hand chan arg} {
   global url streamch playlist
   set streamch [string tolower $streamch]
   if {[string tolower $chan] != "$streamch"} {
	if {$playlist == ""} {
		putquick "PRIVMSG $chan :\002Може да ни слушате на\002: http://RadioErotic.It.Cx"
	} else { 
		putquick "PRIVMSG $chan :\002Може да ни слушате на\002: $playlist"
	}
   }
}

##########    Пускане на поздрави:   #################
########################################################

bind pub -|- !pz get_shoutcast_request
bind pub -|- !pozdrav get_shoutcast_request

proc get_shoutcast_request {nick uhost hand chan arg} {
   global streamch djch
   set streamch [string tolower $streamch]
   if {[string tolower $chan] != "$streamch"} {
	putquick "PRIVMSG $djch :<font color=\"#808080\"><b>Поздрав:</font> <font color=\"#e6650f\">$arg</font> - <font color=\"#808080\">Поискан от:</font> <font color=\"#e6650f\">$nick</font></b>"
	putquick "NOTICE $nick :$nick, pozdrawa ti shte bude izluchen v efir!"
	putquick "NOTICE $nick :Moje da poruchate pozdrawi i v skype na user 4RadioErotic"
   }
}

###############################################
################## KILL DJ ####################
###############################################

bind pub R !killdj kicksource
proc kicksource {nick host handle chan text} {
#ip:
set server "karlovo-bg.com"
#port:
set port "8800"
#login (get it in mirc with /echo $encode(admin:PASS,m)
set login "YWRtaW46NDA0Mjg4MDRwYWNvI0Ah"
#
set sock [socket $server $port]
putquick "PRIVMSG $chan :Водещия е разкачен от радиото (by @$nick)"
putquick "PRIVMSG $chan :Сървъра $server:$port е готов за работа"
putlog "*** Killing current Dj stream (Killed by $nick)"
puts $sock "GET /admin.cgi?mode=kicksrc HTTP/1.1"
puts $sock "User-Agent:Mozilla"
puts $sock "Host: $server"
puts $sock "Authorization: Basic $login"
puts $sock ""
flush $sock
}
############## Ignore hostname ####################
bind pub R !+ignore pub_+pclone
proc pub_+pclone {nick uhost hand chan txt} {
if {[llength $txt]<1} {
putnotc $nick "Ползвай: !+ignore <mask>"
   return 0
 }
    newignore $txt $hand Denied
	putquick "PRIVMSG $chan :[strftime %T/%d.%m.%Y:] Host $txt e blokiran i nqma da ima vuzmojnost da puska pozdrawi (@$hand)"
    putlog "<<$nick>> \002!$hand!\002 Host $txt e blokiran i nqma da ima vuzmojnost da puska pozdrawi"
    save
    return 0
}

bind pub R !-ignore pub_-pclone
proc pub_-pclone {nick uhost hand chan txt} {
if {[llength $txt]<1} {
putnotc $nick "Ползвай: !-ignore <mask>"
   return 0
 }
    killignore $txt
	putquick "PRIVMSG $chan :[strftime %T/%d.%m.%Y:] Blokiraneto na host $txt e premahnato (@$hand)"
    putlog "<<$nick>> \002!$hand!\002 Blokiraneto na host $txt e premahnato <<$txt>>"
    save
    return 0
}
############## RADIO HELP #########################
bind pub - !help pub:Help
bind pub - !radiohelp pub:Help
bind pub - !helpradio pub:Help

proc pub:Help {nick uhost hand chan txt} {
putserv "notice $nick :Moje da ni slushate na adres: 14http://RadioErotic.It.cx"
putserv "notice $nick :Poruchaite si pozdrav i v nashiq skype: 14Radio.Erotic"
putserv "notice $nick :Mojte komandi, koito moe da polzvate sa:"
putserv "notice $nick :-------------------------------------------------"
putserv "notice $nick :4!pz 4<pozdrav4> - poruchaite si pozdrav, koito shte chuete v efir"
putserv "notice $nick :4!link - pokazva link za slushane na radioto"
putserv "notice $nick :4!pesen - pokazva pesenta, koqto vyrvi v momenta"
putserv "notice $nick :4!status - pokazva malka statistika na radioto"
putserv "notice $nick :4!dj - pokazva psevdonima na vodeshtia DJ"
putserv "notice $nick :4!sait - pokazva vruzka kum web saita ni"
putserv "notice $nick :------------ Za vuprosi: 14Paco -----------"
putserv "notice $nick :---------------- Krai na spisuka ----------------"

}




#bind pub -|- !genre get_shoutcast_genre 
#proc get_shoutcast_genre {nick uhost hand chan arg} {
#   global url streamch
#   set streamch [string tolower $streamch]
#   ::http::config -useragent "Mozilla/5.0; Shoutinfo"
#   if {[string tolower $chan] != "$streamch"} { 
#   	set http_req [::http::geturl $url -timeout 2000]
#	if {[::http::status $http_req] != "ok"} {
#		putquick "PRIVMSG $chan :Радиото в момента не работи. Моля, проверете по-късно";
#	}
#	set data [::http::data $http_req]
#	::http::cleanup $http_req
#	if {[regexp {<font class=default>Stream Genre: </font></td><td><font class=default><b>([^<]+)</b>} $data x title]} {
#		putquick "PRIVMSG $chan :\002Genre\002: $title"
#	} else {
#		putquick "PRIVMSG $chan :Couldn't receive any information, checking server status..."
#		get_shoutcast_server $nick $uhost $hand $chan $arg
#	}
#   }
#}
#bind pub -|- !icq get_shoutcast_icq 
#proc get_shoutcast_icq {nick uhost hand chan arg} {
#   global url streamch
#   set streamch [string tolower $streamch]
#   ::http::config -useragent "Mozilla/5.0; Shoutinfo"
#   if {[string tolower $chan] != "$streamch"} { 
#   	set http_req [::http::geturl $url -timeout 2000]
#	if {[::http::status $http_req] != "ok"} {
#		putquick "PRIVMSG $chan :Радиото в момента не работи. Моля, проверете по-късно";
#	}
#	set data [::http::data $http_req]
#	::http::cleanup $http_req
#	if {[regexp {<font class=default>Stream ICQ: </font></td><td><font class=default><b>([^<]+)</b>} $data x title]} {
#		putquick "PRIVMSG $chan :\002ICQ\002: $title"
#	} else {
#		putquick "PRIVMSG $chan :Couldn't receive any information, checking server status..."
#		get_shoutcast_server $nick $uhost $hand $chan $arg
#	}
#   }
#}
#bind pub -|- !aim get_shoutcast_aim 
#proc get_shoutcast_aim {nick uhost hand chan arg} {
#   global url streamch
#   set streamch [string tolower $streamch]
#   ::http::config -useragent "Mozilla/5.0; Shoutinfo"
#   if {[string tolower $chan] != "$streamch"} { 
#  	set http_req [::http::geturl $url -timeout 2000]
#	if {[::http::status $http_req] != "ok"} {
#		putquick "PRIVMSG $chan :Радиото в момента не работи. Моля, проверете по-късно";
#	}
#	set data [::http::data $http_req]
#	::http::cleanup $http_req
#	if {[regexp {<font class=default>Stream AIM: </font></td><td><font class=default><b>([^<]+)</b>} $data x title]} {
#		putquick "PRIVMSG $chan :\002AIM\002: $title"
#	} else {
#		putquick "PRIVMSG $chan :Couldn't receive any information, checking server status..."
#		get_shoutcast_server $nick $uhost $hand $chan $arg
#	}
#   }
#}
putlog "Инсталиран: shoutcast.tcl"
