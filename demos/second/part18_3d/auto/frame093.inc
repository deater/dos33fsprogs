	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,35,23
	.byte BOX_ADD_RSAME,9,31
	.byte 34,41	; 35 32
	.byte SET_COLOR | GREY1
	.byte BOX,13,10,25,13
	.byte 7,13,8,23
	.byte 15,14,16,30
	.byte 22,14,23,30
	.byte 18,22,19,29
	.byte 18,29,20,30
	.byte 4,35,18,41
	.byte 24,35,29,36
	.byte BOX_ADD_RSAME,25,41
	.byte HLIN,4,7,24
	.byte 7,8,30
	.byte HLIN_ADD,6,29	; 31
	.byte VLIN,15,6,9
	.byte 19,6,9
	.byte 23,6,9
	.byte PLOT,8,29
	.byte SET_COLOR | GREEN
	.byte BOX,29,6,33,40
	.byte HLIN,30,33,41
	.byte SET_COLOR | BROWN
	.byte 18,20,29
	.byte 18,20,31
	.byte VLIN,9,6,11
	.byte VLIN_ADD,12,30	; 10
	.byte VLIN,15,14,31
	.byte 22,14,31
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,7,13,8,22
	.byte VLIN,7,6,12
	.byte PLOT,7,23
	.byte END
; total size = 116
