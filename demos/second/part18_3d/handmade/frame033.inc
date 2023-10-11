frame33:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4,6,35,32
	.byte	13,33,35,41		; BOX
	.byte	SET_COLOR | WHITE
	.byte	8,16,11,18		; BOX
	.byte	7,20,12,21		; BOX
	.byte	HLIN,8,12,19
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	BOX,7,22,12,33
	.byte	4,26,5,27		; BOX
	.byte	PLOT,4,30
	.byte	SET_COLOR | GREY1
	.byte	4,31			; PLOT
	.byte	HLIN,4,5,32
	.byte	HLIN_ADD,4,6	; 33
	.byte	HLIN,9,12,33
	.byte	BOX,4,34,12,37
	.byte	HLIN,5,14,38
	.byte	HLIN_ADD,6,15	; 39
	.byte	7,17		; HLIN_ADD 40
	.byte	8,17		; HLIN_ADD 41
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	PLOT,5,6
	.byte	VLIN,5,11,16
	.byte	5,22,25		; VLIN
	.byte	SET_COLOR | RED
	.byte	HLIN,4,5,28
	.byte	SET_COLOR | WHITE
	.byte	4,5,29		; HLIN
	.byte END

	; 955 - 9ac = 87
