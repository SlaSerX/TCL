########## Nastroiki ###########

#flaga na userite koito bota nqma da priema za inviters
set uflag "f"

#prez kolko vreme bota da rejoinva kanalite (v minuti)
set cycle_time "60"

#Poqsnenie: Tuk trqbwa da se dobawi i istinskiq botnick na bota.

#vtoria nick na checker-a
set chnick "BOTNIK"

## Ottuk nadolu ne butai ni6to!!! ##
#####################################
### PRIVATE MESSAGES
bind msgm - *#* kb_i
bind msgm - *www* kb_i
bind msgm - *http* kb_i

### NOTICES 
bind notc - *#* kb_i
bind notc - *www* kb_i
bind notc - *http* kb_i

### PUBLIC MESSAGES
bind pubm - "* #*" kb_i
bind pubm - "*www*" kb_i
bind pubm - "*http*" kb_i

proc kb_i {nick uhost handle args} {
 global bla bla uflag
 if {[matchattr $handle $uflag] || [matchattr $handle b]} {
  putlog "14Защитен потребител:15 $nick ($uhost)"
  return 0
 }
 putlog "14Засечен нарушител:4 $nick ($uhost)"
 set banmask "*!*[string trimleft [maskhost $uhost] *!]"
 set targmask "*!*[string trimleft $banmask *!]"
 putallbots "kb $nick $targmask"
 return 1
}
timer $cycle_time cyclechans

proc cyclechans {} {
 global cycle_time sag chnick
 putlog "*** Проверявам каналите за спам..."
 putquick "NICK $chnick"
 foreach chan [channels] {
  channel set $chan +inactive
  channel set $chan -inactive
 }
 timer $cycle_time cyclechans
}

putlog "Инсталиран: SpamChecker.tcl"
