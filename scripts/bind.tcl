# Bind.tcl v1.0 (03 Jul 2010)
# Copyright by Kiril Georgiev a.k.a Arkadietz
# For Contacts:
# Email <Arkadietz@yahoo.com>
######################################################################


# Now unbind :)

# dcc
unbind dcc - binds *dcc:binds
unbind dcc - restart *dcc:restart
unbind dcc - rehash *dcc:rehash
unbind dcc - reload *dcc:reload
unbind dcc - status *dcc:status
unbind dcc - dump *dcc:dump
unbind dcc - jump *dcc:jump
unbind dcc - ignore *dcc:ignore
unbind dcc - adduser *dcc:adduser
unbind dcc - deluser *dcc:deluser
unbind dcc - +user *dcc:+user
unbind dcc - -user *dcc:-user
unbind dcc - ignores *dcc:ignores
unbind dcc - +ignore *dcc:+ignore
unbind dcc - -ignore *dcc:-ignore
unbind dcc - handle *dcc:handle
unbind dcc - chhandle *dcc:chhandle
unbind dcc - topic *dcc:topic
unbind dcc - invite *dcc:invite
unbind dcc - msg *dcc:msg
unbind dcc - op *dcc:op  
unbind dcc - deop *dcc:deop
unbind dcc - voice *dcc:voice
unbind dcc - devoice *dcc:devoice
unbind dcc - su *dcc:su
unbind dcc - act *dcc:act 

# Now Bind :)

bind dcc n|n binds *dcc:binds 
bind dcc n|n restart *dcc:restart
bind dcc n|n rehash *dcc:rehash
bind dcc n|n reload *dcc:reload
bind dcc n|n status *dcc:status
bind dcc n|n dump *dcc:dump
bind dcc n|n jump *dcc:jump
bind dcc n|n ignore *dcc:ignore
bind dcc m|m adduser *dcc:adduser
bind dcc m|m deluser *dcc:deluser
bind dcc m|m +user *dcc:+user
bind dcc m|m -user *dcc:-user
bind dcc m|m ignores *dcc:ignores
bind dcc m|m +ignore *dcc:+ignore
bind dcc m|m -ignore *dcc:-ignore
bind dcc n|n handle *dcc:handle
bind dcc n|n chhandle *dcc:chhandle
bind dcc n|n topic *dcc:topic
bind dcc n|n invite *dcc:invite 
bind dcc n|n msg *dcc:msg
bind dcc n|n op *dcc:op
bind dcc n|n deop *dcc:deop
bind dcc n|n voice *dcc:voice
bind dcc n|n su *dcc:su
bind dcc n|n act *dcc:act 


putlog "TCL | Bind"
