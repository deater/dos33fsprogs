	.byte SET_COLOR | BROWN
	.byte BOX,4,6,35,41
	.byte SET_COLOR | GREY1
	.byte 7,21,21,33
	.byte BOX_ADD_LSAME,22,37 ; 7, 34
	.byte BOX,8,38,22,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte 8,11,19,12
	.byte BOX_ADD_LSAME,20,14 ; 8, 13
	.byte 21,16
	.byte BOX,7,17,21,20
	.byte HLIN,13,16,6
	.byte HLIN_ADD,12,17	; 7
	.byte HLIN_ADD_RSAME,11	; 11 17 8
	.byte HLIN,10,18,9
	.byte HLIN_ADD_RSAME,9	; 9 18 10
	.byte HLIN,7,16,21
	.byte HLIN_ADD_LSAME,12 ; 7, 12, 22
	.byte 9
	.byte SET_COLOR | DARK_BLUE
	.byte VLIN,17,23,21
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 30,35,4
	.byte END
; total size = 66
