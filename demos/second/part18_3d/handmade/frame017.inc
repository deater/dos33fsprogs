frame17:
	.byte	SET_COLOR | WHITE					; 1
	.byte	BOX, 4, 6, 23,41					; 6
	.byte	SET_COLOR | BROWN					; 7
	.byte	24, 6, 35,36		; BOX				; 11
	.byte	SET_COLOR | GREY1					; 12
	.byte	26, 20, 32, 21		; BOX				; 16
	.byte	24, 36, 30, 40		; BOX				; 20
	.byte	29, 37, 35, 41		; BOX				; 24
	.byte	HLIN, 27, 31, 19					; 28
	.byte	SET_COLOR | RED						; 29
	.byte	26, 32, 22		; HLIN				; 32
	.byte	SET_COLOR | MEDIUM_BLUE					; 33
	.byte	BOX, 33, 11, 35, 17					; 38
	.byte	33, 25, 35, 30		; BOX				; 42
	.byte	SET_COLOR | LIGHT_BLUE					; 43
	.byte	HLIN, 26, 32, 23					; 47
	.byte	HLIN_ADD, 27, 31	; 24				; 50
	.byte END							; 51

	; 51 bytes
