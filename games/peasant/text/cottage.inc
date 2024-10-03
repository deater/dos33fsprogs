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

