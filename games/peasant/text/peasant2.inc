peasant2_dialog_start:

;===============
; That Hay Bale
;===============

; + look
hay_look_message:
.byte "Well, there's that big bale",13
.byte "of hay over there.",0

; + look hay
hay_look_at_hay_message:
.byte "It reminds you of a warm,",13
.byte "safe place where as a child",13
.byte "you'd hide.",0

; + look in hay
hay_look_in_hay_message:
.byte "You search and search",13
.byte "through the haystack.",13
.byte "Nope. No needles.",0

; + look tree
hay_look_at_tree_message:
.byte "It's Arbor Day, Charlie",13
.byte "Brown!",0

; + look fence (merge with others?)
hay_look_at_fence_message:
.byte "A standard peasant fence.",13
.byte "Trogdor makes milk's meat",13
.byte "outta these things.",0

; + enter hay / jump in hay / hide in hay (not muddy)
hay_enter_hay_clean_message:
.byte "Not right now, man. You're",13
.byte "feeling fairly clean given",13
.byte "you just bathed 3",13
.byte "fortnights ago.",0

; + enter hay / jump in hay (muddy but not nearby)
hay_enter_hay_too_far_message:
.byte "Who do you think you are,",13
.byte "MJ? Try from a little",13
.byte "closer.",0

; + 3 POINTS
; + enter hay / jump into hay (muddy)
hay_enter_hay_muddy_message:
.byte "You've not known much",13
.byte "better than a roll in the",13
.byte "hay alone.",0
; walk over
hay_enter_hay_muddy_message2:
.byte "You leap in the hay like a",13
.byte "two years old boy. Uh oh.",13
.byte "The hay sticks to your",13
.byte "muddy body. You're a",13
.byte "walking hay bale! Just like",13
.byte "that one guy from that one",13
.byte "show!",0

; + hug tree (walks to it)
hay_hug_tree_message:
.byte "To every thing, turn, turn,",13
.byte "turn. There is a season,",13
.byte "turn, turn, turn.",0
 
; + get/steal/take hay
;   although only "get" says the "probably wish you could get" message non-hay
hay_get_hay_message:
.byte "Who do you think you are?",13
.byte "Some kind of Thy",13
.byte "Dungeonman? You don't need",13
.byte "any hay.",0


;=============
; Mud Puddle
;=============

; note, puddle goes dry after you get riches

; +2 POINTS
; + (walk into puddle when raining)
puddle_walk_in_message:
.byte "Now you've done it! You're",13
.byte "covered in sticky, albeit",13
.byte "fine smelling, mud. Your",13
.byte 34,"Scalding Lake",34," T-shirt is",13
.byte "all soiled, too. You just",13
.byte "washed it last harvest!",0

; + look (dry)
puddle_look_at_dry_message:
.byte "There's a dried out mud",13
.byte "puddle. It's all caked and",13
.byte "cracked like the kind",13
.byte "rock stars are always",13
.byte "standing on.",0

; + look (wet)
puddle_look_at_wet_message:
.byte "Not much to see. 'Sides",13
.byte "that big mud puddle.",0

; + look mud / puddle	(dry)			; NOT IN WIKI?
puddle_look_mud_dry_message:
.byte "The bone-dry mud puddle is",13
.byte "cracked and caked.",0

; + look mud / puddle	(wet)			; NOT IN WIKI?
puddle_look_mud_wet_message:
.byte "It's that sticky mud.",13
.byte "Y'know, the kind pigs like.",0

; + get / look rock
puddle_get_rock_message:
.byte "That rock's not doin' a",13
.byte "whole lot for me.",0

; + get mud (when it's wet, before you fall in)
puddle_get_mud_wet_clean_message:
.byte "You can't get the mud so",13
.byte "much. More like the mud'll",13
.byte "get you.",0

; + get mud (when it's wet, after you fall in)
puddle_get_mud_wet_dirty_message:
.byte "You've already gotten an",13
.byte "heapin' helpin' all up on",13
.byte "yo'self.",0


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





;=================
; River and Stone
;=================

; + look
river_look_message:
.byte "Not much to see. River's",13
.byte "got a rock in it.",0

; + look water/river
river_look_at_water_message:
.byte "Got a rock in it.",0

; + look rock/stone
river_look_at_rock_message:
.byte "The ages have worn this",13
.byte "rock down. It is a rock of",13
.byte "ages. Still a-rollin.",0

; + swim river/water/rock/stone
river_swim_message:
.byte "Peasants can't swim. Like,",13
.byte "it's illegal.",0

; + get/take/steal rock
river_get_rock_message:
.byte "For what? Now you're just",13
.byte "making up puzzles to solve.",0


;========================
; Mountain Pass / Knight
;========================

; + look
pass_look_message:
.byte "You've reached the",13
.byte "mountain pass that leads to",13
.byte "Trogdor's lair. A royal",13
.byte "knight blocks the entrance.",0

; + look knight/man/dude/guy
knight_look_message:
.byte "He looks way cooler than",13
.byte "you.",0

; + look sign
sign_look_message:
.byte "What that sign there? That",13
.byte "sign says 'Trogdor.'",0

; + look trogdor
trogdor_look_message:
.byte "I know it's labeled",13
.byte "'Trogdor,' but it's really",13
.byte "just a sign, silly. I mean,",13
.byte "attack it if you want...",0

; + attack sign / break sign
attack_sign_message:
.byte "I was being facetious, Mr.",13
.byte "Smarty-short-pants. No",13
.byte "sign attacking for you.",0

; + talk knight (beginning, first time only)
talk_knight_first_message:
.byte "You explain your situation",13
.byte "to the knight. That Trogdor",13
.byte "burninated your cottage",13
.byte "and you've sworn revenge.",13
.byte "You ask for passage up the",13
.byte "mountain to settle your",13
.byte "score.",13
.byte "(Press RETURN to advance",13
.byte "through conversations)",0

; (first time only)
talk_knight_second_message:
.byte 34,"Hang on there,",13
.byte "Trogdorkilla,",34," says the",13
.byte "knight. ",34,"I can only allow",13
.byte "actual peasants up the",13
.byte "mountain pass to face",13
.byte "Trogdor. And you CLEARLY",13
.byte "are not one.",34,0

; + talk (again) picks up here
talk_knight_third_message:
.byte 34,"Look, Dragonheart...",34,0

talk_knight_stink_message:
.byte 34,"You don't STINK like a",13
.byte "peasant.",34,0

talk_knight_dress_message:
.byte 34,"You don't DRESS like a",13
.byte "peasant.",34,0

talk_knight_fire_message:
.byte 34,"And you're definitely not",13
.byte "ON FIRE like a peasant.",34,0

talk_knight_fourth_message:
.byte "Once you're those 3",13
.byte "things, come back and maybe",13
.byte "we can talk.",34,0

; first time only
talk_knight_fifth_message:
.byte "Be sure to LOOK around",13
.byte "lots. TALK to everyone you",13
.byte "see and ASK ABOUT stuff.",13
.byte "Type HELP if you get",13
.byte "confused and INVENTORY to",13
.byte "see your worldly stuff.",13
.byte "Type SAVE or LOAD to save",13
.byte "or load your game. Duh.",0


; + talk knight (with kerrek's belt)
; starts here, this alone
talk_knight_after_belt_message:
.byte "Frankly, Matthew",13
.byte "Broderick, you sure stink",13
.byte "like a peasant. But you",13
.byte "still don't DRESS like a",13
.byte "peasant and you're not ON",13
.byte "FIRE like a peasant.",0

; + talk knight (with ned's robe, on fire or not)
talk_knight_after_robe_message:
.byte "My dear Adso, you are",13
.byte "dressed well but you don't",13
.byte "STINK and you're not ON",13
.byte "FIRE. Let us instead",13
.byte "exercise our brains and try",13
.byte "to solve this tantalizing",13
.byte "conundrum.",0

; + talk knight (after acquiring Kerrek's belt and Naked Ned's robe)
talk_knight_after_robe_and_belt_message:
.byte "Almost there, Dirk the",13
.byte "Daring. You stink like a",13
.byte "peasant and you dress like",13
.byte "one too. But you're clearly",13
.byte "still not ON FIRE.",0

; + 7 POINTS
; + talk knight (after have robe, belt, and on fire)
talk_knight_after_robe_belt_fire_message:
.byte "Lookin good, Mr. Peasant.",13
.byte "Good luck with ol' Beefy",13
.byte "Arm up there.",0

talk_knight_after_robe_belt_fire_message2:
.byte "This is it! You can finally",13
.byte "get revenge on Trogdor! Nice",13
.byte "work so far, stupid!",0

; Not included, would probably just confuse people
;.byte "Please insert floppy disk 2",13
;.byte "into Drive B and press enter.",0

;.byte "Disk read error. Please insert",13
;.byte "floppy disk 2 into Drive B and",13
;.byte "press enter.",0

; + ask about fire
knight_ask_fire_message:
.byte 34,"Well, whenever I see",13
.byte "peasants, they tend to be",13
.byte "on fire. So get yourself on",13
.byte "fire. I hear horse grease",13
.byte "gives a nice, controlled",13
.byte "burn.",34,0

; + ask about Jhonka
knight_ask_jhonka_message:
.byte 34,"Since the Kerrek showed",13
.byte "up, we don't see the Jhonka",13
.byte "so much anymore. He lives",13
.byte "in that little cave over in",13
.byte "west Peasantry.",34,0

; + ask about Kerrek
knight_ask_kerrek_message:
.byte 34,"I call him Big Stinky.",13
.byte "He's slow and stupid, but",13
.byte "he'll pound you into milks",13
.byte "meat without a second",13
.byte "thought.",34,0
 
; + ask about naked ned
knight_ask_ned_message:
.byte 34,"That weirdo used to live",13
.byte "over in west Peasantry but",13
.byte "now I guess he just prances",13
.byte "around the forest in his",13
.byte "birthday suit.",34,0

; + ask about robe
knight_ask_robe_message:
.byte 34,"Peasants wear those brown",13
.byte "robes. You know, with the",13
.byte "rope around the waist. Get",13
.byte "yourself one of those.",34,0

; + ask about smell
knight_ask_smell_message:
.byte 34,"I never met a peasant that",13
.byte "didn't stink. If you wanna",13
.byte "smell bad, get the Kerrek",13
.byte "involved. That thing",13
.byte "reeks!",34,0

; + ask about trogdor
knight_ask_trogdor_message:
.byte 34,"If I had a gold coin for",13
.byte "every whining peasant's",13
.byte "cottage that freaking",13
.byte "dragon burninated, I'd be",13
.byte "rich as a jhonka.",0

; + ask about (unknown)
knight_ask_unknown_message:
.byte 34,"I don't know anything",13
.byte "about that, short pants.",34,0

peasant2_dialog_end:

.assert (>peasant2_dialog_end - >peasant2_dialog_start) < $1E , error, "peasant2 dialog too big"
