frame37:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 12,6,35,32
	.byte	23,33,35,41		; BOX
	.byte	SET_COLOR | WHITE
	.byte	19,14,21,17		; BOX
	.byte	18,19,22,20		; BOX
	.byte	HLIN,18,21,18
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	13,14,6			; HLIN
	.byte	PLOT,14,11
	.byte	BOX,13,12,14,15
	.byte	HLIN,14,16,21
	.byte	VLIN,9,14,16
	.byte	SET_COLOR | GREY1
	.byte	BOX,18,21,22,32
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	4,6,8,22		; BOX
	.byte	14,22,17,25		; BOX
	.byte	HLIN,7,8,25
	.byte	18,22,33		; HLIN
	.byte	PLOT,18,23
	.byte	HLIN,19,20,25
	.byte	17,19,27		; HLIN
	.byte	HLIN_ADD,18,19	; 28
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,9,6,11,23
	.byte	HLIN,15,16,23
	.byte	HLIN_ADD,17,19
	.byte	PLOT,17,25
	.byte	SET_COLOR | GREY1
	.byte	PLOT,9,23
	.byte	15,21			; PLOT
	.byte	17,33			; PLOT
	.byte	HLIN,4,6,23
	.byte	BOX,4,25,5,27
	.byte	4,29,5,30		; BOX
	.byte	9,25,12,26		; BOX
	.byte	10,27,13,30		; BOX
	.byte	11,30,15,34		; BOX
	.byte	12,32,16,38		; BOX
	.byte	13,34,22,41		; BOX
	.byte	VLIN,31,37,4
	.byte	SET_COLOR | ORANGE
	.byte	24,25,16		; VLIN
	.byte	SET_COLOR | RED
	.byte	HLIN,17,19,26
	.byte	SET_COLOR | WHITE
	.byte	VLIN,26,27,20
	.byte END

	; b4e - be8 = 154
