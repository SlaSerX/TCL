#-----------------------------------------------------------------------------#
# incith:google                                                        v1.8.8g#
#                                                                             #
# performs various methods of Google searches                                 #
# tested on:                                                                  #
#   eggdrop v1.6.17 GNU/LINUX with Tcl 8.4                                    #
#   windrop v1.6.17 CYGWIN_NT with Tcl 8.4                                    #
#                                                                             #
# NEWS:                                                                       #
#  As of v1.6, I (madwoota) have taken over the development of incith:google. #
#  If you have any feature req's, bugs, ideas, etc, please dont hesitate to   #
#  send them to me. My contact details have replaced incith's, but if you     #
#  wish to approach him directly about anything, I can point you in the right #
#  direction.                                                                 #
#                                                                             #
#  See the Egghelp forum for inciths handover and all the latest info:        #
#    http://forum.egghelp.org/viewtopic.php?t=10175                           #
#                                                                             #
# Basic usage guide:                                                          #
#   .chanset #channel +google                                                 #
#   !google <define:|spell:> <search terms> <1+1> <1 cm in ft> <patent ##>    #
#      <weather city|zip> <??? airport> <city,state/zip>                      #
#   !images <search terms>                                                    #
#   !groups <search terms>                                                    #
#   !local <what> near <where>                                                #
#   !books <search terms>                                                     #
#   !video <search terms>                                                     #
#   !fight <word(s) one> vs <word(s) two>                                     #
#                                                                             #
# ChangeLog:                                                                  #
#  1.0: first public release                                                  #
#  1.1: improved bolding of search terms, compatible with chopped descriptions#
#       supports 'define: <word>' lookups                                     #
#       supports calculator. !google (4+3) * 2 - 1                            #
#         - converts, too. !google 1 lb in ounces                             #
#       image lookups coded, !images <search>                                 #
#       'spell: word1 word2' function added - don't rely on this, it's not a  #
#         dictionary, just corrects common typos.                             #
#       flood protection added                                                #
#  1.2: will wrap long lines (yay, a worthy solution!)                        #
#       allowed setting of the seperator instead of a ' | ' by default. If you#
#         set this to "\n" then you will get each result on a seperate line   #
#         instead of one line                                                 #
#       will display 'did you mean' if no results                             #
#       [PDF] links will be parsed/included now                               #
#       fixed a bug when no data was returned from google such is the case    #
#         when you search for """"""""""""""""""                              #
#  1.3: can return results in multiple languages now                          #
#       fixed quotes being displayed around links                             #
#       private messages support added (for /msg !google)                     #
#       video.google.com seems impossible, Google Video Viewer                #
#         is required to view videos, etc                                     #
#  1.4: bit of a different output, easier to click links now                  #
#       local lookups coded, use !local <what> near <where>                   #
#       seems google does currency the same way my exchange                   #
#         script does (!g 1 usd in cad)                                       #
#       "patent ##" will return the patent link if it exists                  #
#       bugfix in private messages                                            #
#       sorry to all whom grabbed a borked copy on egghelp :-(                #
#  1.5: fix for !local returning html on 'Unverified listing's                #
#       "madwoota" has supplied some nice code updates for us!                #
#         - "answer" matches, eg: !g population of japan                      #
#           - !g <upc code>                                                   #
#         - google groups (!gg), google news (!gn)                            #
#         - movie: review lookups                                             #
#         - area code lookups (!g 780)                                        #
#         - books.google lookups (!gb !books)                                 #
#       reworked binds to fix horrible bug allowing !g !gi !gp                #
#       case insensitive binds (!gi, !GI, !gI, !Gi, etc)                      #
#   .1: fix for double triggers/bad binds                                     #
#   .2: fix involving "can't read link" error                                 #
#madwoota:                                                                    #
#  1.6: fixed google search returning no results                              #
#       fixed descriptions getting cut short on 'answers'                     #
#       fixed bug where some urls were returned invalid                       #
#       fixed google local searches returning no results                      #
#       fixed google books searches returning invalid links                   #
#       changed 'did you means' to get returned first as well                 #
#       added google weather: !g weather <city|zip>                           #
#         - note: US weather only (blame google!)                             #
#       added travel info, eg: !g sfo airport | !g united 134                 #
#       added config option to send output via /notice                        #
#       added initial attempt at parsing google video (!gv)                   #
#  1.7: added option to force all replies as private (req)                    #
#       fixed google groups returning no results                              #
#       fixed define: errors on no results                                    #
#       fixed google books errors on no results/typos                         #
#       fixed movie review errors on no results/typos                         #
#       fixed some characters not usable as command_chars on                  #
#         one of regular eggdrop or windrop+cygwin                            #
#       fixed occasional weird response for travel info                       #
#       updated requirements to http package 2.4                              #
#       loads of other internal changes                                       #
#   .1: fixed search parameters not being parsed correctly                    #
#         - resulted in some bogus "no results" replies.                      #
#   .2: fixed main google search returning rubbish results                    #
#         - google changed their source again                                 #
#       changed all methods of parsing the search results to                  #
#         *hopefully* cope better with any source changes                     #
#       changed output queue to stop the bot from flooding                    #
#   .3: fixed some urls being returned with spaces in them                    #
#         - makes them unusable in most irc clients                           #
#       fixed google groups occasionally returning junk due to                #
#         changes in 1.7.2 (will revisit this later)                          #
#  1.8: added option to turn on "safe" searches                               #
#       added channel user level filtering option (+v/+o only)                #
#       added google fight! !gf or !fight <blah> vs <blah>                    #
#        - inspired by www.googlefight.com                                    #
#       added ability to do any custom mode to descs & links                  #
#        - i'll just apologise now for this one :)                            #
#       removed variable underline_links (superseded by above)                #
#       removed use of 'tcl_endOfWord' to stop windrop breaking               #
#       fixed excess %20's appearing in some results                          #
#       fixed "translate this" only returns ? (i think)                       #
#       stopped local from returning ad spam on first result                  #
#   .1: added tied result check to google fight                               #
#       fixed groups parsing that broke                                       #
#       fixed local parsing that broke                                        #
#       fixed "answer" matches parsing that broke                             #
#   .2: fixed a chance of a "define:" + a "Did you mean:" not                 # 
#        returning a result as expected                                       #
#   .3: added function to strip all &#???; unicode from desc results          #
#        - simply replaces &#256; to &#99999; with a "?"                      #
#   .4: fixed tracking rubbish after links on define: lookups                 #
#       fixed local lookups ... again                                         #
#       fixed spell: from returning "0"                                       #
#       added option to disable either weblink or google link on "!g define:" #
#       added stock quotes (try !g intc or !g amd)                            #
#   .5: fixed main google results broke ! Google changed <p> -> <div> :)      #
#       fixed weather                                                         #
#       fixed area code map results (eg: !g 90210 or !g beverly hills, ca)    #
#       added new setting to default to NOT return secondary results          #
#   .6: fixed spell: (apparently, but i dont remember doing it :)             #
#       fixed the class=1 bug which also happened to fix some results not     #
#         being returned due to Google's inconsistent html formatting (sorta) #
#   .6a:an update to a 'temp fix' which will actually work                    #
#       note: http.tcl has now no longer included in this package.            #
#   .6b:fixed !g weather results                                              #
#   .7: added a url encoder/decoder to ensure sane requests are sent          #
#   .7a:removed the login cruft from google                                   #
#       fixed googlefights on funky characters                                #
#   .7b:removed more cruft from google (thanks incith)                        #
#   .7c:fixed something i broke in one of the above fixes... gotta love it.   #
#   .8: fixed up whatever i could find that was broken (nearly everything :)  #
#       added a new option to only return one line on some 'answer' matches   #
#     a:removed some formatting cruft from calc results                       #
#     c:fixed google video and some minor presentation rarities               #
#     d:cleaned up <em></em> appearing in results                             #
#     e:updated something                                                     #
#     f:fixed google. fyi, try !g whois blah.com :)                           #
#     g:fixed images that i broke while fixing google (sorry)                 #
#                                                                             #
# TODO:                                                                       #
#   Make define: return up to $search_results definitions from single source  #
#   Localisation options - determine country limit on input?                  #
#   Google music Album/Albums/Songs search                                    #
#   - http://www.google.com/musica?aid=53YC6821hBO                            #
#   - http://www.google.com/musicsearch?q=sublime                             #
#   Code base clean up !                                                      #
#                                                                             #
# Suggestions/Thanks/Bugs, e-mail at bottom of header.                        #
#                                                                             #
# LICENSE:                                                                    #
#   This code comes with ABSOLUTELY NO WARRANTY.                              #
#                                                                             #
#   This program is free software; you can redistribute it                    #
#   and/or modify it under the terms of the GNU General Public                #
#   License as published by the Free Software Foundation;                     #
#   either version 2 of the License, or (at your option) any                  #
#   later version.                                                            #
#                                                                             #
#   This program is distributed in the hope that it will be                   #
#   useful, but WITHOUT ANY WARRANTY; without even the implied                #
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR                   #
#   PURPOSE.  See the GNU General Public License for more                     #
#   details. (http://www.gnu.org/copyleft/library.txt)                        #
#                                                                             #
# Copyright (C) 2005, Jordan                                                  #
# Currently maintained by madwoota                                            #
# google(at)woota(dot)net                                                     #
#-----------------------------------------------------------------------------#
package require http 2.4
setudef flag google

# 0 will typically disable an option, otherwise a value 1 or
# above will enable it.
#
namespace eval incith {
  namespace eval google {
    # set this to the command character you want to use for the binds
    variable command_char "!"

    # set these to your preferred binds ("one two" - space delimited!)
    variable google_binds "g google"
    variable image_binds "gi image images"
    variable local_binds "gl local"
    variable group_binds "gg group groups"
    variable news_binds "gn news"
    variable books_binds "gb books"
    variable video_binds "gv video"
    variable fight_binds "gf fight googlefight"

    # To restrict input queries to Ops (+o), Halfops (+h) or Voiced (+v) users on
    #  any +google channel, use this setting.
    # Set the variable to one of the following to achieve the desired filtering:
    # At least Op - 3
    # At least Halfop - 2  (will also allow ops)
    # At least Voice - 1   (will also allow halfops and ops)
    # Everyone - 0         (no filtering)
    #
    # Note: this does NOT apply to private messages, use the below setting for them.
    #
    variable chan_user_level 0

    # if you want to allow users to search via private /msg, enable this
    variable private_messages 1

    # as per emailed & forum requests, use the next two variables together
    # to determine the output type like so:
    #  notice_reply 1 & force_private 1 = private notice reply only (this is as requested)
    #  notice_reply 0 & force_private 1 = private msg reply only
    #  notice_reply 1 & force_private 0 = regular channel OR private NOTICE
    #  notice_reply 0 & force_private 0 = regular channel OR private MSG (default)

    # set to 1 to enable a /notice reply instead, 0 for normal text
    variable notice_reply 0
    # set to 1 to force all replies to be private
    variable force_private 0


    # set this to the language you want results in! use 2 letter form.
    #   "all" is the default/standard google.com search.
    #   See http://www.google.com/advanced_search for a list.  You have to use
    #   the 'Language' dropdown box, perform a search, and find a line in the URL
    #   that looks like "&lr=lang_en" (for English). "en" is your language code.
    # Popular Ones: it (italian), da (danish), de (german), es (spanish), fr (french)
    # please note, this does not 'translate', it searches Google in a
    #   language of choice, which means you can still get English results.
    variable language "all"

    # set this to "on" to let google filter "adult content" from any of your search results
    #  "off" means results will not be filtered at all
    #  note: this is only applicable to !google, !images and !groups
    variable safe_search "off"

    # number of search results/image links to return, 'define:' is always 1 as some defs are huge
    variable search_results 4
    variable image_results 4
    variable local_results 4
    variable group_results 3
    variable news_results 3
    variable books_results 4
    variable video_results 4

		# set this to 1 to only return a single result on these 'special' matches in google:
		#  time in <blah>, weather in <blah>, population of <blah>, <blah> airport
    variable break_on_special 1

    # set this to 0 to turn google fight off (it is a tad slow after all ...)
    variable google_fight 1

    # what to use to seperate results, set this to "\n" and it will output each result
    #  on a line of its own. the seperator will be removed from the end of the last result.
    variable seperator " | "

    # ** this is not an optional setting, if a string is too long to send, it won't be sent! **
    # It should be set to the max amount of characters that will be received in a public
    #   message by your IRC server.  If you find you aren't receiving results, try lowering this.
    variable split_length 443

    # trimmed length of returned descriptions, only for standard searches.
    variable description_length 40

    # set these to 0 to turn off either the source web link or google.com define: link for a define:<blah> search
    variable define_weblinks 1
    variable define_googlelinks 1
    
    # set this to 1 to enable returning sub/secondary results from the same site from google as per forum req
    variable subresults 0

    # replace search terms appearing in the description as bolded words?
    # - does not bold entire description, just the matching search words
    # - this is ignored if desc_modes contains the Bold mode below
    variable bold_descriptions 1

    # Use these two settings to set colours, bold, reverse, underline etc on either descriptions or links
    # The following modes apply and you can use any combination of them: (NO SPACES!)
    #
    #  Bold = \002
    #  Underline = \037
    #  Reverse = \026
    #  Colours:                 #RGB/Html code:
    #   White = \0030           #FFFFFF
    #   Black = \0031           #000000
    #   Blue = \0032            #00007F
    #   Green = \0033           #008F00
    #   Light Red = \0034       #FF0000
    #   Brown = \0035           #7F0000
    #   Purple = \0036          #9F009F
    #   Orange = \0037          #FF7F00
    #   Yellow = \0038          #F0FF00
    #   Light Green = \0039     #00F700
    #   Cyan = \00310           #008F8F
    #   Light Cyan = \00311     #00F7FF
    #   Light Blue = \00312     #0000FF
    #   Pink = \00313           #FF00FF
    #   Grey = \00314           #7F7F7F
    #   Light Grey = \00315     #CFCFCF
    #
    # This example will do Bold, Underline and Light Blue: "\002\037\00312"
    # Note: This will affect *ALL* descs or links. Dont forget to use the \ too !
    # Also note, abusing this this heavily increases the number of characters per line,
    #  so your output lines will increase somewhat.
    variable desc_modes ""
    variable link_modes ""

    # number of minute(s) to ignore flooders, 0 to disable flood protection
    variable ignore 1

    # how many requests in how many seconds is considered flooding?
    # by default, this allows 3 queries in 10 seconds, the 4th being ignored
    #   and ignoring the flooder for 'variable ignore' minutes
    variable flood 4:10
  }
}
# end of configuration, script begins

namespace eval incith {
  namespace eval google {
    variable version "incith:google-1.8.8g"
  }
}

# bind the public binds
bind pubm -|- "*" incith::google::public_message

# bind the private message binds, if wanted
if {$incith::google::private_messages >= 1} {
  bind msgm -|- "*" incith::google::private_message
}

namespace eval incith {
  namespace eval google {
    # GOOGLE
    # performs a search on google.
    #
    proc google {input} {
      # local variable initialization
      set results 0 ; set calc 0 ; set break 0 ; set spell 0 ; set output "" ; set did_you_mean 0

      # can't be moved to fetch_html since $spell isn't global
      if {[string match -nocase "spell:*" $input] == 1} {
        set spell 1
      }

      # if we don't want any search results, stop now.
      if {$incith::google::search_results <= 0} {
        return
      }

      # fetch the html
      set html [fetch_html $input 1]

      #debugging output
      #set fopen [open /temp/google_temp.html w]
      #puts $fopen $html
      #close $fopen

      # parse the html
      while {$results < $incith::google::search_results} {
        # the regexp grabs the data and stores them into their variables, while
        # the regsub removes the data, for the next loop to grab something new.

        # check if there was an alternate spelling first
        if {[string match "*Did you mean:*" $html] == 1} {
          
          regexp -nocase -- {Did you mean:.*?<a.*?href=.*?>(.+?)</a>} $html - desc
          regsub -all -- {Did.+?you.+?mean:.*?<a.*?href=.*?>(.+?)</a>} $html {} html
          #Just neatens the bolding up a bit (if required)
          regsub -all -- "\002" $desc {} desc
          if {$incith::google::bold_descriptions > 0 && [string match "\002" $incith::google::desc_modes] != 1} {
            set desc "Did you mean: \002${desc}\002 ?"
          } else {
            set desc "Did you mean: ${desc}?"
          }
          set did_you_mean 1
          set link ""
        # top match / "answer" match
          #!g population of japan
        } elseif {[string match "*&oi=answers*" $html] == 1} {
          regexp -- {oi=answers(?:.*?)>(.+?)<br>.*?((http|ftp|https)://.+?)(\s-\s<a|</td>)} $html - desc link
          regsub -all {oi=answers(?:.*?)>(.+?)<br>.*?((http|ftp|https)://.+?)(\s-\s<a|</td>)} $html {} html
          regsub -all "(</a>)" $desc "" desc
          if {$incith::google::break_on_special >= 1} { set break 1 }
          #area codes
          #!g area code 616
        } elseif {[string match "*/images/map_icon2.gif*" $html] == 1} {
          regexp -- {<div class=e>.*?<td.*?valign=top.*?>(.*?)<.+?href=\x22(.+?)\x22.*?</div>} $html - desc link
          regsub -- {<div class=e>.*?</div>} $html {} html
          if {[info exists link] == 1} {
          	set link [urldecode $link]
          	if {[string match "/url?q=http*" $link] == 1} {
	          	regexp -- {/url\?q=(.+?q=.+?)&} $link - link
						}
          }
          if {$incith::google::break_on_special >= 1} { set break 1 }
        # travel info
          #!g lax airport
        } elseif {[string match "*/images/airplane.gif*" $html] ==1} {
          regexp -- {<div class=[ge]>.*?<a href="(.+?)".*?>(.+?)</a>.*?</div>} $html - link desc
          regsub -- {<div class=[ge]>.*?images/airplane.gif.*?</div>} $html - html
        # weather!
          #!g weather 90210
        } elseif {[string match "*/images/weather/*" $html] == 1} {
          regexp -- {<div class=e>.*?<div style=.*?>(.*?)</div>.*?<td><div.*?><div.*?>(.+?)</div><div.*?>(.+?)<.*?>(.+?)<.*?>(.+?)</div>.*?</table>} $html - w1 w2 w3 w4 w5
          regsub -- {<div class=e>.*?</table} $html {} html
          set desc "$w1\: $w2, $w3, $w4, $w5"
          regsub -all -- {&deg;} $desc {°} desc
          set link ""
          regsub -all -- {weather} $input {} input
          if {$incith::google::break_on_special >= 1} { set break 1 }
        # time:
          #!g time in melbourne
        } elseif {[string match "*/chart?chs=40x30&chc=localtime*" $html] == 1} {
          regexp -- {<div class=e>.*?<td valign=.*?>(.*?)<.*?</div>} $html - desc
          regsub -- {<div class=e>.*?<td valign=.*?>(.+?)<.*?</div>} $html {} html
          set link ""
          if {$incith::google::break_on_special >= 1} { set break 1 }
        # define:
        #!g define:toast define:hyperthreading
        } elseif {[string match "define:*" $input] == 1} {
          regexp -- {(<li>.+?)<a href.*(http.+?)(&usg=.+?\x22>|&sig=.+?\x22>|\x22>)} $html - d1 link
          #Setup an internal loop to find multiple bullet points (multiple definitions)
          # but still only from the first group to avoid multiple same answers
          while {$results < $incith::google::search_results && $break != 1 && [info exists d1]} {
            regexp -- {<li>(.*?)<} $d1 - d2
            if {[regexp -inline {<li>.*?<li>} $d1] != ""} {
              regsub -- {<li>.+?<li>} $d1 {<li>} d1
            } else {
              set break 1
            }
  					if {[info exists desc] == 1} {
					    set desc ${desc}${incith::google::seperator}${d2}
					  } else {
  					  set desc $d2
					  }
            incr results
          }
          regsub -all -- {\+} $input {%2B} define_input
          regsub -all -- { } $define_input {+} define_input
          if !${incith::google::define_weblinks} {
		        if ${incith::google::define_googlelinks} {
		      		set link "http://www.google.com/search?hl=${incith::google::language}&q=${define_input}"
		       	} else {
			       	set link ""
    	     	}
          } elseif {[info exists link] == 1 && ${incith::google::define_weblinks}} {
	          regsub -all " " $link "%20" link
	         	if ${incith::google::define_googlelinks} {
			       	append link " ( http://www.google.com/search?hl=${incith::google::language}&q=${define_input} )"
    	     	}
          }
       		set break 1
        # movie:
        } elseif {[string match "movie:*" $input] == 1} {
          regexp -- {<td valign=top><a href=\x22/movies/reviews\?cid=(.+?)&fq(?:.+?)\x22>(.+?)</a>} $html - cid desc
          regsub -- {<td valign=top><a href=\x22/movies/reviews\?cid=(.+?)</a>} $html {} html
          if {[info exists cid] == 1 } { set link "http://www.google.com/movies/reviews?cid=${cid}" }
        # domain whois
        } elseif {[string match "*/images/whois.gif*" $html] == 1} {
          regexp -- { class=\x22g(?: |>).*?<a href=".+?".*?>(.+?)<.*?<td valign=top><div.*?>(.*?)<.*?/div>} $html - d1 d2
          regsub -- { class=\x22g(?: |>).*?<a href=".+?".*?>(.+?)<.*?<td valign=top><div.*?>(.*?)<.*?/div>} $html {} html
          set desc "$d1, $d2"
          set link ""
        #finance / stock quotes
        } elseif {[string match "*<div class=e><div><a href=?/url?q=http://finance.google.com/finance*" $html] == 1} {
        	# this has to be one of the worst regexps ever written ! 
          regexp -- {<div class=e>.*?<a href=\x22.+?\x22>(.+?)</a>(.*?)<.*?<td colspan=3 nowrap>(.+?)</td>.*?Mkt Cap:.*?<td.*?>(.+?)</td>} $html - tick name price mktcap
          regsub -- {<div class=e>.*?<a href=\x22.+?\x22>(.+?)</a>(.*?)<.*?<td colspan=3 nowrap>(.+?)</td>.*?Mkt Cap:.*?<td.*?>(.+?)</td>} $html {} html
          if {[info exists tick] == 1 && [info exists name] == 1 && [info exists name] == 1} {
            set desc "$tick: $name = $$price"
          	set link "http://finance.google.com/finance?q=$tick"
						regsub -all -- "\002" $link {} link
          	if {[info exists mktcap] == 1} { append desc " Mkt Cap: $mktcap" }
          	unset tick ; unset name ; unset price ; unset mktcap
          }
        # patents
        # no longer supported by google in regular search - have to use http://google.com/patents/
        #} elseif {[regexp {^patent\s+(\d+)\s*$} $input]} {
        #  regexp -- {<a href="(http://patft.uspto.gov/.+?)">} $html - desc
        #  regsub -- {<a href="(http://patft.uspto.gov/.+?)">} $html {} html
        #  set break 1
        #  set link ""
        # spell: checker
        } elseif {$spell == 1} {
          set desc "No alternate spellings found."
          set link ""
        # calculator
        } elseif {[string match "*/images/calc_img*" $html] == 1} {
          # remove bold codes from the html, not necessary here.
          regsub -all -- "\002" $html {} html
          regexp -nocase -- {calc_img.+?nowrap.*?>(.+?)</} $html - desc
          set link ""
          set calc 1
        # regular search
        } else {
		      #as per forum request. ps: yay regsub!
      		if !${incith::google::subresults} {
      			regsub -all -- { class=g style=\x22margin-left:.*?\x22.*?</div>} $html {} html
      		}
					
					#fix to remove <img> spam from descriptions (usually from a picture next to the result).
					#get the div
          regexp -- { class=g>(.+?)</div>} $html - div
          #test the $desc for "<img"
          if {[info exists div] == 1} {
	          regexp -- {<a.*?href=.*?>(.+?)</a>} $div - test
	          if {[string range $test 0 3] == "<img"} { 
	            #if found, remove that whole <a href /> (We will use the next one)
	            regsub -- {<a.*?href=.*?</a>} $div {} div
	          }

	          #proceed as normal
	          regexp -- {<a.*?href=\x22(.+?)\x22.*?>(.+?)</a>} $div - link desc
	          regsub -- { class=g>.*?</div>} $html {} html
	
	          #trim the description
	          if {[info exists desc] == 1 && $incith::google::description_length > 0} {
	            set desc [string range $desc 0 [expr $incith::google::description_length - 1]]
	          }
          }
        }

        if {[info exists desc] == 0} {
          if {$output == ""} {
            set output "Sorry, no search results were found."
          }
          return $output
        }

				#Clean up the url result to remove google cruft (tracking, etc)
        if {[info exists link] == 1} {
          if {[string match "*/url\?sa=U*" $link] == 1} {
            regexp -- {/url.+?sa=U.+?q=(.*)&e=} $link - link
          } elseif {[string match "*/url\?sa=X*" $link] == 1} {
            regexp -- {/url.+?sa=X.+?q=(.*)\x22} $link - link
          } elseif {[string match "*/url\?q=*&sa=*" $link] == 1 || [string match "*/url\?q=*&revid=*" $link] == 1 } {
            regexp -- {/url\?q=(.+?)(?:&sa=|&revid=)} $link - link            
          } elseif {[string match "/search\?q=*&revid=*&sa=*" $link] == 1} {
            regexp -- {/search\?q=(.+?)&revid=.*?&sa=} $link - link
            set link "http://www.google.com/search\?q=$link"
          } elseif {[string match *.pdf $link] == 1} {
            set desc "\[PDF\] $desc"
          }
        }

        # Make sure we dont have an ugly %00 style url (an encoded url also wont work on buggy webservers)
        # this is a duplicate if check for debugging purposes only - trust me, you wont miss the cpu time.
        if {[string match "*\%\[2-7\]\[0-9a-fA-F\]*" $link] == 1} {
          set link [urldecode $link]
        }

        # this removes trailing spaces from the description, and converts %20's to spaces
        # \017 is ^O, read by clients as 'stop bold/colors/underline'
        set desc [string trim $desc]
        regsub -all "%20" $desc " " desc
        regsub -all "<br>" $desc " " desc

        if {[info exists desc] == 1 && $incith::google::desc_modes != ""} { set desc "$incith::google::desc_modes[string trim $desc]" }
        if {$results == 0 && [string match "* -- Current local *" $desc] == 1 && [string match "http://www.google.com*" $link] == 1 } { set spell 1 }

        # add the search result
        if {$calc == 0 && $spell == 0} {
          if {$link != ""} {
            if {[info exists link] == 1 && $incith::google::link_modes != ""} { set link "$incith::google::link_modes[string trim $link]" }
            if {[string match "define:*" $input] != 1} {
              regsub -all " " [string trim $link] "%20" link
            }
            regsub -all "(?:\x93|\x94|&quot;|\x22)" $link {} link
            append output "${desc}\017 \@ ${link}\017${incith::google::seperator}"
          } else {
            append output "${desc}\017 ${incith::google::seperator}"
          }
        } else {
          append output "${desc}\017"
        }

        # Check the various results where we only need one result.
        if {$spell == 1 || $calc == 1 || $break == 1} {
          break
        }

        # increase the results, clear the variables for the next loop
        unset link ; unset desc ; set spell 0 ; set calc 0 ; set break 0
        if {[info exists did_you_mean] == 1} { unset did_you_mean }
        incr results
      }

      # make sure we have something to send
      if {[info exists output] == 0} {
        set reply "Sorry, no search results were found."
        if {[info exists did_you_mean] == 1} {
          append reply " Did you mean: ${did_you_mean}?"
        }
        return $reply
      }
      return $output
    }

    # IMAGES
    # fetches a list of links to images from images.google.
    #
    proc images {input} {
      ; set results 0 ; set output ""

      # if we don't want any search results, stop now.
      if {$incith::google::image_results <= 0} {
        return
      }

      # fetch the html
      set html [fetch_html $input 2]

      # check for 'did you mean?' first
      regexp -nocase -- {Did you mean:.*?<a.*?href=.*?>(.+?)</a>} $html - did_you_mean
      if {[info exists did_you_mean] == 1} {
        append output "Did you mean: $did_you_mean ?"
        incr results
      }

      # parse the html
      while {$results < $incith::google::image_results} {
        regexp -- {<a.+?href=/imgres\?imgurl=(.+?)&imgrefurl} $html - link
        regsub -- {<a.+?href=/imgres\?imgurl=(.+?)&imgrefurl} $html {} html

        # if there's no link, return or stop looping, depending
        if {![info exists link]} {
          if {$results == 0} {
            set reply "Sorry, no search results were found."
            return $reply
          } else {
            break
          }
        }

        # prevent duplicate results is mostly useless here, but will at least
        #   ensure that we don't get the exact same picture.
        if {[string match "*$link*" $output] == 1} {
          break
        }
        if {[info exists link] == 1 && $incith::google::link_modes != ""} { set link "$incith::google::link_modes[string trim $link]" }

        # add the search result
        # \017 is ^O, read by clients as 'reset color' (stop bold/etc)
        if {[string length $output] > 0} {
        	append output "${incith::google::seperator}${link}\017"
        } else {
					append output "${link}\017"
 				}

        # increase the results, clear the variables for the next loop just in case
        unset link
        incr results
      }

      # make sure we have something to send
      if {[info exists output] == 0} {
        set reply "Sorry, no search results were found."
        return $reply
      }
      return $output
    }

    # LOCAL
    # fetches a list of address & phone numbers from local.google.
    #
    proc local {input} {
      ; set results 0 ; set output ""

      # if we don't want any search results, stop now.
      if {$incith::google::local_results <= 0} {
        return
      }

      # fetch the html
      set html [fetch_html $input 3]

      # check for 'did you mean?' first
      regexp -nocase -- {Did you mean:.*?<a.*?href=.*?>(.+?)</a>} $html - did_you_mean
      if {[info exists did_you_mean] == 1} {
        append output "Did you mean: $did_you_mean ?"
        incr results
      }

      # parse the html
      while {$results < $incith::google::local_results} {

      	regexp -- {<div class="bn">.*?<a href=.*?>(.+?)</a>.*?</div>.*?<div class="al adr">(.*?)</div>} $html - name addr
        regsub -- {<div class="bn">.*?</div>.*?<div class="al adr">.*?</div>} $html {} html 

        # if there's no link, return or stop looping, depending
        if {[info exists name] == 0} {
          if {$results == 0} {
            set reply "Sorry, no search results were found."
            return $reply
          } else {
            break
          }
        }

				if {[string match "*<nobr*" $addr] == 1} { regsub -- {<nobr.*?>(.*?)</nobr>} $addr {\1} addr }
        if {$incith::google::desc_modes != ""} { set name "$incith::google::desc_modes$name" }
        if {$incith::google::link_modes != ""} { set link "$incith::google::link_modes${addr}\017." }
        if {[info exists link] == 0} { set link "${addr}." }
        
        
        # add the search result
        # \017 is ^O, read by clients as 'reset color' (stop bold/etc)
        if {[string length $output] > 0} {
        	append output "${incith::google::seperator}${name}\017 \@ ${link}\017"
        } else {
        	append output "${name}\017 \@ ${link}\017"
				}
        # increase the results, clear the variables for the next loop just in case
        unset name ; unset link
        incr results
      }

      # make sure we have something to send
      if {[info exists output] == 0} {
        set reply "Sorry, no search results were found."
        return $reply
      }
      return $output
    }

    # GROUPS
    # fetches a list of threads from groups.google.
    #
    proc groups {input} {
      set results 0 ; set output ""

      # if we don't want any search results, stop now.
      if {$incith::google::group_results <= 0} {
        return
      }

      # fetch the html
      set html [fetch_html $input 4]

      # check for 'did you mean?' first
      regexp -nocase -- {Did you mean:.*?<a.*?href=.*?>(.+?)</a>} $html - did_you_mean
      if {[info exists did_you_mean] == 1} {
        append output "Did you mean: $did_you_mean ?"
        incr results
      }
      
      #Remove the "groups matching" if it exists (its really quite useless)
      if {[string match "*/groups/img/groups-onebox.gif*" $html] == 1} {
        regsub -- {<table.*?groups-onebox.gif.*?</table>} $html {} html
      }

      # parse the html
      while {$results < $incith::google::group_results} {
	      #as per forum request. ps: yay regsub!
    		if !${incith::google::subresults} {
    			regsub -all -- {<blockquote style=".*?">.*?</blockquote>} $html {} html
    		}

        regexp -- {<a.*?href=\x22/group/(.*?)/browse_thread/thread/(.+?)/.*?>(.+?)</a>.*?</table>} $html {} group thread desc
        regsub -- {<a.*?href=\x22/group/.*?</table>} $html {} html

        #if theres no desc, return or stop looping, depending
        if {[info exists desc] == 0} {
          if {$results == 0} {
            set reply "Sorry, no search results were found."
            return $reply
          } else {
            break
          }
        }

        if {[info exists desc] == 1 && $incith::google::description_length > 0} {
          set desc [string range $desc 0 [expr $incith::google::description_length - 1]]
        }

        # make the link valid because we only got a partial href result, not a full url
        set link "http://groups.google.com/group/${group}/browse_thread/thread/${thread}"

        if {[info exists desc] == 1 && $incith::google::desc_modes != ""} { set desc "$incith::google::desc_modes[string trim $desc]" }
        if {[info exists link] == 1 && $incith::google::link_modes != ""} { set link "$incith::google::link_modes[string trim $link]" }

        # add the search result
        if {[string length $output] > 0} {
        	append output "${incith::google::seperator}${desc}\017 \@ ${link}\017"
        } else {
        	append output "${desc}\017 \@ ${link}\017"
				}

        # increase the results, clear the variables for the next loop just in case
        unset link; unset desc
        incr results
      }

      # make sure we have something to send
      if {[info exists output] == 0} {
        set reply "Sorry, no search results were found."
        return $reply
      }
      return $output
    }

    # NEWS
    # fetches the news from news.google.
    #
    proc news {input} {
      ; set results 0 ; set output ""

      # if we don't want any search results, stop now.
      if {$incith::google::news_results <= 0} {
        return
      }

      # fetch the html
      set html [fetch_html $input 5]

      # check for 'did you mean?' first
      regexp -nocase -- {Did you mean:.*?<a.*?href=.*?>(.+?)</a>} $html - did_you_mean
      if {[info exists did_you_mean] == 1} {
        append output "Did you mean: $did_you_mean ?"
        incr results
      }

      # parse the html
      while {$results < $incith::google::news_results} {
        # somewhat extenuated regexp due to allowing that there *might* be
        # an image next to the story
        regexp -- {<div class=lh>.*?<a.*?href=\x22(.*?)\x22.*?>(.+?)</a>.*?</div>} $html {} link desc
        regsub -- {<div class=lh>.*?<a.*?href=\x22(.*?)\x22.*?>(.+?)</a>.*?</div>} $html {} html

        # if there's no desc, return or stop looping, depending
        if {[info exists desc] == 0} {
          if {$results == 0} {
            set reply "Sorry, no search results were found."
            return $reply
          } else {
            break
          }
        }

        if {[info exists desc] == 1 && $incith::google::description_length > 0} {
          set desc [string range $desc 0 [expr $incith::google::description_length - 1]]
        }

        # prevent duplicate results is mostly useless here, but will at least
        #   ensure that we don't get the exact same article.
        if {[string match "*$link*" $output] == 1} {
          break
        }

        if {[info exists desc] == 1 && $incith::google::desc_modes != ""} { set desc "$incith::google::desc_modes[string trim $desc]" }
        if {[info exists link] == 1 && $incith::google::link_modes != ""} { set link "$incith::google::link_modes[string trim $link]" }

        # add the search result
        if {[string length $output] > 0} {
          append output "${incith::google::seperator}${desc}\017 \@ ${link}\017"
        } else {
        	append output "${desc}\017 \@ ${link}\017"
				}

        # increase the results, clear the variables for the next loop just in case
        unset link; unset desc
        incr results
      }

      # make sure we have something to send
      if {[info exists output] == 0} {
        set reply "Sorry, no search results were found."
        return $reply
      }
      return $output
    }

    # BOOKS
    # fetches book titles from books.google.
    #
    proc books {input} {
      ; set results 0 ; set output ""

      # if we don't want any search results, stop now.
      if {$incith::google::books_results <= 0} {
        return
      }

      # fetch the html
      set html [fetch_html $input 6]

      # check for 'did you mean?' first
      regexp -nocase -- {Did you mean:.*?<a.*?href=.*?>(.+?)</a>} $html - did_you_mean
      if {[info exists did_you_mean] == 1} {
        append output "Did you mean: $did_you_mean ?"
        incr results
      }

      #parse the html
      while {$results < $incith::google::books_results} {
        regexp -- {<div class=resbdy.*?<a.*?href=\x22(.+?)&dq=.*?>(.+?)</a>.*?</div>} $html {} link desc
        regsub -- {<div class=resbdy.*?</div>} $html {} html

        # if there's no desc, return or stop looping, depending
        if {[info exists desc] == 0} {
          if {$results == 0} {
            set reply "Sorry, no search results were found."
            return $reply
          } else {
            break
          }
        }

        # prevent duplicate results is mostly useless here, but will at least
        #   ensure that we don't get the exact same article.
        if {[string match "*$link*" $output] == 1} {
          break
        }

        if {[info exists desc] == 1 && $incith::google::desc_modes != ""} { set desc "$incith::google::desc_modes[string trim $desc]" }
        if {[info exists link] == 1 && $incith::google::link_modes != ""} { set link "$incith::google::link_modes[string trim $link]" }

        # add the search result
        if {[string length $output] > 0} {
          append output "${incith::google::seperator}${desc}\017 \@ ${link}\017"
        } else {
        	append output "${desc}\017 \@ ${link}\017"
				}

        # increase the results, clear the variables for the next loop just in case
        unset link; unset desc
        incr results
      }

      # make sure we have something to send
      if {[info exists output] == 0} {
        set reply "Sorry, no search results were found."
        return $reply
      }
      return $output
    }

    # VIDEO
    # fetches links to video with search data in it (video.google.com)
    #
    proc video {input} {
      ; set results 0 ; set output ""

      # if we don't want any search results, stop now.
      if {$incith::google::video_results <= 0} {
        return
      }

      # fetch the html
      set html [fetch_html $input 7]

      # check for 'did you mean?' first
      regexp -nocase -- {Did you mean:.*?<a.*?href=.*?>(.+?)</a>} $html - did_you_mean
      if {[info exists did_you_mean] == 1} {
        append output "Did you mean: $did_you_mean ?"
        incr results
      }

      # parse the html
      while {$results < $incith::google::video_results} {
        regexp -- {<div class=\x22rl-title\x22.*?>.*?<a href=.*?docid=(.+?)&.*?>(.+?)</a>.*?</div>} $html {} link desc
        regsub -- {<div class=\x22rl-title\x22.*?</div>} $html {} html

        # if there's no desc, return or stop looping, depending
        if {[info exists desc] == 0} {
          if {$results == 0} {
            set reply "Sorry, no search results were found."
            return $reply
          } else {
            break
          }
        }
        if {[info exists desc]} {
          set link "http://video.google.com/videoplay?docid=$link"
        }
        set desc [string trim $desc]
        set link [string trim $link]
        if {[string match "*\%\[2-7\]\[0-9a-fA-F\]*" $link] == 1} {
          set link [urldecode $link]
        }

        # prevent duplicate results is mostly useless here, but will at least
        #   ensure that we don't get the exact same article.
        if {[string match "*$link*" $output] == 1} {
         break
        }

        if {[info exists desc] == 1 && $incith::google::desc_modes != ""} { set desc "$incith::google::desc_modes[string trim $desc]" }
        if {[info exists link] == 1 && $incith::google::link_modes != ""} { set link "$incith::google::link_modes[string trim $link]" }

        # add the search result
        if {[string length $output] > 0} {
          append output "${incith::google::seperator}${desc}\017 \@ ${link}\017"
        } else {
        	append output "${desc}\017 \@ ${link}\017"
				}

        # increase the results, clear the variables for the next loop just in case
        unset link; unset desc
        incr results
      }

      # make sure we have something to send
      if {[info exists output] == 0} {
        set reply "Sorry, no search results were found."
        return $reply
      }
      return $output
    }

    # FIGHT
    # google fight !
    #
    proc fight {input} {
      set output ""; set winner 0

      # if google fight is disabled, stop now.
      if {$incith::google::google_fight <= 0} {
        return
      }
      
      regexp -nocase -- {^(.+?) vs (.+?)$} $input - word1 word2

      # This fixes up the issues with 'reserved' url characters: "$&+,/:=@?" by converting them to %xx
      set word1 [incith::google::urlencode $word1]
      set word2 [incith::google::urlencode $word2]

      # fetch the first result
      set html [fetch_html $word1 8]
      # parse the html
      regexp -- {Results.+?of about.+?([,0-9]{1,}).+?for} $html - match1

      # fetch the second result
      set html [fetch_html $word2 8]
      # parse the html
      regexp -- {Results.+?of about.+?([,0-9]{1,}).+?for} $html - match2

      if {![info exists match1]} {
        set match1 "0"
        set match1expr "0"
      } else {
        regsub -all {,} $match1 {} match1expr
      }

      if {![info exists match2]} {
        set match2 "0"
        set match2expr "0"
      } else {
        regsub -all {,} $match2 {} match2expr
      }

      if {[expr $match2expr < $match1expr]} {
        set winner 1
      } elseif {[expr $match2expr > $match1expr]} {
        set winner 2
      } elseif {[expr $match2expr == $match1expr]} {
        set winner 3
      }

      # This fixes up the issues with 'reserved' url characters: "$&+,/:=@?" by converting them to %xx
      set word1 [incith::google::urldecode $word1]
      set word2 [incith::google::urldecode $word2]
      regsub -all "%20" $word1 " " word1
      regsub -all "%20" $word2 " " word2
      
      if {$incith::google::bold_descriptions > 0 && $incith::google::desc_modes == ""} {
        set word1 "\002$word1\017"; set word2 "\002$word2\017"
        set match1 "\002 $match1\017"; set match2 "\002 $match2\017"
      } elseif {$incith::google::desc_modes != ""} {
        set word1 "$incith::google::desc_modes$word1\017"; set word2 "$incith::google::desc_modes$word2\017"
        set match1 "$incith::google::desc_modes $match1\017"; set match2 "$incith::google::desc_modes $match2\017"
      } else {
        set match1 " $match1"; set match2 " $match2"
      }

      if {$winner == 1} {
        set output "By results on Google: $word1 beats $word2 by$match1 to$match2!"
      } elseif {$winner == 2} {
        set output "By results on Google: $word2 beats $word1 by$match2 to$match1!"
      } elseif {$winner == 3} {
        set output "By results on Google: $word1 ties with $word2 on$match1!"
      } else {
        set output "Could not determine the winner."
      }

      # make sure we have something to send
      if {[info exists output] == 0} {
        set reply "Sorry, no search results were found."
        return $reply
      }
      return $output
    }

    # FETCH_HTML
    # fetches html for the various *.google.com sites
    #
    proc fetch_html {input switch} {
      # for local
      regexp -nocase -- {^(.+?) near (.+?)$} $input - search location
      # for the rest

      # GOOGLE
      if {$switch == 1} {
        # we don't want 'define:+<search>', so we'll just remove the space if there is one.
        regsub -nocase -- {^define:\s*} $input {define:} input

        # spell after define so 'spell: define: foo' doesn't turn into a define lookup
        if {[string match -nocase "spell:*" $input] == 1} {
          regsub -nocase -- {^spell:\s*} $input {} input
        }

        regsub -all -- {\x22} $input {%22} input
        regsub -all -- {\+} $input {%2B} input
        regsub -all -- {\s} $input {+} input

        if {[string match "movie:*" $input] == 1} {
          set query "http://www.google.com/movies?hl=en&q=${input}&safe=${incith::google::safe_search}&btnG=Search&lr=lang_${incith::google::language}"
        } else {
          set query "http://www.google.com/search?hl=en&q=${input}&safe=${incith::google::safe_search}&btnG=Search&lr=lang_${incith::google::language}"
        }
      # IMAGES
      } elseif {$switch == 2} {
        set query "http://images.google.com/images?hl=en&q=${input}&safe=${incith::google::safe_search}&btnG=Search+Images"
      # LOCAL
      } elseif {$switch == 3} {
        # a + joins words together in the search, so we change +'s to there search-form value
        regsub -all -- {\+} $search {%2B} search
        regsub -all -- {\+} $location {%2B} location
        # change spaces to +'s for a properly formatted search string.
        regsub -all -- { } $search {+} search
        regsub -all -- { } $location {+} location
        set query "http://local.google.com/local?hl=en&q=${search}&near=${location}&view=text"
      } elseif {$switch == 4} {
        set query "http://groups.google.com/groups?hl=en&q=${input}&safe=${incith::google::safe_search}"
      } elseif {$switch == 5} {
        set query "http://news.google.com/news?hl=en&q=${input}&ned=tus"
      } elseif {$switch == 6} {
        regsub -all -- { } $input {+} input
        set query "http://books.google.com/books?q=${input}&as_brr=0"
      } elseif {$switch == 7} {
        set query "http://video.google.com/videosearch?q=${input}"
      } elseif {$switch == 8} {
        set query "http://www.google.com/search?hl=&q=${input}&safe=off&btnG=Search&lr=lang_all&num=1"
      }

      # beware, changing the useragent will result in differently formatted html from Google.
      set ua "Lynx/2.8.5rel.1 libwww-FM/2.14 SSL-MM/1.4.1 GNUTLS/1.4.4"
      set http [::http::config -useragent $ua]
      set http [::http::geturl "$query" -timeout [expr 1000 * 10]]
      set html [::http::data $http]

      # generic pre-parsing
      regsub -all "\n" $html " " html
      regsub -all "(?:\x91|\x92|&#39;)" $html "\x27" html
      regsub -all "(?:\x93|\x94|&quot;)" $html "\x22" html
      regsub -all "&amp;" $html {\&} html
      regsub -all -nocase {<h2.+?>} $html "" html
      regsub -all -nocase {<font.+?>} $html "" html
      regsub -all -nocase {<sup>(.+?)</sup>} $html {\1} html
      regsub -all -nocase {<font.+?>} $html "" html
      regsub -all -nocase {</font>} $html "" html
      regsub -all -nocase {<span.+?>} $html "" html
      regsub -all -nocase {</span>} $html "" html
      regsub -all -nocase {<input.+?>} $html "" html
      regsub -all -nocase {(?:<i>|</i>)} $html "" html
      regsub -all -nocase {(?:<em>|</em>)} $html "" html
      
      #' this is the "---" line in "population of Japan" searches
      regsub -all "&#8212;" $html "--" html
      regsub -all "&times;" $html {*} html
      regsub -all "&nbsp;" $html { } html
      regsub -all -nocase "&#215;" $html "x" html
      regsub -all -nocase "&lt;" $html "<" html
      regsub -all -nocase "&gt;" $html ">" html

      # regsub to junk the remaining unicode chars since irc cant handle them properly anyway
      # this will only match &#256; to &#99999;
      regsub -all -- {&#(25(\[6-9\])?|2(\[6-9\])?[\d]|(\[3-9\])?[\d]{2}|[\d]{4,5});} $html "" html
      
      #
      # regexps that should remain seperate go here
      # google specific regexps
      if {$switch == 1} {
        # regexp the rest of the html for a much easier result to parse
        regsub -all -nocase {<b>\[PDF\]</b>\s*} $html "" html
        
        regsub -all -- "<p class=g>" $html "<div class=g>" html
        regsub -all -- {<p class=g style="margin-left:} $html {<div class=g style="margin-left:} html

        # because we dont want to sign in
        #regsub -- {<a href=".*?/accounts/Login.*?">Sign in</a>} $html {} html
        # or go to google.com..
        #regsub -all -- {<a id=logo .*?</a>} $html {} html
        # or freaking look at the definition!  gah!  stop adding new stuff google!
        #regsub -all -- {<a href="/url.+?http://www\.answers\.com/.+?" title="Look up definition.+?">.+?</a>} $html {} html

      } elseif {$switch == 2} {
        # these %2520 codes, I have no idea. But they're supposed to be %20's
        regsub -all {%2520} $html {%20} html
      } elseif {$switch == 3} {
        regsub -all -nocase { - <nobr>Unverified listing</nobr>} $html "" html
      } elseif {$switch == 4} {
      } elseif {$switch == 5} {
      } elseif {$switch == 6} {
      } elseif {$switch == 7} {
      } elseif {$switch == 8} {
      }
      # no point having it so many times
      if {$incith::google::bold_descriptions > 0 && [string match "\002" $incith::google::desc_modes] != 1} {
        regsub -all -nocase {(?:<b>|</b>)} $html "\002" html
      } else {
        regsub -all -nocase {(<b>|</b>)} $html {} html
      }

      return $html
    }

    # PUBLIC_MESSAGE
    # decides what to do with binds that get triggered
    #
    proc public_message {nick uhand hand chan input} {
      if {[lsearch -exact [channel info $chan] +google] != -1} {
        if {$incith::google::chan_user_level == 3} {
          if {[isop $nick $chan] == 0} {
            return
          }
        } elseif {$incith::google::chan_user_level == 2} {
          if {[ishalfop $nick $chan] == 0 && [isop $nick $chan] == 0} {
            return
          }
        } elseif {$incith::google::chan_user_level == 1} {
          if {[isvoice $nick $chan] == 0 && [ishalfop $nick $chan] == 0 && [isop $nick $chan] == 0} {
            return
          }
        }
        send_output "$input" "$chan" "$nick" "$uhand"
      }
    }

    # PRIVATE_MESSAGE
    # decides what to do with binds that get triggered
    #
    proc private_message {nick uhand hand input} {
      if {$incith::google::private_messages >= 1} {
        send_output $input $nick $nick $uhand
      }
    }

    # SEND_OUTPUT
    # no point having two copies of this in public/private_message{}
    #
    proc send_output {input where nick uhand} {
      if {[encoding system] != "identity" && [lsearch [encoding names] "ascii"]} {
        set command_char [encoding convertfrom ascii ${incith::google::command_char}]
        set input [encoding convertfrom ascii $input]
      } elseif {[encoding system] == "identity"} {
        set command_char [encoding convertfrom identity ${incith::google::command_char}]
        set input [encoding convertfrom identity $input]
      } else {
        set command_char ${incith::google::command_char}
      }

      #Specifically retrieve only ONE (ascii) character, then check that matches the command_char first
      set trigger_char [string index $input 0]
      if {[encoding system] == "identity"} {
        set trigger_char [encoding convertfrom identity $trigger_char]
      }

      #Sanity check 1 - If no match, stop right here. No need to match every (first word) of
      # every line of channel data against every bind if the command_char doesnt even match.
      if {$trigger_char != $command_char} {
        return
      }

      set trigger [string range [lindex $input 0] 1 end]
      #Sanity check 2 - Stop if theres nothing to search for (quiet)
      set search [string trim [string range $input [string wordend $input 1] end]]
      if {$search == ""} { return }

      # flood protection check
      if {[flood $nick $uhand]} {
        return
      }
      
      if {$incith::google::force_private == 1} { set where $nick }

      # check for !google
      foreach bind [split $incith::google::google_binds " "] {
        if {[string match -nocase $bind $trigger] == 1} {
          # This fixes up the issues with 'reserved' url characters: "$&+,/:=@?" by converting them to %xx
          set search [incith::google::urlencode $search]

          # call google
          foreach line [incith::google::parse_output [google $search]] {
            put_output $where $line
          }
          break
        }
      }

      # check for !images
      foreach bind [split $incith::google::image_binds " "] {
        if {[string match -nocase $bind $trigger] == 1} {
          # This fixes up the issues with 'reserved' url characters: "$&+,/:=@?" by converting them to %xx
          set search [incith::google::urlencode $search]
          # call images
          foreach line [incith::google::parse_output [images $search]] {
            put_output $where $line
          }
          break
        }
      }
      # check for !local
      foreach bind [split $incith::google::local_binds " "] {
        if {[string match -nocase $bind $trigger] == 1} {
          # local requires splitting of the search
          regexp -nocase -- {^(.+?) near (.+?)$} $search - what location

          if {![info exists what] || ![info exists location]} {
            put_output $where "Local searches should be the format of 'pizza near footown, bar'"
            return
          }

          foreach line [incith::google::parse_output [local $search]] {
            put_output $where $line
          }
          break
        }
      }
      # check for !groups
      foreach bind [split $incith::google::group_binds " "] {
        if {[string match -nocase $bind $trigger] == 1} {
          # This fixes up the issues with 'reserved' url characters: "$&+,/:=@?" by converting them to %xx
          set search [incith::google::urlencode $search]
          # call groups
          foreach line [incith::google::parse_output [groups $search]] {
            put_output $where $line
          }
          break
        }
      }
      # check for !news
      foreach bind [split $incith::google::news_binds " "] {
        if {[string match -nocase $bind $trigger] == 1} {
          # This fixes up the issues with 'reserved' url characters: "$&+,/:=@?" by converting them to %xx
          set search [incith::google::urlencode $search]
          # call news
          foreach line [incith::google::parse_output [news $search]] {
            put_output $where $line
          }
          break
        }
      }
      # check for !books
      foreach bind [split $incith::google::books_binds " "] {
        if {[string match -nocase $bind $trigger] == 1} {
          # call books
          foreach line [incith::google::parse_output [books $search]] {
            put_output $where $line
          }
          break
        }
      }
      # check for !video
      foreach bind [split $incith::google::video_binds " "] {
        if {[string match -nocase $bind $trigger] == 1} {
          # This fixes up the issues with 'reserved' url characters: "$&+,/:=@?" by converting them to %xx
          set search [incith::google::urlencode $search]
          # call video
          foreach line [incith::google::parse_output [video $search]] {
            put_output $where $line
          }
          break
        }
      }
      # check for !fight
      foreach bind [split $incith::google::fight_binds " "] {
        if {[string match -nocase $bind $trigger] == 1} {
          # fight requires splitting of the search
          regexp -nocase -- {^(.+?) vs (.+?)$} $search - word1 word2
          if {![info exists word1] || ![info exists word2]} {
            put_output $where "Google fights should be the format of 'random vs predictable'"
            return
          }

          # call fight
          foreach line [incith::google::parse_output [fight $search]] {
            put_output $where $line
          }
          break
        }
      }
    }

    # PUT_OUTPUT
    # actually sends the output to the server
    proc put_output {where line} {
      if {$incith::google::notice_reply == 1} {
        putserv "NOTICE $where :$line"
      } else {
        putserv "PRIVMSG $where :$line"
      }
    }


    # PARSE_OUTPUT
    # prepares output for sending to a channel/user, calls line_wrap
    #
    proc parse_output {input} {
      set parsed_output [set parsed_current {}]
      if {[string match "\n" $incith::google::seperator] == 1} {
        regsub {\n\s*$} $input "" input
        foreach newline [split $input "\n"] {
          foreach line [incith::google::line_wrap $newline] {
            lappend parsed_output $line
          }
        }
      } else {
        regsub "(?:${incith::google::seperator}|\\|)\\s*$" $input {} input
        foreach line [incith::google::line_wrap $input] {
          lappend parsed_output $line
        }
      }
      return $parsed_output
    }

    # LINE_WRAP
    # takes a long line in, and chops it before the specified length
    # http://forum.egghelp.org/viewtopic.php?t=6690
    #
    proc line_wrap {str {splitChr { }}} {
      set out [set cur {}]
      set i 0
      set len $incith::google::split_length
      #regsub -all "\002" $str "<ZQ" str
      #regsub -all "\037" $str "<ZX" str
      foreach word [split [set str][set str ""] $splitChr] {
        if {[incr i [string len $word]] > $len} {
          #regsub -all "<ZQ" $cur "\002" cur
          #regsub -all "<ZX" $cur "\037" cur
          lappend out [join $cur $splitChr]
          set cur [list $word]
          set i [string len $word]
        } else {
          lappend cur $word
        }
        incr i
      }
      #regsub -all "<ZQ" $cur "\002" cur
      #regsub -all "<ZX" $cur "\037" cur
      lappend out [join $cur $splitChr]
    }

    # FLOOD_INIT
    # modified from bseen
    #
    variable flood_data
    variable flood_array
    proc flood_init {} {
      if {$incith::google::ignore < 1} {
        return 0
      }
      if {![string match *:* $incith::google::flood]} {
        putlog "$incith::google::version: variable flood not set correctly."
        return 1
      }
      set incith::google::flood_data(flood_num) [lindex [split $incith::google::flood :] 0]
      set incith::google::flood_data(flood_time) [lindex [split $incith::google::flood :] 1]
      set i [expr $incith::google::flood_data(flood_num) - 1]
      while {$i >= 0} {
        set incith::google::flood_array($i) 0
        incr i -1
      }
    }
    ; flood_init

    # FLOOD
    # updates and returns a users flood status
    #
    proc flood {nick uhand} {
      if {$incith::google::ignore < 1} {
        return 0
      }
      if {$incith::google::flood_data(flood_num) == 0} {
        return 0
      }
      set i [expr ${incith::google::flood_data(flood_num)} - 1]
      while {$i >= 1} {
        set incith::google::flood_array($i) $incith::google::flood_array([expr $i - 1])
        incr i -1
      }
      set incith::google::flood_array(0) [unixtime]
      if {[expr [unixtime] - $incith::google::flood_array([expr ${incith::google::flood_data(flood_num)} - 1])] <= ${incith::google::flood_data(flood_time)}} {
        putlog "$incith::google::version: flood detected from ${nick}."
        newignore [join [maskhost *!*[string trimleft $uhand ~]]] $incith::google::version flooding $incith::google::ignore
        return 1
      } else {
        return 0
      }
    }

    # URL Decode
    # Decodes all of the %00 strings in a url and returns it
    #
    proc urldecode {url} {
      if {[string match "*\%\[2-7\]\[0-9a-fA-F\]*" $url] == 1} {
        #regsub -all "%20" $url " " url
        regsub -all "%22" $url "\x22" url
        regsub -all "%23" $url "#" url
        regsub -all "%25" $url "%" url
        regsub -all "%26" $url {\x26} url
        regsub -all "%2B" $url "+" url
        regsub -all "%2F" $url {/} url
        regsub -all "%3A" $url ":" url
        regsub -all "%3C" $url "<" url
        regsub -all "%3D" $url "=" url
        regsub -all "%3E" $url ">" url
        regsub -all "%3F" $url "?" url
        regsub -all "%5B" $url "\[" url
        regsub -all "%5C" $url "\\" url
        regsub -all "%5D" $url "]" url
        regsub -all "%5E" $url "^" url
        regsub -all "%60" $url "`" url
        regsub -all "%7B" $url "{" url
        regsub -all "%7C" $url "|" url
        regsub -all "%7D" $url "}" url
        regsub -all "%7E" $url "~" url
      }
      return $url
    }

    # URL Encode
    # Encodes all non alphanumerics to %00 strings in the input and returns it
    #
    proc urlencode {url} {
      set url [string trim $url]
      # % goes first ... obviously :)
      regsub -all -- {\%} $url {%25} url
      regsub -all -- { } $url {%20} url
      regsub -all -- {\&} $url {%26} url
      #regsub -all -- {\!} $url {%21} url
      regsub -all -- {\@} $url {%40} url
      regsub -all -- {\#} $url {%23} url
      regsub -all -- {\$} $url {%24} url
      regsub -all -- {\^} $url {%5E} url
      #regsub -all -- {\*} $url {%2A} url
      #regsub -all -- {\(} $url {%28} url
      #regsub -all -- {\)} $url {%29} url
      regsub -all -- {\+} $url {%2B} url
      regsub -all -- {\=} $url {%3D} url
      regsub -all -- {\\} $url {%5C} url
      regsub -all -- {\/} $url {%2F} url
      regsub -all -- {\|} $url {%7C} url
      regsub -all -- {\[} $url {%5B} url
      regsub -all -- {\]} $url {%5D} url
      regsub -all -- {\{} $url {%7B} url
      regsub -all -- {\}} $url {%7D} url
      #regsub -all -- {\.} $url {%2E} url
      regsub -all -- {\,} $url {%2C} url 
      #regsub -all -- {\-} $url {%2D} url
      #regsub -all -- {\_} $url {%5F} url
      #regsub -all -- {\'} $url {%27} url
      
      #Need : to make define:, movie: etc work 
      #regsub -all -- {\:} $url {%3A} url
      
      regsub -all -- {\;} $url {%3B} url
      regsub -all -- {\?} $url {%3F} url
      regsub -all -- {\"} $url {%22} url
      regsub -all -- {\<} $url {%3C} url
      regsub -all -- {\>} $url {%3E} url
      regsub -all -- {\~} $url {%7E} url
      regsub -all -- {\`} $url {%60} url
            
      return $url
    }
  }
}

putlog " - $incith::google::version loaded."

# EOF
