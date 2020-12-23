# [0/1] Set this to 1 if you want the bot to +v users when it deops them.
set IDLEOP(voice) 0

# [0/1] Set this to 0 if you don't want DeOPing done. This turns the
#       script into a idle DeVoice script.
set IDLEOP(deop) 1

# [0/1] Defualt status for IdleOP checking. 0:off 1:on
set IDLEOP(active) 1

# Set this to the number of minutes you want between each scan.
set IDLEOP(timer) 10

# Set to anything above 0 to warn them of thier idle time.
set IDLEOP(warnidle) 20
set IDLEOP(warnmsg) "You've been idle for !idle! minutes on !channel!."

# This is the time in minutes to DeOP if longer then.
set IDLEOP(maxidle) 30

# This is the time in minutes to DeVoice +v'ed OPs that are idle.
set IDLEOP(maxidlev) 60

# [0/1] Set this to 1 to devoice idle +v users. 0 not to.
set IDLEOP(dodevoice) 0

# Set this to the channels you want scanned.
set IDLEOP(chans) "#Sofia"

# Set this to a flag you want to be exempt from checks.
set IDLEOP(exempt) "W"

set IDLEOP(tag) "\002\[IdleOP\]\002"
set IDLEOP(ver) "v1.05.01"


set cmdchar_ "!"
proc cmdchar { } {
global cmdchar_
 return $cmdchar_
}


bind dcc o idleopchk dcc_idleopchk
proc dcc_idleopchk {handle idx args} {
global IDLEOP
 set chan [string tolower [lindex [console $idx] 0]]
 putidx $idx "$IDLEOP(tag) Checking OP Idle times for $chan"
 idleopchk $chan $idx
                                  }

proc check_idleop {} {
global IDLEOP
 timer $IDLEOP(timer) check_idleop
 if {$IDLEOP(active) == 0} {putlog "IdleOP Checking is Deactivated. Skipping Check."
                            return 0}
 foreach c [string tolower [channels]] {idleopchk $c 0}
                     }
 timer $IDLEOP(timer) check_idleop

proc idleopchk {chan idx} {
global IDLEOP
 set dochan 999
 foreach c [string tolower $IDLEOP(chans)] {
  if {$c == $chan} {set dochan 1}
                                           }
 if {$dochan != 1} {return 0}

 foreach user1 [chanlist $chan] {
  subst -nobackslashes -nocommands -novariables user1
  set ex 999
  set hand [nick2hand $user1 $chan]
  if {([matchattr $hand m] == 1) ||
      ([matchchanattr $hand |m $chan] == 1) ||
      ([matchattr $hand b] == 1)} {set ex 1}
  if {([matchattr $hand $IDLEOP(exempt)] == 1) ||
      ([matchchanattr $hand |$IDLEOP(exempt) $chan] == 1)} {set ex 1}

 if {($ex != 1) && ([isvoice $user1 $chan])} { 
 set idletime [getchanidle $user1 $chan]
 if {(($IDLEOP(dodevoice)) && ($idletime > $IDLEOP(maxidlev)))} {
  if {($idx > 0)} {putidx $idx "User $user1 idle for $idletime minutes. DeVoiceing."
                } else {putlog "User $user1 idle for $idletime minutes. DeVoiceing."}
  putserv "NOTICE $user1 :You have been idle over $idletime minutes. Forced DeVoice."
#  putserv "MODE $chan -v $user1"
  pushmode $chan -v $user1
                                                                }
                                             }


 if {($ex != 1) && ([isop $user1 $chan])} {
 set idletime [getchanidle $user1 $chan]
 if {($IDLEOP(warnidle)>0) && ($idletime > $IDLEOP(warnidle))} {
  set idlemsg $IDLEOP(warnmsg)
  regsub -all {!idle!} $idlemsg "$idletime" idlemsg
  regsub -all {!channel!} $idlemsg "$chan" idlemsg
  putserv "NOTICE $user1 :$idlemsg"
                                      } 
 if {($idletime > $IDLEOP(maxidle)) && ($IDLEOP(deop) == 1)} {
  if {($idx > 0)} {putidx $idx "User $user1 idle for $idletime minutes. DeOPing."
                } else {putlog "User $user1 idle for $idletime minutes. DeOPing."}
  putserv "NOTICE $user1 :You have been idle over $idletime minutes. Forced DeOP."
  pushmode $chan -o $user1
  if {($IDLEOP(voice) == 1) && (![isvoice $user1 $chan])} {pushmode $chan +v $user1}
                       }
                                         }
                                 }
}


bind dcc o idleop dcc_idleop
proc dcc_idleop {handle idx args} {
global IDLEOP

# set chan [string tolower [lindex [console $idx] 0]]
foreach c $IDLEOP(chans) {
 listidleops $c $idx
                         }
}

proc listidleops {chan idx} {
global IDLEOP
 putidx $idx "$IDLEOP(tag) Listing Idle times for $chan"
 set exnum 0
 foreach user1 [chanlist $chan] {
  set hand [nick2hand $user1 $chan]
  set ex " "
 if {([matchattr $hand m] == 1) ||
     ([matchchanattr $hand m $chan] == 1) ||
     ([matchattr $hand b] == 1)} {set ex "W"
                                  set exnum [expr $exnum + 1]}
  if {$ex != " "} {set ex " \($ex\) "}
  if {([isop $user1 $chan]) || ([isvoice $user1 $chan])} {
  
   putdcc $idx "$IDLEOP(tag)  User $user1${ex}has been idle [getchanidle $user1 $chan] mins."
                              }
                                }
  if {$exnum > 0} {putidx $idx "$IDLEOP(tag) NOTE: Users marked with a (E) after thier nick are exempted from idle-deop"}
}


bind pub o [cmdchar]idleop pub_idleop
proc pub_idleop {nick uhost hand channel rest} {
global IDLEOP
switch [string tolower [lindex $rest 0]] {
 ""    { putserv "NOTICE $nick :Syntax: [cmdchar]idleop \[on/off\]" }
 "off" { set IDLEOP(active) 0 }
 "on"  { set IDLEOP(active) 1 }
 }
if {$IDLEOP(active) == 0} { putserv "NOTICE $nick :IdleOP Checking if currentlly off"
                   } else { putserv "NOTICE $nick :IdleOP Checking is currentlly on" }
 }


putlog "Loaded:Idle.tcl $IDLEOP(ver)"


