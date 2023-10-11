frame31:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,30,39
	.byte	16,40,30,41		; BOX
	.byte	SET_COLOR | WHITE
	.byte	31,6,35,41		; BOX
	.byte	4,17,6,18		; BOX
	.byte	4,19,7,22		; BOX
	.byte	SET_COLOR | GREY1
	.byte	4,23,7,39		; BOX
	.byte	4,37,10,39		; BOX
	.byte	HLIN,8,10,37
	.byte	HLIN_ADD,8,12	; 38
	.byte	8,14			; HLIN_ADD 39
	.byte	5,15			; HLIN_ADD40
	.byte	7,17			; HLIN_ADD 41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	VLIN,4,25,26
	.byte	SET_COLOR | RED
	.byte	PLOT,4,27
	.byte	SET_COLOR | WHITE
	.byte	VLIN,4,28,29
	.byte END

	; 8db - 917 = 60 bytes
