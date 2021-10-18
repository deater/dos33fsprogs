
;===============
; That Hay Bale
;===============

; After jumping in the haystack, go to any screen except Jhonka
.byte "Drat. The winds are heavy on all but a couple of key screens... looks like you're no longer in stealth mode.",0

; + look
.byte "Well, there's that big bale",13
.byte "of hay over there.",0

; + look hay
.byte "It reminds you of a warm,",13
.byte "safe place where as a child",13
.byte "you'd hide.",0

; + look in hay
.byte "You search and search",13
.byte "through the haystack.",13
.byte "Nope. No needles.",0

; + look tree
.byte "It's Arbor Day, Charlie",13
.byte "Brown!",0

; + look fence (merge with others?)
.byte "A standard peasant fence.",13
.byte "Trogdor makes milk's meat",13
.byte "outta these things.",0

; + enter hay / jump in hay / hide in hay (not muddy)
.byte "Not right now, man. You're",13
.byte "feeling fairly clean given",13
.byte "you just bathed 3",13
.byte "fortnights ago.",0

; + enter hay / jump in hay (muddy but not nearby)
.byte "Who do you think you are, MJ? Try from a little closer.",0

; + enter hay / jump into hay
.byte "You've not known much better than a roll in the hay alone.",0
.byte "You leap in the hay like a two years old boy. Uh oh. The hay sticks to your muddy body. You're a walking hay bale! Just like that one guy from that one show!",0

; + hug tree (walks to it)
.byte "To every thing, turn, turn,",13
.byte "turn. There is a season,",13
.byte "turn, turn, turn.",0
 
; + get hay
.byte "Who do you think you are?",13
.byte "Some kind of Thy",13
.byte "Dungeonman? You don't need",13
.byte "any hay.",0


;=============
; Mud Puddle
;=============

; + (walk into puddle when raining)
.byte "Now you've done it! You're covered in sticky, albeit fine smelling, mud. Your ",34,"Scalding Lake",34," T-shirt is all soiled, too. You just washed it last harvest!",0

; + look (dry)
.byte "There's a dried out mud",13
.byte "puddle. It's all caked and",13
.byte "cracked like the kind",13
.byte "rock stars are always",13
.byte "standing on.",0

; + look (wet)
.byte "Not much to see. 'Sides that big mud puddle.",0

; + get / look rock
.byte "That rock's not doin' a",13
.byte "whole lot for me.",0

; + get mud (when it's wet, before you fall in)
.byte "You can't get the mud so much. More like the mud'll get you.",0

; + get mud (when it's wet, after you fall in)
.byte "You've already gotten an heapin' helpin' all up on yo'self.",0


;===============
; Archery Range
;===============

; + look
.byte "You've come across some",13
.byte "kind of shooting gallery.",13
.byte "There's a depressed",13
.byte "looking archer at the desk",13
.byte "there.",0

; + look archer (before speaking to Mendelev)
.byte "He looks depressed. He",13
.byte "keeps sighing all",13
.byte "obviously like he wants you",13
.byte "to ask about it.",0

; + look archer (before saying haldo to Dongolev)
.byte "He looks depressed. Jeez, who invited the fun sponge?",0

; + look archer(s)/(anything not covered elsewhere)  (after saying haldo to Dongolev)
.byte "You've come across some kind of shooting gallery. A pair of twin brothers seem to be running the place.",0

; + look target
.byte "Hey, they had those same",13
.byte "targets at Peasant Scout",13
.byte "Camp!",0

; + look desk
.byte "It says 'archery' on it. My",13
.byte "wife's drunk.",0

; POINTS +2
; + talk man (you walk over) [ note, did verify the quotes here]
.byte 34,"Oh, hi. I'm Mendelev,",34,13
.byte "says the archer. ",34,"I used to",13
.byte "run a shooting range here",13
.byte "with my brother Dongolev.",13
.byte "But we don't talk so much",13
.byte "anymore. I haven't seen him",13
.byte "in a Jhonka's age. If you",13
.byte "ever run into him, tell him",13
.byte "I said 'haldo'.",0
.byte 34,"You mean 'hello,'",34," you",13
.byte "ask?",0
.byte 34,"Oh, um. No. Shut up. I",13
.byte "said 'haldo' and I meant",13
.byte "'haldo.' Tell him I said",13
.byte "'haldo.'",34,0

; + give super trinket
.byte 34,"That'll work,",34," says Mendelev. Just hit 3 bullseyes and you win the SuperTime FunBow TM!",0
.byte "The ARROW KEYS aim left and right and the SPACE BAR operates the bow. You'll need to press it a couple of times to get a nice shot off but we don't give lessons so you're on your own.",0
; (get [X]=3-5 bullseyes)
.byte 34,"Nice shootin! [X] hits.",34," Says Mendelev. ",34,"Here's your prize!",34," You got the SuperTime FunBow TM! We don't sell ammo, so you'll have to find your own arrows for it.",0

; + ask about fire (all ask abouts m&d must both be there)
.byte 34,"Trogdor just burned down some idiot peasant's cottage. You should ask him,",34," says Mendelev. / ",34,"Yeah, this jerk goes on vacation to some prancey lake and...",34," / They see you staring daggers at them and turn bright red. / ",34,"Oh. Nevermind,",34," says Dongolev. ",34,"Um, yeah. What's a fire?",34," adds Mendelwhatever.",0

; + ask about naked ned
.byte "That guy creeps us out. In fact, shut up about him.",0

; + ask about robe
.byte "We wouldn't know. We only wear archer clothes. You just can't arch real well in a robe, y'know?",0

; + ask about smell
.byte "That giant pig running around sure smells bad. Maybe talk to him.",0

; + ask about trogdor
.byte 34,"Oh man, there was this one time when I came THIS close to having Trogdor ARROWED!",34," says Dongolev. / ",34,"Hey, shut up! That was me!",34," interrupts Mendelev, ",34,"YOU almost arrowed that blue baby!",34," says Dongolev. / ",34,"Did not!",34," / ",34,"Did so!",34," / ",34,"Did not!",34," / (You see where this is going.)",0

; + ask about (unknown)
.byte "Either we don't know anything about that, or you're real boring.",0

; + haldo (after Dongolev has returned)
.byte "HALDO!!",0

; + play game (before saying haldo to Dongolev)
.byte "The gallery's not open and",13
.byte "you got no bow or arrows,",13
.byte "Cupid.",0

; + get/take/steal target
.byte "No. Those will fall on you",13
.byte "and more than likely kill",13
.byte "you.",0
 
; + get/take/steal arrow
.byte "They have ",34,"RANGE",34," printed",13
.byte "on them, so it would be",13
.byte "kind of embarrassing to have",13
.byte "to shoot around with them.",13
.byte "Also, that guy over there",13
.byte "is giving you the evil eye.",0

; + talk (while away from or behind the desk)
.byte "Why don't you saddle up to the front of the table there, cowboy?",0

; + talk (after talking to him before) NOT IN WIKI
.byte 34,"Tell my bro I said 'haldo'",13
.byte "if you see him,",34," he says",13
.byte "and goes back to pouting.",0

; + talk (after beating the minigame)
.byte 34,"Go away!",34," says Dongolev. ",34,"We're arguing about who's hotter,",34," adds Mendelev.",0


;=================
; River and Stone
;=================

; + look
.byte "Not much to see. River's",13
.byte "got a rock in it.",0

; + look water
.byte "Got a rock in it.",0

; + look rock
.byte "The ages have worn this",13
.byte "rock down. It is a rock of",13
.byte "ages. Still a-rollin.",0

; + swim river/water
.byte "Peasants can't swim. Like,",13
.byte "it's illegal.",0

; + get/take/steal rock
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
.byte "He looks way cooler than",13
.byte "you.",0

; + look sign
.byte "What that sign there? That",13
.byte "sign says 'Trogdor.'",0

; + look trogdor
.byte "I know it's labeled",13
.byte "'Trogdor,' but it's really",13
.byte "just a sign, silly. I mean,",13
.byte "attack it if you want...",0

; + attack sign / break sign
.byte "I was being facetious, Mr.",13
.byte "Smarty-short-pants. No",13
.byte "sign attacking for you.",0

; + talk knight (beginning, first try)
.byte "You explain your situation",13
.byte "to the knight. That Trogdor",13
.byte "burninated your cottage",13
.byte "and you've sworn revenge.",13
.byte "You ask for passage up the",13
.byte "mountain to settle your",13
.byte "score.",13
.byte "(Press RETURN to advance",13
.byte "through conversations)",0

.byte 34,"Hang on there,",13
.byte "Trogdorkilla,",34," says the",13
.byte "knight. ",34,"I can only allow",13
.byte "actual peasants up the",13
.byte "mountain pass to face",13
.byte "Trogdor. And you CLEARLY",13
.byte "are not one.",34,0

; + talk (again) picks up here
.byte 34,"Look, Dragonheart...",34,0

.byte 34,"You don't STINK like a",0
.byte " peasant.",34,0

.byte 34,"You don't DRESS like a",13
.byte "peasant.",34,0

.byte 34,"And you're definitely not",13
.byte "ON FIRE like a peasant.",34,0

.byte "Once you're those 3",13
.byte "things, come back and maybe",13
.byte "we can talk.",34,0

; only first time through
.byte "Be sure to LOOK around",13
.byte "lots. TALK to everyone you",13
.byte "see and ASK ABOUT stuff.",13
.byte "Type HELP if you get",13
.byte "confused and INVENTORY to",13
.byte "see your worldly stuff.",13
.byte "Type SAVE or LOAD to save",13
.byte "or load your game. Duh.",0

; + talk knight (with kerrek's belt)
.byte "Frankly, Matthew Broderick, you sure stink like a peasant. But you still don't DRESS like a peasant and you're not ON FIRE like a peasant.",0

; + talk knight (with ned's robe, on fire or not)
.byte "My dear Adso, you are dressed well but you don't STINK and you're not ON FIRE. Let us instead exercise our brains and try to solve this tantalizing conundrum.",0

; + talk knight (after acquiring Kerrek's belt and Naked Ned's robe)
.byte "Almost there, Dirk the Daring. You stink like a peasant and you dress like one too. But you're clearly still not ON FIRE.",0

; + talk knight (after have all three)
.byte "Lookin good, Mr. Peasant. Good luck with ol' Beefy Arm up there.",0
.byte "This is it! You can finally get revenge on Trogdor! Nice work so far, stupid!",0
.byte "Please insert floppy disk 2 into Drive B and press enter.",0
.byte "Disk read error. Please insert floppy disk 2 into Drive B and press enter.",0

; + ask about fire
.byte 34,"Well, whenever I see",13
.byte "peasants, they tend to be",13
.byte "on fire. So get yourself on",13
.byte "fire. I hear horse grease",13
.byte "gives a nice, controlled",13
.byte "burn.",34,0

; + ask about Jhonka
.byte 34,"Since the Kerrek showed",13
.byte "up, we don't see the Jhonka",13
.byte "so much anymore. He lives",13
.byte "in that little cave over in",13
.byte "west Peasantry.",34,0

; + ask about Kerrek
.byte 34,"I call him Big Stinky.",13
.byte "He's slow and stupid, but",13
.byte "he'll pound you into milks",13
.byte "meat without a second",13
.byte "thought.",34,0
 
; + ask about naked ned
.byte 34,"That weirdo used to live",13
.byte "over in west Peasantry but",13
.byte "now I guess he just prances",13
.byte "around the forest in his",13
.byte "birthday suit.",34,0

; + ask about robe
.byte 34,"Peasants wear those brown",13
.byte "robes. You know, with the",13
.byte "rope around the waist. Get",13
.byte "yourself one of those.",34,0

; + ask about smell
.byte 34,"I never met a peasant that",13
.byte "didn't stink. If you wanna",13
.byte "smell bad, get the Kerrek",13
.byte "involved. That thing",13
.byte "reeks!",34,0

; + ask about trogdor
.byte 34,"If I had a gold coin for",13
.byte "every whining peasant's",13
.byte "cottage that freaking",13
.byte "dragon burninated, I'd be",13
.byte "rich as a jhonka.",0

; + ask about (unknown)
.byte 34,"I don't know anything",13
.byte "about that, short pants.",34,0


