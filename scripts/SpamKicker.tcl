## ��������� ##

# ����� ����� �� ���� ����� (� ������)
set ban_time "60"

######################################
##  �� ��� ������ �� ������������   ##
######################################


bind bot Z kb kbspam

proc kbspam {botnc kb inviter} {
 global ban_time
 set nick [lindex $inviter 0]
 #set bmask [lindex $inviter 1]
 set nickhand [nick2hand $nick]
 set bmask "[lindex [split $inviter] 1]"
 if {[matchattr $nickhand f] || [matchattr $nickhand b]} {
  putlog "14������� ����������:15 $nick ($bmask)" 
  return 0
 }
 putlog "14������� ���������:4 $nick ($bmask)" 
 foreach chan [channels] {
 putquick "KICK $chan $nick :������� e ���� �� ������ ���� 15($bmask15). ����, ����������� ������ ���� $ban_time ������."
 putquick "MODE $chan +b $bmask"
 newban "$bmask" "CHECK" "$nick 15($bmask15) �������� ��� ���� � ������ �� �� ��������." "$ban_time"
 #putquick "PRIVMSG $nick :������� e ���� �� ������ ���� 15($bmask15). ����, ����������� ������ ���� $ban_time ������."
 }
}

putlog "����������: SpamKicker.tcl"
