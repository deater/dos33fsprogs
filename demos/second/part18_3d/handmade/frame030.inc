frame30:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 28,6,35,41
	.byte	4,17,5,31		; BOX
	.byte	SET_COLOR | BROWN
	.byte	4,6,28,16		; BOX
	.byte	5,17,28,18		; BOX
	.byte	6,19,27,40		; BOX
	.byte	HLIN, 19,27,41
	.byte	SET_COLOR | GREY1
	.byte	BOX,4,32,5,39
	.byte	HLIN,6,7,36		; left 6
	.byte	HLIN_ADD_LSAME,9	; 37
	.byte	12			; HLIN_ADD_LSAME 38
	.byte	14			; HLIN_ADD_LSAME 39
	.byte	16			; HLIN_ADD_LSAME 40
	.byte	HLIN_ADD,7,18	; 41
	.byte	PLOT,35,38
	.byte	HLIN_ADD,34,35		; 39 right 35
	.byte	HLIN_ADD_RSAME,33	; 40
	.byte	32			; HLIN_ADD_RSAME 41
	.byte	BOX,4,25,5,27
	.byte	PLOT,5,24
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,5,28,6,29
	.byte	VLIN,6,24,26
	.byte	PLOT,4,26
	.byte	5,25			; PLOT
	.byte	SET_COLOR | RED
	.byte	6,27			; PLOT
	.byte END

	; 88a - 8db = 81 bytes
