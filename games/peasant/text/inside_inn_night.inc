inside_inn_night_dialog_start:

;=========================
; Inside Giant Inn (Night)
;=========================

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

; + look bell (day/night)
inside_inn_look_bell_message:
.byte "Tis broked.",0

; + look desk (night)
inside_inn_look_desk_night_message:
.byte "There's a broken bell and",13
.byte "a piece of parchment on",13
.byte "there.",0

; + look candle (night)
inside_inn_look_candle_night_message:
.byte "That candle's not at all on",13
.byte "fire.",0

;=================
; get

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

; + ring bell (day/night)
inside_inn_ring_bell_message:
.byte "Instead of ringing or",13
.byte "dinging, it just goes",13
.byte "'DUNG.'",0
 
inside_inn_night_dialog_end:

.assert (>inside_inn_night_dialog_end - >inside_inn_night_dialog_start) < $1E , error, "inn dialog too big"

