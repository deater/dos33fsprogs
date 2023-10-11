	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,8,23
	.byte BOX_ADD_RSAME,7,27
	.byte SET_COLOR | BROWN
	.byte BOX,7,6,35,23
	.byte BOX_ADD_RSAME,11,41
	.byte SET_COLOR | GREY1
	.byte BOX,14,22,18,33
	.byte 4,25,12,26
	.byte 7,32,12,33
	.byte BOX_ADD,8,18,36	; 34
	.byte BOX_ADD_RSAME,9,38
	.byte HLIN,4,7,27
	.byte HLIN_ADD,5,12	; 28
	.byte HLIN_ADD_LSAME,10 ; 5, 10, 29
	.byte HLIN,6,10,30
	.byte HLIN_ADD_LSAME,11 ; 6, 11, 31
	.byte HLIN,10,18,39
	.byte HLIN_ADD_LSAME,19 ; 10, 19, 40
	.byte HLIN,11,20,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 8,10,23
	.byte 8,12,25
	.byte VLIN,12,17,8
	.byte 6,8,8
	.byte 21,22,8
	.byte 11,16,10
	.byte 6,7,10
	.byte 21,22,10
	.byte 10,15,12
	.byte 21,24,12
	.byte PLOT,12,6
	.byte SET_COLOR | WHITE
	.byte BOX,14,16,17,19
	.byte BOX_ADD_LSAME,18,21 ; 14, 20
	.byte BOX,9,26,12,28
	.byte HLIN,15,16,15
	.byte 9,10,24
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,9,27,10,28
	.byte 4,39,5,41
	.byte HLIN,7,8,22
	.byte HLIN_ADD_LSAME,9 ; 7, 9, 23
	.byte HLIN,6,11,25
	.byte HLIN_ADD_LSAME,12 ; 6, 12, 26
	.byte PLOT,6,24
	.byte SET_COLOR | RED
	.byte HLIN,9,12,27
	.byte SET_COLOR | ORANGE
	.byte VLIN,25,26,8
	.byte END
; total size = 156
