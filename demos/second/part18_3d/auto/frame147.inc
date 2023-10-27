	.byte SET_COLOR | GREY1
	.byte BOX,10,26,17,27
	.byte 10,23,12,24
	.byte 16,29,17,30
	.byte HLIN,10,14,25
	.byte 14,17,28
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,26,7,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte 10,26,12,27
	.byte 6,35,8,39
	.byte BOX_ADD_RSAME,5,41
	.byte HLIN,11,13,22
	.byte 17,18,28
	.byte 16,18,31
	.byte 7,8,34
	.byte VLIN,7,30,33
	.byte 12,23,25
	.byte 18,25,27
	.byte 18,29,30
	.byte PLOT,15,30
	.byte SET_COLOR | PINK
	.byte BOX,24,10,25,12
	.byte BOX_ADD_LSAME,26,16 ; 24, 13
	.byte BOX,23,18,27,20
	.byte BOX_ADD_LSAME,28,24 ; 23, 21
	.byte BOX,22,26,29,27
	.byte BOX_ADD_RSAME,21,29
	.byte BOX,21,31,31,33
	.byte 20,35,32,41
	.byte HLIN,23,26,17
	.byte 22,28,25
	.byte 21,30,30
	.byte 20,31,34
	.byte SET_COLOR | RED
	.byte 10,12,24
	.byte PLOT,18,27
	.byte SET_COLOR | YELLOW
	.byte VLIN,15,26,27
	.byte END
; total size = 128
