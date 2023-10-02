	.byte SET_COLOR | GREY1
	.byte BOX,4,28,18,33
	.byte BOX_ADD_RSAME,5,35
	.byte 6,37	; 18 36
	.byte 7,39	; 18 38
	.byte HLIN,8,18,40
	.byte HLIN_ADD_RSAME,9	; 9 18 41
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,35,27
	.byte BOX_ADD_RSAME,8,30
	.byte BOX,16,32,35,38
	.byte HLIN,9,35,31
	.byte 17,35,39
	.byte HLIN_ADD_RSAME,18	; 18 35 40
	.byte 19	; 19 35 41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,10,22,15,32
	.byte 4,26,8,27
	.byte 5,27,7,29
	.byte 4,24,5,25
	.byte VLIN,39,41,4
	.byte PLOT,4,23
	.byte SET_COLOR | WHITE
	.byte BOX,10,20,15,21
	.byte 11,16,14,19
	.byte HLIN,6,8,28
	.byte SET_COLOR | MEDIUM_BLUE
	.byte VLIN,11,16,8
	.byte 12,16,6
	.byte 21,25,6
	.byte 13,16,4
	.byte 22,25,8
	.byte 6,7,5
	.byte 21,22,4
	.byte PLOT,7,6
	.byte SET_COLOR | RED
	.byte HLIN,5,8,27
	.byte SET_COLOR | DARK_BLUE
	.byte VLIN,25,27,4
	.byte SET_COLOR | ORANGE
	.byte PLOT,4,26
	.byte END
; total size = 123
