	.byte SET_COLOR | BROWN
	.byte BOX,4,6,35,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 7,7,11,16
	.byte 16,8,20,16
	.byte 25,9,28,17
	.byte 33,9,35,17
	.byte 33,20,35,33
	.byte 7,25,11,34
	.byte 16,26,20,34
	.byte 25,26,28,34
	.byte SET_COLOR | GREY1
	.byte 32,20,35,24
	.byte SET_COLOR | LIGHT_BLUE
	.byte 31,23,32,24
	.byte BOX_ADD_LSAME,35,26 ; 31, 25
	.byte HLIN,33,35,21
	.byte HLIN_ADD_RSAME,31	; 31 35 22
	.byte HLIN,32,35,27
	.byte SET_COLOR | ORANGE
	.byte VLIN,35,24,26
	.byte END
; total size = 68
