peasant3_dialog_start:

;=============
; Jhonka cave
;=============

; + (walk in haystack)
jhonka_in_hay_message:
.byte "Hey, nice disguise! The",13
.byte "Jhonka doesn't seem to",13
.byte "notice you.",0


; kerrek alive

; + look (kerrek alive)
jhonka_look_at_message:
.byte "There's a little cave with",13
.byte "a little door with a little",13
.byte "note on it.",0

; + look door (kerrek alive)		; not in WIKI
jhonka_look_at_door_message:
.byte "There's a little note on it.",0

; + look cave
jhonka_look_at_cave_message:
.byte "Just a little cave. Calm",13
.byte "down.",0

; + look fence
jhonka_look_at_fence_message:
.byte "A standard peasant fence.",13
.byte "Trogdor makes milk's meat",13
.byte "outta these things.",0

; + look/read note (before killing Kerrek) [ will walk to it if far away]
jhonka_read_note_message:
.byte "It says ",34,"scared of kerrek.",13
.byte "go way. -j",34,0

; + open door [ will walk you there] {before jhonka out, if jhonka out nothing)
jhonka_open_door_message:
.byte "It's locked. With one o'",13
.byte "them SCHLAGE deadbolts,",13
.byte "too. Those things are hard",13
.byte "core.",0


; + knock (while he's inside) [ will walk over]
jhonka_knock_message1:
.byte "A gravelly voice inside",13
.byte "yells,  'JUST US CHICKENS'",0

jhonka_knock_message2:
.byte "A gravelly voice inside",13
.byte "yells, 'NO FOR RENT'",0

jhonka_knock_message3:
.byte "A gravelly voice inside",13
.byte "yells, 'I GIVE LAST YEAR!'",0

jhonka_knock_message4:
.byte "A gravelly voice inside",13
.byte "yells, 'GAVE AT OFFICE'",0

jhonka_knock_message5:
.byte "A gravelly voice inside",13
.byte "yells, 'GO WAY!'",0

; + get note (kerrek alive)
jhonka_get_note_message:
.byte "It's been magically sealed",13
.byte "to the door with a",13
.byte "wondrously whimsical spell.",0

; + climb/jump fence
jhonka_climb_fence_message:
.byte "No, you have business to",13
.byte "attend to here in",13
.byte "Peasantry.",0


;================================
; kerrek dead


; + look (kerrek dead, before riches)
jhonka_look_at_with_riches_message:
.byte "There's a disgusting",13
.byte "little Jhonka hopping",13
.byte "around outside a little",13
.byte "cave.A fat pile of riches",13
.byte "lies next to him.",0

; + look (after kerrek dead, after take riches)
jhonka_look_at_no_riches_message:
.byte "There's a disgusting",13
.byte "little Jhonka hopping",13
.byte "around outside a small",13	; WIKI wrong
.byte "cave.",0


; + look club/turkey leg (when he's outside)
jhonka_look_at_club_message:
.byte "Turkey leg or no, it looks",13
.byte "like the Jhonka's been",13
.byte "gnawing on it.",0

; + look cave
; same as alive

; + look door (after kerrek)		; not in WIKI
jhonka_look_at_door_out_message:
.byte "Just a door, nothing more.",0

; + look riches (if riches are there)
jhonka_look_at_riches_message:
.byte "That's one fat pile of",13
.byte "riches alright.",0

; + look fence
; same as alive

; + look jhonka (when he's outside)
jhonka_look_at_jhonka_out_message:
.byte "The Jhonka is gray and",13
.byte "grody. He's got a cromagnon",13
.byte "forehead and jaw with a",13
.byte "pair of wicked incisors. He",13
.byte "sports an old loin-cheese",13
.byte "cloth and carries either",13
.byte "a big club or one of those",13
.byte "roasted turkey legs you got",13
.byte "at the Ren Fest.",0


; + get club / leg  (when he's out)
jhonka_get_club_message:
.byte "Now there's a surefire way",13
.byte "to get yourself killed.",0

; + get riches (before jumping in hay, also even after taking them)
jhonka_get_riches_no_hay_message:
.byte "The Jhonka will see you!",13
.byte "And rip out your jugular",13
.byte "with his teeth or something",13
.byte "equally horrible.",0

; + steal/get riches (in hay)
jhonka_steal_riches_message:
.byte "Oh OH! A stiff breeze blew",13
.byte "all the hay and,",13
.byte "surprisingly, the mud off",13
.byte "of you! ",34,"You take my",13
.byte "riches?!",34," growls the",13
.byte "Jhonka.",0


; + 7 POINTS
; + no
jhonka_no_message:
.byte 34,"Okay. Lemme know if you",13
.byte "see riches anywhere,",34," he",13
.byte "grunts and goes back to his",13
.byte "hopping. You smooth",13
.byte "talker, you.",0

; + yes (to the Jhonka when he asks you about his riches)
jhonka_yes_message:
.byte 34,"I KILL YOU!!",34," screams the",13
.byte "Jhonka.",0

; {The Jhonka clubs you to death}  (Warning: Obviously, you will die.) 
jhonka_yes_message2:
.byte "Club or turkey leg, the",13
.byte "Jhonka sure just beat you",13
.byte "senseless with whatever he",13
.byte "was holding. You dead.",13
.byte "Thanks for playing!",0

; + Type any command other than "yes" or "no" 
; after the Jhonka asks if you stole the riches
; you can't walk while waiting here
jhonka_answer_him_message:
.byte "Just answer him, yes or no,",13
.byte "you fool!",0


; + ask about fire
jhonka_ask_about_fire_message:
.byte 34,"Burninator make fire!",13
.byte "Barbecue all peasants!",34,0

; + ask about Jhonka
jhonka_ask_about_jhonka_message:
.byte 34,"The Kerrek is dead!",34," he",13
.byte "cries and hops around some",13
.byte "more. You wonder how",13
.byte "someone this primitive",13
.byte "could have made that much",13
.byte "dough.",0

; + ask about naked ned (or) robe
jhonka_ask_about_ned_message:
.byte 34,"Filthy naked peasant!",13
.byte "Stay away from my",13
.byte "cave-hole!",34," Who's he",13
.byte "calling naked? HE'S the one",13
.byte "wearing the string bikini.",0

; + ask about smell
jhonka_ask_about_smell_message:
.byte 34,"Kerrek smell! Now Kerrek",13
.byte "dead!",34," screeches the",13
.byte "Jhonka. So you can infer",13
.byte "from this that all smells",13
.byte "are dead? You always sucked",13
.byte "at the analytical",13
.byte "questions.",0

; + ask about trogdor
jhonka_ask_about_trogdor_message:
.byte 34,"All hail Burninator!",13
.byte "Trogdor Number One! Beat",13
.byte "Peasant Tech!",34," says the",13
.byte "grimy Jhonka.",0

; + ask about (unknown)
jhonka_ask_about_unknown_message:
.byte 34,"Jhonka don't know nothing",13
.byte "bout that!",34,0

; + kill jhonka (outside)
jhonka_kill_message:
.byte "No way! Jhonka's are born",13	; [sic]
.byte "scrappers. He may be",13
.byte "little, but he'll crawl ya.",0

; + give / give {anything}
jhonka_give_message:
.byte 34,"Don't need nothing from no",13
.byte "filthy peasantses!!",34,0

; + talk jhonka (while inside the hay)
jhonka_talk_in_hay_message:
.byte "Not now! You'll blow your",13
.byte "cover!",0

; + talk
; + talk jhonka (jhonka there, not in hay)
; same as ask about jhonka
;.byte 34,"The Kerrek is dead!",34," he",13
;.byte "cries and hops around some",13
;.byte "more. You wonder how",13
;.byte "someone this primitive",13
;.byte "could have made that much",13
;.byte "dough.",0

; + climb/jump fence
; same as alive


;=========================
; Your Burninated Cottage
;=========================

; + look [WIKI IS WRONG]
cottage_look_at_message:
.byte "The remains of your",13
.byte "thatched-roof cottage lie",13
.byte "burninated before you. You",13
.byte "swear revenge against",13
.byte "Trogdor.",0

; + look cottage
cottage_look_at_cottage_message:
.byte "All your baubles and",13
.byte "trinkets, your flasks and",13
.byte "scrolls, your goblets and",13
.byte "staffs! BURNINATED!!",0

; (And then, if you haven't taken the map yet:)
cottage_look_at_cottage_message_map:
.byte "Looks like there's a piece",13
.byte "of unburninated paper on",13
.byte "the ground.",0
 
; + look ground
; + look paper
cottage_look_at_map_message:
.byte "Hey, it's your old",13
.byte "fireproof map to Peasantry.",0
 
; + get/take/steal map/paper
cottage_get_map_message:
.byte "You tuck it nice-like into",13
.byte "your short, short pants.",13
.byte "Type MAP at nearly any time",13
.byte "to check the map.",0

; + get map (if you already have it)
cottage_get_map_already_message:
.byte "Yeah but like you already",13
.byte "map the took, guy!",0

;==================
; Pebble Lake West
;==================

; + look
lake_west_look_at_message:
.byte "There's definitely half a",13
.byte "lake here with a sandy",13
.byte "shore.",0

; + look lake/water
lake_west_look_at_lake_message:
.byte "It extends onto the next",13
.byte "screen and has a sandy",13
.byte "shore.",0

; + look sand NOT IN WIKI
lake_west_look_at_sand_message:
.byte "There's a bunch of fairly",13
.byte "substantial pebbles in the",13
.byte "sand.",0

; + look sand (after pebbles)
lake_west_look_at_sand_after_message:
.byte "Remember those pebbles on",13
.byte "the beach? Man, those were",13
.byte "good times.",0

; + look bush
lake_west_look_at_bush_message:
.byte "Don't worry about that",13
.byte "bush. Yeah, there's red",13
.byte "berries on it but never you",13
.byte "mind.",0

; + look berries
lake_west_look_at_berries_message:
.byte "Shut up.",0

; + get berries
lake_west_get_berries_message:
.byte "NO MAN! JEEZ!",0

; + get stones	; +1 POINT
; + get pebbles
lake_west_get_pebbles_message:
.byte "You grab up a handful of",13
.byte "fairly substantial",13
.byte "pebbles. You make sure to",13
.byte "get an even mix of",13
.byte "sedentary, igneous, and,",13
.byte "um, sureptitious rocks.",0

; + swim {none}/lake/water
lake_west_swim_message:
.byte "Not in this game, Swimmer",13
.byte "Dan! In this game, you",13
.byte "drown.",0

; + skip stones/pebbles
lake_west_skip_stones_message:
.byte "You've always been",13
.byte "terrible at skipping",13
.byte "stones. And you're even",13
.byte "worse at just plain",13
.byte "throwing rocks in lakes.",13
.byte "You decide to save yourself",13
.byte "the embarrassment.",0

; + get pebbles/rocks (from too far)
lake_west_pebbles_too_far_message:
.byte "You do your best Mr.",13
.byte "Fantastic impression,",13
.byte "but you can't reach from",13
.byte "here.",0

; +5 POINTS
; + throw baby
lake_west_throw_baby_message:
.byte "Something tells you this is",13
.byte "a good idea and you lob the",13
.byte "little one into the lake.",0

lake_west_throw_baby_message2:
.byte "You won't be arrested after",13
.byte "all! The little guy has",13
.byte "resurfaced safely,",13
.byte "carrying an old bottle of",13
.byte "soda. You take the soda and",13
.byte "stow your swaddling buddy",13
.byte "for takeoff.",0

; + throw baby (before getting the baby)
lake_west_throw_baby_no_baby_message:
.byte "I think you misread the",13
.byte "walkthrough on GameFAQs.",13
.byte "You gotta get the baby",13
.byte "first.",0

; + throw baby (after getting the soda)
lake_west_throw_baby_already_message:
.byte "Baby Dashing is a little",13
.byte "waterlogged from the last",13
.byte "toss, and you read his soft",13
.byte "gurgling to mean that",13
.byte "there's no more soda left.",0

; + throw feed (at south side)
; + throw baby (not in right spot)
; same as lake_east_throw_feed_too_south_message:


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


;===================
; Outside Giant Inn
;===================

; + (exiting inn with pot on head)
outside_inn_pot_message:
.byte "Phew! You discard the big",13
.byte "black pot and wipe the",13
.byte "horse grease from your",13
.byte "eyes. The hood of your robe",13
.byte "is still covered in highly",13
.byte "flammable horse grease,",13
.byte "though.",0


; + look
outside_inn_look_message:
.byte "There's a giant Inn here.",13
.byte "It takes up, like, the",13
.byte "entire screen.",0

; + look door
outside_inn_door_look_note_message:
.byte "Just a door. A door with a",13
.byte "note on it.",0

; + look door (after fish fed)
outside_inn_door_look_message:
.byte "Just a door.",0

; + look inn
outside_inn_inn_look_message:
.byte "Looks okay from out here.",13
.byte "But do they have a free",13
.byte "breakfast buffet?",0

; + look sign
outside_inn_sign_look_message:
.byte "If you can't read that",13
.byte "sign, you need to quit",13
.byte "playing this game.",0
 
; + look window
outside_inn_window_look_message:
.byte "Check it out! There's an",13
.byte "INN in there.",0

; + look note
; + read note (before feed in lake)
outside_inn_note_look_message:
.byte "It says, ",34,"Gone Fishin",34," just",13
.byte "like that grog coozie your",13
.byte "cousin got you.",0

; + get/look/read note (after feed in lake)
outside_inn_note_look_gone_message:
.byte "The note is gone.",0

; + open
; + open door (after old man)
outside_inn_door_open_message:
.byte "You open the door and step",13
.byte "inside the inn.",0

; + open {none}/door (before old man)
outside_inn_door_open_locked_message:
.byte "It's locked fast!",0

; + knock {none}/door (closed)
outside_inn_door_knock_locked_message:
.byte "No answer.",0

; + knock (open)
outside_inn_door_knock_message:
.byte "Just open it, man!",0

; + get note
outside_inn_note_get_message:
.byte "What is it with you and",13
.byte "notes?! No!! ",0

; +3 POINTS: leave inn with pot on head

peasant3_dialog_end:

.assert (>peasant3_dialog_end - >peasant3_dialog_start) < $1E , error, "peasant3 dialog too big"
