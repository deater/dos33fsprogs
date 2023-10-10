	.byte SET_COLOR | BROWN
	.byte BOX,12,6,35,38
	.byte BOX_ADD_RSAME,23,41
	.byte SET_COLOR | GREY1
	.byte BOX,4,21,6,23
	.byte 9,21,11,23
	.byte 14,21,15,25
	.byte 14,22,22,25
	.byte 4,25,5,27
	.byte 16,26,22,27
	.byte BOX_ADD_RSAME,18,33
	.byte BOX,10,28,14,29
	.byte 11,33,22,34
	.byte BOX_ADD_RSAME,12,38
	.byte 13,41	; 22 39
	.byte BOX,4,29,5,30
	.byte HLIN,18,22,21
	.byte 7,12,25
	.byte HLIN_ADD_RSAME,9	; 9 12 26
	.byte HLIN,10,15,30
	.byte HLIN_ADD_RSAME,11	; 11 15 31
	.byte HLIN,11,16,32
	.byte 10,13,27
	.byte VLIN,31,37,4
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,6,11,22
	.byte 17,26,20,27
	.byte 19,25,20,26
	.byte HLIN,14,17,22
	.byte HLIN_ADD_LSAME,18 ; 14, 18, 23
	.byte 19
	.byte 17
	.byte HLIN,7,8,25
	.byte 18,22,33
	.byte 18,19,28
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,9,6,11,22
	.byte HLIN,10,11,23
	.byte HLIN_ADD,16,19	; 24
	.byte HLIN,15,16,23
	.byte PLOT,17,25
	.byte SET_COLOR | WHITE
	.byte BOX,18,19,22,20
	.byte 19,14,21,17
	.byte HLIN,18,21,18
	.byte VLIN,26,27,20
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,13,12,14,15
	.byte HLIN,13,14,6
	.byte VLIN,9,14,16
	.byte PLOT,14,11
	.byte 14,21
	.byte 16,21
	.byte SET_COLOR | RED
	.byte HLIN,17,19,26
	.byte SET_COLOR | ORANGE
	.byte VLIN,24,25,16
	.byte END
; total size = 185
