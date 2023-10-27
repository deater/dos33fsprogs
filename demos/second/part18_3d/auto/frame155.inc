	.byte SET_COLOR | GREY1
	.byte BOX,13,18,19,19
	.byte BOX_ADD_LSAME,18,21 ; 13, 20
	.byte HLIN,15,18,17
	.byte 17,18,22
	.byte VLIN,13,15,17
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,9,27,10,30
	.byte BOX_ADD_RSAME,8,39
	.byte 7,41	; 10 40
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,11,29,13,32
	.byte BOX_ADD_RSAME,10,39
	.byte BOX,10,40,12,41
	.byte HLIN,11,12,28
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,19,16,20,18
	.byte 14,22,15,23
	.byte HLIN,13,14,20
	.byte HLIN_ADD_LSAME,15 ; 13, 15, 21
	.byte VLIN,12,40,41
	.byte VLIN_ADD,30,39	; 13
	.byte VLIN,19,14,16
	.byte VLIN_ADD,19,23	; 20
	.byte PLOT,14,19
	.byte 15,24
	.byte SET_COLOR | BROWN
	.byte BOX,4,40,5,41
	.byte SET_COLOR | RED
	.byte PLOT,19,16
	.byte 20,17
	.byte SET_COLOR | ORANGE
	.byte HLIN,16,17,17
	.byte SET_COLOR | WHITE
	.byte PLOT,6,41
	.byte END
; total size = 106
