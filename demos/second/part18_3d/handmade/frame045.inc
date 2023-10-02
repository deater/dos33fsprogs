frame45:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,21,20
	.byte	SET_COLOR | GREY1
	.byte	19,29,35,41
	.byte	HLIN,34,35,23
	.byte	HLIN_ADD_RSAME,32	; 24
	.byte	30	; 25
	.byte	29	; 26
	.byte	27	; 27
	.byte	25	; 28
	.byte	SET_COLOR | GREEN
	.byte	PLOT,33,16
	.byte	HLIN_ADD,32,33	; 17
	.byte	HLIN_ADD_RSAME,30	; 18
	.byte	28		; 19
	.byte	HLIN_ADD,27,32	; 20
	.byte	26,32		; 21
	.byte	24,31		; 22
	.byte	22,30		; 23
	.byte	22,28		; 24
	.byte	22,26		; 25
	.byte	23,24		; 26
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,18,20,15
	.byte	HLIN_ADD_RSAME,15	; 16
	.byte	13
	.byte	10
	.byte	8
	.byte	6			; 20
	.byte	BOX,4,21,21,35
	.byte	4,36,20,37
	.byte	4,38,19,39
	.byte	4,40,18,41
	.byte	VLIN,26,33,22
	.byte	SET_COLOR | BROWN
	.byte	BOX,22,6,29,8
	.byte	21,9,31,16
	.byte	HLIN,21,29,17
	.byte	HLIN_ADD,21,27
	.byte	21,25
	.byte	21,23
	.byte	22,23
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,31,6,35,11
	.byte	PLOT,32,12
	.byte	SET_COLOR | GREEN
	.byte	HLIN,23,26,6
	.byte	BOX,22,7,23,10
	.byte	SET_COLOR | LIGHT_GREEN
	.byte	24,7,26,11
	.byte	PLOT,23,13
	.byte	BOX,23,9,24,12
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,27,28,6
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,10,11,21
	.byte	15,18,21
	.byte	SET_COLOR | PINK
	.byte	11,14,22
	.byte	14,18,23
	.byte	19,20,24
	.byte	6,9,30
	.byte	10,14,31
	.byte	SET_COLOR | ORANGE
	.byte	12,16,25
	.byte	17,19,26
	.byte	SET_COLOR | GREY1
	.byte	13,15,32
	.byte	12,14,33
	.byte	PLOT,34,12
	.byte	35,11
	.byte END

	; fb3 - 1069 = 182 bytes
