
;==================
; Pebble Lake East
;==================

; + look / look lake
lake_east_look_at_lake_message_man_gone:
.byte "Why it's half a lake.",0

; + look (when the old man is fishing)
lake_east_look_at_lake_message:
.byte "Why it's half a lake.With a",13	; [SIC] on the space after lake
.byte "fisherman in it. And he's",13
.byte "fishing!",0

; + look dude/man/guy/peasant/old guy/old man (while he is fishing)
lake_east_look_at_man_message:
.byte "An older peasant sits",13
.byte "silently in a boat with his",13
.byte "line in the water.",0

; + look sand
lake_east_look_at_sand_message:
.byte "One million three hundred",13
.byte "thousand seventy-four",13
.byte "hundred and sixty two...",13
.byte "One million three hundred",13
.byte "thousand seventy-four",13
.byte "hundred and sixty three...",0
lake_east_look_at_sand_message2:
.byte " Drat! You lost count again.",0

; + look boat/dinghy (while he is fishing)
lake_east_look_at_boat_message:
.byte 34,"Keep your eyes off my",13
.byte "dinghy!",34,0

; + look boat/dinghy (after he is gone)
lake_east_look_at_boat_gone_message:
.byte "It was loaned out to the",13
.byte "Fishing Challenge",13
.byte "videogame.",0

; + talk man (before throwing chicken feed in lake)
lake_east_talk_man_message:
.byte "You holler at the old man",13
.byte "about Trogdor, but he just",13
.byte "grumbles about the fish not",13
.byte "biting. ",34,"Must be using the",13
.byte "wrong bait...",34," he says,",13
.byte "suggestively.",0

; + talk man (after throwing chicken feed in lake) WIKI IS WRONG
lake_east_talk_man_after_message:
.byte "He DEFINITELY can't hear",13	; [sic] actual game has 'here' here
.byte "you from here. He's in the",13
.byte "INN.",0

; + throw feed (at south side)
lake_east_throw_feed_too_south_message:
.byte "Maybe try again from the",13
.byte "center of the lake. Looks",13
.byte "deeper there.",0

; +2 POINTS
; + throw chicken feed
lake_east_throw_feed_message:
.byte "You toss the feed into the",13
.byte "lake. You shed a tear for",13
.byte "each one. ",34,"Goodbye, Monty",34,13
.byte "you sniff. ",34,"Bye Delga,",13
.byte "Rasputin. Farewell,",13
.byte "Combledon!",34," and so forth.",0

; throw two handfulls, fish animation
lake_east_throw_feed2_message:
.byte "Woah! That crotchety old",13
.byte "man just caught a pantload",13
.byte "of fish! ",34,"Now I can get",13
.byte "back to running the inn,",34,13
.byte "he says and rows to shore",13
.byte "and hauls his boat out and",13
.byte "cleans, guts, and filets",13
.byte "all the fish and a buncha",13
.byte "other stuff we didn't",13
.byte "animate.",0

; + throw feed (before getting the feed)
lake_east_throw_feed_none_message:
.byte "You have nothing with which",13
.byte "to do that ... with.",0

; + throw feed (after throwing the feed)  (The repetition is probably just a goof.) 
lake_east_throw_feed_already_message:
.byte "You already fed the fish.",13
.byte "Let's get moving here,",13
.byte "people!You already fed the",13
.byte "fish. Let's get moving,",13
.byte "here, people!",0

; + throw (anything but the feed while he is fishing)
lake_east_throw_default_message:
.byte 34,"That isn't gonna work for",13
.byte "bait!",34," the old man screams,",13
.byte "at a needlessly harsh",13
.byte "volume.",0

; + throw (anything when fisherman gone)
lake_east_throw_default_gone_message:
.byte "You already fed the fish.",13
.byte "Let's get moving, here,",13
.byte "people!",0

