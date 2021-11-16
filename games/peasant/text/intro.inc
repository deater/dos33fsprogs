; TODO: should we merge this in to use the common text drawing?
;	This might save a few bytes due to word compression
;	However these are custom box sizes so things would
;	change up a bit


cottage_text1:
	.byte 0,52,24,  0,253,82
	.byte 9,35,"YOU are Rather Dashing, a",13
	.byte      "humble peasant living in",13
	.byte      "the peasant kingdom of",13
	.byte      "Peasantry.",0

; wait a few seconds

cottage_text2:
	.byte 0,41,15, 0,255,96
	.byte 8,25,"You return home from a",13
	.byte       "vacation on Scalding Lake",13
	.byte       "only to find that TROGDOR",13
	.byte       "THE BURNINATOR has",13
	.byte       "burninated your thatched",13
	.byte       "roof cottage along with all",13
	.byte       "your goods and services.",0

; wait a few seconds, then start walking toward cottage

cottage_text3:
	.byte   0,28,20, 0,252,86
	.byte 7,33,"With nothing left to lose,",13
	.byte      "you swear to get revenge on",13
	.byte      "the Wingaling Dragon in the",13
	.byte      "name of burninated peasants",13
	.byte      "everywhere.",0

; Walk to edge of screen


lake_w_message1:
	.byte   0,42,24, 0,252,82
	.byte   8,41,"You head east toward the",13
	.byte        "mountain atop which",13
	.byte        "TROGDOR lives.",0

lake_e_message1:
	.byte 0,35,34, 0,253,72
	.byte 7,49,"That's a nice looking lake.",0

; walk up a bit

river_message1:
	.byte 0,35,34, 0,253,82
	.byte 7,49,"You can start playing in a",13
	.byte      "second here.",0

; walks behind tree


; continues displaying previous message

; stops as approach knight

knight_message1:
	.byte 0,35,34, 0,253,72
	.byte 7,49,"OK go for it.",0
