frame27:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 25,6,34,30
	.byte	25,31,32,38		; BOX
	.byte	SET_COLOR | BROWN
	.byte	4,6,24,36		; BOX
	.byte	18,37,24,39		; BOX
	.byte	VLIN,30,6,33
	.byte	SET_COLOR | WHITE
	.byte	4,19,30			; VLIN
	.byte	SET_COLOR | DARK_BLUE
	.byte	35,6,27			; VLIN
	.byte	BOX, 15,21,17,23
	.byte	SET_COLOR | GREY1
	.byte	PLOT,4,41
	.byte	35,28			; PLOT
	.byte	35,30			; PLOT
	.byte	VLIN,4,31,33
	.byte	HLIN,4,7,34
	.byte	HLIN_ADD,4,10	; 35
	.byte	4,14		; HLIN_ADD 36
	.byte	6,17		; HLIN_ADD 37
	.byte	9,20		; HLIN_ADD 38
	.byte	12,23		; HLIN_ADD 39
	.byte	16,31		; HLIN_ADD 40
	.byte	18,31		; HLIN_ADD 41
	.byte	HLIN,33,35,31		; right=35
	.byte	HLIN_ADD_RSAME,32	; 32
	.byte	31			; HLIN_ADD_RSAME 33
	.byte	30			; HLIN_ADD_RSAME 34
	.byte	HLIN_ADD,29,34	; 35
	.byte	28,34			; HLIN_ADD 36
	.byte	27,33			; HLIN_ADD 37
	.byte	26,32			; HLIN_ADD 38
	.byte	25,32			; HLIN_ADD 39
	.byte	BOX,11,19,13,23
	.byte	VLIN,10,20,21
	.byte	HLIN,15,18,25
	.byte	HLIN_ADD,16,17	; 26
	.byte	VLIN,18,22,25
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,14,15,22
	.byte	HLIN_ADD,10,12	; 23
	.byte	10,17		; HLIN_ADD 24
	.byte	11,12		; HLIN_ADD 25
	.byte	PLOT,16,23
	.byte	SET_COLOR | ORANGE
	.byte	HLIN,14,15,23
	.byte	SET_COLOR | RED
	.byte	10,12,22	; HLIN
	.byte END

	; 714 - 797 = 131
