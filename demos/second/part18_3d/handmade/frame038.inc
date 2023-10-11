frame38:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 12,6,35,41
	.byte	SET_COLOR | WHITE
	.byte	19,13,22,17		; BOX
	.byte	19,18,23,20		; BOX
	.byte	HLIN,21,22,12
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	7,8,25			; HLIN
	.byte	BOX, 4,6,8,22
	.byte	SET_COLOR | DARK_BLUE
	.byte	9,6,11,23		; BOX
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,14,10,15
	.byte	VLIN_ADD,9,14		; VLIN_ADD 15
	.byte	8,14			; VLIN_ADD 16
	.byte	VLIN,14,20,24		; VLIN
	.byte	VLIN_ADD,20,25		; VLIN_ADD 15
	.byte	VLIN_ADD,21,26		; VLIN_ADD 16
	.byte	SET_COLOR | GREY1
	.byte	BOX,19,21,23,33
	.byte	12,35,23,41		; BOX
	.byte	11,32,16,36		; BOX
	.byte	10,30,15,31		; BOX
	.byte	10,27,13,29		; BOX
	.byte	9,25,12,26		; BOX
	.byte	4,25,5,27		; BOX
	.byte	VLIN,4,29,32
	.byte	HLIN,4,6,23
	.byte	PLOT,9,23
	.byte	17,34			; PLOT
	.byte	14,29			; PLOT
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,18,19,21		; right 21
	.byte	HLIN_ADD_RSAME,17	; 22
	.byte	17			; 23
	.byte	HLIN_ADD,17,18		; 24
	.byte	BOX,20,22,21,23
	.byte	PLOT,22,25
	.byte	20,26			; PLOT
	.byte	HLIN_ADD,20,22	; 27
	.byte	PLOT,21,28
	.byte	HLIN,19,23,34
	.byte	SET_COLOR | DARK_BLUE
	.byte	18,19,23		; HLIN
	.byte	PLOT,22,24
	.byte	21,25			; PLOT
	.byte	SET_COLOR | ORANGE
	.byte	19,24			; PLOT
	.byte	SET_COLOR | RED
	.byte	20,25			; PLOT
	.byte	HLIN_ADD,21,22	; 26
	.byte END

	; be1 - c75 = 148 bytes
