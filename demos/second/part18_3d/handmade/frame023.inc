frame23:
	.byte	SET_COLOR | GREY1
	.byte	BOX, 4,6,18,41
	.byte	SET_COLOR | BROWN
	.byte	19, 6, 34, 35			; BOX
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	7, 6, 9, 15			; BOX
	.byte	6,26, 9, 34			; BOX
	.byte	SET_COLOR | GREY1
	.byte	20,32,23,41			; BOX
	.byte	24,33,25,41			; BOX
	.byte	26,34,29,41			; BOX
	.byte	30,35,32,41			; BOX
	.byte	33,36,35,41			; BOX
	.byte	VLIN, 20,41,19
	.byte	26,35,34			; VLIN
	.byte	6,35,35				; VLIN
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX, 24,19,25,24
	.byte	31,20,33,25			; BOX
	.byte	VLIN, 21,22,26
	.byte	PLOT, 32,19
	.byte	SET_COLOR | GREY1
	.byte	VLIN, 17,23,24
	.byte	BOX, 27,21, 31,23
	.byte	PLOT, 24,17
	.byte	31,20				; PLOT
	.byte	SET_COLOR | ORANGE
	.byte	HLIN, 28,29,22
	.byte	SET_COLOR | RED
	.byte	PLOT, 24,21
	.byte	HLIN, 32,33,23
	.byte	SET_COLOR | BLACK
	.byte	BOX, 18,33,20,35
	.byte	20,34,22,36			; BOX
	.byte	23,35,25,37			; BOX
	.byte	25,36,27,38			; BOX
	.byte	27,37,30,39			; BOX
	.byte	29,38,32,40			; BOX
	.byte	31,39,35,41			; BOX
	.byte END

	; 563 - 4e4 = 127
