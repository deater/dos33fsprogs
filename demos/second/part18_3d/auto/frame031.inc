	.byte SET_COLOR | GREY1
	.byte BOX,4,32,17,39
	.byte HLIN,5,17,40
	.byte HLIN_ADD_RSAME,7	; 7 17 41
	.byte SET_COLOR | GREY2
	.byte BOX,4,23,7,31
	.byte VLIN,34,35,7
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,30,22
	.byte BOX_ADD_RSAME,8,36
	.byte HLIN,11,30,37
	.byte HLIN_ADD_RSAME,13	; 13 30 38
	.byte 15	; 15 30 39
	.byte 16	; 16 30 40
	.byte 18	; 18 30 41
	.byte SET_COLOR | WHITE
	.byte BOX,31,6,35,41
	.byte 4,19,7,22
	.byte 4,17,6,18
	.byte VLIN,28,29,4
	.byte SET_COLOR | LIGHT_BLUE
	.byte 25,26,4
	.byte SET_COLOR | RED
	.byte PLOT,4,27
	.byte END
; total size = 67
