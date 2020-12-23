########################################################
## clear voice from partyline by Paco (paco@gsmbg.org) #
########################################################
## Не променяй тази стойност ###
variable kolko 0

## Хората имащи този флаг няма да бъдат девойснати при изпълнение на команда .clearvoice .cvoice
variable flagche "Q"

## Тук напишете канала, в който да работи скрипта
variable kanalche "#ruse"



###################################
#      От тук надолу - НЕПИПАЙ    #
###################################
bind dcc n|n clearvoice clearvoice
bind dcc n|n cvoice clearvoice

#            Кодиране             #
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
puglog "Инсталиран: Clearvoice.tcl"