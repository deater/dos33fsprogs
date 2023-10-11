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
	.byte 17,21,19,24
	.byte BOX_ADD_LSAME,22,26 ; 17, 25
	.byte 23,35
	.byte BOX,6,28,11,29
	.byte BOX_ADD,7,12,31	; 30
	.byte BOX,8,33,14,34
	.byte 9,37,23,39
	.byte BOX_ADD_RSAME,10,41
	.byte HLIN,5,6,24
	.byte HLIN_ADD,6,7	; 25
	.byte 8,9	; 26
	.byte 6,10	; 27
	.byte HLIN,7,13,32
	.byte 8,15,35
	.byte HLIN_ADD_LSAME,16 ; 8, 16, 36
	.byte SET_COLOR | WHITE
	.byte BOX,18,12,22,14
	.byte 17,16,23,19
	.byte HLIN,20,21,10
	.byte HLIN_ADD_RSAME,18	; 18 21 11
	.byte HLIN,17,22,15
	.byte 17,20,20
	.byte PLOT,23,20
	.byte SET_COLOR | MEDIUM_BLUE
	.byte VLIN,11,10,15
	.byte 11,20,25
	.byte 13,8,14
	.byte 13,21,27
	.byte 15,6,13
	.byte 15,21,28
	.byte SET_COLOR | ORANGE
	.byte 22,23,24
	.byte END
; total size = 139
