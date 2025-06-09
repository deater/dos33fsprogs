;==================
; Pebble Lake West
;==================

; + look
lake_west_look_at_message:
.byte "There's definitely half a",13
.byte "lake here with a sandy",13
.byte "shore.",0

; + look lake/water
lake_west_look_at_lake_message:
.byte "It extends onto the next",13
.byte "screen and has a sandy",13
.byte "shore.",0

; + look sand NOT IN WIKI
lake_west_look_at_sand_message:
.byte "There's a bunch of fairly",13
.byte "substantial pebbles in the",13
.byte "sand.",0

; + look sand (after pebbles)
lake_west_look_at_sand_after_message:
.byte "Remember those pebbles on",13
.byte "the beach? Man, those were",13
.byte "good times.",0

; + look bush
lake_west_look_at_bush_message:
.byte "Don't worry about that",13
.byte "bush. Yeah, there's red",13
.byte "berries on it but never you",13
.byte "mind.",0

; + look berries
lake_west_look_at_berries_message:
.byte "Shut up.",0

; + get berries
lake_west_get_berries_message:
.byte "NO MAN! JEEZ!",0

; + get stones	; +1 POINT
; + get pebbles
lake_west_get_pebbles_message:
.byte "You grab up a handful of",13
.byte "fairly substantial",13
.byte "pebbles. You make sure to",13
.byte "get an even mix of",13
.byte "sedentary, igneous, and,",13
.byte "um, sureptitious rocks.",0

; + swim {none}/lake/water
lake_west_swim_message:
.byte "Not in this game, Swimmer",13
.byte "Dan! In this game, you",13
.byte "drown.",0

; + skip stones/pebbles
lake_west_skip_stones_message:
.byte "You've always been",13
.byte "terrible at skipping",13
.byte "stones. And you're even",13
.byte "worse at just plain",13
.byte "throwing rocks in lakes.",13
.byte "You decide to save yourself",13
.byte "the embarrassment.",0

; + get pebbles/rocks (from too far)
lake_west_pebbles_too_far_message:
.byte "You do your best Mr.",13
.byte "Fantastic impression,",13
.byte "but you can't reach from",13
.byte "here.",0

; +5 POINTS
; + throw baby
lake_west_throw_baby_message:
.byte "Something tells you this is",13
.byte "a good idea and you lob the",13
.byte "little one into the lake.",0

lake_west_throw_baby_message2:
.byte "You won't be arrested after",13
.byte "all! The little guy has",13
.byte "resurfaced safely,",13
.byte "carrying an old bottle of",13
.byte "soda. You take the soda and",13
.byte "stow your swaddling buddy",13
.byte "for takeoff.",0

; + throw baby (before getting the baby)
lake_west_throw_baby_no_baby_message:
.byte "I think you misread the",13
.byte "walkthrough on GameFAQs.",13
.byte "You gotta get the baby",13
.byte "first.",0

; + throw baby (after getting the soda)
lake_west_throw_baby_already_message:
.byte "Baby Dashing is a little",13
.byte "waterlogged from the last",13
.byte "toss, and you read his soft",13
.byte "gurgling to mean that",13
.byte "there's no more soda left.",0

; + throw feed (at south side)
; + throw baby (not in right spot)
; note: same as lake_east_throw_feed_too_south_message:
lake_west_throw_feed_too_south_message:
.byte "Maybe try again from the",13
.byte "center of the lake. Looks",13
.byte "deeper there.",0
