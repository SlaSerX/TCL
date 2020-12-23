# superbitch.tcl v2.0 (4 June 2000)
# copyright (c) 1998-2000 by slennox <slennox@egghelp.org>
# slennox's eggdrop page - http://www.egghelp.org/
#
# This script provides an enhanced bitch mode. It deops both the user who
# was opped and the user who performed the disallowed op. It is very useful
# for protecting the channel from gullible ops who accidentally op someone
# they shouldn't, or from ops who use exploitable clients/scripts and may
# unintentionally op someone via an exploit (e.g. CTCPREPLY backdoor). The
# script doesn't completely replace eggdrop's +bitch channel mode - you may
# still wish to use that in conjunction with superbitch.tcl.
#
# Note: superbitch.tcl may not function correctly on eggdrop 1.4.0-1.4.1
# due to a pushmode bug in those versions of eggdrop. The problem is fixed
# in 1.4.2 and later. 1.3.x bots are not affected by this problem.
#
# v2.0 - New standalone release. Contains refinements and features from the
#        netbots.tcl version of superbitch.tcl.

# Specify the list of channels to activate superbitch on.
set sb_chans ""
# Valid settings: one channel like "#donkeys", a list of channels like
# "#donkeys #cows #pigs", or "" to activate on all channels.

# The flags for users who are allowed to give op to users with the flags
# specified in sb_canopflags.
set sb_canop "m|m"
# Valid settings: set in globalflags|chanflags format (e.g. "m|m" means
# global OR channel master, "m|-" means global masters only), or set to ""
# to specify that no users are allowed to op.

# The flags for users who are allowed to be opped by users with an sb_canop
# flag.
set sb_canopflags "o|o"
# Valid settings: set in globalflags|chanflags format (e.g. "m|m" means
# global OR channel master, "m|-" means global masters only), or set to ""
# to specify that no users are allowed to be opped.

# The flags for users who are allowed to give op to anyone. This setting
# ignores sb_canop and sb_canopflags (e.g. you can set sb_canop to "" but
# users with flags specified in sb_canopany will still be allowed to op
# anyone).
set sb_canopany "b|-"
# Valid settings: set in globalflags|chanflags format (e.g. "m|m" means
# global OR channel master, "m|-" means global masters only), or set to ""
# to specify that no users have the 'can op anyone' privilege.

# If a user ops someone they shouldn't, remove their global & channel +o
# status and give them the +d flag? (note that +m/n is not removed).
set sb_remove 0
# Valid settings: 1 to enable, 0 to disable.

# List of users to send a note to if a user's +o status is removed by
# superbitch.tcl.
set sb_note "YourNick"
# Valid settings: one user like "Tom", a list of users like
# "Tom Dick Harry", or "" to specify that no notes are sent.

# Make the bot double-check who it opped after opping a nick, reversing the
# op if the opped user doesn't match +o? This was mainly designed to help
# prevent 'op cheating', but I haven't tested it for that so I'm not sure
# if it's actually effective.
set sb_checkop 0
# Valid settings: 1 to enable, 0 to disable.


# Don't edit below unless you know what you're doing.

if {$numversion < 1040200} {
  if {[info commands isop] != ""} {
    proc wasop {nick chan} {
      return [isop $nick $chan]
    }
  }
}

proc sb_bitch {nick uhost hand chan mode opped} {
  global botnick sb_chans sb_canop sb_canopany sb_canopflags sb_checkop sb_note sb_remove
  if {$mode == "+o"} {
    if {$nick != $botnick} {
      if {((($opped != $botnick) && ($nick != $opped) && ([onchan $nick $chan]) && (![wasop $opped $chan])) && (($sb_chans == "") || ([lsearch -exact $sb_chans [string tolower $chan]] != -1)))} {
        if {![matchattr [nick2hand $opped $chan] $sb_canopflags $chan]} {
          if {(($sb_canopany == "") || (![matchattr $hand $sb_canopany $chan]))} {
            pushmode $chan -o $opped
            pushmode $chan -o $nick
            if {(($sb_remove) && ([validuser $hand]) && ([matchattr $hand o|o $chan]))} {
              chattr $hand -o+d|-o+d $chan
              if {[info commands sendnote] != ""} {
                foreach recipient $sb_note {
                  if {[validuser $recipient]} {
                    sendnote SUPERBITCH $recipient "Removed +o from $hand (opped $opped on $chan)"
                  }
                }
              }
            }
          }
        } else {
          if {((($sb_canopany == "") || (![matchattr $hand $sb_canopany $chan])) && (($sb_canop == "") || (![matchattr $hand $sb_canop $chan])))} {
            pushmode $chan -o $opped
            pushmode $chan -o $nick
            if {(($sb_remove) && ([validuser $hand]) && ([matchattr $hand o|o $chan]))} {
              chattr $hand -o+d|-o+d $chan
              if {[info commands sendnote] != ""} {
                foreach recipient $sb_note {
                  if {[validuser $recipient]} {
                    sendnote SUPERBITCH $recipient "Removed +o from $hand (opped $opped on $chan)"
                  }
                }
              }
            }
          }
        }
      }
    } else {
      if {(($sb_checkop) && (![matchattr [nick2hand $opped $chan] o|o $chan]))} {
        pushmode $chan -o $opped
        putlog "superbitch: opped non +o user $opped on $chan - reversing."
      }
    }
  }
  return 0
}

set sb_chans [split [string tolower $sb_chans]] ; set sb_note [split $sb_note]

bind mode - * sb_bitch

putlog "Superbitch v2.0 by dJ_TEDY Loaded."

return
