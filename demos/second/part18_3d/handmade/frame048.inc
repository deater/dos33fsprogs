frame48:
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,4,36,21,41
	.byte	4,30,20,35
	.byte	4,23,19,29
	.byte	SET_COLOR | BROWN
	.byte	19,6,32,23
	.byte	HLIN,20,31,24
	.byte	HLIN_ADD_LSAME,30	; 25
	.byte	29	; 26
	.byte	28	; 27
	.byte	25	; 28
	.byte	25	; 29
	.byte	HLIN,21,22,30
	.byte	PLOT,21,31
	.byte	SET_COLOR | WHITE
	.byte	BOX,4,6,22,7
	.byte	4,8,21,17
	.byte	4,18,19,21
	.byte	HLIN,4,18,22
	.byte	HLIN_ADD_LSAME,15
	.byte	12
	.byte	9
	.byte	7
	.byte	4
	.byte	SET_COLOR | DARK_BLUE
	.byte	BOX,30,6,34,9
	.byte	31,10,35,15
	.byte	32,16,35,19
	.byte	HLIN,32,34,20
	.byte	PLOT,32,21
	.byte	SET_COLOR | GREY1
	.byte	HLIN,26,27,6
	.byte	PLOT,33,21
	.byte	HLIN_ADD,32,34
	.byte	HLIN_ADD,33,34
	.byte	HLIN_ADD,32,33
	.byte	PLOT,31,25
	.byte	35,38
	.byte	HLIN_ADD,33,35
	.byte	HLIN_ADD_RSAME,31
	.byte	29
	.byte	SET_COLOR|GREEN
	.byte	HLIN,33,34,25
	.byte	HLIN_ADD,32,35	; 26
	.byte	HLIN_ADD_RSAME,30	; 27
	.byte	29	; 28
	.byte	27	; 29
	.byte	25	; 30
	.byte	24	; 31
	.byte	22	; 32
	.byte	HLIN_ADD,21,34	; 33
	.byte	HLIN_ADD,21,33	; 34
	.byte	HLIN_ADD,21,31	; 35
	.byte	HLIN_ADD,22,29	; 36
	.byte	HLIN_ADD_LSAME,27 ; 37
	.byte	25
	.byte	24
	.byte	22
	.byte	HLIN,24,25,11
	.byte	BOX,23,12,26,13
	.byte	21,14,25,18
	.byte	SET_COLOR|LIGHT_GREEN
	.byte	23,18,24,21
	.byte	24,16,25,20
	.byte	25,15,26,19
	.byte	VLIN,26,13,14
	.byte	SET_COLOR|MEDIUM_BLUE
	.byte	20,18,20		; VLIN
	.byte	20,25,28		; VLIN
	.byte	21,25,27		; VLIN
	.byte	35,6,10			; VLIN
	.byte	SET_COLOR|ORANGE
	.byte	25,21,25		; VLIN
	.byte	26,26,28		; VLIN
	.byte	SET_COLOR|PINK
	.byte	21,13,16		; VLIN
	.byte	VLIN_ADD,19,24		; VLIN_ADD 22
	.byte	25,30			; VLIN_ADD 23
	.byte	PLOT,21,18
	.byte	SET_COLOR|WHITE
	.byte	27,7
	.byte	SET_COLOR|LIGHT_BLUE
	.byte	28,6
	.byte	HLIN,25,26,7
	.byte	SET_COLOR|GREY1
	.byte	26,27,6
	.byte	END

	; 11d4 - 12af = 218
