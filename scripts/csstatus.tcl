#########################################################################################################################################
#
# ��� ��� 9 16:34:00 2006
#
# ::: RUS :::
# v 1.0 by Frilak (frilak@gmail.com) irc://irc.alfa-com.ru/eggdrop - frilak
# - ������� ������ ���������� ��� ���� Counter Strike.!!!! �� ��� STEAM ������ !!!! ��� ������ ���������� ������ rcon:
# --- ftp://ftp.eggheads.org/pub/eggdrop/modules/1.6/ - ������ ��� *nix
# --- http://eggdrop.org.ru/files/rconmod.zip - ������ ��� windrop
# - ��������� ������� (� �������� ���������)  - !cs (���������� ���-�� ������� � �����) !players (���������� ������ ������� + �����)
# - ��� ������� �������� �������� ������� �� ip. ��� ����� ����� ������ ���� �������� �� ���� + �������� � ������ ������� (��� �����)
# - ������� ������� ����. 
# P.S ������ ���� ��������� � ����������� �� ���� (������) ���� ����������� �� ��� ����� � IRC
# P.P.S ������ ��� ������ ������� ��� ������� ����������� :) ������ ������ �� ��������.
# P.P.P.S ���� ������ �� �������� �������� ������ ��� ���� csstatus :)
#
# ::: TODO :::
# � ��������� ������ ������� ��������� ���������� �������� ) �����
#
# ======================================================================================================================================
#
# Thu Mar 9 16:34:00 2006
#
# ::: ENG :::
# v 1.0 by Frilak (frilak@gmail.com) irc://irc.alfa-com.ru/eggdrop - frilak
# - Just a simple script for monitoring Counter Strike Server.!!! NOT FOR STEAM SERVERS !!! For work requires module rcon:
# --- ftp://ftp.eggheads.org/pub/eggdrop/modules/1.6/ - version for *nix
# --- http://eggdrop.org.ru/files/rconmod.zip - version for windrop
# - Commands available - !cs (shows the number of players and the map) !players (shows the players list + their`s frags)
# - Admins are able to see players ip`s. To do so the admin should be in bot`s userlist + his handle should be in the admin list
# - Read comments below 
# P.S Send your comments by e-mail (at the top of the page) or directly in IRC
# P.P.S Firstly script was written for private use :)
# P.P.P.S If it doesn`t work may be you forgot the flag csstatus :)
# P.P.P.P.S Sorry for my baaaaad english...
#
# ::: TODO :::
# In the next version script will work with more then one server ) wait
#
#
#########################################################################################################################################

unloadmodule rcon
if {[loadmodule rcon]!=""} {
die "This script requires rcon module"
die "Download it from ftp://ftp.eggheads.org/pub/eggdrop/modules/1.6/ - for *nix\n http://eggdrop.org.ru/files/rconmod.zip - for windrop"
}

set cs(version) "1.0"

################## -- ��� ��������� ��� ���������� �������� -- #######################
################## -- This variables should be changed -- ############################

# ���� ) | Language ) (rus|eng)
set cs(lang) "eng"

# ���� ��� ��������� CS ������ | Host where the server is located
set cs(rhost) "91.134.48.66"

# ���� �� ������� �� �����. �� ��������� - 27015 | It`s port. By default - 27015
set cs(rport) "27015"

# ������ rcon ��� ����� ������� | It`s rcon password
set cs(rconpass) "lamzo123"

# ��������� ���� csstatus ��� ������ ������� ������ �� ����������� ������� | Reserving the flag csstatus to enable the script only at some chans
setudef flag csstatus

# ������ �����... | Adding binds...
bind pub - !cs cs_status
bind pub - !�� cs_status
bind pub - !�� cs_status
bind pub - !������ cs_players
bind pub - !������ cs_players
bind pub - !players cs_players

# ������ ������ ������� ������ �������� IP ������� �� ������� !players | The admins list. Add handles. They will see players IP`s
set cs(admins) "Frilak sanek etc"

####################### Do not change anything below this line if you don`t know what you`re doing #########################
####################### �� ������� ������ ���� ���� ����� ���� �� ������ ��� ������� #######################################

proc cs_status {nick uhost hand chan args} {
global cs
    set hostname ""
    set map ""
    set pl ""
    set max ""
    set challenge ""

if {![channel get $chan csstatus]} { return }
    set challenge [challengercon $cs(rhost) $cs(rport)]
if {$challenge=="-1"} {
    if {$cs(lang)=="rus"} {
    putquick "NOTICE $nick :������ ����������"
    } else {
    putquick "NOTICE $nick :Server not responding"
    }
    return
}
    set status [rcon $cs(rhost) $cs(rport) $challenge "$cs(rconpass)" status]
regsub -all -- {\ +} $status " " status
regsub -all -- {\# } $status "\#" status
foreach line [split $status "\n"] {
    if {[regexp -nocase -- {hostname: (.*?)$} $line garb hostname]} { continue }
    if {[regexp -nocase -- {map : (.*?) at.*$} $line garb map]} { continue }
    if {[regexp -nocase -- {players : (.*?) active \((.*?) max\)$} $line garb pl max]} { continue }
}
if {$cs(lang)=="rus"} {
    putquick "NOTICE $nick :$hostname"
    putquick "NOTICE $nick :����� - \0038$map. \0031������� \0033 $pl /\0036 $max"
    } else {
    putquick "NOTICE $nick :$hostname"
    putquick "NOTICE $nick :Map - \0038$map. \0031Players \0033 $p /\0036 $max"
    }
}
proc cs_players {nick uhost hand chan args} {
global cs
    set hostname ""
    set map ""
    set pl ""
    set max ""
    set challenge ""
    set players ""
    set templayer ""

if {![channel get $chan csstatus]} { return }
    set challenge [challengercon $cs(rhost) $cs(rport)]
if {$challenge=="-1"} {
    if {$cs(lang)=="rus"} {
    putquick "NOTICE $nick :������ ����������"
    } else {
    putquick "NOTICE $nick :Server not responding"
    }
    return
}
foreach adm [split $cs(admins) " "] {
    if {$hand==$adm} { set isadm 1 
    break
	} else { set isadm 0 }
}
    set status [rcon $cs(rhost) $cs(rport) $challenge "$cs(rconpass)" status]
regsub -all -- {\ +} $status " " status
regsub -all -- {\# } $status "\#" status
foreach line [split $status "\n"] {
if {[regexp -nocase -- {hostname: (.*?)$} $line garb hostname]} { continue }
if {[regexp -nocase -- {map : (.*?) at.*$} $line garb map]} { continue }
if {[regexp -nocase -- {players : (.*?) active \((.*?) max\)$} $line garb pl max]} { continue }
if {[regexp -nocase -- {\#[0-9]+ \"(.*?)\" [0-9]+ STEAM_ID_LAN ([0-9]+) [0-9]+:[0-9]+ [0-9]+ [0-9]+ (.*?):[0-9]+} $line garb tmplayer frags ip]} {
if {$frags>10} { set color "\0035" } else { set color "\0039" }
if {$isadm} {
    lappend players "\00310\[\00312$ip \00310-- \00312< $tmplayer > $color-- $frags\00310\]"
    continue
	} else {
#putlog $tmplayer
	    lappend players "\00310\[\00312$tmplayer $color-- $frags\00310\]"
	    continue
}
}

}

if {$cs(lang)=="rus"} {
    putquick "NOTICE $nick :������:"
    } else {
    putquick "NOTICE $nick :Playing:"
    }
foreach pla $players {
    putquick "NOTICE $nick :$pla"
}
}

putlog "csstatus.tcl $cs(version) by Frilak (frilak@gmail.com) loaded"