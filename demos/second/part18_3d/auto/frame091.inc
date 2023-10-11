	.byte SET_COLOR | GREEN
	.byte BOX,27,6,35,35
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 4,6,8,41
	.byte SET_COLOR | DARK_BLUE
	.byte 10,6,26,27
	.byte 30,6,34,15
	.byte BOX_ADD_LSAME,33,32 ; 30, 16
	.byte SET_COLOR | GREY1
	.byte BOX,14,9,23,12
	.byte BOX_ADD,15,16,26	; 13
	.byte BOX,21,13,22,26
	.byte 18,19,19,27
	.byte 9,29,18,36
	.byte 24,30,26,31
	.byte 24,33,34,35
	.byte BOX_ADD,25,35,41	; 36
	.byte BOX,9,37,17,41
	.byte HLIN,9,26,27
	.byte 23,26,29
	.byte 24,27,32
	.byte 33,34,32
	.byte VLIN,9,6,23
	.byte 16,6,8
	.byte 19,6,8
	.byte 22,6,8
	.byte 34,30,31
	.byte PLOT,9,26
	.byte SET_COLOR | BROWN
	.byte HLIN,18,19,25
	.byte 18,19,27
	.byte VLIN,11,6,26
	.byte 15,13,27
	.byte 21,13,27
	.byte SET_COLOR | LIGHT_BLUE
	.byte 9,6,22
	.byte END
; total size = 118
