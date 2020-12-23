########################################################
## clear voice from partyline by Paco (paco@gsmbg.org) #
########################################################
## �� �������� ���� �������� ###
variable kolko 0

## ������ ����� ���� ���� ���� �� ����� ���������� ��� ���������� �� ������� .clearvoice .cvoice
variable flagche "Q"

## ��� �������� ������, � ����� �� ������ �������
variable kanalche "#ruse"



###################################
#      �� ��� ������ - �������    #
###################################
bind dcc n|n clearvoice clearvoice
bind dcc n|n cvoice clearvoice

#            ��������             #
###################################
proc clearvoice {hand idx arg} {
    variable kanalche; variable kolko; variable flagche
    set opnum 0
    foreach user [chanlist $kanalche] {
        if {[isvoice $user $kanalche]} { incr opnum }
    }
    if {$opnum <= $kolko} { return } {
        putdcc $idx "*** All voices in $kanalche was cleared by @$hand"
        foreach user [chanlist $kanalche] {
            if {[isvoice $user $kanalche]} { 
                if {![matchattr [nick2hand $user] $flagche]} { putquick "MODE $kanalche -v $user"}
            }
        }
    }
}
puglog "����������: Clearvoice.tcl"