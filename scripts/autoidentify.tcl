## Descripcion:													  
## my simple try to ShakeIt nickserv@services.bg identify 
## and my first try too


# TCL by Lyudmil

# Lyudmil`s Team Identify  TCL
putlog "4-=5{ 12TCL by 11Lyudmil 12Loaded 5}4=-"

### Setup

# set nick n password to be identified - you must edit this
set nickname "Ruse"
set password "aifon"

### Code

# Change the m to another flag if you like. 
bind pub m .identify  do_identify
bind pub m .release do_release
bind pub m .ghost do_ghost


#    # # # # ## do not edit below # ### # # ## 

#identify  starts #

proc do_identify {nick host handle chan text} { 
global nickname password
putquick "PRIVMSG ns :identify $password" 
putserv "NOTICE $nick :identifying to nickserv@services.bg..."
}

# nick Ghosting starts here #

proc do_ghost {nick host handle chan text} {
global nickname password
putquick "PRIVMSG ns :ghost $nickname $password"
putserv "NOTICE $nick :Ghosting your Bot nick"
}

#ends here #

set init-server {  
putquick "PRIVMSG ns :identify $password" 
putserv "MODE $nick +R"
}
 
