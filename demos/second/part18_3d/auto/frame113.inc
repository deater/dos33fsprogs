	.byte SET_COLOR | BROWN
	.byte BOX,18,6,35,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 4,12,23,19
	.byte 4,38,18,41
	.byte 4,20,17,37
	.byte SET_COLOR | DARK_BLUE
	.byte 4,6,25,8
	.byte BOX_ADD_LSAME,23,11 ; 4, 9
	.byte BOX,4,40,6,41
	.byte 4,28,5,39
	.byte HLIN,4,22,12
	.byte HLIN_ADD_LSAME,20 ; 4, 20, 13
	.byte 18
	.byte 16
	.byte 13
	.byte 11
	.byte 9
	.byte 6
	.byte PLOT,4,20
	.byte SET_COLOR | PINK
	.byte BOX,22,22,35,23
	.byte BOX_ADD_LSAME,32,41 ; 22, 24
	.byte VLIN,6,21,35
	.byte SET_COLOR | ORANGE
	.byte BOX,24,7,28,8
	.byte BOX_ADD_RSAME,25,10
	.byte 26,12	; 28 11
	.byte HLIN,26,28,6
	.byte 27,28,13
	.byte HLIN_ADD_RSAME,26	; 26 28 14
	.byte HLIN,24,29,15
	.byte HLIN_ADD_RSAME,23	; 23 29 16
	.byte HLIN,20,30,17
	.byte HLIN_ADD,18,31	; 18
	.byte HLIN_ADD_LSAME,32 ; 18, 32, 19
	.byte HLIN,19,32,20
	.byte HLIN_ADD_LSAME,33 ; 19, 33, 21
	.byte 35
	.byte HLIN,20,30,23
	.byte HLIN_ADD_LSAME,29 ; 20, 29, 24
	.byte HLIN,21,27,25
	.byte HLIN_ADD_LSAME,25 ; 21, 25, 26
	.byte 23
	.byte HLIN,34,35,23
	.byte PLOT,35,24
	.byte SET_COLOR | GREY1
	.byte BOX,11,8,17,9
	.byte BOX_ADD_RSAME,15,11
	.byte HLIN,12,14,7
	.byte 16,17,7
	.byte VLIN,6,11,12
	.byte 9,14,17
	.byte PLOT,16,6
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,14,17,10
	.byte VLIN,6,9,12
	.byte 11,13,17
	.byte PLOT,15,9
	.byte 17,9
	.byte 12,11
	.byte SET_COLOR | RED
	.byte VLIN,6,7,11
	.byte 8,9,12
	.byte PLOT,17,12
	.byte SET_COLOR | YELLOW
	.byte 14,10
	.byte 15,11
	.byte END
; total size = 188
