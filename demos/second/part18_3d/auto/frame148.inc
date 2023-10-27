	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,32,9,41
	.byte HLIN,4,6,31
	.byte SET_COLOR | GREY1
	.byte BOX,12,23,14,24
	.byte 17,30,19,31
	.byte HLIN,12,16,25
	.byte HLIN_ADD_LSAME,17 ; 12, 17, 26
	.byte 19
	.byte HLIN,14,19,28
	.byte HLIN_ADD_RSAME,15	; 15 19 29
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,8,38,9,39
	.byte BOX_ADD_LSAME,10,41 ; 8, 40
	.byte HLIN,13,14,22
	.byte 12,13,27
	.byte HLIN_ADD,17,19	; 28
	.byte 15,17	; 29
	.byte HLIN,17,18,32
	.byte VLIN,9,33,37
	.byte 12,28,29
	.byte 14,23,25
	.byte 17,26,27
	.byte 19,26,30
	.byte PLOT,13,26
	.byte SET_COLOR | PINK
	.byte BOX,28,12,29,13
	.byte 27,15,30,16
	.byte BOX_ADD_LSAME,31,19 ; 27, 17
	.byte 32,22
	.byte 33,24
	.byte BOX,26,26,34,27
	.byte BOX_ADD_LSAME,35,30 ; 26, 28
	.byte BOX,25,31,35,41
	.byte HLIN,27,29,14
	.byte 26,33,25
	.byte SET_COLOR | RED
	.byte 12,14,24
	.byte PLOT,19,28
	.byte SET_COLOR | ORANGE
	.byte HLIN,16,17,26
	.byte PLOT,16,25
	.byte END
; total size = 130
