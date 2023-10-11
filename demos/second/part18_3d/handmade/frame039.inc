frame39:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 9,6,35,35
	.byte	24,36,35,41		; BOX
	.byte	SET_COLOR | WHITE
	.byte	HLIN,20,21,10
	.byte	HLIN_ADD,18,21	; 11
	.byte	HLIN,17,22,15
	.byte	BOX,18,12,22,14
	.byte	17,16,23,20
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	4,6,5,23
	.byte	4,26,5,27
	.byte	SET_COLOR | DARK_BLUE
	.byte	6,6,8,24
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,11,10,15
	.byte	11,20,25
	.byte	13,8,14
	.byte	13,21,27
	.byte	15,6,13
	.byte	15,21,28
	.byte	SET_COLOR | GREY1
	.byte	BOX,17,21,23,35
	.byte	10,36,23,41
	.byte	HLIN,5,6,24
	.byte	HLIN_ADD,6,7	; 25
	.byte	8,9	; 26
	.byte	6,10	; 27
	.byte	6,11	; 28
	.byte	6,11	; 29
	.byte	7,12	; 30
	.byte	7,12	; 31
	.byte	7,13	; 32
	.byte	8,14	; 33
	.byte	8,14	; 34
	.byte	8,15	; 35
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,17,23,36
	.byte	21,22,20
	.byte	HLIN_ADD,20,23	; 21
	.byte	HLIN,20,23,24
	.byte	VLIN,20,21,24
	.byte	23,24,26
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,21,22,23,23
	.byte	SET_COLOR | ORANGE
	.byte	VLIN,22,23,24
	.byte END

	; c75 - cfd = 136
