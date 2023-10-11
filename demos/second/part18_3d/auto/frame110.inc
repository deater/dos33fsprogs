	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,16,39
	.byte BOX_ADD_LSAME,10,41 ; 4, 40
	.byte SET_COLOR | ORANGE
	.byte BOX,16,6,35,17
	.byte SET_COLOR | BROWN
	.byte 26,13,28,14
	.byte 16,16,30,22
	.byte BOX_ADD_RSAME,17,41
	.byte HLIN,26,27,12
	.byte 26,29,15
	.byte VLIN,10,11,26
	.byte SET_COLOR | PINK
	.byte BOX,17,12,25,21
	.byte 31,18,35,36
	.byte 18,22,25,41
	.byte 30,37,35,41
	.byte HLIN,27,35,6
	.byte HLIN_ADD_LSAME,32 ; 27, 32, 7
	.byte 29
	.byte HLIN,23,25,10
	.byte HLIN_ADD_RSAME,20	; 20 25 11
	.byte HLIN,32,35,17
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,13,6,29
	.byte HLIN,4,13,6
	.byte HLIN_ADD_LSAME,9 ; 4, 9, 7
	.byte 5
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,7,26,8,34
	.byte 8,36,9,40
	.byte HLIN,14,17,18
	.byte 8,12,41
	.byte VLIN,15,25,7
	.byte 19,20,17
	.byte PLOT,8,35
	.byte SET_COLOR | GREY1
	.byte BOX,11,16,15,17
	.byte HLIN,13,14,15
	.byte 16,17,15
	.byte 14,16,18
	.byte HLIN_ADD_LSAME,15 ; 14, 15, 19
	.byte HLIN,13,16,39
	.byte HLIN_ADD,11,15	; 40
	.byte 10,12	; 41
	.byte VLIN,13,15,11
	.byte VLIN_ADD,18,19	; 12
	.byte VLIN,13,14,16
	.byte VLIN_ADD,16,17	; 17
	.byte PLOT,14,14
	.byte 16,38
	.byte SET_COLOR | RED
	.byte 11,17
	.byte 12,18
	.byte SET_COLOR | YELLOW
	.byte 15,19
	.byte END
; total size = 168
