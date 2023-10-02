	.byte SET_COLOR | BROWN
	.byte BOX,19,6,35,38
	.byte SET_COLOR | WHITE
	.byte 4,6,18,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 29,21,32,32
	.byte 29,11,32,18
	.byte SET_COLOR | GREY1
	.byte 19,39,35,41
	.byte 27,21,34,25
	.byte HLIN,19,23,37
	.byte HLIN_ADD_LSAME,28 ; 19, 28, 38
	.byte HLIN,28,31,20
	.byte SET_COLOR | GREY2
	.byte 19,34,40
	.byte SET_COLOR | LIGHT_BLUE
	.byte 27,34,25
	.byte HLIN_ADD,28,33	; 26
	.byte SET_COLOR | RED
	.byte HLIN,27,34,24
	.byte END
; total size = 56
