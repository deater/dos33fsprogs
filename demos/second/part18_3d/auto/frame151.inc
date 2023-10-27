	.byte SET_COLOR | GREY1
	.byte BOX,18,27,21,28
	.byte 22,30,23,31
	.byte HLIN,18,23,26
	.byte 22,23,24
	.byte VLIN,22,23,24
	.byte PLOT,21,25
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,16,26,17,30
	.byte 15,38,16,39
	.byte HLIN,20,21,28
	.byte HLIN_ADD_RSAME,19	; 19 21 29
	.byte HLIN,19,20,30
	.byte 15,17,40
	.byte HLIN_ADD_LSAME,18 ; 15, 18, 41
	.byte VLIN,15,36,37
	.byte 17,31,32
	.byte 23,26,31
	.byte PLOT,21,27
	.byte SET_COLOR | DARK_BLUE
	.byte HLIN,13,14,39
	.byte HLIN_ADD_RSAME,12	; 12 14 40
	.byte 11	; 11 14 41
	.byte VLIN,14,37,38
	.byte SET_COLOR | RED
	.byte 16,25,27
	.byte PLOT,22,24
	.byte 23,25
	.byte SET_COLOR | ORANGE
	.byte HLIN,19,20,25
	.byte END
; total size = 89
