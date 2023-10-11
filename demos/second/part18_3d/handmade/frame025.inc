frame25:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,7,41
	.byte	25,6,35,33		; BOX
	.byte	25,34,27,36		; BOX
	.byte	SET_COLOR | BROWN
	.byte	8,6,24,34		; BOX
	.byte	20,35,24,36		; BOX
	.byte	VLIN,31,6,24
	.byte	30,25,32		; VLIN
	.byte	SET_COLOR | GREY1
	.byte	HLIN,8,11,33
	.byte	HLIN_ADD,8,15	; 34
	.byte	10,19		; HLIN_ADD 35
	.byte	14,22		; HLIN_ADD 36
	.byte	17,32		; HLIN_ADD 37
	.byte	20,31		; HLIN_ADD 38
	.byte	23,30		; HLIN_ADD 39
	.byte	26,29		; HLIN_ADD 40
	.byte	HLIN,8,9,38
	.byte	HLIN_ADD,8,11	; 39
	.byte	8,14		; HLIN_ADD 40
	.byte	8,16		; HLIN_ADD 41
	.byte	HLIN,34,35,30		; right=35
	.byte	HLIN_ADD_RSAME,33	; 31
	.byte	31			; HLIN_ADD_RSAME 32
	.byte	30			; HLIN_ADD_RSAME 33
	.byte	HLIN_ADD,28,34		; 34
	.byte	27,33			; HLIN_ADD 35
	.byte	26,32			; HLIN_ADD 36
	.byte	PLOT,35,29
	.byte	BOX,17,18,19,21
	.byte	22,19,24,21		; BOX
	.byte	23,23,24,25		; BOX
	.byte	HLIN,20,21,20
	.byte	PLOT,20,22
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,18,22,19,23
	.byte	21,22,22,23		; BOX
	.byte	VLIN,25,20,23
	.byte	PLOT,17,22
	.byte	20,21			; PLOT
	.byte	23,21			; PLOT
	.byte	HLIN,23,24,22
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,22,22
	.byte	HLIN,21,22,21
	.byte	SET_COLOR | RED
	.byte	PLOT, 25,22
	.byte	19,21			; PLOT
	.byte	HLIN, 17,18,20
	.byte END

	; 5ee - 67d = 143
