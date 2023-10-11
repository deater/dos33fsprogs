	.byte SET_COLOR | GREY1
	.byte BOX,4,6,35,33
	.byte 4,38,35,41
	.byte 6,34,30,35
	.byte HLIN,4,33,37
	.byte 4,31,36
	.byte 34,35,34
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,5,14
	.byte 12,7,15,15
	.byte 20,8,23,16
	.byte 11,25,15,34
	.byte 20,25,22,33
	.byte 4,25,5,35
	.byte SET_COLOR | LIGHT_BLUE
	.byte 30,19,33,21
	.byte BOX_ADD_LSAME,31,24 ; 30, 22
	.byte 32,26
	.byte SET_COLOR | BROWN
	.byte BOX,32,6,35,19
	.byte BOX_ADD_RSAME,34,21
	.byte BOX,32,26,35,31
	.byte HLIN,34,35,32
	.byte SET_COLOR | DARK_BLUE
	.byte 29,30,22
	.byte HLIN_ADD_LSAME,31 ; 29, 31, 23
	.byte VLIN,29,19,21
	.byte 29,24,26
	.byte PLOT,32,22
	.byte SET_COLOR | ORANGE
	.byte HLIN,33,34,24
	.byte PLOT,33,23
	.byte END
; total size = 103
