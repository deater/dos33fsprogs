;=============
; Jhonka cave
;=============

; + Type any command other than "yes" or "no" after the Jhonka asks if you stole the riches
.byte "Just answer him, yes or no, you fool!",0

; + look
.byte "There's a little cave with",13
.byte "a little door with a little",13
.byte "note on it.",0

; + look (kerrek dead, before riches)
.byte "There's a disgusting little Jhonka hopping around outside a little cave.A fat pile of riches lies next to him.",0

; + look (after kerrek dead, after take riches)
.byte "There's a disgusting little Jhonka hopping around outside a little cave.",0

; + look club/turkey leg (when he's outside)
.byte "Turkey leg or no, it looks like the Jhonka's been gnawing on it.",0

; + look cave
.byte "Just a little cave. Calm",13
.byte "down.",0

; + look fence (need to be standing near it?)
.byte "A standard peasant fence.",13
.byte "Trogdor makes milk's meat",13
.byte "outta these things.",0

; + look jhonka (when he's outside)
.byte "The Jhonka is gray and grody. He's got a cromagnon forehead and jaw with a pair of wicked incisors. He sports an old loin-cheese cloth and carries either a big club or one of those roasted turkey legs you got at the Ren Fest.",0

; + read note (before killing Kerrek) [ will walk to it if far away]
.byte "It says ",34,"scared of kerrek.",13
.byte "go way. -j",34,0

; + (walk in haystack)
.byte "Hey, nice disguise! The Jhonka doesn't seem to notice you.",0

; + steal riches
.byte "Oh OH! A stiff breeze blew all the hay and, surprisingly, the mud off of you! ",34,"You take my riches?!",34," growls the Jhonka.",0

; + 7 POINTS
; + no
.byte 34,"Okay. Lemme know if you see riches anywhere,",34," he grunts and goes back to his hopping. You smooth talker, you.",0

; + ask about fire
.byte "Burninator make fire! Barbecue all peasants!",0

; + ask about Jhonka
.byte 34,"The Kerrek is dead!",34," he cries and hops around some more. You wonder how someone this primitive could have made that much dough.",0

; + ask about naked ned (or) robe
.byte 34,"Filthy naked peasant! Stay away from my cave-hole!",34," Who's he calling naked? HE'S the one wearing the string bikini.",0

; + ask about smell
.byte 34,"Kerrek smell! Now Kerrek dead!",34," screeches the Jhonka. So you can infer from this that all smells are dead? You always sucked at the analytical questions.",0

; + ask about trogdor
.byte 34,"All hail Burninator! Trogdor Number One! Beat Peasant Tech!",34," says the grimy Jhonka.",0

; + ask about (unknown)
.byte "Jhonka don't know nothing bout that!",0

; + yes (to the Jhonka when he asks you about his riches)
.byte "'I KILL YOU!!' screams the Jhonka.",0
; {The Jhonka clubs you to death}  (Warning: Obviously, you will die.) 
.byte "Club or turkey leg, the jhonka sure just beat you senseless with whatever he was holding. You dead. Thanks for playing!",0

; + open door [ will walk you there]
.byte "It's locked. With one o'",13
.byte "them SCHLAGE deadbolts,",13
.byte "too. Those things are hard",13
.byte "core.",0

; + knock (while he's inside) [ will walk over]
.byte "A gravelly voice inside",13

.byte "yells, 'JUST US CHICKENS'",0
; or
.byte "yells, 'NO FOR RENT'",0
; or 
.byte "yells, 'I GIVE LAST YEAR!'",0
; or 
.byte "yells, 'GAVE AT OFFICE'",0
; or: 
.byte "yells, 'GO WAY!'",0

; + kill jhonka (outside)
.byte "No way! Jhonka's are born scrappers. He may be little, but he'll crawl ya.",0

; + get club (when he's out)
.byte "Now there's a surefire way to get yourself killed.",0

; + get note
.byte "It's been magically sealed",13
.byte "to the door with a",13
.byte " wondrously whimsical spell.",0

; + give riches (before jumping in hay)
.byte "The Jhonka will see you! And rip out your jugular with his teeth or something equally horrible.",0

; + talk jhonka (while inside the hay)
.byte "Not now! You'll blow your cover!",0

;=========================
; Your Burninated Cottage
;=========================

; + look [WIKI IS WRONG]
.byte "The remains of your",13
.byte "thatched-roof cottage lie",13
.byte "burninated before you. You",13
.byte "swear revenge against",13
.byte "Trogdor.",0

; + look cottage
.byte "All your baubles and",13
.byte "trinkets, your flasks and",13
.byte "scrolls, your goblets and",13
.byte "staffs! BURNINATED!!",0
; (And then, if you haven't taken the map yet:)
.byte "Looks like there's a piece",13
.byte "of unburninated paper on",13
.byte "the ground.",0
 
; + look ground
; + look paper
.byte "Hey, it's your old",13
.byte "fireproof map to Peasantry.",0
 
; + get map
.byte "You tuck it nice-like into",13
.byte "your short, short pants.",13
.byte "Type MAP at nearly any time",13
.byte "to check the map.",0

; + get map (if you already have it)
.byte "Yeah but like you already",13
.byte "map the took, guy!",0

;==================
; Pebble Lake West
;==================

; + look
.byte "There's definitely half a",13
.byte "lake here with a sandy",13
.byte "shore.",0

; + look lake/water
.byte "It extends onto the next",13
.byte "screen and has a sandy",13
.byte "shore.",0

; + look sand NOT IN WIKI
.byte "There's a bunch of fairly",13
.byte "substantial pebbles in the",13
.byte "sand.",0

; + look sand (after pebbles)
.byte "Remember those pebbles on the beach? Man, those were good times.",0

; + look bush
.byte "Don't worry about that",13
.byte "bush. Yeah, there's red",13
.byte "berries on it but never you",13
.byte "mind.",0

; + look berries
.byte "Shut up.",0

; + get berries
.byte "NO MAN! JEEZ!",0

; + get stones	; +1 POINT
; + get pebbles
.byte "You grab up a handful of",13
.byte "fairly substantial",13
.byte "pebbles. You make sure to",13
.byte "get an even mix of",13
.byte "sedentary, igneous, and,",13
.byte "um, sureptitious rocks.",0

; + swim
.byte "Not in this game, Swimmer",13
.byte "Dan! In this game, you",13
.byte "drown.",0

; + skip stones
.byte "You've always been",13
.byte "terrible at skipping",13
.byte "stones. And you're even",13
.byte "worse at just plain",13
.byte "throwing rocks in lakes.",13
.byte "You decide to save yourself",13
.byte "the embarrassment.",0

; + get pebbles/rocks (from too far)
.byte "You do your best Mr. Fantastic impression, but you can't reach from here.",0

; +5 POINTS
; + throw baby
.byte "Something tells you this is a good idea and you lob the little one into the lake.",0
.byte "You won't be arrested after all! The little guy has resurfaced safely, carrying an old bottle of soda. You take the soda and stow your swaddling buddy for takeoff.",0

; + throw baby (before getting the baby)
.byte "I think you misread the",13
.byte "walkthrough on GameFAQs.",13
.byte "You gotta get the baby",13
.byte "first.",0

; + throw baby (after getting the soda)
.byte "Baby Dashing is a little waterlogged from the toss, and you read his soft gurgling to mean that there's no more soda left.",0

; + throw baby/feed (at south side)
.byte "Maybe try again from the center of the lake. Looks deeper there.",0


;==================
; Pebble Lake East
;==================

; + look / look lake
.byte "Why it's half a lake.",0

; + look (when the old man is fishing)
.byte "Why it's half a lake.With a",13	; [SIC] on the space after lake
.byte "fisherman in it. And he's",13
.byte "fishing!",0

; + look man/guy/peasant/old guy/old man (while he is fishing)
.byte "An older peasant sits",13
.byte "silently in a boat with his",13
.byte "line in the water.",0

; + look sand
.byte "One million three hundred",13
.byte "thousand seventy-four",13
.byte "hundred and sixty two...",13
.byte "One million three hundred",13
.byte "thousand seventy-four",13
.byte "hundred and sixty three...",0
.byte " Drat! You lost count again.",0

; + look boat/dinghy (while he is fishing)
.byte 34,"Keep your eyes off my",13
.byte "dinghy!",34,0

; + look boat/dinghy (after he is gone)
.byte "It was loaned out to the Fishing Challenge videogame.",0

; + talk man (before throwing chicken feed in lake)
.byte "You holler at the old man",13
.byte "about Trogdor, but he just",13
.byte "grumbles about the fish not",13
.byte "biting. ",34,"Must be using the",13
.byte "wrong bait...",34," he says,",13
.byte "suggestively.",0

; + throw baby/feed (at south side)
.byte "Maybe try again from the",13
.byte "center of the lake. Looks",13
.byte "deeper there.",0

; +2 POINTS
; + throw chicken feed
.byte "You toss the feed into the",13
.byte "lake. You shed a tear for",13
.byte "each one. ",34,"Goodbye, Monty",34,13
.byte "you sniff. ",34,"Bye Delga,",13
.byte "Rasputin. Farewell,",13
.byte "Combledon!",34," and so forth.",0
; throw two handfulls, fish animation
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
.byte "You have nothing with which",13
.byte "to do that ... with.",0

; + throw feed (after throwing the feed)  (The repetition is probably just a goof.) 
.byte "You already fed the fish.",13
.byte "Let's get moving here,",13
.byte "people!You already fed the",13
.byte "fish. Let's get moving,",13
.byte "here, people!",0


; + throw (anything but the feed while he is fishing)
.byte 34,"That isn't gonna work for",13
.byte "bait!",34," the old man screams,",13
.byte "at a needlessly harsh",13
.byte "volume.",0

; + throw (anything when fisherman gone)
.byte "You already fed the fish.",13
.byte "Let's get moving, here,",13
.byte "people!",0


;===================
; Outside Giant Inn
;===================

; + look
.byte "There's a giant Inn here.",13
.byte "It takes up, like, the",13
.byte "entire screen.",13

; + look door
.byte "Just a door. A door with a",13
.byte "note on it.",0

; + look inn
.byte "Looks okay from out here.",13
.byte "But do they have a free",13
.byte "breakfast buffet?",0

; + look sign
.byte "If you can't read that",13
.byte "sign, you need to quit",13
.byte "playing this game.",0
 
; + look window
.byte "Check it out! There's an",13
.byte "INN in there.",0

; + look note
; + read note (before feed in lake)
.byte "It says, ",34,"Gone Fishin",34," just",13
.byte "like that grog coozie your",13
.byte "cousin got you.",0

; + open
; + open door (after old man)
.byte "You open the door and step",13
.byte "inside the inn.",0

; + open door (before old man)
.byte "It's locked fast!",0

; + knock (closed)
.byte "No answer.",0

; + knock (open)
.byte "Just open it, man!",0

; + get note
.byte "What is it with you and",13
.byte "notes?! No!! ",0

; +3 POINTS: leave inn with pot on head