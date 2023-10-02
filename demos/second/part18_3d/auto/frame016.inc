	.byte SET_COLOR | WHITE
	.byte BOX,4,6,27,41
	.byte SET_COLOR | BROWN
	.byte 28,6,35,34
	.byte SET_COLOR | GREY1
	.byte BOX_ADD_LSAME,35,38 ; 28, 35
	.byte BOX,28,19,33,22
	.byte HLIN,28,31,18
	.byte 28,30,34
	.byte 33,35,39
	.byte SET_COLOR | LIGHT_BLUE
	.byte 28,33,22
	.byte HLIN_ADD_LSAME,30 ; 28, 30, 23
	.byte SET_COLOR | RED
	.byte HLIN,28,32,21
	.byte END
; total size = 42
