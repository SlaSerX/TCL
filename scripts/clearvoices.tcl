namespace eval evoicelimit {
    # Kolko nai-mnogo voice-nati da ima predi bota da clear-ne
    variable brojka 1
    # Kanalite v koito bota da sledi za mnogo voices user
    variable clchan "#ruse"
    #koi useri s kakuv flag da ne bydat devoice-vani
    variable flag "n"
    # credits
    variable version "clearvoices.tcl"
    variable author "Paco (http://irc.techno-link.com/tcls)"
    bind mode - "$clchan *+v*" [namespace current]::e:clearops
    
    proc e:clearops {n u h c m w} {
        variable clchan; variable brojka; variable flag
        set opnum 0
        foreach user [chanlist $clchan] {
            if {[isvoice $user $clchan]} { incr opnum }
        }
        if {$opnum <= $brojka} { return } {
            #putserv "PRIVMSG $clchan :Channel voices (+) positions are full. Clearing voices.."
            foreach user [chanlist $clchan] {
                if {[isvoice $user $clchan]} {
                    if {![matchattr [nick2hand $user] $flag]} { putquick "MODE $clchan -v $user"}
                }
            }
        }
    }
    putlog "Инсталиран: ClearVoices.tcl"
}