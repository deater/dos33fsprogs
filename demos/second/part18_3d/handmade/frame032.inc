frame32:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,33,39
	.byte	16,40,33,41		; BOX
	.byte	SET_COLOR | WHITE
	.byte	34,6,35,41		; BOX
	.byte	6,16,8,17		; BOX
	.byte	5,18,9,19		; BOX
	.byte	4,20,9,21		; BOX
	.byte	PLOT,5,17
	.byte	SET_COLOR | GREY1
	.byte	BOX,4,22,9,39
	.byte	4,22,9,39		; BOX
	.byte	PLOT,10,37
	.byte	HLIN_ADD,10,12
	.byte	10,14			; HLIN_ADD
	.byte	6,15			; HLIN_ADD
	.byte	7,16			; HLIN_ADD
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	VLIN,25,29,4
	.byte	SET_COLOR | RED
	.byte	PLOT,4,28
	.byte END

	; 917 - 955 = 62
