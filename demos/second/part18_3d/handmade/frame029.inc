frame29:
	.byte	SET_COLOR | WHITE
	.byte	BOX,27,6,35,41
	.byte	SET_COLOR | BROWN
	.byte	4,6,26,38		; BOX
	.byte	17,39,26,41		; BOX
	.byte	VLIN,6,22,34
	.byte	23,34,33		; VLIN
	.byte	SET_COLOR | WHITE
	.byte	18,30,4			; VLIN
	.byte	SET_COLOR | GREY1
	.byte	VLIN,31,34,4
	.byte	HLIN,4,5,35		; left 4
	.byte	HLIN_ADD_LSAME,8	; 36
	.byte	10			; HLIN_ADD_LSAME 37
	.byte	13			; HLIN_ADD_LSAME 38
	.byte	HLIN_ADD,5,16		; 39
	.byte	8,19			; HLIN_ADD 40
	.byte	10,21			; HLIN_ADD 41
	.byte	PLOT,35,34
	.byte	HLIN,33,35,35		; right 35
	.byte	HLIN_ADD_RSAME,33	; 36
	.byte	32			; HLIN_ADD_RSAME 37
	.byte	31			; HLIN_ADD_RSAME 38
	.byte	30			; HLIN_ADD_RSAME 39
	.byte	28			; HLIN_ADD_RSAME 40
	.byte	28			; HLIN_ADD_RSAME 41
	.byte	BOX,6,23,8,25
	.byte	VLIN,21,27,4
	.byte	24,25,5			; VLIN
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	22,23,5			; VLIN
	.byte	PLOT,9,23
	.byte	8,28			; PLOT
	.byte	HLIN,9,10,24
	.byte	HLIN_ADD,9,10	; 25
	.byte	6,9			; HLIN_ADD 26
	.byte	8,10			; HLIN_ADD 27
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,6,24
	.byte	HLIN_ADD,6,7
	.byte	SET_COLOR | RED
	.byte	PLOT,10,26
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN,23,24,8
	.byte END

	; 81d - 88A = 109 bytes
