frame43:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,22,22
	.byte	SET_COLOR | BROWN
	.byte	23,6,35,18
	.byte	32,19,35,26
	.byte	33,27,35,35
	.byte	34,36,35,41
	.byte	SET_COLOR | GREY1
	.byte	HLIN,31,32,27
	.byte	HLIN_ADD,28,32		; 28	right 32
	.byte	HLIN_ADD_RSAME,25	; 29
	.byte	BOX,21,30,32,35
	.byte	16,36,33,41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,19,20,17		; right 20
	.byte	HLIN_ADD_RSAME,16	; 18
	.byte	14	; 19
	.byte	12	; 20
	.byte	9	; 21
	.byte	7	; 22
	.byte	BOX,4,23,21,33
	.byte	VLIN,22,30,31
	.byte	HLIN,4,21,32		; left 4
	.byte	HLIN_ADD_LSAME,21	; 33
	.byte	20	; 34
	.byte	20	; 35
	.byte	19	; 36
	.byte	18	; 37
	.byte	18	; 38
	.byte	17	; 39
	.byte	16	; 40
	.byte	15	; 41
	.byte	SET_COLOR | GREEN
	.byte	PLOT,31,20
	.byte	HLIN_ADD,29,31	; 21
	.byte	26,31	; 22
	.byte	24,31	; 23
	.byte	22,31	; 24
	.byte	22,30	; 25
	.byte	22,28	; 26
	.byte	22,25	; 27
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN,30,6,16
	.byte	31,17,18
	.byte	SET_COLOR | ORANGE
	.byte	28,13,15
	.byte	29,16,19
	.byte	21,17,22
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX,24,9,25,10
	.byte	22,17,23,20
	.byte	25,15,26,18
	.byte	SET_COLOR | PINK
	.byte	PLOT,26,6
	.byte	VLIN,27,15,18
	.byte	28,19,20
	.byte	SET_COLOR | LIGHT_GREEN
	.byte	21,13,16
	.byte	27,13,14
	.byte	26,7,9
	.byte	PLOT,27,7
	.byte	22,14
	.byte	HLIN,27,29,6
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	VLIN,29,7,13
	.byte	PLOT,24,11
	.byte	HLIN_ADD,24,27	; 12
	.byte	PLOT,24,13
	.byte	SET_COLOR | YELLOW
	.byte	HLIN,26,27,11
	.byte	PLOT,26,12
	.byte	SET_COLOR | GREY1
	.byte	PLOT,23,9
	.byte	BOX,22,10,23,13
	.byte	HLIN,23,24,14
	.byte	PLOT,25,11
	.byte	VLIN,28,7,12
	.byte	27,8,10
	.byte	PLOT,26,10
	.byte	SET_COLOR | RED
	.byte	29,10
	.byte	HLIN,22,23,12
	.byte	SET_COLOR | BROWN
	.byte	BOX,22,15,23,16
	.byte	HLIN,24,27,19
	.byte	HLIN_ADD,23,27	; 20
	.byte	22,25	; 21
	.byte	22,23	; 22
	.byte	PLOT,25,15
	.byte END

	; e00 - ee9 = 233 bytes
