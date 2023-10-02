frame20:
	.byte	SET_COLOR | BROWN
	.byte	BOX, 4, 6, 35,41
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	18, 9, 21, 17		; BOX
	.byte	26, 10, 29, 17		; BOX 
	.byte	34, 10, 35, 17		; BOX
	.byte	18, 26, 21, 33		; BOX
	.byte	25, 26, 29, 33		; BOX 
	.byte	34, 30, 35, 34		; BOX
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	31, 21, 35, 27		; BOX
	.byte	HLIN, 32, 35, 20
	.byte	34, 35, 29		; HLIN
	.byte	SET_COLOR | GREY1
	.byte	BOX, 34, 22, 35, 28
	.byte	HLIN, 32, 35, 24
	.byte	4,6,39			; HLIN
	.byte	HLIN_ADD, 4,19		; 40
	.byte	4,29			; HLIN_ADD 41
	.byte	SET_COLOR | RED
	.byte	HLIN, 34, 35, 26
	.byte	SET_COLOR | ORANGE
	.byte	PLOT, 33, 25
	.byte END

	; 71 bytes
