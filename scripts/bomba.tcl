
bind  pub   -   !bomba  doTimebomb
bind  pub   -   !reji   doCutWire

###############################################################################
# Configuration
#

set gTimebombMinimumDuration 20
set gTimebombMaximumDuration 60
set gWireChoices "cherven oranjev jult zelen sin indigo violetov cheren bql kafqv rozov bejov elektrikav rezedav siv purpuren zlaten slonova-kost ohra tumno-sin maslineno-zelen tumno-lilav sreburen"
set gMaxWireCount 4

###############################################################################
# Internal Globals
#

set gTheScriptVersion "0.4"
set gTimebombActive 0
set gTimerId 0
set gTimebombTarget ""
set gTimebombChannel ""
set gCorrectWire "sin"
set gNumberNames "0 1 2 3 4 5 6 7 8 9 10 11 12"

###############################################################################


proc note {msg} {
  putlog "% $msg"
}

proc IRCKick {theNick theChannel theReason} {
  note "Kicking $theNick in $theChannel (Reason: $theReason)"
  putquick "KICK $theChannel $theNick :$theReason"
}

proc IRCPrivMSG {theTarget messageString} {
  putserv "PRIVMSG $theTarget :$messageString"
}

proc IRCAction {theTarget messageString} {
  putserv "PRIVMSG $theTarget :\001ACTION $messageString\001"
}

proc MakeEnglishList {theList} {
  set theListLength [llength $theList]
  set returnString [lindex $theList 0]
  for {set x 1} {$x < $theListLength} {incr x} {
    if { $x == [expr $theListLength - 1] } {
      set returnString "$returnString and [lindex $theList $x]"
    } else {
      set returnString "$returnString, [lindex $theList $x]"
    }
  }
  return $returnString
}

proc SelectWires {wireCount} {
  global gWireChoices
  set totalWireCount [llength $gWireChoices]
  set selectedWires ""
  for {set x 0} {$x < $wireCount} {incr x} {
    set currentWire [lindex $gWireChoices [expr int( rand() * $totalWireCount )]]
    if { [lsearch $selectedWires $currentWire] == -1 } {
      lappend selectedWires $currentWire
    } else {
      set x [expr $x - 1]
    }
  }
  return $selectedWires
}

proc DetonateTimebomb {destroyTimer kickMessage} {
  global gTimebombTarget gTimerId gTimebombChannel gTimebombActive
  if { $destroyTimer } {
    killutimer $gTimerId
  }
  set gTimerId 0
  set gTimebombActive 0
  IRCKick $gTimebombTarget $gTimebombChannel $kickMessage
}

proc DiffuseTimebomb {wireCut} {
  global gTimerId gTimebombActive gTimebombTarget gTimebombChannel
  killutimer $gTimerId
  set gTimerId 0
  set gTimebombActive 0
  IRCPrivMSG $gTimebombChannel "$gTimebombTarget прерязва $wireCut кабел. Това обезвреди бомбата"
}

proc StartTimeBomb {theStarter theNick theChannel} {
  global gTimebombActive gTimebombTarget gTimerId gTimebombChannel gNumberNames gCorrectWire
  global gMaxWireCount gTimebombMinimumDuration gTimebombMaximumDuration
  if { $gTimebombActive == 1 } {
    note "Timebomb ne e startirana $theStarter (Reason: timebomb e ve4e aktivirana)"
    if { $theChannel != $gTimebombChannel } {
      IRCPrivMSG $theChannel "Имам само една бомба :))) Съжалявам"
    } else {
      IRCAction $theChannel "Бомбата вече е в гащите на $gTimebombTarget'"
    }
  } else {
    set timerDuration [expr $gTimebombMinimumDuration + [expr int(rand() * ($gTimebombMaximumDuration - $gTimebombMinimumDuration))]]
    set gTimebombTarget $theNick
    set gTimebombChannel $theChannel
    set numberOfWires [expr 1 + int(rand() * ( $gMaxWireCount - 0 ))]
    set listOfWires [SelectWires $numberOfWires]
    set gCorrectWire [lindex $listOfWires [expr int( rand() * $numberOfWires )]]
    set wireListAsEnglish [MakeEnglishList $listOfWires]
    set wireCountAsEnglish [lindex $gNumberNames $numberOfWires]
    IRCAction $theChannel "Пъхва бомба в гащичките на $gTimebombTarget. До експлозията остават  \[\002$timerDuration\002\] секунди"
    if { $numberOfWires == 1 } {
      IRCPrivMSG $theChannel "Бомбата може да се обезвреди само ако срежете верния кабел. Има $wireCountAsEnglish на брой кабела. Взбери цвят от $wireListAsEnglish и напиши !reji цвета за да обезвредиш екслозива"
    } else {
      IRCPrivMSG $theChannel "Има $wireCountAsEnglish на брой кабела. Те са $wireListAsEnglish. Напиши !reji цвета за да обезвредиш екслозива"
    }
    note "Бомбата е стартирана от $theStarter (Поставена е на $theNick. Тя ще избухне след $timerDuration секунди)"
    set gTimebombActive 1
    set gTimerId [utimer $timerDuration "DetonateTimebomb 0 {\002*ТРЕЕЕЕЕЕЕЕЕЕЕЕС!*\002}"]
  }
}

###############################################################################
# Eggdrop command binds
#

proc doCutWire {nick uhost hand chan arg} {
  global gTimebombActive gCorrectWire gTimebombTarget
  if { $gTimebombActive == 1 } {
    if { [string tolower $nick] == [string tolower $gTimebombTarget] } {
      if { [llength $arg] == 1 } {
        if { [string tolower $arg] == [string tolower $gCorrectWire] } {
          DiffuseTimebomb $gCorrectWire
        } else {
          DetonateTimebomb 1 "\002Грешка... *БУУМ!*\002"
        }
      }
    }
  }
}

proc doTimebomb {nick uhost hand chan arg} {
  global botnick
  set theNick $nick
  if { [llength $arg] == 1 } {
    set theNick [lindex [split $arg] 0]
  }
  if { [string tolower $theNick] == [string tolower $botnick] } {
    set theNick $nick
    IRCKick $theNick $chan "Ташак ли си праиш с мене?"
    return
  }
  if { [validuser $theNick] == 1 } {
    if { [matchattr $theNick "+b"] == 1 } {
      set theNick $nick
      IRCKick $theNick $chan "Ташак ли си праиш с мене?"
      return
    }
  }
  StartTimeBomb $nick $theNick $chan
}

###############################################################################
putlog "Инсталиран: bomba.tcl"