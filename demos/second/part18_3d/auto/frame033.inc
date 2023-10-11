	.byte SET_COLOR | BROWN
	.byte BOX,4,6,35,37
	.byte BOX_ADD_RSAME,15,41
	.byte SET_COLOR | GREY1
	.byte BOX,4,33,12,37
	.byte HLIN,4,5,32
	.byte 5,14,38
	.byte HLIN_ADD,6,15	; 39
	.byte 7,17	; 40
	.byte HLIN_ADD_RSAME,8	; 8 17 41
	.byte PLOT,4,31
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,7,22,12,32
	.byte 4,26,5,29
	.byte HLIN,7,8,33
	.byte PLOT,4,30
	.byte SET_COLOR | WHITE
	.byte BOX,8,16,11,18
	.byte 7,20,12,21
	.byte HLIN,8,12,19
	.byte 4,5,29
	.byte SET_COLOR | MEDIUM_BLUE
	.byte VLIN,5,11,16
	.byte 5,22,25
	.byte PLOT,5,6
	.byte SET_COLOR | RED
	.byte HLIN,4,5,28
	.byte END
; total size = 83
