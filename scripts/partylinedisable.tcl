bind chon - * disableparty
proc disableparty {hand idx} {
    if {[matchattr $hand n} return
	putdcc $idx "#$hand# 4*** 14�������� �����������, ������ � Partyline" 
boot $hand "��������� � partyline � ���� ��� � ������ ���������. �������� �� ���� ����������."
}
putlog "����������: partylinedisable.tcl"