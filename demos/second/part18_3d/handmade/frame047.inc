frame47:
	.byte	SET_COLOR | WHITE
	.byte	BOX,4,6,21,24
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	PLOT,19,19
	.byte	HLIN_ADD,16,19	; 20
	.byte	14,19		; 21
	.byte	11,20		; 22
	.byte	8,20		; 23
	.byte	6,20		; 24
	.byte	BOX,4,25,20,31
	.byte	4,32,21,38
	.byte	4,39,22,41
	.byte	SET_COLOR | GREY1
	.byte	PLOT,35,32
	.byte	HLIN_ADD,33,35	; 33
	.byte	HLIN_ADD_RSAME,31	; 34
	.byte	29			; 35
	.byte	28			; 36
	.byte	26			; 37
	.byte	24			; 38
	.byte	BOX,23,39,35,41
	.byte	SET_COLOR | GREEN
	.byte	PLOT,34,28
	.byte	HLIN,32,33,23
	.byte	HLIN_ADD_RSAME,30
	.byte	28
	.byte	26	; 26
	.byte	25	; 27
	.byte	23	; 28
	.byte	22	; 29
	.byte	HLIN_ADD,21,31
	.byte	21,29	; 31
	.byte	22,27	; 32
	.byte	22,26	; 33
	.byte	22,24	; 34
	.byte	PLOT,22,35
	.byte	SET_COLOR | BROWN
	.byte	BOX,22,6,28,10
	.byte	21,11,29,15
	.byte	20,16,30,21
	.byte	21,22,30,23
	.byte	HLIN,21,28,24
	.byte	HLIN_ADD_LSAME,25
	.byte	24		; 26
	.byte	23		; 27
	.byte	21		; 28	PLOT INSTEAD?
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,29,6,33,11
	.byte	30,12,35,17
	.byte	31,18,32,21
	.byte	PLOT,35,17
	.byte	31,22
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	33,6
	.byte	VLIN,6,12,34
	.byte	6,16,35
	.byte	SET_COLOR | PINK
	.byte	17,22,21
	.byte	23,27,22
	.byte	SET_COLOR | ORANGE
	.byte	19,21,24
	.byte	22,26,25
	.byte	SET_COLOR | GREEN
	.byte	12,16,21
	.byte	BOX,22,11,25,12
	.byte	23,9,24,10
	.byte	SET_COLOR | LIGHT_GREEN
	.byte	24,12,25,17
	.byte	22,13,24,18
	.byte	PLOT,22,19
	.byte	SET_COLOR | WHITE
	.byte	27,7
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	26,7
	.byte	HLIN,27,28,6
	.byte	SET_COLOR | GREY1
	.byte	25,26,6
	.byte	END

	; 1115 - 11d4 = 191 bytes
