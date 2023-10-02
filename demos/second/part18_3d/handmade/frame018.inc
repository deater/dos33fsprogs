frame18:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4, 6, 18,41
	.byte	SET_COLOR | BROWN
	.byte	19, 6, 35,38		; BOX
	.byte	SET_COLOR | GREY1
	.byte	27, 21, 34, 23		; BOX
	.byte	19, 39, 35, 41		; BOX
	.byte	HLIN, 28, 31, 20
	.byte	19, 23, 37		; HLIN
	.byte	HLIN_ADD, 19, 28	; 38
	.byte	SET_COLOR | RED
	.byte	HLIN, 27, 34, 24
	.byte	SET_COLOR | MEDIUM_BLUE
	.byte	BOX, 29, 11, 32, 18
	.byte	29, 27, 32, 32		; BOX 
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	HLIN, 27, 34, 25
	.byte	HLIN_ADD, 28, 33	; 26
	.byte END

	; 54 bytes
