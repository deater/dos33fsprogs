	.byte SET_COLOR | GREEN
	.byte BOX,26,6,35,33
	.byte SET_COLOR | DARK_BLUE
	.byte 13,6,25,25
	.byte 29,6,32,30
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 4,6,10,41
	.byte SET_COLOR | GREY1
	.byte 15,9,23,11
	.byte BOX_ADD,16,17,24	; 12
	.byte BOX,21,12,22,24
	.byte 11,27,18,36
	.byte 23,27,25,29
	.byte 24,31,32,32
	.byte 25,35,35,37
	.byte 11,37,17,41
	.byte HLIN,11,25,25
	.byte 24,28,30
	.byte 31,32,30
	.byte 24,33,33
	.byte HLIN_ADD_LSAME,35 ; 24, 35, 34
	.byte VLIN,6,8,16
	.byte 19,24,19
	.byte 6,8,19
	.byte 6,8,22
	.byte SET_COLOR | BROWN
	.byte BOX,11,6,12,25
	.byte VLIN,12,25,16
	.byte 12,25,21
	.byte PLOT,19,23
	.byte 19,25
	.byte END
; total size = 101
