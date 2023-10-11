frame24:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4,6,10,41
	.byte	28,6,35,24				; BOX
	.byte	27,25,35,35				; BOX
	.byte	SET_COLOR | BROWN
	.byte	11,6,27,18				; BOX
	.byte	11,19,26,31				; BOX
	.byte	15,32,26,34				; BOX
	.byte	HLIN,25,26,35
	.byte	VLIN,34,6,15
	.byte	33,16,32				; VLIN
	.byte	SET_COLOR | GREY1
	.byte	HLIN,11,14,32
	.byte	HLIN_ADD,11,18	; 33
	.byte	14,21		; HLIN_ADD 34
	.byte	17,24		; HLIN_ADD 35
	.byte	19,34		; HLIN_ADD 36
	.byte	22,34		; HLIN_ADD 37
	.byte	25,32		; HLIN_ADD 38
	.byte	28,31		; HLIN_ADD 39
	.byte	HLIN,11,13,37
	.byte	HLIN_ADD,11,16	; 38
	.byte	11,18		; HLIN_ADD 39
	.byte	11,21		; HLIN_ADD 40
	.byte	11,22		; HLIN_ADD 41
	.byte	HLIN,34,35,32
	.byte	HLIN_ADD,32,35	; 33
	.byte	31,35		; HLIN_ADD 34
	.byte	HLIN,29,35,35
	.byte	BOX,20,18,22,22
	.byte	23,20,27,21	; BOX
	.byte	HLIN,20,21,17
	.byte	PLOT,26,19
	.byte	27,23		; PLOT
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN,23,25,22
	.byte	HLIN_ADD,20,22	; 23
	.byte	27,28		; HLIN_ADD 24
	.byte	VLIN,22,19,21
	.byte	28,20,23	; VLIN
	.byte	PLOT,27,19
	.byte	26,23		; PLOT
	.byte	SET_COLOR | ORANGE
	.byte	24,21		; PLOT
	.byte	SET_COLOR | RED
	.byte	28,22		; PLOT
	.byte	HLIN, 20,21,20
	.byte	SET_COLOR | DARK_BLUE
	.byte	26,27,22	; HLIN
	.byte END

	; 563 - 5ee = 139
