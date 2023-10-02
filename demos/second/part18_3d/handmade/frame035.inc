frame35:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 7,6,18,33
	.byte	19,6,35,41		; BOX
	.byte	SET_COLOR | WHITE
	.byte	14,16,17,19		; BOX
	.byte	14,20,18,21		; BOX
	.byte	HLIN, 15,16,15
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	PLOT,12,6
	.byte	VLIN,10,15,12
	.byte	21,25,12		; VLIN
	.byte	6,7,10			; VLIN
	.byte	11,16,10		; VLIN
	.byte	21,23,10		; VLIN
	.byte	6,8,8			; VLIN
	.byte	12,17,8			; VLIN
	.byte	12,17,8			; VLIN
	.byte	PLOT,8,21
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,4,39,5,41
	.byte	6,22,8,26		; BOX
	.byte	HLIN,9,11,25
	.byte	HLIN_ADD,9,12	; 26
	.byte	HLIN,9,10,28
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,4,6,6,23
	.byte	HLIN,7,8,24
	.byte	PLOT,8,27
	.byte	SET_COLOR | GREY1
	.byte	BOX,14,22,18,33
	.byte	4,25,5,26		; BOX
	.byte	HLIN,4,7,27
	.byte	HLIN_ADD,5,8	; 28
	.byte	5,10		; HLIN_ADD 29
	.byte	6,10		; HLIN_ADD 30
	.byte	6,11		; HLIN_ADD 31
	.byte	7,12		; HLIN_ADD 32
	.byte	7,12		; HLIN_ADD 33
	.byte	8,18		; HLIN_ADD 34 rsame 18
	.byte	HLIN_ADD_RSAME,8	; 35
	.byte	8	; HLIN_ADD_RSAME 36
	.byte	9	; 37
	.byte	9	; 38
	.byte	10	; 39
	.byte	HLIN_ADD,10,19		; 40
	.byte	11,20		; HLIN_ADD 41
	.byte	SET_COLOR | ORANGE
	.byte	VLIN,25,26,8
	.byte	SET_COLOR | RED
	.byte	HLIN,9,12,27
	.byte	SET_COLOR | WHITE
	.byte	9,10,24		; HLIN
	.byte	11,12,28	; HLIN
	.byte END

	; a20 - ab3 = 147
