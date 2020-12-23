# ratbox-services-ident.tcl

# toya script prawi bota po-lesno da se identwa w NS
namespace eval auth {
  variable version  1.0
  variable author   raptor
  
  # ID informacia
  variable name     "Aztec"
  variable pass     "shaper123"
  
  # /mode bota +i? 
  variable usex     1
  
  # hosta na NS
  variable service  "Q@CServe.quakenet.org"
    
  bind EVNT  -|-   init-server   [namespace current]::connect
}

proc auth::connect {event} {
#  putquick "PRIVMSG Q@CServe.quakenet.org :AUTH Eustace 123asd"
  putquick "PRIVMSG Q@CServe.quakenet.org :AUTH Aztec shaper123"
  if {$auth::usex} {
    putquick "MODE $::botnick +i"
  }
}

putlog "Loaded:ident.tcl"