frame22:
	.byte	SET_COLOR | GREY1
	.byte	BOX, 4,6,31,41
	.byte	SET_COLOR | BROWN
	.byte	32, 6, 35, 32		; BOX
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	4,  6,  5, 14		; BOX
	.byte	12, 7, 15, 15		; BOX
	.byte	20, 8, 23, 16		; BOX
	.byte	4, 25,  5, 35		; BOX
	.byte	11,25, 15, 34		; BOX
	.byte	20,25, 22, 33		; BOX
	.byte	SET_COLOR | GREY1
	.byte	32,22,35,25		; BOX
	.byte	32,32,33,41		; BOX
	.byte	34,33,35,41		; BOX
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	30,20,33,21		; BOX
	.byte	30,24,31,26		; BOX
	.byte	HLIN, 30,31,19
	.byte	PLOT, 32,25
	.byte	SET_COLOR | ORANGE
	.byte	HLIN, 33,34,24
	.byte	PLOT, 33,23
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN, 29,19,26
	.byte	HLIN, 30,32,22
	.byte	HLIN_ADD, 30,31		; 23
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	PLOT, 31,22
	.byte	SET_COLOR | BLACK
	.byte	BOX, 31,34, 33,35
	.byte	32,35, 35,36		; BOX
	.byte	HLIN, 34,35,37
	.byte END

	; 4e3 - 47c	103 bytes
