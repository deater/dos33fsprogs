	.byte SET_COLOR | GREY1
	.byte BOX,20,9,35,11
	.byte BOX_ADD_RSAME,21,28
	.byte 22,41	; 35 29
	.byte BOX,15,30,18,41
	.byte 15,11,17,29
	.byte HLIN,15,16,6
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,12,6,14,7
	.byte BOX_ADD_LSAME,15,16 ; 12, 8
	.byte 17,18
	.byte BOX,12,21,16,41
	.byte HLIN,12,19,19
	.byte HLIN_ADD_LSAME,17 ; 12, 17, 20
	.byte VLIN,19,17,18
	.byte 19,20,21
	.byte SET_COLOR | BROWN
	.byte BOX,22,6,35,27
	.byte BOX_ADD_RSAME,29,39
	.byte BOX,29,40,34,41
	.byte SET_COLOR | PINK
	.byte 23,6,33,8
	.byte 4,6,11,20
	.byte 23,9,32,14
	.byte BOX_ADD_LSAME,31,20 ; 23, 15
	.byte BOX,4,21,12,41
	.byte 23,21,30,25
	.byte BOX_ADD_LSAME,29,31 ; 23, 26
	.byte 28,36
	.byte HLIN,23,24,37
	.byte PLOT,35,41
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,15,19,17,20
	.byte VLIN,11,6,20
	.byte VLIN_ADD,21,41	; 12
	.byte VLIN,15,17,18
	.byte 17,17,18
	.byte PLOT,15,21
	.byte SET_COLOR | YELLOW
	.byte 17,20
	.byte END
; total size = 131
