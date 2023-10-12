	.byte SET_COLOR | BROWN
	.byte BOX,22,6,35,38
	.byte BOX_ADD_RSAME,24,41
	.byte SET_COLOR | GREY1
	.byte BOX,19,11,21,13
	.byte BOX_ADD_RSAME,20,22
	.byte BOX,13,15,16,16
	.byte BOX_ADD_LSAME,18,19 ; 13, 17
	.byte 16,29
	.byte BOX,21,29,22,30
	.byte 13,30,17,38
	.byte 22,37,23,38
	.byte BOX_ADD,13,18,41	; 39
	.byte HLIN,13,18,6
	.byte HLIN_ADD_LSAME,16 ; 13, 16, 7
	.byte 14
	.byte HLIN,13,15,14
	.byte VLIN,21,23,28
	.byte VLIN_ADD,31,36	; 22
	.byte 39,41	; 23
	.byte PLOT,21,10
	.byte 15,13
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,9,7,12,10
	.byte BOX_ADD_LSAME,13,15 ; 9, 11
	.byte 15,17
	.byte BOX,9,20,14,25
	.byte BOX_ADD_LSAME,15,36 ; 9, 26
	.byte 16,41
	.byte HLIN,9,13,6
	.byte 17,18,17
	.byte HLIN_ADD_RSAME,9	; 9 18 18
	.byte HLIN,9,15,19
	.byte VLIN,18,15,16
	.byte 18,19,20
	.byte SET_COLOR | PINK
	.byte BOX,25,6,35,24
	.byte 4,6,8,18
	.byte BOX_ADD_LSAME,9,34 ; 4, 19
	.byte BOX,25,25,34,27
	.byte BOX_ADD_LSAME,33,31 ; 25, 28
	.byte 32,35
	.byte BOX,4,35,10,41
	.byte 25,36,31,39
	.byte BOX_ADD_LSAME,30,41 ; 25, 40
	.byte PLOT,13,6
	.byte SET_COLOR | DARK_BLUE
	.byte VLIN,8,6,18
	.byte VLIN_ADD,19,34	; 9
	.byte 35,41	; 10
	.byte VLIN,15,16,19
	.byte PLOT,16,15
	.byte SET_COLOR | YELLOW
	.byte 17,19
	.byte END
; total size = 170
