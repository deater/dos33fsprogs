frame40:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,35,41
	.byte	SET_COLOR | WHITE
	.byte	HLIN,19,20,8		; right 20
	.byte	HLIN_ADD_RSAME,17	; 9
	.byte	16	; 10
	.byte	15	; 11
	.byte	HLIN_ADD,15,21		; 12 right 21
	.byte	HLIN_ADD_RSAME,15	; 13
	.byte	15	; 13
	.byte	14	; 14
	.byte	BOX,14,15,22,20
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	21,19,22,23
	.byte	SET_COLOR | DARK_BLUE
	.byte	PLOT,22,18
	.byte	VLIN,19,21,21
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	11,16,6
	.byte	22,27,7
	.byte	7,14,8
	.byte	22,28,9
	.byte	22,29,11
	.byte	PLOT,10,14
	.byte	BOX,10,6,11,13
	.byte	SET_COLOR | GREY1
	.byte	14,21,20,23
	.byte	14,24,22,27
	.byte	14,28,23,41
	.byte	PLOT,4,30
	.byte	HLIN_ADD,4,5		; 31 left 4
	.byte	HLIN_ADD_LSAME,6	; 32
	.byte	7	; 33
	.byte	8	; 34
	.byte	9	; 35
	.byte	10	; 36
	.byte	11	; 37
	.byte	12	; 38
	.byte	12	; 39
	.byte	BOX,4,40,13,41
	.byte	SET_COLOR | RED
	.byte	PLOT,22,21
	.byte END

	; cfd - d63 = 102
