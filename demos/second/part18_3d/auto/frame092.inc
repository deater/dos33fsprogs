	.byte SET_COLOR | DARK_BLUE
	.byte BOX,5,6,35,24
	.byte BOX_ADD_RSAME,10,29
	.byte 32,37	; 35 30
	.byte SET_COLOR | GREEN
	.byte BOX,28,6,31,37
	.byte SET_COLOR | GREY1
	.byte 8,6,9,23
	.byte 13,9,24,12
	.byte BOX_ADD,15,16,28	; 13
	.byte BOX,21,13,22,28
	.byte 6,32,18,39
	.byte 24,32,27,35
	.byte 25,38,35,41
	.byte 6,40,17,41
	.byte 18,21,19,29
	.byte HLIN,6,9,24
	.byte 8,9,28
	.byte HLIN_ADD,7,27	; 29
	.byte HLIN,24,28,36
	.byte HLIN_ADD,25,30	; 37
	.byte HLIN,34,35,37
	.byte VLIN,6,8,16
	.byte 6,8,19
	.byte 6,8,22
	.byte PLOT,9,27
	.byte SET_COLOR | BROWN
	.byte HLIN,18,19,27
	.byte 18,19,29
	.byte VLIN,6,28,11
	.byte 13,29,15
	.byte 13,29,21
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,21,5,41
	.byte VLIN,6,20,4
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,8,6,9,22
	.byte PLOT,8,23
	.byte END
; total size = 127
