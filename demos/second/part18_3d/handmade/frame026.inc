frame26:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,5,41
	.byte	24,6,34,34		; BOX
	.byte	24,30,32,37		; BOX
	.byte	SET_COLOR | BROWN
	.byte	6,6,24,15		; BOX
	.byte	6,16,23,35		; BOX
	.byte	HLIN,20,23,36
	.byte	PLOT,23,37
	.byte	VLIN,30,6,32
	.byte	SET_COLOR | DARK_BLUE
	.byte	35,6,26			; VLIN
	.byte	SET_COLOR | GREY1
	.byte	HLIN,6,7,33
	.byte	HLIN_ADD,6,11	; 34
	.byte	6,15		; HLIN_ADD 35
	.byte	9,19		; HLIN_ADD 36
	.byte	12,22		; HLIN_ADD 37
	.byte	15,31		; HLIN_ADD 38
	.byte	18,30		; HLIN_ADD 39
	.byte	22,29		; HLIN_ADD 40
	.byte	25,29		; HLIN_ADD 41
	.byte	PLOT,6,39
	.byte	HLIN_ADD,6,9	; 40
	.byte	6,11		; HLIN_ADD 41
	.byte	PLOT,35,29
	.byte	HLIN_ADD,33,35	; 30 right=35
	.byte	HLIN_ADD_RSAME,32	; 31
	.byte	31			; HLIN_ADD_RSAME 32
	.byte	HLIN_ADD,30,34		; 33
	.byte	28,34			; HLIN_ADD 34
	.byte	27,33			; HLIN_ADD 35
	.byte	26,32			; HLIN_ADD 36
	.byte	25,32			; HLIN_ADD 37
	.byte	BOX,14,19,17,22
	.byte	18,21,19,23		; BOX
	.byte	HLIN,15,16,23
	.byte	19,22,24		; HLIN
	.byte	PLOT,22,23
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,20,20,21,22
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	VLIN,17,20,24
	.byte	HLIN,20,21,23
	.byte	HLIN_ADD,15,17	; 24
	.byte	20,21		; HLIN_ADD 25
	.byte	HLIN,15,16,18
	.byte	VLIN,22,21,22
	.byte	SET_COLOR | GREY1
	.byte	PLOT,20,22
	.byte	17,22			; PLOT
	.byte	SET_COLOR | ORANGE
	.byte	HLIN,18,19,22
	.byte	SET_COLOR | RED
	.byte	14,16,21		; HLIN
	.byte END

	; 67d - 714 = 151 bytes
