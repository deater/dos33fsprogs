frame16:
	.byte	SET_COLOR | WHITE
	.byte	BOX, 4, 6, 27,41
	.byte	SET_COLOR | BROWN
	.byte	28, 6, 35,34		; BOX
	.byte	SET_COLOR | GREY1
	.byte	28, 19, 33, 21		; BOX
	.byte	28, 35, 35, 38		; BOX
	.byte	HLIN, 28, 31, 18
	.byte	28, 30, 34		; HLIN
	.byte	33, 35, 39		; HLIN
	.byte	SET_COLOR | RED
	.byte	28, 32, 21		; HLIN
	.byte	SET_COLOR | LIGHT_BLUE
	.byte	28, 33, 22		; HLIN
	.byte	HLIN_ADD, 28, 30	; 23
	.byte	END

	; 42 bytes
