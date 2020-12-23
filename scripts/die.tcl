##############################################
## Die Password TCL By NeZiRuS <NeZiRuS@abv.bg> ##
##############################################

# Vavedi tuk parolata za .die
set pass "594573"

# Da logva li botut neuspeshnite opiti za .die
set useinfo "1"

set infochan "#SweetHell"

# Suobshtenie pri neuspeshen opit za .die

set accdenied "Access Denied. Die log Saved"

######################################################################
## OT TUK NA DOLU NE PIPAI NISHTO AKO ISKASH TCL DA RABOTI PRAVILNO ##
######################################################################

# putlog "Die Password TCL by NeZiRuS Loaded."

bind dcc n|- die die:acc
unbind msg n|- die *msg:die

proc die:acc {hand idx text} {
	global useinfo infochan accdenied pass
	if {$text == ""} {
		putidx $idx "Use: .die <password> \[reason\]"
		return 0
	}
	set chkpass [lindex $text 0]
	if {$chkpass == $pass} { 
		if {[llength $text] > 1} {
			set reason [lrange $text 1 end]
		} else {
			set reason "upalnomoshten ot $hand"
		}
		die $reason 
		return 1
	} else {
		putidx $idx "Invalid die password"
		if {$useinfo == 1} { 
			putlog "$hand Access Denied. Die log Saved!!! \"$chkpass\" "
			return 0
		} 
		return 0
	}
}

