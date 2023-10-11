frame19:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4, 6, 12,41
	.byte	SET_COLOR | BROWN
	.byte	13, 6, 35,40		; BOX
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	25, 11, 28, 18		; BOX
	.byte	33, 11, 35, 18		; BOX 
	.byte	25, 26, 28, 32		; BOX
	.byte	33, 29, 35, 33		; BOX 
	.byte	SET_COLOR | GREY1
	.byte	29, 21, 35, 24		; BOX
	.byte	HLIN, 29, 34, 20
	.byte	13, 18, 38		; HLIN
	.byte	HLIN_ADD, 13, 25	; 39
	.byte	13, 33			; HLIN_ADD 40
	.byte	13, 35			; HLIN_ADD 41
	.byte	SET_COLOR | RED
	.byte	HLIN, 29, 35, 25
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN_ADD, 28, 35	; 26
	.byte	29, 35			; HLIN_ADD 27
	.byte	30, 35			; HLIN_ADD 28
	.byte	VLIN, 28, 21, 26
	.byte END

	; 65 bytes
