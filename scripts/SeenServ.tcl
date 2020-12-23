##########################################################################
# .chanset #chan +seenserv - ��������� ���� �� ������ � ������� �����
# .chanset #chan +seenserv - ��������� �� ���� �� ������ � ������� �����
# .chanset #chan seen:meth 1/2/3/4 - �������� �� ����� ��� �� ���� ����������
##########################################################################
# ��� �� ������� ����������?
# 1 - �� �����
# 2 - � ������
# 3 - ���� ������ �� ����
# 4 - ���� ������ �� ������ (�� ��������������)
##########################################################################

# nedei bara nadolu ako ne razbirash :)
bind pub -|- seen serv:seen
bind msgm -|- "*is*currently*online*" success:seen
bind msgm -|- "*was*" offline:seen
bind msgm -|- "*sorry*have*recently*" nosucc:seen
setudef flag seen
setudef flag seenserv
setudef str seen:meth

proc msg:seen {nick chan msg} {
  switch [channel get $chan seen:meth] {
    1 { putquick "PRIVMSG $nick :$msg" }
    2 { putquick "PRIVMSG $chan :$msg" }
    3 { putquick "NOTICE $nick :$msg" }
    4 { putquick "NOTICE $chan :$msg" }
    default { putquick "PRIVMSG $chan :$msg" }
  }
}
proc serv:seen {n u h c t} {
if { [channel get $c seenserv] } {
	if {$t == ""} {
		set msg "$n, �� ������ seen-���, �� �� ���� ������� ���� ��?"
              putlog "** $n �� ����� � ���� � $c"
		msg:seen $n $c $msg
		return 0
	}
	if {[onchan $t $c]} {
		set msg "$t � ������� � � ������, ������� �� � ��� �����"
              putlog "** $n seening $t in $c, but nick is in channel"
		msg:seen $n $c $msg
		return 0
	}
	putquick "PRIVMSG SeenServ :seen $t"
	set ::schan "$c"
	set ::rnick "$n"
}
}
proc success:seen {n u h t} {
if { $n == "SeenServ" } {
	set msg "[lindex $t 0] [lindex $t 1] � ������� � ������."
       putlog "** ($::schan) ** $::rnick seening [lindex $t 0] [lindex $t 1] and this nick is currently online"
	msg:seen $::rnick $::schan $msg
	return 0
	}
}
proc offline:seen {n u h t} {
if { $n == "SeenServ" } {
	set msg "[lindex $t 0] [lindex $t 1] ���� �������� ���������(�) ����� [regsub -nocase {ago} [lrange $t 6 end] ""]"
       putlog "** ($::schan) ** $::rnick seening [lindex $t 0] [lindex $t 1] last seen [regsub -nocase {ago} [lrange $t 6 end] ""] ago"
	msg:seen $::rnick $::schan $msg
	return 0
	}
}
proc nosucc:seen {n u h t} {
if { $n == "SeenServ" } {
	set msg "�� ������� ��������� ���������� �� ������ ���������."
       putlog "** ($::schan) ** $::rnick seening [lindex $t 4] but this nick is not found"
	msg:seen $::rnick $::schan $msg
	return 0
	}
}
# malko credits =)
putlog "����������: SeenServ.tcl"

