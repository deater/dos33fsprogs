;===============
; That Hay Bale
;===============

; + look (at anything, while hiding inside the bale of hay)
hay_look_while_in_hay_message:
.byte "Right now, you see a bunch",13
.byte "of hay.",0

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
; also if you are already in hay
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

; + climb/jump fence
hay_climb_fence_message:
.byte "No, you have business to",13
.byte "attend to here in",13
.byte "Peasantry.",0

