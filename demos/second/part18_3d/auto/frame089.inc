	.byte SET_COLOR | GREEN
	.byte BOX,26,6,35,33
	.byte BOX_ADD_RSAME,34,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,12,41
	.byte SET_COLOR | DARK_BLUE
	.byte 13,6,25,23
	.byte 28,6,31,27
	.byte SET_COLOR | GREY1
	.byte 15,8,23,10
	.byte BOX_ADD,16,17,22	; 11
	.byte BOX,23,25,25,26
	.byte 13,26,18,37
	.byte 24,28,31,29
	.byte BOX_ADD_LSAME,33,33 ; 24, 30
	.byte BOX,25,37,33,39
	.byte 12,38,17,39
	.byte BOX_ADD,26,33,41	; 40
	.byte BOX,21,11,22,22
	.byte HLIN,13,25,23
	.byte 23,26,27
	.byte 11,17,40
	.byte HLIN_ADD_RSAME,10	; 10 17 41
	.byte HLIN,30,31,27
	.byte VLIN,17,22,19
	.byte 6,7,16
	.byte 6,7,19
	.byte 6,7,22
	.byte SET_COLOR | BROWN
	.byte 11,23,16
	.byte 11,23,21
	.byte PLOT,19,21
	.byte 19,23
	.byte END
; total size = 109
