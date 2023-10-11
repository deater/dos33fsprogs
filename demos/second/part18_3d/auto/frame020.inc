	.byte SET_COLOR | BROWN
	.byte BOX,4,6,35,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 18,9,21,17
	.byte 26,10,29,17
	.byte 34,10,35,17
	.byte 34,20,35,34
	.byte 25,26,29,33
	.byte 18,26,21,33
	.byte SET_COLOR | LIGHT_BLUE
	.byte 31,21,35,27
	.byte HLIN,32,35,20
	.byte 34,35,29
	.byte SET_COLOR | GREY1
	.byte BOX,34,22,35,23
	.byte 34,26,35,28
	.byte HLIN,32,35,24
	.byte HLIN_ADD_RSAME,33	; 33 35 25
	.byte HLIN,4,6,39
	.byte HLIN_ADD_LSAME,19 ; 4, 19, 40
	.byte 29
	.byte SET_COLOR | RED
	.byte HLIN,34,35,26
	.byte SET_COLOR | ORANGE
	.byte PLOT,33,25
	.byte END
; total size = 76
