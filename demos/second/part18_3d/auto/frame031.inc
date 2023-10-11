	.byte SET_COLOR | BROWN
	.byte BOX,4,6,30,39
	.byte BOX_ADD_RSAME,16,41
	.byte SET_COLOR | GREY1
	.byte BOX,4,23,7,36
	.byte HLIN,4,10,37
	.byte HLIN_ADD_LSAME,12 ; 4, 12, 38
	.byte 14
	.byte HLIN,5,15,40
	.byte HLIN_ADD,7,17	; 41
	.byte SET_COLOR | WHITE
	.byte BOX,31,6,35,41
	.byte 4,17,6,18
	.byte BOX_ADD_LSAME,7,22 ; 4, 19
	.byte VLIN,28,29,4
	.byte SET_COLOR | LIGHT_BLUE
	.byte 25,26,4
	.byte SET_COLOR | RED
	.byte PLOT,4,27
	.byte END
; total size = 55
