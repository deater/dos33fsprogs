frame50:
	.byte	SET_COLOR | BROWN
	.byte	BOX,18,6,35,32
	.byte	HLIN,14,34,33
	.byte	HLIN_ADD_LSAME,33	; 34
	.byte	31
	.byte	28
	.byte	27
	.byte	25
	.byte	23
	.byte	22
	.byte	20
	.byte	SET_COLOR | GREEN
	.byte	HLIN,34,35,35
	.byte	HLIN_ADD_RSAME,32
	.byte	30
	.byte	28
	.byte	27
	.byte	25
	.byte	23
	.byte	BOX,17,30,18,32
	.byte	16,22,20,26
	.byte	17,18,19,21
	.byte	26,19,27,22
	.byte	27,16,28,18
	.byte	28,15,31,16
	.byte	31,17,32,18
	.byte	29,13,30,14
	.byte	PLOT,20,21
	.byte	29,17
	.byte	SET_COLOR | WHITE
	.byte	BOX,4,6,18,8
	.byte	4,9,17,17
	.byte	4,18,16,21
	.byte	4,22,15,26
	.byte	4,27,14,31
	.byte	4,32,13,37
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	VLIN,14,36,39	
	.byte	15,36,38	; VLIN
	.byte	17,34,36	; VLIN
	.byte	VLIN_ADD,9,11	; VLIN_ADD 18
	.byte	16,18		; VLIN_ADD 19
	.byte	15,18		; VLIN_ADD 20
	.byte	23,26		; VLIN_ADD 21
	.byte	6,7		; VLIN_ADD 22
	.byte	12,15		; VLIN_ADD 23
	.byte	21,24		; VLIN_ADD 24
	.byte	29,33		; VLIN_ADD 25
	.byte	29,32		; VLIN_ADD 26
	.byte	VLIN,19,8,10	; VLIN
	.byte	21,32,35	; VLIN
	.byte	21,6,8		; VLIN
	.byte	22,31,34	; VLIN
	.byte	22,13,15	; VLIN
	.byte	25,21,23	; VLIN
	.byte	SET_COLOR | ORANGE
	.byte	18,32,36	; VLIN
	.byte	19,37,41	; VLIN
	.byte	30,25,29	; VLIN
	.byte	31,30,34	; VLIN
	.byte	SET_COLOR | PINK
	.byte	25,6,14		; VLIN
	.byte	VLIN_ADD,15,18	; VLIN_ADD 26
	.byte	24,28		; VLIN_ADD 27
	.byte	29,34		; VLIN_ADD 28
	.byte	35,36		; VLIN_ADD 29
	.byte	SET_COLOR | LIGHT_GREEN
	.byte	BOX,15,27,16,34
	.byte	19,24,20,32
	.byte	17,25,18,29
	.byte	28,19,32,24
	.byte	VLIN,14,32,33
	.byte	PLOT,17,33
	.byte	18,23
	.byte	20,23
	.byte	30,17
	.byte	28,26
	.byte	18,24
	.byte	17,30
	.byte	HLIN,29,31,18
	.byte	28,29,25
	.byte	VLIN,27,20,23
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,12,13,34
	.byte	HLIN_ADD_RSAME,10
	.byte	7
	.byte	6
	.byte	BOX,4,38,13,41
	.byte	HLIN,29,30,6
	.byte	PLOT,28,7
	.byte	27,8
	.byte	SET_COLOR | RED
	.byte	HLIN,26,27,6
	.byte	SET_COLOR | GREY1
	.byte	26,27,7
	.byte	PLOT,28,6
	.byte	END

	; 253 bytes
