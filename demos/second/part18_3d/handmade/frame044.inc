frame44:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,21,21
	.byte	SET_COLOR | BROWN
	.byte	22,6,31,11
	.byte	20,11,32,15
	.byte	HLIN,20,31,16
	.byte	HLIN_ADD,20,29	; 17
	.byte	21,27	; 18	set left 21
	.byte	HLIN_ADD_LSAME,26	; 19
	.byte	24	; 20
	.byte	22	; 21
	.byte	SET_COLOR | GREY1
	.byte	BOX,33,12,34,14
	.byte	25,6,27,7
	.byte	PLOT,28,6
	.byte	HLIN,34,35,23		; set right 35
	.byte	HLIN_ADD_RSAME,32	; 24
	.byte	30	; 25
	.byte	28	; 26
	.byte	26	; 27
	.byte	24	; 28
	.byte	BOX,17,29,35,41
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,30,31,6
	.byte	BOX,25,8,27,9
	.byte	HLIN,18,19,15
	.byte	HLIN_ADD,16,19		; 16	set right 19
	.byte	HLIN_ADD_RSAME,14	; 17
	.byte	HLIN_ADD,12,20		; 18	set right 20
	.byte	HLIN_ADD_RSAME,9	; 19
	.byte	7	; 20
	.byte	5	; 21
	.byte	BOX,4,22,21,28
	.byte	HLIN,4h,22,29	; Set left 4
	.byte	HLIN_ADD_LSAME,22	; 30
	.byte	22	; 31
	.byte	21	; 32
	.byte	21	; 33
	.byte	20	; 34
	.byte	20	; 35
	.byte	19	; 36
	.byte	19	; 37
	.byte	18	; 38
	.byte	17	; 39
	.byte	17	; 40
	.byte	16	; 41
	.byte	SET_COLOR | GREEN
	.byte	BOX,22,23,24,26
	.byte	24,22,26,25
	.byte	25,21,27,24
	.byte	27,20,29,23
	.byte	28,19,31,22
	.byte	30,18,33,21
	.byte	33,16,34,17
	.byte	PLOT,32,17
	.byte	23,8
	.byte	VLIN,6,12,24
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,32,6,35,11
	.byte	HLIN,32,33,12
	.byte	SET_COLOR | ORANGE
	.byte	VLIN,12,14,26
	.byte	15,18,27
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	9,11,21
	.byte	8,10,22
	.byte	15,18,22
	.byte	14,17,23
	.byte	SET_COLOR | PINK
	.byte	6,7,23
	.byte	13,14,24
	.byte	15,19,25
	.byte	SET_COLOR | LIGHT_GREEN
	.byte	BOX,25,10,27,11
	.byte	PLOT,25,12
	.byte	SET_COLOR | YELLOW
	.byte	29,6
	.byte	SET_COLOR | RED
	.byte	HLIN,25,26,6
	.byte END

	; ee9 - fb3 = 202 bytes
