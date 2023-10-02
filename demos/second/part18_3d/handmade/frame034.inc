frame34:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,35,31
	.byte	16,32,35,41		; BOX
	.byte	SET_COLOR | WHITE
	.byte	11,16,14,19		; BOX
	.byte	10,20,15,21		; BOX
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	PLOT,7,6
	.byte	VLIN,11,16,8
	.byte	22,25,8			; VLIN
	.byte	6,7,5			; VLIN
	.byte	12,16,6			; VLIN
	.byte	21,25,6			; VLIN
	.byte	13,16,4			; VLIN
	.byte	21,22,4			; VLIN
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	39,41,4			; VLIN
	.byte	BOX,10,22,15,32
	.byte	5,26,7,29		; BOX
	.byte	PLOT,4,23
	.byte	HLIN_ADD,4,5	; 24
	.byte	4,5		; HLIN_ADD 25
	.byte	5,8		; HLIN_ADD 26
	.byte	SET_COLOR | GREY1
	.byte	VLIN,28,29,4
	.byte	HLIN,4,7,30
	.byte	HLIN_ADD,4,8		; 31
	.byte	4,9			; HLIN_ADD 32
	.byte	4,15			; HLIN_ADD 33 right 15
	.byte	HLIN_ADD_RSAME,5	; 34
	.byte	5			; HLIN_ADD_RSAME 35
	.byte	6			; HLIN_ADD_RSAME 36
	.byte	6			; HLIN_ADD_RSAME 37
	.byte	7			; HLIN_ADD_RSAME 38
	.byte	HLIN_ADD,7,16		; 39
	.byte	8,17			; HLIN_ADD 40
	.byte	9,18			; HLIN_ADD 41
	.byte	SET_COLOR | DARK_BLUE
	.byte	VLIN,25,27,4
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,4,26
	.byte	SET_COLOR | RED
	.byte	HLIN,6,8,27
	.byte	SET_COLOR | WHITE
	.byte	6,8,28			; HLIN
	.byte END

	; 9ac - a20 = 116
