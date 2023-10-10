	.byte SET_COLOR | PINK
	.byte BOX,18,6,35,41
	.byte SET_COLOR | BROWN
	.byte 17,6,28,13
	.byte BOX_ADD,28,34,31	; 14
	.byte BOX_ADD_LSAME,33,41 ; 28, 32
	.byte BOX,17,19,18,41
	.byte PLOT,17,18
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,8,20,16
	.byte 4,35,17,41
	.byte 4,17,16,34
	.byte SET_COLOR | DARK_BLUE
	.byte 4,6,22,7
	.byte 4,24,7,37
	.byte 4,19,6,23
	.byte HLIN,4,19,8
	.byte HLIN_ADD_LSAME,16 ; 4, 16, 9
	.byte 13
	.byte 10
	.byte 7
	.byte HLIN,5,6,18
	.byte PLOT,4,13
	.byte 4,38
	.byte SET_COLOR | ORANGE
	.byte BOX,23,6,25,7
	.byte 16,10,27,11
	.byte 30,15,35,16
	.byte 34,20,35,21
	.byte HLIN,21,25,8
	.byte HLIN_ADD,18,26	; 9
	.byte HLIN,16,28,12
	.byte 31,35,12
	.byte HLIN_ADD_RSAME,16	; 16 35 13
	.byte HLIN,18,25,14
	.byte 29,35,14
	.byte HLIN_ADD,18,23	; 15
	.byte HLIN_ADD_LSAME,20 ; 18, 20, 16
	.byte HLIN,31,35,17
	.byte HLIN_ADD_RSAME,32	; 32 35 18
	.byte 33	; 33 35 19
	.byte PLOT,35,11
	.byte 35,22
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,11,13,17,14
	.byte 7,34,8,39
	.byte HLIN,14,17,15
	.byte VLIN,24,33,7
	.byte 16,17,17
	.byte 40,41,8
	.byte SET_COLOR | GREY1
	.byte HLIN,15,16,11
	.byte 13,16,13
	.byte HLIN_ADD,11,14	; 14
	.byte 14,16	; 15
	.byte HLIN,13,14,12
	.byte VLIN,11,13,11
	.byte 14,16,12
	.byte 9,10,12
	.byte PLOT,15,10
	.byte 16,12
	.byte 16,14
	.byte SET_COLOR | RED
	.byte 11,13
	.byte 12,14
	.byte SET_COLOR | YELLOW
	.byte 15,15
	.byte END
; total size = 196
