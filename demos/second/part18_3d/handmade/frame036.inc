frame36:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 10,6,35,32
	.byte	21,33,35,41		; BOX
	.byte	SET_COLOR | WHITE
	.byte	16,18,20,20		; BOX
	.byte	17,15,19,17		; BOX
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	PLOT,11,7
	.byte	HLIN,11,12,6
	.byte	VLIN,14,10,15
	.byte	14,21,23		; VLIN
	.byte	PLOT,12,11
	.byte	BOX,11,12,12,16
	.byte	HLIN,11,12,21
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,4,6,6,22
	.byte	16,21,20,32		; BOX
	.byte	HLIN,16,18,33
	.byte	5,6,26			; HLIN
	.byte	5,6,40			; HLIN
	.byte	HLIN_ADD,4,6	; 41
	.byte	PLOT,14,24
	.byte	BOX,10,23,13,25
	.byte	12,27,13,28		; BOX
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,7,6,9,23
	.byte	HLIN,11,12,24
	.byte	PLOT,12,26
	.byte	SET_COLOR | GREY1
	.byte	PLOT,6,23
	.byte	HLIN,7,9,25
	.byte	HLIN_ADD,7,10	; 26
	.byte	BOX,8,27,11,29
	.byte	9,30,13,32		; BOX
	.byte	10,33,15,36		; BOX
	.byte	11,37,20,39		; BOX
	.byte	12,40,21,41		; BOX
	.byte	16,34,20,36		; BOX
	.byte	13,25,16,26		; BOX
	.byte	HLIN,19,20,33
	.byte	11,12,22		; HLIN
	.byte	SET_COLOR | ORANGE
	.byte	PLOT,12,25
	.byte	SET_COLOR | RED
	.byte	HLIN,13,16,27
	.byte	SET_COLOR | WHITE
	.byte	14,15,28		; HLIN
	.byte END

	; ab3 - b4e = 155 bytes
