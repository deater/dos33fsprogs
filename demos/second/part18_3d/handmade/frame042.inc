frame42:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,22,24
	.byte	SET_COLOR | BROWN
	.byte	HLIN,4,6,6
	.byte	PLOT,4,7
	.byte	HLIN,20,35,6
	.byte	BOX,21,7,35,8
	.byte	22,9,35,12
	.byte	23,13,35,24
	.byte	24,25,35,34
	.byte	25,35,35,41
	.byte	SET_COLOR | GREY1
	.byte	20,15,21,18
	.byte	21,16,22,20
	.byte	16,35,24,41
	.byte	PLOT,21,14
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	20,19
	.byte	HLIN_ADD,17,20		; 20
	.byte	14,22		; 21 right 22
	.byte	HLIN_ADD_RSAME,11	; 22
	.byte	8	; 23
	.byte	6	; 24
	.byte	BOX,4,25,23,34
	.byte	HLIN,4,22,35		; left 4
	.byte	HLIN_ADD_LSAME,20	; 36
	.byte	19	; 37
	.byte	18	; 38
	.byte	17	; 39
	.byte	16	; 40
	.byte	15	; 41
	.byte	SET_COLOR | RED
	.byte	PLOT,21,18
	.byte	HLIN,20,21,17
	.byte END

	; da4 - e00 = 92 bytes
