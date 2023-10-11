frame46:
	.byte	SET_COLOR | WHITE
	.byte	BOX,4,6,21,21
	.byte	SET_COLOR | GREY1
	.byte	21,33,35,41
	.byte	PLOT,35,26
	.byte	HLIN_ADD,33,35		; 27
	.byte	HLIN_ADD_RSAME,31	; 28
	.byte	29			; 29
	.byte	27			; 30
	.byte	26			; 31
	.byte	24			; 32
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX,34,6,35,13
	.byte	SET_COLOR | BROWN
	.byte	22,6,28,8
	.byte	21,9,28,10
	.byte	26,11,29,12
	.byte	20,13,29,14
	.byte	20,15,30,24
	.byte	SET_COLOR | DARK_BLUE
	.byte	29,6,33,10
	.byte	30,11,33,14
	.byte	31,15,33,16
	.byte	31,17,32,18
	.byte	VLIN,34,12,14
	.byte	SET_COLOR | PINK
	.byte	21,13,19		; VLIN
	.byte	22,20,24		; VLIN
	.byte	SET_COLOR | ORANGE
	.byte	24,15,19		; VLIN
	.byte	25,20,22		; VLIN
	.byte	SET_COLOR | GREEN
	.byte	HLIN,23,24,7
	.byte	HLIN_ADD,22,24	; 8
	.byte	22,25		; 9
	.byte	BOX,21,10,22,12
	.byte	HLIN,31,32,19
	.byte	HLIN_ADD_RSAME,29	; 20
	.byte	27			; 21
	.byte	26			; 22
	.byte	24			; 23
	.byte	23			; 24
	.byte	HLIN_ADD,21,31		; 25
	.byte	HLIN_ADD_LSAME,29	; 26
	.byte	27			; 27
	.byte	26			; 28
	.byte	24			; 29
	.byte	22			; 30
	.byte	SET_COLOR | GREY1
	.byte	HLIN,26,27,6
	.byte	SET_COLOR|LIGHT_BLUE
	.byte	PLOT,28,6
	.byte	PLOT,26,7
	.byte	HLIN,18,19,17		; 17
	.byte	HLIN_ADD,14,19		; 18
	.byte	12,19			; 19
	.byte	9,19			; 20
	.byte	6,20			; 21
	.byte	BOX,4,22,20,26
	.byte	4,27,21,39
	.byte	4,40,20,41
	.byte	SET_COLOR|LIGHT_GREEN
	.byte	PLOT,23,15
	.byte	24,9
	.byte	HLIN_ADD,23,25
	.byte	BOX,22,11,25,14
	.byte END

	; 1069 - 1115 = 172 bytes
