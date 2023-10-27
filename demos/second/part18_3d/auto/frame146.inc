	.byte SET_COLOR | GREY1
	.byte BOX,9,28,16,29
	.byte 9,24,11,26
	.byte 15,30,16,32
	.byte HLIN,9,13,27
	.byte 15,16,27
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,23,7,41
	.byte 10,26,11,27
	.byte 9,29,11,30
	.byte HLIN,13,15,29
	.byte HLIN_ADD_LSAME,17 ; 13, 17, 30
	.byte HLIN,16,17,33
	.byte VLIN,11,24,25
	.byte 14,29,31
	.byte 17,27,29
	.byte 17,31,32
	.byte PLOT,10,23
	.byte 11,28
	.byte 15,32
	.byte 16,34
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,21,7,25
	.byte BOX_ADD_LSAME,6,30 ; 4, 26
	.byte 5,35
	.byte BOX,34,31,35,33
	.byte BOX_ADD_RSAME,33,36
	.byte 32,40	; 35 37
	.byte HLIN,4,6,20
	.byte 31,35,41
	.byte VLIN,4,36,40
	.byte 35,27,30
	.byte PLOT,4,19
	.byte SET_COLOR | PINK
	.byte BOX,22,8,24,12
	.byte BOX_ADD_LSAME,25,14 ; 22, 13
	.byte BOX,21,15,25,19
	.byte 20,21,26,23
	.byte BOX_ADD_RSAME,19,25
	.byte BOX,19,27,28,34
	.byte BOX_ADD_LSAME,29,41 ; 19, 35
	.byte HLIN,23,24,7
	.byte 21,26,20
	.byte 19,27,26
	.byte PLOT,23,6
	.byte SET_COLOR | BROWN
	.byte BOX,17,38,18,41
	.byte VLIN,18,31,37
	.byte SET_COLOR | RED
	.byte HLIN,9,10,26
	.byte PLOT,9,25
	.byte 10,27
	.byte 17,31
	.byte SET_COLOR | YELLOW
	.byte HLIN,13,14,29
	.byte PLOT,14,30
	.byte END
; total size = 178
