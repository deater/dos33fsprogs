	.byte SET_COLOR | GREY1
	.byte BOX,4,6,25,11
	.byte 4,24,19,27
	.byte 4,12,18,23
	.byte 4,28,17,34
	.byte BOX_ADD_LSAME,16,41 ; 4, 35
	.byte BOX,20,33,25,41
	.byte HLIN,21,23,32
	.byte SET_COLOR | ORANGE
	.byte BOX,20,6,35,14
	.byte BOX_ADD_RSAME,29,32
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,11,6,18,10
	.byte BOX_ADD_LSAME,17,21 ; 11, 11
	.byte 16,24
	.byte 15,27
	.byte 16,32
	.byte 15,40
	.byte HLIN,18,19,26
	.byte VLIN,18,22,23
	.byte VLIN_ADD,24,25	; 19
	.byte PLOT,19,27
	.byte 15,41
	.byte SET_COLOR | PINK
	.byte BOX,4,6,12,13
	.byte 30,6,35,8
	.byte 20,10,28,14
	.byte 4,14,11,22
	.byte 21,15,28,25
	.byte 7,23,10,29
	.byte 21,26,29,31
	.byte 26,33,35,41
	.byte HLIN,20,23,8
	.byte HLIN_ADD_LSAME,27 ; 20, 27, 9
	.byte HLIN,31,35,9
	.byte 24,33,32
	.byte SET_COLOR | BROWN
	.byte BOX,4,19,5,20
	.byte BOX_ADD_LSAME,6,23 ; 4, 21
	.byte BOX,27,22,28,25
	.byte 4,24,7,26
	.byte 27,26,29,29
	.byte 4,27,8,28
	.byte 4,30,10,38
	.byte 26,30,29,31
	.byte BOX_ADD_LSAME,28,35 ; 26, 32
	.byte 27,39
	.byte HLIN,4,9,29
	.byte VLIN,4,16,18
	.byte 26,40,41
	.byte 28,14,21
	.byte 30,6,8
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,32,10,33
	.byte BOX_ADD_LSAME,11,35 ; 4, 34
	.byte 12,37
	.byte HLIN,4,6,30
	.byte HLIN_ADD_LSAME,8 ; 4, 8, 31
	.byte HLIN,4,13,38
	.byte HLIN_ADD_RSAME,6	; 6 13 39
	.byte 9	; 9 13 40
	.byte HLIN,13,14,41
	.byte SET_COLOR | DARK_BLUE
	.byte VLIN,15,24,27
	.byte VLIN_ADD,22,23	; 16
	.byte SET_COLOR | YELLOW
	.byte PLOT,17,27
	.byte END
; total size = 216
