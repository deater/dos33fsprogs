frame49:
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,33,6,35,24	
	.byte	SET_COLOR | BROWN
	.byte	21,6,32,12
	.byte	20,13,33,18
	.byte	20,19,34,24
	.byte	19,25,35,27
	.byte	HLIN,19,34,28
	.byte	HLIN_ADD_LSAME,33	; 29
	.byte	31			; 30
	.byte	29			; 31
	.byte	27			; 32
	.byte	25			; 33
	.byte	24			; 34
	.byte	22			; 35
	.byte	21			; 36
	.byte	SET_COLOR | WHITE
	.byte	BOX,4,6,22,11
	.byte	4,12,20,15
	.byte	4,16,19,26
	.byte	4,27,18,31
	.byte	PLOT,28,7
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,16,18,27
	.byte	HLIN_ADD_RSAME,14	; 28
	.byte	11
	.byte	9
	.byte	6
	.byte	BOX,4,32,18,35
	.byte	4,36,19,41
	.byte	HLIN,27,30,6
	.byte	HLIN_ADD,26,27
	.byte	SET_COLOR | ORANGE
	.byte	VLIN,28,26,31
	.byte	27,23,25		; VLIN
	.byte	SET_COLOR | PINK
	.byte	22,7,12			; VLIN
	.byte	VLIN_ADD,13,18		; VLIN_ADD 23
	.byte	21,25			; VLIN_ADD 24
	.byte	26,31			; VLIN_ADD 25
	.byte	32,33			; VLIN_ADD 26
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,19,29,32
	.byte	21,13,14		; VLIN 
	.byte	21,19,22		; VLIN
	.byte	22,20,22		; VLIN
	.byte	BOX,22,27,23,30
	.byte	SET_COLOR | GREEN
	.byte	HLIN,34,35,30
	.byte	HLIN_ADD_RSAME,32
	.byte	30
	.byte	28
	.byte	27
	.byte	25
	.byte	23
	.byte	21
	.byte	BOX,20,38,35,41
	.byte	25,14,28,15
	.byte	24,16,27,19
	.byte	HLIN,26,27,13
	.byte	23,24,19
	.byte	SET_COLOR | GREY1
	.byte	24,26,6
	.byte	SET_COLOR | LIGHT_GREEN
	.byte	VLIN,18,26,27
	.byte	19,21,26
	.byte	25,19,24
	.byte	26,18,23
	.byte	28,15,16
	.byte	BOX,27,17,29,22
	.byte	PLOT,24,20
	.byte	END		

	; 12af - 136c = 186
