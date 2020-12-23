bind evnt - init-server evnt:init_server

proc evnt:init_server {type} {
  global botnick
  putserv "timer 1 ping $botnick" 
  putserv "AWAY :I'm a bot.  Your messages will be ignored."
}
