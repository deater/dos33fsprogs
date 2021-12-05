inn_dialog_start:

;==================
; Inside Giant Inn
;==================

; Type any command while the pot of horse grease is on your head
.byte "You need to get out of",13
.byte "there before that smelly",13
.byte "octogenarian gets back.",0

; + look (day)
inside_inn_look_message:
.byte "What a dump! Only one bed",13
.byte "and no minibar? The",13
.byte "Innkeeper stands behind a",13
.byte "desk and there's a door",13
.byte "that's closed.",0

; + look (night)
inside_inn_look_night_message:
.byte "It's still dark out. The",13
.byte "grimey old Innkeeper is",13
.byte "gone and he left the",13
.byte "pantry open.",0

; + look window (day/night)
inside_inn_look_window_message:
.byte "Check it out! There's a",13
.byte "Peasantry out there!",0

; + look man (day)
inside_inn_look_man_message:
.byte "He's an older peasant with",13
.byte "big cotton swabs stuffed up",13
.byte "his nose. Oh wait. Those",13
.byte "are nose hairs. Grody.",0

; + look man (night)		not in wiki?
inside_inn_look_man_night_message:
.byte "He gone.",0

; + look painting (day/night)
inside_inn_look_painting_message:
.byte "It's a painting of dogs",13
.byte "playing 'Magic: The",13
.byte "Nerdening.'",0

; + look paper / note / parchment (day/night)
inside_inn_look_paper_message:
.byte "It says, ",34,"Note to self:",13
.byte "Wave arms wildly!",34,0

; + look pillow (day/night)
inside_inn_look_pillow_message:
.byte "If you sleep in that bed,",13
.byte "you're NOT putting your",13
.byte "head on that nasty pillow.",0

; + look pot (night)
inside_inn_look_pot_night_message:
.byte "It's full of horse grease.",13
.byte "I guess that sounds useful.",0

; + look rug (day/night)
inside_inn_look_rug_message:
.byte "Maybe that used to be a",13
.byte "magic carpet. But it's sure",13
.byte "a cat pee-stained carpet",13
.byte "now.",0

; + look bed (day/night)
inside_inn_look_bed_message:
.byte "Is that just a fitted sheet",13
.byte "over a slab of concrete?",0

; + look bell (day/note)
inside_inn_look_bell_message:
.byte "Tis broked.",0

; + look desk (day)
inside_inn_look_desk_message:
.byte "There's a broken bell and",13
.byte "a piece of parchment on",13
.byte "there. And some crazy old",13
.byte "guy behind it.",0

; + look desk (night)
inside_inn_look_desk_night_message:
.byte "There's a broken bell and",13
.byte "a piece of parchment on",13
.byte "there.",0

; + look candle (night)
inside_inn_look_candle_night_message:
.byte "That candle's not at all on",13
.byte "fire.",0

; + look/open door (day)
inside_inn_open_door_message:
.byte 34,"That's the pantry,",34," says",13
.byte "the Innkeeper. ",34,"Employees",13
.byte "only.",34,0

;==========
; talk

; + talk man (day)
inside_inn_talk_man_message:
.byte 34,"If you're interested in",13
.byte "staying the night, just",13
.byte "type 'get a room.'",34,0

;==========
; give

; + give/use baby (before you get the baby) (day) (at night says default)
inside_inn_give_baby_before_message:
.byte "You have no baby nor any",13
.byte "immediate prospects.",0

; +5 POINTS
; + give/use baby (by desk) (day)
inside_inn_give_baby_message:
.byte 34,"Well lookit that little",13
.byte "guy!",34," says the Innkeeper.",13
.byte 34,"You want a treat, do ya?",13
.byte "What do babies like?",34," He",13
.byte "fishes around in his",13
.byte "pockets.",0

inside_inn_give_baby2_message:
.byte 34,"Um, how bout my",13
.byte "medication!",34," You grab the",13
.byte "bottle of pills before he",13
.byte "can force them on the baby.",13
.byte 34,"Hey, those were for him!",34,0

; + give/use baby (when you already have the pills)
inside_inn_give_baby_already_message:
.byte "You already milked that",13
.byte "fogey for all the pills",13
.byte "he's worth.",0

;=================
; get

; + get a room (without robe) (do you need to be wearing it?)
inside_inn_get_room_no_robe_message:
.byte 34,"I only serve peasants",13
.byte "here, fancypants!",34," barks",13
.byte "the old guy. ",34,"Where's your",13
.byte "robe?",34,0

; +3 POINTS
; + get room (with robe) (day) (at night gives default)
inside_inn_get_room_message:
.byte 34,"Okay, youngster,",34," says",13
.byte "the decrepit old person.",13
.byte 34,"Just bed on down for the",13
.byte "night and I'm sure I'll",13
.byte "remember to collect the fee",13
.byte "come morning.",34,0

; walk over to bed
; square transition

inside_inn_get_room2_message:
.byte "Night falls like a bad",13
.byte "power point presentation.",0

; un-transition
; rolling around

inside_inn_get_room3_message:
.byte "What an uncomfortable bed!",13
.byte "You sleep for maybe 20",13
.byte "minutes before the extreme",13
.byte "pain in your spine forces",13
.byte "you to get up.",0

; + get a room (when on fire)
.byte 34,"Board of Peasant Health",13	; [sic] in game says \oard
.byte "says I can't serve any folk",13
.byte "that's on fire. Nothing",13
.byte "personal. Well, I mean, I",13
.byte "don't like you much",13
.byte "anyway.",34,0

; + get paper (day/night)
inside_inn_get_paper_message:
.byte "Naw, it might be important",13
.byte "to that wrinkly old loon.",0

; + get painting (day/night)	; WIKI IS WRONG
inside_inn_get_painting_message:
.byte "Weird. It's actually just",13
.byte "painted right onto the",13
.byte "wall. Like, the frame and",13
.byte "everything.",0

; + get rug (day/night)
inside_inn_get_rug_message:
.byte "You're not touching that",13
.byte "thing. Too many",13
.byte "questionable stains on it.",0

; + get doing-sproings (day/night)
inside_inn_get_doing_message:
.byte "That's the worst thing",13
.byte "anyone has ever tried to",13
.byte "type in this game. Ever.",0

; + get pillow (day/night)
inside_inn_get_pillow_message:
.byte "Not a chance. There's even",13
.byte "more questionable stains",13
.byte "on that pillow than there",13
.byte "are on that rug.",0

; + get bell (day/night)
inside_inn_get_bell_message:
.byte "You can't. It looks like",13
.byte "it's been somehow olded to",13
.byte "the desk.",0

; +2 POINTS
; + get/take/steal pot/grease (night)
inside_inn_get_grease_message:
.byte "You reach way up to the top",13
.byte "shelf.",0

; points actually happen here
; falls on your head

inside_inn_get_grease_message2:
.byte "Oh great! Now you can't see",13
.byte "a thing and your head is",13
.byte "covered in highly",13
.byte "flammable horse grease.",13
.byte "You better get out of here",13
.byte "before that disgusting old",13
.byte "man comes back.",0

; + get pot/grease (at night, already have it)
inside_inn_grease_already_message:
.byte "You already have a nice",13
.byte "greasy swab of it on the",13
.byte "corner of your hood.",0

; + get/light candle (night)
inside_inn_get_candle_message:
.byte "It seems like you should be",13
.byte "able to do that, doesn't",13
.byte "it? Sorry. No dice.",0

; + get old man rub (day/night) (after getting pills?)
inside_inn_get_rub_message:
.byte "You disgust me.",0



; + get bed, sleep/sleep on bed (day)
inside_inn_get_bed_message:
inside_inn_sleep_bed_message:
.byte "You probably want to talk",13
.byte "to that stinky old guy over",13
.byte "there about that.",0


;==============
; ask

; + ask about fire (day)
inside_inn_ask_about_fire_message:
.byte 34,"I've always preferred",13
.byte "being on fire at night.",13
.byte "Looks prettier and keeps",13
.byte "the butterflies away.",34,0

; + ask about naked ned (day)
inside_inn_ask_about_ned_message:
.byte 34,"He used to be such a nice,",13
.byte "clothed young man. Wonder",13
.byte "what he's done with all his",13
.byte "old clothes?",34,0

; + ask about robe (day)
inside_inn_ask_about_robe_message:
.byte 34,"I wear my robe hood-down",13
.byte "so it's easier to trim my",13
.byte "ear hairs. If you need a",13
.byte "robe, maybe try someone",13
.byte "that's not using theirs.",34,0
 
; + ask about smell (day)
inside_inn_ask_about_smell_message:
.byte 34,"Well, if you don't stink,",13
.byte "maybe find something that",13
.byte "does and wear it. Like a",13
.byte "dead carcass or summat.",34,0 

; + ask about trogdor (day)
inside_inn_ask_about_trogdor_message:
.byte 34,"Are you talking about that",13
.byte "young green boy that lives",13
.byte "up the street? He's always",13
.byte "tearing my roof off and",13
.byte "eating my customers.",34,0

; + ask about (unknown) (day)
inside_inn_ask_about_unknown_message:
.byte 34,"I don't know nothing about",13
.byte "no whatever you just said.",34,0

; + ring bell (day/night)
inside_inn_ring_bell_message:
.byte "Instead of ringing or",13
.byte "dinging, it just goes",13
.byte "'DUNG.'",0
 



inn_dialog_end:

.assert (>inn_dialog_end - >inn_dialog_start) < $1E , error, "inn dialog too big"

