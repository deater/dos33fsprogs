	.byte SET_COLOR | GREY1
	.byte BOX,4,22,16,39
	.byte HLIN,6,16,40
	.byte HLIN_ADD_RSAME,7	; 7 16 41
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,35,21
	.byte BOX_ADD_RSAME,34,41
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,33,15
	.byte BOX_ADD_RSAME,9,17
	.byte 10,36	; 33 18
	.byte HLIN,11,33,37
	.byte HLIN_ADD_RSAME,13	; 13 33 38
	.byte 15	; 15 33 39
	.byte 16	; 16 33 40
	.byte 17	; 17 33 41
	.byte HLIN,4,5,16
	.byte VLIN,17,19,4
	.byte SET_COLOR | LIGHT_BLUE
	.byte 25,29,4
	.byte SET_COLOR | RED
	.byte PLOT,4,28
	.byte END
; total size = 58
