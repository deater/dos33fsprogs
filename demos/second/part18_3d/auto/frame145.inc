	.byte SET_COLOR | PINK
	.byte BOX,17,24,26,41
	.byte 19,21,26,23
	.byte 19,18,25,20
	.byte 20,11,24,17
	.byte 21,6,23,9
	.byte HLIN,20,23,10
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,7,26,8,31
	.byte 7,29,9,30
	.byte 7,32,16,33
	.byte BOX_ADD_LSAME,8,36 ; 7, 34
	.byte BOX,15,36,16,37
	.byte HLIN,7,11,31
	.byte 10,16,34
	.byte HLIN_ADD_RSAME,11	; 11 16 35
	.byte SET_COLOR | WHITE
	.byte BOX,4,17,8,21
	.byte BOX_ADD_LSAME,7,31 ; 4, 22
	.byte BOX,5,32,6,34
	.byte BOX_ADD,4,7,41	; 35
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,34,16,35,19
	.byte 4,17,7,21
	.byte 33,20,35,22
	.byte 4,22,6,26
	.byte 32,23,35,25
	.byte BOX_ADD_RSAME,31,28
	.byte BOX,4,28,5,32
	.byte 30,29,35,31
	.byte BOX_ADD_RSAME,29,34
	.byte 28,37	; 35 35
	.byte 27,41	; 35 38
	.byte HLIN,4,5,14
	.byte HLIN_ADD_LSAME,7 ; 4, 7, 15
	.byte 8
	.byte HLIN,4,7,27
	.byte VLIN,4,33,38
	.byte 35,13,15
	.byte SET_COLOR | GREY1
	.byte BOX,7,29,8,31
	.byte 10,31,11,32
	.byte 11,34,13,35
	.byte HLIN,14,15,30
	.byte HLIN_ADD_LSAME,16 ; 14, 16, 31
	.byte 15
	.byte HLIN,10,12,33
	.byte HLIN_ADD_LSAME,13 ; 10, 13, 34
	.byte VLIN,7,27,28
	.byte PLOT,14,29
	.byte SET_COLOR | BROWN
	.byte VLIN,16,38,41
	.byte VLIN_ADD,24,31	; 17
	.byte 18,23	; 18
	.byte SET_COLOR | RED
	.byte VLIN,7,30,31
	.byte VLIN_ADD,32,33	; 8
	.byte VLIN,16,35,36
	.byte SET_COLOR | YELLOW
	.byte HLIN,11,13,34
	.byte HLIN_ADD_RSAME,12	; 12 13 35
	.byte END
; total size = 198
