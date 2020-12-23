#########################################################################
# Chilla's IMDb info script
# 
##
# Version: 20040110 - changed script to use new query string and parse
#                     new IMDb search results page - NetRipper
##
# Notes for this version: Thanks to 2dee for showing me his
# imdb site update fix. Thanks to TotaLGaZ for his help.
# Thanks to Chilla and FAN for their work on this brilliant script.
# Would like to make the options selectable from the partyline and also
# add a disable trigger in channel(both specific and global) option. Who 
# knows might get round to it one day but if anyone else wants to then it 
# will save me a job.
##
# Version: 20030014 - works with updated imdb site, new option of public
# or notice response to chan triggers.
# - GQsm http://forum.egghelp.org
##
# Version: 20020604 - fixed misc http/html stuff, added msg command - FAN
##
# Version: 20011031 - - Chilla
#########################################################################


# base imdb url, to which you can append "/Title?######" or whatever
set imdburl "http://www.imdb.com"

# the imdb search script
set imdbsearchurl "http://www.imdb.com:80/find?"

# 1 for each of these means that the respective values will ALWAYS show
# and that command options for these will be disregarded
# leave zero to keep them an option at the command line
set show_rating 1 
set show_genre 1
set show_tagline 1
set show_outline 0
set show_cast 0

# for a channel !imdb request
# set to 1 = title ,rating, genre and tagline(if selected) will be displayed
# publicly to the channel
# set to 0 = all results will be sent as private notice
set pub_or_not 1

#########################################################################
# DO NOT MODIFY BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING!
#########################################################################

set DEBUG 0
set imdbVERSION 20040110
set b_agent "MSIE 6.0" 

# If you are getting http error messages, try uncommentign this next line:
#package forget http
package require http 2.3

bind pub -|- !imdb imdb_handler
bind msg -|- !imdb imdb_msghandler

proc imdb_handler { nick uhost hand chan args } {
	global DEBUG imdbVERSION imdburl imdbsearchurl b_agent
	global show_rating show_genre show_tagline show_outline show_cast
	global pub_or_not

   # How do you want your results ? chan or priv
	if {$pub_or_not == 1 } {
	set toput "PRIVMSG $chan"
	} else {
	set toput "NOTICE $nick"
	}

          # set to defaults
		set o_rating $show_rating 
		set o_genre $show_genre 
		set o_tagline $show_tagline
		set o_outline $show_outline 
		set o_cast $show_cast


		set checkargs [string trim $args " \n"]

		# if no arguments passed, show help
		if {[string compare $checkargs "{}"] == 0} {
			putserv "NOTICE $nick :IMDb info script v$imdbVERSION - 7General Help"
			putserv "NOTICE $nick :14<===========================================>"
			putserv "NOTICE $nick :7!imdb \[options\] <imdb title>"
			putserv "NOTICE $nick :7options: -r     ratings" 
			putserv "NOTICE $nick :7         -g     genre" 
			putserv "NOTICE $nick :7         -t     tagline" 
			putserv "NOTICE $nick :7         -o     plot outline" 
			putserv "NOTICE $nick :7         -c     cast" 
			putserv "NOTICE $nick :7Example: !imdb -o -c Beautiful Mind" 
			return	
		} 

	# Look for command line options and enable each, as desired
	set fargs ""
		set imdbtitle ""
		foreach piece [split $args " "] {
			set piece	[string trim $piece "{}"]
				if {[string compare $piece "-r"] == 0 } {
					set o_rating 1
				} elseif {[string compare $piece "-g"] == 0 } {
					set o_genre 1
				} elseif {[string compare $piece "-t"] == 0 } {
					set o_tagline 1
				} elseif {[string compare $piece "-o"] == 0 } {
					set o_outline 1
				} elseif {[string compare $piece "-c"] == 0 } {
					set o_cast 1
				} else {
					set fargs "$fargs $piece"
				}
		}
        #set fargs [string trimleft $args]
	if {$DEBUG == 1} {
		putserv "NOTICE $nick :I am doing a search for \"$fargs\" on imdb.com"
	}

	set query $fargs

		# do initial search
		set searchString [ ::http::formatQuery $query ] 
                set searchString [string trimleft $searchString "+"]		
                if {$DEBUG == 1} {
		 putserv "NOTICE $nick :searchString: \"$searchString\""		
		}
                set page [::http::config -useragent $b_agent]
		set page [::http::geturl ${imdbsearchurl}q=${searchString}&sort=smart&tv=off]

		set redirect 0
		set newurl ""

		set lines [split [::http::data $page] \n]
		set numLines [llength $lines]

		for {set i 0} {$i < $numLines} {incr i 1} {
			set line [lindex $lines $i]
				#if redirect necessary, find first link and redirect
                                #putserv "NOTICE $nick : $line"
				if {[string match "*title search*" $line]} {
					set redirect 1
		                        #putserv "NOTICE $nick : redirect 1"
						for {} {$i < $numLines} {incr i 1} {
							set line [lindex $lines $i]
								if {[string match -nocase "*1.&#160;*" $line]} {
									regexp href=\"\[^\"\]*\" $line title
										set title [string range $title 6 [expr [string length $title] - 2]] 
										append newurl $imdburl $title
	
										# get the page redirected to
										set page [::http::config -useragent $b_agent]
										set page [::http::geturl ${newurl}]
										set lines [split [::http::data $page] \n]
								}
						}
					set i $numLines
				}
		}

	# if no redirect happened, then get first page on match

	if {$redirect == 0} {
		upvar 0 $page oldpage
			regexp Location\ \[^\ \]*\ Connection $oldpage(meta) location
		        #putserv "NOTICE $nick : $oldpage(meta)"                        
			set newurl [string range $location 9 [expr [string length $location] - 12]]
			set page [::http::config -useragent $b_agent]
			set page [::http::geturl ${newurl}]
			set lines [split [::http::data $page] \n]
	}

	# for bogus searches
	if {[string length $newurl] == 0} {
		putserv "NOTICE $nick :No no no! I can't find that!"
			return
	}

	set numLines [llength $lines]

	# scan for wanted data from the page
		for {set i 0} {$i < $numLines} {incr i 1} {
			set line [lindex $lines $i]
				if {[string compare -length 7 $line "<title>"] == 0} {
					# the movie title, year, url
					set title [string range $line 7 [expr [string length $line] - 9]]
						set title [string map {&#223; ß &#228; ä &#246; ö &#252; ü &#196; Ä &#214; Ö &#220; Ü &#232; è  &#233; é &#234; ê &#225; á &#224; à } $title]
						putserv "$toput :$title \( $newurl \)"
				} elseif {($o_tagline == 1) && ([regexp \[.\]*Tagline:\[.\]* $line] > 0)} {
					# the tagline
					regsub -all \<\[^\>\]*\> $line "" tagline
						regsub -all \\\(\[^\\\)\]*\\\) $tagline "" tagline 
						regsub -all \[\ \t\]+ $tagline " " tagline 
						regsub -all \&nbsp\; $tagline " " tagline
						set tagline [string trim $tagline " "]
						set tagline [string map {&#223; ß &#228; ä &#246; ö &#252; ü &#196; Ä &#214; Ö &#220; Ü &#232; è  &#233; é &#234; ê &#225; á &#224; à } $tagline]
						putserv "$toput :$tagline"
				} elseif {($o_outline == 1) && ([regexp \[.\]*Outline:\[.\]* $line] > 0)} {
					# the outline
					regsub -all \<\[^\>\]*\> $line "" outline
						regsub -all \\\(\[^\\\)\]*\\\) $outline "" outline 
						regsub -all \[\ \t\]+ $outline " " outline 
						regsub -all \&nbsp\; $outline " " outline
						set outline [string trim $outline " "]
						set outline [string map {&#223; ß &#228; ä &#246; ö &#252; ü &#196; Ä &#214; Ö &#220; Ü &#232; è  &#233; é &#234; ê &#225; á &#224; à } $outline]
						putserv "NOTICE $nick :$outline"
				} elseif {($o_genre == 1) && ([regexp \[.\]*Genres\[.\]* $line] > 0)} {
					# the genre
					regsub -all \<\[^\>\]*\> $line "" genre
						regsub -all \\\(\[^\\\)\]*\\\) $genre "" genre
						regsub -all \[\ \t\]+ $genre " " genre
						set genre [string trim $genre " "]
						set genre "Genre: $genre"
						putserv "$toput :$genre"
				} elseif {($o_rating == 1) && ([regexp \[.\]*User\ Rating\[.\]* $line] > 0)} { 
					# the user rating 
					set j [expr $i + 3] 
					set line2 [lindex $lines $j] 
					set j [expr $i + 4] 
					set line3 [lindex $lines $j] 
					regsub -all \<\[^\>\]*\> $line3 "" rating 
						regsub -all \&nbsp\; $rating " " rating 
						regsub -all \[\ \t\]+ $rating " " rating 
						set rating [string trim $rating " "] 
						set goldstars [regexp -all goldstar $line2] 
						set greystars [expr 10 - $goldstars] 
					
						# generating the rating bar 
						set marker "*" 
						set rating_bar "11\[7" 
						for {set i2 0} {$i2 < $goldstars} {incr i2 1} { 
							set rating_bar "$rating_bar$marker" 
						} 
					set marker "-" 
						set rating_bar "$rating_bar14" 
						for {set i3 0} {$i3 < $greystars} {incr i3 1} { 
							set rating_bar "$rating_bar$marker" 
						} 
					set rating_bar "$rating_bar11\]" 
						putserv "$toput :$rating $rating_bar"
				} elseif {($o_cast == 1) && ([regexp \[.\]*\\\.\\\.\\\.\\\.\[.\]* $line] > 0)} {

					if {[regexp Name $line] > 0} {
						regsub -all \<\[^\>\]*\> $line "" cast
						set cast [string map {&#223; ß &#228; ä &#246; ö &#252; ü &#196; Ä &#214; Ö &#220; Ü &#232; è  &#233; é &#234; ê &#225; á &#224; à } $cast]
		                                set checkargs [string trim $args " \n"]						
							putserv "NOTICE $nick :$cast"
					}
				}
		}

}

proc imdb_msghandler { nick uhost hand args } {
	global DEBUG imdbVERSION imdburl imdbsearchurl b_agent
	global show_rating show_genre show_tagline show_outline show_cast

          # set to defaults
		set o_rating $show_rating 
		set o_genre $show_genre 
		set o_tagline $show_tagline
		set o_outline $show_outline 
		set o_cast $show_cast

		set checkargs [string trim $args " \n"]

		# if no arguments passed, show help
		if {[string compare $checkargs "{}"] == 0} {
			putserv "PRIVMSG $nick :IMDb info script v$imdbVERSION - 7General Help"
			putserv "PRIVMSG $nick :14<===========================================>"
			putserv "PRIVMSG $nick :7!imdb \[options\] <imdb title>"
			putserv "PRIVMSG $nick :7options: -r     ratings" 
			putserv "PRIVMSG $nick :7         -g     genre" 
			putserv "PRIVMSG $nick :7         -t     tagline" 
			putserv "PRIVMSG $nick :7         -o     plot outline" 
			putserv "PRIVMSG $nick :7         -c     cast" 
			putserv "PRIVMSG $nick :7Example: !imdb -o -c Beautiful Mind" 
			return	
		} 

	# Look for command line options and enable each, as desired
	set fargs ""
		set imdbtitle ""
		foreach piece [split $args " "] {
			set piece	[string trim $piece "{}"]
				if {[string compare $piece "-r"] == 0 } {
					set o_rating 1
				} elseif {[string compare $piece "-g"] == 0 } {
					set o_genre 1
				} elseif {[string compare $piece "-t"] == 0 } {
					set o_tagline 1
				} elseif {[string compare $piece "-o"] == 0 } {
					set o_outline 1
				} elseif {[string compare $piece "-c"] == 0 } {
					set o_cast 1
				} else {
					set fargs "$fargs $piece"
				}
		}
        #set fargs [string trimleft $args]
	if {$DEBUG == 1} {
		putserv "PRIVMSG $nick :I am doing a search for \"$fargs\" on imdb.com"
	}

	set query $fargs

		# do initial search
		set searchString [ ::http::formatQuery $query ] 
                set searchString [string trimleft $searchString "+"]		
                if {$DEBUG == 1} {
		 putserv "PRIVMSG $nick :searchString: \"$searchString\""		
		}
                set page [::http::config -useragent $b_agent]
                set page [::http::geturl ${imdbsearchurl}title=${searchString}&sort=smart&tv=off]

		set redirect 0
		set newurl ""

		set lines [split [::http::data $page] \n]
		set numLines [llength $lines]

		for {set i 0} {$i < $numLines} {incr i 1} {
			set line [lindex $lines $i]
				#if redirect necessary, find first link and redirect
                                #putserv "PRIVMSG $nick : $line"
				if {[string compare $line "<TITLE>IMDb title search</TITLE>"] == 0} {
					set redirect 1
		                        #putserv "PRIVMSG $nick : redirect 1"
						for {} {$i < $numLines} {incr i 1} {
							set line [lindex $lines $i]
								if {[string compare -length 8 $line "<OL><LI>"] == 0} {
									regexp HREF=\"\[^\"\]*\" $line title
										set title [string range $title 6 [expr [string length $title] - 2]] 
										append newurl $imdburl $title
	
										# get the page redirected to
										set page [::http::config -useragent $b_agent]
										set page [::http::geturl ${newurl}]
										set lines [split [::http::data $page] \n]
								}
						}
					set i $numLines
				}
		}

	# if no redirect happened, then get first page on match

	if {$redirect == 0} {
		upvar 0 $page oldpage
			regexp Location\ \[^\ \]*\ Connection $oldpage(meta) location
		        #putserv "PRIVMSG $nick : $oldpage(meta)"                        
			set newurl [string range $location 9 [expr [string length $location] - 12]]
			set page [::http::config -useragent $b_agent]
			set page [::http::geturl ${newurl}]
			set lines [split [::http::data $page] \n]
	}

	# for bogus searches
	if {[string length $newurl] == 0} {
		putserv "PRIVMSG $nick :No no no! I can't find that!"
			return
	}

	set numLines [llength $lines]

	# scan for wanted data from the page
		for {set i 0} {$i < $numLines} {incr i 1} {
			set line [lindex $lines $i]
				if {[string compare -length 7 $line "<title>"] == 0} {
					# the movie title, year, url
					set title [string range $line 7 [expr [string length $line] - 9]]
						set title [string map {&#223; ß &#228; ä &#246; ö &#252; ü &#196; Ä &#214; Ö &#220; Ü &#232; è  &#233; é &#234; ê &#225; á &#224; à } $title]
						putserv "PRIVMSG $nick :$title \( $newurl \)"
				} elseif {($o_tagline == 1) && ([regexp \[.\]*Tagline:\[.\]* $line] > 0)} {
					# the tagline
					regsub -all \<\[^\>\]*\> $line "" tagline
						regsub -all \\\(\[^\\\)\]*\\\) $tagline "" tagline 
						regsub -all \[\ \t\]+ $tagline " " tagline 
						regsub -all \&nbsp\; $tagline " " tagline
						set tagline [string trim $tagline " "]
						set tagline [string map {&#223; ß &#228; ä &#246; ö &#252; ü &#196; Ä &#214; Ö &#220; Ü &#232; è  &#233; é &#234; ê &#225; á &#224; à } $tagline]
						putserv "PRIVMSG $nick :$tagline"
				} elseif {($o_outline == 1) && ([regexp \[.\]*Outline:\[.\]* $line] > 0)} {
				# the outline
					regsub -all \<\[^\>\]*\> $line "" outline
						regsub -all \\\(\[^\\\)\]*\\\) $outline "" outline 
						regsub -all \[\ \t\]+ $outline " " outline 
						regsub -all \&nbsp\; $outline " " outline
						set outline [string trim $outline " "]
						set outline [string map {&#223; ß &#228; ä &#246; ö &#252; ü &#196; Ä &#214; Ö &#220; Ü &#232; è  &#233; é &#234; ê &#225; á &#224; à } $outline]
						putserv "PRIVMSG $nick :$outline"
				} elseif {($o_genre == 1) && ([regexp \[.\]*Genres\[.\]* $line] > 0)} {
					# the genre
					regsub -all \<\[^\>\]*\> $line "" genre
						regsub -all \\\(\[^\\\)\]*\\\) $genre "" genre
						regsub -all \[\ \t\]+ $genre " " genre
						set genre [string trim $genre " "]
						set genre "Genre: $genre"
						putserv "PRIVMSG $nick :$genre"
				} elseif {($o_rating == 1) && ([regexp \[.\]*User\ Rating\[.\]* $line] > 0)} { 
					# the user rating 
					set j [expr $i + 3] 
					set line2 [lindex $lines $j] 
					set j [expr $i + 4] 
					set line3 [lindex $lines $j] 
					regsub -all \<\[^\>\]*\> $line3 "" rating 
						regsub -all \&nbsp\; $rating " " rating 
						regsub -all \[\ \t\]+ $rating " " rating 
						set rating [string trim $rating " "] 
						set goldstars [regexp -all goldstar $line2] 
						set greystars [expr 10 - $goldstars] 
					
						# generating the rating bar 
						set marker "*" 
						set rating_bar "11\[7" 
						for {set i2 0} {$i2 < $goldstars} {incr i2 1} { 
							set rating_bar "$rating_bar$marker" 
						} 
					set marker "-" 
						set rating_bar "$rating_bar14" 
						for {set i3 0} {$i3 < $greystars} {incr i3 1} { 
							set rating_bar "$rating_bar$marker" 
						} 
					set rating_bar "$rating_bar11\]" 
						putserv "PRIVMSG $nick :$rating $rating_bar"
				} elseif {($o_cast == 1) && ([regexp \[.\]*\\\.\\\.\\\.\\\.\[.\]* $line] > 0)} {

					if {[regexp Name $line] > 0} {
						regsub -all \<\[^\>\]*\> $line "" cast
						set cast [string map {&#223; ß &#228; ä &#246; ö &#252; ü &#196; Ä &#214; Ö &#220; Ü &#232; è  &#233; é &#234; ê &#225; á &#224; à } $cast]
		                                set checkargs [string trim $args " \n"]						
							putserv "PRIVMSG $nick :$cast"
					}
				}
		}

}

putlog " -=\[ chilla's IMDB info version $imdbVERSION loaded \]=- lastupdate 10-01-04 "
