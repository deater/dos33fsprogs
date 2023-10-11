	.byte SET_COLOR | GREY1
	.byte BOX,4,24,35,39
	.byte HLIN,6,35,40
	.byte HLIN_ADD_RSAME,7	; 7 35 41
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,28,23
	.byte BOX_ADD,6,27,35	; 24
	.byte HLIN,8,27,36
	.byte HLIN_ADD_RSAME,10	; 10 27 37
	.byte 13	; 13 27 38
	.byte 15	; 15 27 39
	.byte 17	; 17 27 40
	.byte 19	; 19 27 41
	.byte SET_COLOR | WHITE
	.byte BOX,29,6,35,18
	.byte BOX_ADD_RSAME,28,37
	.byte BOX,4,19,5,23
	.byte 4,28,5,31
	.byte HLIN,28,34,38
	.byte HLIN_ADD_LSAME,33 ; 28, 33, 39
	.byte 32
	.byte 31
	.byte VLIN,4,17,18
	.byte PLOT,4,24
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,5,28,6,29
	.byte HLIN,5,6,25
	.byte PLOT,6,24
	.byte 4,26
	.byte 6,26
	.byte SET_COLOR | RED
	.byte 6,27
	.byte END
; total size = 86
