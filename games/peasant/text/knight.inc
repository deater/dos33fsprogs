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

