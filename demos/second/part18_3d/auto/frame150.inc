	.byte SET_COLOR | GREY1
	.byte BOX,19,28,22,29
	.byte HLIN,18,22,27
	.byte 18,21,26
	.byte 19,21,25
	.byte VLIN,22,30,31
	.byte SET_COLOR | DARK_BLUE
	.byte HLIN,12,14,38
	.byte HLIN_ADD_RSAME,11	; 11 14 39
	.byte 10	; 10 14 40
	.byte 9	; 9 14 41
	.byte PLOT,14,37
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,16,25,17,29
	.byte 14,40,16,41
	.byte HLIN,22,23,27
	.byte 19,20,30
	.byte VLIN,15,37,39
	.byte 17,30,32
	.byte 17,23,24
	.byte 21,28,29
	.byte 23,28,31
	.byte 23,24,26
	.byte PLOT,22,32
	.byte SET_COLOR | RED
	.byte HLIN,16,17,26
	.byte PLOT,23,26
	.byte 16,27
	.byte SET_COLOR | ORANGE
	.byte 20,25
	.byte END
; total size = 85
