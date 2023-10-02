	.byte SET_COLOR | BROWN
	.byte BOX,9,6,35,39
	.byte BOX_ADD_RSAME,24,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,6,5,23
	.byte 17,16,23,27
	.byte 4,26,5,27
	.byte HLIN,8,23,36
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,6,6,8,24
	.byte 21,22,23,23
	.byte SET_COLOR | GREY1
	.byte 17,25,22,26
	.byte BOX_ADD_LSAME,23,35 ; 17, 27
	.byte BOX,6,28,11,29
	.byte BOX_ADD,7,12,31	; 30
	.byte BOX,8,33,14,34
	.byte 9,37,23,39
	.byte BOX_ADD_RSAME,10,41
	.byte BOX,17,21,19,24
	.byte HLIN,5,6,24
	.byte HLIN_ADD,6,7	; 25
	.byte HLIN,6,10,27
	.byte 7,13,32
	.byte 8,15,35
	.byte HLIN_ADD_LSAME,16 ; 8, 16, 36
	.byte HLIN,8,9,26
	.byte SET_COLOR | WHITE
	.byte BOX,17,16,23,19
	.byte 18,12,22,14
	.byte HLIN,18,21,11
	.byte 17,22,15
	.byte 17,20,20
	.byte 20,21,10
	.byte PLOT,23,20
	.byte SET_COLOR | MEDIUM_BLUE
	.byte VLIN,6,13,15
	.byte 21,28,15
	.byte 8,14,13
	.byte 21,27,13
	.byte 10,15,11
	.byte 20,25,11
	.byte SET_COLOR | GREY2
	.byte PLOT,19,22
	.byte 17,23
	.byte 17,34
	.byte SET_COLOR | ORANGE
	.byte VLIN,23,24,22
	.byte END
; total size = 154
