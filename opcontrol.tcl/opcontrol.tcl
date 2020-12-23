# Op Control By xTc^bLiTz

# Gonna Ask You Not To Rip This, But Since Half Of You Probably Are Not To 
# Much I Can Do About It.  Just Remember That Ripping This For Yourself 
# Takes Away From The Statisfaction Of Making Something Like This Yourself. 
# Also If I Find People Ripping My Work, I Will No Longer Post Other 
# Scripts, And You Will Have To Start Making Everything For Yourself
# Give Credit Where Credit Is Due.

# This Script Works Best If You Use My opcmds.tcl Script With It.  It 
# Contains Easy Commands For Adding/Removing Users From The User Database.

# Configure The Variables Below Here.

# Set This Variable To In Seconds To How Long You Want The Bot To Wait 
# Before Opping Someone.  5 Seconds Is The Default, I Don't Recommend 
# Going Lower Than This Number

set OC_OpDelay 5

# Set This Variable To The Flag You Wish To Use For People Who Are Not 
# Aloud Ops

set OC_NoOpFlag "O"

# Set This Variable To The Flag You Will Use For People Aloud Ops

set OC_OpFlag "o"

# Set Up Instructions:

# Copy This TCL Into Your eggdrop/scripts Directory, Edit eggdrop.conf And 
# Add The Line: source scripts/opcontrol.tcl

# Code Is Below, Do Not Edit Below This Line

# Bindings

bind join $OC_OpFlag * proc_CheckJoin
bind mode - "* +o"  proc_CheckOps
bind pub m|m !noop proc_NoOp
bind pub m|m !allowop proc_AllowOp

# Check Join Process - This Process Checks The Handle Of The Person That 
# Joins And If The Are Ops, Will Wait To See If Chanserv, Or Anyone Else, 
# Ops Them Before Opping Them. Will Also Check If They Are Not Permitted 
# Ops And Wait To See If Anyone Ops Them.

proc proc__CheckJoin { nick uhost hand chan } {
  global OC_OpDelay OC_NoOpFlag OC_OpFlag
  if {[matchattr [nick2hand $nick] R]} {
    return 0
  } else {
    utimer $OC_OpDelay proc_GiveOps $nick $uhost $hand $chan
  }
}

# Process Give Ops - Will Check And See If Anyone Has Opped The Person And 
# If So Will Not Op Them.

proc proc_GiveOps { nick uhost hand chan } {
  if {[isop $nick $chan}] {
    return 0
  } else {
    putserv "MODE $chan +o $nick
  }
}

proc proc_NoOps { nick uhost hand chan } {
  if {[isop $nick $chan]} {
    putserv "MODE $chan -o $nick"
  }
}

# Process CheckOps - This Process Is Triggered When Someone Is Opped In 
# The Channel, The Bot Will Check And See If They Have The NoOp Flag, If 
# They Do, Then They Will Be Automatically DeOpped, And A Notice Will Be Set 
# The The Opping Person Informing Them That The User Has A No Op Flag

proc proc_CheckOps { nick uhost hand chan mc victim } {
  global OC_NoOpFlag
  if {[matchattr [nick2hand $victim] $OC_NoOpFlag]} {
    if {$nick == "chanserv"} {
      putquick "MODE $chan -o $victim"
    }
    if {$nick == ""} {
      putquick "MODE $chan -o $victim"
    } else {
       putquick "MODE $chan -o $victim"
       putquick "NOTICE $nick :$victim Does Not Have Access To Ops In $chan - DeOpping $victim"
    }
  }
}

# Process NoOp - This Process Is Triggered When !noop Command Is Used, It 
# Will Set The Victim With The NoOp Flag And Remove The Ops From The Victim 
# If They Are Opped

proc proc_NoOp { nick uhost hand chan args } {
  global OC_NoOpFlag
  if {[validuser [nick2hand $args]]} {
    if {[matchattr [nick2hand $args] $OC_NoOpFlag]} {
      putserv "PRIVMSG $chan :$args Already Has No Op Flag"
      return 0
    } else {
      chattr [nick2hand $args] +$OC_NoOpFlag
      putserv "MODE $chan -o $args"
      putserv "PRIVMSG $chan :\002$args\002 Is No Longer Aloud Ops In \002$chan"
    }
  } else {
    putserv "PRIVMSG $chan :\002$args\002 Not Found In User Database"
  }
}

# Process AllowOp - This Process Will Remove The NoOp Flag And Allow.

proc proc_AllowOp { nick uhost hand chan args } {
  global OC_NoOpFlag
  if {[validuser [nick2hand $args]]} {
    if {[matchattr [nick2hand $args] $OC_NoOpFlag]} {
      chattr [nick2hand $args] -$OC_NoOpFlag $chan
      putserv "PRIVMSG $chan :\002$args\002 Is Now Aloud Op Access In \002$chan"
    } else {
      putserv "PRIVMSG $chan :\002$args\002 Is Already Aloud Op Access In $chan"
    }
  } else {
    putserv "PRIVMSG $chan :\002$args\002 Not Found In User Database."
  }
}

putlog "*** Op Control by xTc^bLiTz <xtc_blitz@hotmail.com Loaded"
