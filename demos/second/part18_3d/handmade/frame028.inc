frame28:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 26,6,35,25
	.byte	25,26,35,40		; BOX
	.byte	SET_COLOR | BROWN
	.byte	4,6,25,25		; BOX
	.byte	5,26,24,37		; BOX
	.byte	17,38,24,40		; BOX
	.byte	VLIN,6,19,32
	.byte	20,34,31		; VLIN
	.byte	SET_COLOR | WHITE
	.byte	19,30,4			; VLIN
	.byte	SET_COLOR | BLACK
	.byte	PLOT,35,40
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX, 7,21,8,22
	.byte	12,22,13,24		; BOX
	.byte	SET_COLOR | GREY1
	.byte	VLIN,31,34,4
	.byte	HLIN,4,7,35
	.byte	HLIN_ADD,4,10	; 36
	.byte	4,13		; HLIN_ADD 37
	.byte	6,16		; HLIN_ADD 38
	.byte	8,19		; HLIN_ADD 39
	.byte	11,22		; HLIN_ADD 40
	.byte	13,33		; HLIN_ADD 41
	.byte	PLOT,35,31
	.byte	HLIN_ADD,34,35		; 32 right=35
	.byte	HLIN_ADD_RSAME,33	; 33
	.byte	31		; HLIN_ADD_RSAME 34
	.byte	31		; HLIN_ADD_RSAME 35
	.byte	30		; HLIN_ADD_RSAME 36
	.byte	29		; HLIN_ADD_RSAME 37
	.byte	28		; HLIN_ADD_RSAME 38
	.byte	27		; HLIN_ADD_RSAME 39
	.byte	HLIN_ADD,26,34	; 40
	.byte	BOX,10,23,12,25
	.byte	HLIN,7,8,20
	.byte	7,8,24		; HLIN
	.byte	12,13,26	; HLIN
	.byte	PLOT,9,21
	.byte	13,27		; PLOT
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,7,8,25
	.byte	VLIN,22,24,9
	.byte	23,27,14	; VLIN
	.byte	PLOT,13,25
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,11,24
	.byte	SET_COLOR | RED
	.byte	7,22		; PLOT
	.byte	HLIN, 7,8,23
	.byte END

	; 797 - 81d = 134 bytes
