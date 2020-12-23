# Last version of egglib_pub can be grabbed here:
# http://eggdrop.org.ru/scripts/egglib.zip

#auto say by Rix

#timer 60 [list pub_csinfo "pitka" "na@baba" "pitkata" "#cs-optilan" ""]

   bind pub - !d2 pub_csinfo

   proc pub_csinfo {nick uhost hand chan args} {
#if { [llength [timers]] == 0 } { timer 60 [list pub_csinfo "pitka" "na@baba" "pitkata" "#cs-optilan" ""] }
   # Путь к нашему скрипту
       set query "http://radio-lubov.info/campari/ms.php"

       set id [::egglib::http_init "pub_csinfo_"]

        ::egglib::http_get $id $query [list $nick $uhost $chan]

   }

   proc pub_csinfo_on_error {id nick uhost chan} {
       ::egglib::out $nick $chan "no connect to server..."
   }

   proc pub_csinfo_on_data {id data nick uhost chan} {
       foreach line [split $data \n] {
           if { [regexp -nocase -- {<cut>(.*?)</cut>} $line garb csinfo] } {
           putquick "privmsg $chan :$csinfo"
             
                  }
       }

   }

#putlog "cs.info.tcl is loaded."
