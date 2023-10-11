frame41:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,35,41
	.byte	SET_COLOR | GREY1
	.byte	7,21,21,37
	.byte	8,34,22,41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,13,16,6
	.byte	HLIN_ADD,12,17	; 7
	.byte	11,17	; 8
	.byte	10,18	; 9
	.byte	9,18	; 10
	.byte	BOX,8,11,19,12
	.byte	8,13,20,14
	.byte	8,15,21,16
	.byte	7,17,20,20
	.byte	HLIN,7,16,21
	.byte	HLIN_ADD,7,12	; 22
	.byte	7,9	; 23
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN,21,17,23
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	4,30,35
	.byte END

	; d63 - da4 = 65 bytes
