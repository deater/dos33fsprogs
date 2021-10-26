;==================
; Inside Giant Inn
;==================

; Type any command while the pot of horse grease is on your head
.byte "You need to get out of there before that smelly octogenarian gets back.",0

; + look
.byte "What a dump! Only one bed",13
.byte "and no minibar? The",13
.byte "Innkeeper stands behind a",13
.byte "desk and there's a door",13
.byte "that's closed.",0

; + look (night)
.byte "It's still dark out. The grimey old Innkeeper is gone and he left the pantry open.",0

; + look window
.byte "Check it out! There's a",13
.byte "Peasantry out there!",0

; + talk man
.byte 34,"If you're interested in",13
.byte "staying the night, just",13
.byte "type 'get a room.'",34,0

; + give baby (before you get the baby)
.byte "You have no baby nor any",13
.byte "immediate prospects.",0

; +5 POINTS
; + give/use baby (by desk)
.byte 34,"Well lookit that little guy!",34," says the Innkeeper. ",34,"You want a treat, do ya? What do babies like?",34," He fishes around in his pockets.",0
.byte 34,"Um, how bout my medication!",34," You grab the bottle of pills before he can force them on the baby. ",34,"Hey, those were for him!",34,0

; + give baby (when you already have the pills)
.byte "You already milked that fogey for all the pills he's worth.",0

; + get a room (without robe)	
.byte 34,"I only serve peasants",13
.byte "here, fancypants!",34," barks",13
.byte "the old guy. ",34,"Where's your",13
.byte "robe?",34,0

; +3 POINTS
; + get room (with robe)
.byte 34,"Okay, youngster,",34," says the decrepit old person. ",34,"Just bed on down for the night and I'm sure I'll remember to collect the fee come morning.",34,0
.byte "Night falls like a bad power point presentation.",0
.byte "What an uncomfortable bed! You sleep for maybe 20 minutes before the extreme pain in your spine forces you to get up.",0

; + get a room (when on fire)
.byte 34,"Board of Peasant Health says I can't serve any folk that's on fire. Nothing personal. Well, I mean, I don't like you much anyway.",34,0

; +2 POINTS
; + get/take/steal pot
.byte "You reach way up to the top shelf.",0
.byte "Oh great! Now you can't see a thing and your head is covered in highly flammable horse grease. You better get out of here before that disgusting old man comes back.",0

; + get bell (after getting a room)
.byte "You can't. It looks like it's been somehow olded to the desk.",0

; + get candle (at night)
.byte "It seems like you should be able to do that, doesn't it? Sorry. No dice.",0

; + get grease (at night, already have it)
.byte "You already have a nice greasy swab of it on the corner of your hood.",0

; + get old man rub (in the inn ?? when)
.byte "You disgust me.",0

; + get paper
.byte "Naw, it might be important",13
.byte "to that wrinkly old loon.",0

; + get painting		; WIKI IS WRONG
.byte "Weird. It's actually just",13
.byte "painted right onto the",13
.byte "wall. Like, the frame and",13
.byte "everything.",0

; + get pot (if you already have it)
.byte "You already have a nice greasy swab of it on the corner of your hood.",0

; + get rug
.byte "You're not touching that",13
.byte "thing. Too many",13
.byte "questionable stains on it.",0

; + (exiting inn with pot on head)
.byte "Phew! You discard the big black pot and wipe the horse grease from your eyes. The hood of your robe is still covered in highly flammable horse grease, though.",0

; + ask about fire
.byte 34,"I've always preferred",13
.byte "being on fire at night.",13
.byte "Looks prettier and keeps",13
.byte "the butterflies away.",34,0

; + ask about naked ned
.byte 34,"He used to be such a nice,",13
.byte "clothed young man. Wonder",13
.byte "what he's done with all his",13
.byte "old clothes?",34,0

; + ask about robe
.byte 34,"I wear my robe hood-down",13
.byte "so it's easier to trim my",13
.byte "ear hairs. If you need a",13
.byte "robe, maybe try someone",13
.byte "that's not using theirs.",34,0
 

; + ask about smell
.byte 34,"Well, if you don't stink,",13
.byte "maybe find something that",13
.byte "does and wear it. Like a",13
.byte "dead carcass or summat.",34,0 

; + ask about trogdor
.byte 34,"Are you talking about that",13
.byte "young green boy that lives",13
.byte "up the street? He's always",13
.byte "tearing my roof off and",13
.byte "eating my customers.",34,0

; + ask about (unknown)
.byte 34,"I don't know nothing about",13
.byte "no whatever you just said.",34,0

; + ring bell
.byte "Instead of ringing or",13
.byte "dinging, it just goes",13
.byte "'DUNG.'",0
 
; + light candle (at night)
.byte "It seems like you should be able to do that, doesn't it? Sorry. No dice.",0

; + open door (before getting room)
.byte 34,"That's the pantry,",34," says",13
.byte "the Innkeeper. ",34,"Employees",13
.byte "only.",34,0

; + sleep/sleep on bed (man is there)
.byte "You probably want to talk",13
.byte "to that stinky old guy over",13
.byte "there about that.",0

; + get doing-sproings
.byte "That's the worst thing",13
.byte "anyone has ever tried to",13
.byte "type in this game.  Ever.",0

; + get pillow
.byte "Not a chance. There's even",13
.byte "more questionable stains",13
.byte "on that pillow than there",13
.byte "are on that rug.",0

; + look man
.byte "He's an older peasant with",13
.byte "big cotton swabs stuffed up",13
.byte "his nose. Oh wait. Those",13
.byte "are nose hairs. Grody.",0

; + look painting
.byte "It's a painting of dogs",13
.byte "playing 'Magic: The",13
.byte "Nerdening.'",0

; + look paper
.byte "It says, ",34,"Note to self:",13
.byte "Wave arms wildly!",34,0

; + look pillow
.byte "If you sleep in that bed,",13
.byte "you're NOT putting your",13
.byte "head on that nasty pillow.",0

; + look pot (after getting a room)
.byte "It's full of horse grease. I guess that sounds useful.",0

; + look rug
.byte "Maybe that used to be a",13
.byte "magic carpet. But it's sure",13
.byte "a cat pee-stained carpet",13
.byte "now.",0

; + look bed
.byte "Is that just a fitted sheet",13
.byte "over a slab of concrete?",0

; + look bell
.byte "Tis broked.",0

; + look candle (after getting a room)
.byte "That candle's not at all on fire.",0

; + look desk (man there)
.byte "There's a broken bell and",13
.byte "a piece of parchment on",13
.byte "there. And some crazy old",13
.byte "guy behind it.",0

; + look desk (night?)
.byte "There's a broken bell and",13
.byte "a piece of parchment on",13
.byte "there.",0

