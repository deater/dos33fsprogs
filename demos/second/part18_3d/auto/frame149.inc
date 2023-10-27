	.byte SET_COLOR | GREY1
	.byte BOX,14,27,19,28
	.byte BOX_ADD_RSAME,17,30
	.byte VLIN,15,24,26
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,20,28,21,29
	.byte 12,40,13,41
	.byte HLIN,15,16,23
	.byte 14,16,25
	.byte 14,16,28
	.byte 19,21,30
	.byte HLIN_ADD_RSAME,20	; 20 21 31
	.byte VLIN,12,36,39
	.byte 16,26,27
	.byte 21,24,27
	.byte PLOT,16,22
	.byte 16,24
	.byte 14,29
	.byte 20,32
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,38,11,41
	.byte HLIN,9,11,36
	.byte HLIN_ADD_RSAME,6	; 6 11 37
	.byte SET_COLOR | PINK
	.byte BOX,32,8,35,26
	.byte BOX_ADD_RSAME,31,41
	.byte HLIN,32,33,6
	.byte HLIN_ADD_LSAME,34 ; 32, 34, 7
	.byte SET_COLOR | RED
	.byte HLIN,14,15,25
	.byte PLOT,14,26
	.byte 21,26
	.byte SET_COLOR | ORANGE
	.byte HLIN,18,19,26
	.byte END
; total size = 100
