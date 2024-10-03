;===============
; Archery Range
;===============

; + look
archery_look_message:
.byte "You've come across some",13
.byte "kind of shooting gallery.",13
.byte "There's a depressed",13
.byte "looking archer at the desk",13
.byte "there.",0

; + look archer (before speaking to Mendelev)
archery_look_at_archer_message:
.byte "He looks depressed. He",13
.byte "keeps sighing all",13
.byte "obviously like he wants you",13
.byte "to ask about it.",0

; + look archer (after talk but before saying haldo to Dongolev)
archery_look_at_archer_sponge_message:
.byte "He looks depressed. Jeez,",13
.byte "who invited the fun sponge?",0

; + look archer(s)/(anything not covered elsewhere)  (after saying haldo to Dongolev)
archery_look_at_archer_otherwise_message:
.byte "You've come across some",13
.byte "kind of shooting gallery. A",13
.byte "pair of twin brothers seem",13
.byte "to be running the place.",0

; + look target
archery_look_at_target_message:
.byte "Hey, they had those same",13
.byte "targets at Peasant Scout",13
.byte "Camp!",0

; + look desk
archery_look_at_desk_message:
.byte "It says 'archery' on it. My",13
.byte "wife's drunk.",0

; + talk (while away from or behind the desk)
archery_talk_far_message:
.byte "Why don't you saddle up to",13
.byte "the front of the table",13
.byte "there, cowboy?",0


; POINTS +1 (default) if you talk before finding Dongolev
; POINTS +1 extra point if you get trinket or mask first
; + talk {nothing}/man/guy/dude/archer/Mendelev
;        (you walk over) [ note, did verify the quotes here]
archery_talk_mendelev_message:
.byte 34,"Oh, hi. I'm Mendelev,",34,13
.byte "says the archer. ",34,"I used to",13
.byte "run a shooting range here",13
.byte "with my brother Dongolev.",13
.byte "But we don't talk so much",13
.byte "anymore. I haven't seen him",13
.byte "in a Jhonka's age. If you",13
.byte "ever run into him, tell him",13
.byte "I said 'haldo'.",0

archery_talk_mendelev2_message:
.byte 34,"You mean 'hello,'",34," you",13
.byte "ask?",0

archery_talk_mendelev3_message:
.byte 34,"Oh, um. No. Shut up. I",13
.byte "said 'haldo' and I meant",13
.byte "'haldo.' Tell him I said",13
.byte "'haldo.'",34,0

; + talk (after talking to him before) NOT IN WIKI
archery_talk_mendelev_between_message:
.byte 34,"Tell my bro I said 'haldo'",13
.byte "if you see him,",34," he says",13
.byte "and goes back to pouting.",0

; + talk (after dongolev back, before minigame)
;   talk mendelev, dongolev, brothers, guy, dude, man
;        (have arrow, not sure if that matters)
archery_talk_before_minigame_message:
.byte 34,"Haldo!",34," say the brothers.",13
.byte 34,"Test your skill! Give us",13
.byte "the right super item from",13
.byte "your inventory and you can",13
.byte "give it as many tries as",13
.byte "you need!",34,0

; + talk (after trinket, before minigame) same as "play game"

; + talk (after beating the minigame)
;   talk mendelev, dongolev, brothers, guy, dude, man
archery_talk_after_minigame_message:
.byte 34,"Go away!",34," says Dongolev.",13
.byte 34,"We're arguing about who's",13
.byte "hotter,",34," adds Mendelev.",0

; + 2 POINTS
; + give super trinket
archery_give_trinket_message:
.byte 34,"That'll work,",34," says",13
.byte "Mendelev. Just hit 3",13
.byte "bullseyes and you win the",13
.byte "SuperTime FunBow TM!",0

; jmp to archery_play_game_message2


; give trinket (already gave)		not in wiki
archery_give_trinket_again_message:
.byte "You already gave them the",13
.byte "trinket. Fortunately, you",13
.byte "have an open invitation to",13
.byte "humiliate yourself at the",13
.byte "range.",0

; launches into game...

; play game, after trinket
archery_play_game_message:
.byte 34,"Haldo again!",34," say the",13
.byte "brothers. ",34,"Get 3 bullseyes",13
.byte "this time and you'll win",13
.byte "yourself an SuperTime",13		; [sic]
.byte "FunBow",34,0

archery_play_game_message2:
.byte 34,"The ARROW KEYS aim left",13
.byte "and right and the SPACE BAR",13
.byte "operates the bow. You'll",13
.byte "need to press it a couple",13
.byte "of times to get a nice shot",13
.byte "off but we don't give",13
.byte "lessons so you're on your",13
.byte "own.",0




; hints
; slack, just aim at middle, both at red line
; full left, aim at right edge of leg
; full right, aim at left edge of leg

; play game after won, goes the "arguing" thing


;=======
; ask

; + ask about fire (all ask abouts m&d must both be there)
archery_ask_about_fire_message:
.byte 34,"Trogdor just burned down",13
.byte "some idiot peasant's",13
.byte "cottage. You should ask",13
.byte "him,",34," says Mendelev.",0
archery_ask_about_fire_message2:
.byte 34,"Yeah, this jerk goes on",13
.byte "vacation to some prancey",13
.byte "lake and...",34,0
archery_ask_about_fire_message3:
.byte "They see you staring",13
.byte "daggers at them and turn",13
.byte "bright red.",0
archery_ask_about_fire_message4:
.byte 34,"Oh. Nevermind,",34," says",13
.byte "Dongolev. ",34,"Um, yeah.",13
.byte "What's a fire?",34," adds",13
.byte "Mendelwhatever.",0

; + ask about naked ned
archery_ask_about_ned_message:
.byte "That guy creeps us out. In",13
.byte "fact, shut up about him.",0

; + ask about robe
archery_ask_about_robe_message:
.byte 34,"We wouldn't know. We only",13
.byte "wear archer clothes. You",13
.byte "just can't arch real well",13
.byte "in a robe, y'know?",34,0

; + ask about smell
archery_ask_about_smell_message:
.byte 34,"That giant pig running",13
.byte "around sure smells bad. Maybe",13
.byte "talk to him.",34,0

; + ask about trogdor
archery_ask_about_trogdor_message:
.byte 34,"Oh man, there was this one",13
.byte "time when I came THIS close",13
.byte "to having Trogdor",13
.byte "ARROWED!",34," says Dongolev.",0
archery_ask_about_trogdor_message2:
.byte 34,"Hey, shut up! That was me!",34,13
.byte "interrupts Mendelev, ",34,"YOU",13
.byte "almost arrowed that blue",13
.byte "baby!",34," says Dongolev.",0
archery_ask_about_trogdor_message3:
.byte 34,"Did not!",34,0
archery_ask_about_trogdor_message4:
.byte 34,"Did so!",34,0
archery_ask_about_trogdor_message5:
.byte 34,"Did not!",34,0
archery_ask_about_trogdor_message6:
.byte "(You see where this is",13
.byte "going.)",0

; + ask about (unknown)
archery_ask_about_unknown_message:
.byte 34,"Either we don't know",13
.byte "anything about that, or",13
.byte "you're real boring.",34,0

; + haldo (after Dongolev has returned)
archery_haldo_message:
.byte "HALDO!!",0

; + play game (before saying haldo to Dongolev) (before trinket?)
archery_play_game_closed_message:
.byte "The gallery's not open and",13
.byte "you got no bow or arrows,",13
.byte "Cupid.",0



; + get/take/steal target
archery_get_target_message:
.byte "No. Those will fall on you",13
.byte "and more than likely kill",13
.byte "you.",0
 
; + get/take/steal arrow
archery_get_arrow_message:
.byte "They have ",34,"RANGE",34," printed",13
.byte "on them, so it would be",13
.byte "kind of embarrassing to have",13
.byte "to shoot around with them.",13
.byte "Also, that guy over there",13
.byte "is giving you the evil eye.",0




; (get [X]=3-5 bullseyes)
archery_won_message:
.byte 34,"Nice shootin! 3 hits.",34,13
.byte "Says Mendelev. ",34,"Here's",13
.byte "your prize!",34," You got the",13
.byte "SuperTime FunBow TM! We",13
.byte "don't sell ammo, so you'll",13
.byte "have to find your own",13
.byte "arrows for it.",0

; BEAT GAME = +3 POINTS
; get bow

archery_zero_message:
.byte 34,"Sorry!",34," says",13
.byte "Dongolev.",34,"Not a single",13
.byte "hit. Your game face must be",13
.byte "on back-order. Maybe come",13
.byte "back when your shipment",13
.byte "comes in.",0

archery_some_message:
.byte 34,"Sorry!",34," says",13
.byte "Dongolev.",34,"Only 1",13
.byte "hit. Your game face must be",13
.byte "on back-order. Maybe come",13
.byte "back when your shipment",13
.byte "comes in.",0

archery_lose_message:
.byte 34,"But since you gave us this",13
.byte "trinket, and you obviously",13
.byte "don't have a prayer of",13
.byte "winning, you can play again",13
.byte "whenever you want.",34,0




