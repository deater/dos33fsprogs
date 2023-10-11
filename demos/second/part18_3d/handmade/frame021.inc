frame21:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4, 6, 35, 41
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	7,  7, 11, 16		; BOX
	.byte	16, 8, 20, 16		; BOX
	.byte	25, 9, 28, 17		; BOX
	.byte	33, 9, 35, 17		; BOX
	.byte	7, 25, 11, 34		; BOX
	.byte	16,26, 20, 34		; BOX
	.byte	25,26, 28, 34		; BOX
	.byte	33,28, 35, 33		; BOX
	.byte	SET_COLOR | GREY1
	.byte	32,20,35,21		; BOX
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	31, 22, 35,26		; BOX
	.byte	HLIN, 33, 35, 21
	.byte	32, 35, 27		; HLIN
	.byte	SET_COLOR | GREY1
	.byte	BOX, 33,23,35,24
	.byte	SET_COLOR | ORANGE
	.byte	VLIN, 35,24,26
	.byte END

	; 68 bytes
