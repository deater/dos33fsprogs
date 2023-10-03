	.byte SET_COLOR | BROWN
	.byte BOX,11,6,35,22
	.byte BOX_ADD_RSAME,28,39
	.byte 34,41	; 35 40
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,5,6,16,8
	.byte 20,6,27,22
	.byte 5,9,8,12
	.byte SET_COLOR | GREEN
	.byte BOX_ADD,4,16,41	; 13
	.byte BOX,7,11,11,12
	.byte SET_COLOR | LIGHT_GREEN
	.byte 15,27,18,29
	.byte BOX_ADD,14,19,32	; 30
	.byte 13,20,34	; 33
	.byte BOX_ADD_RSAME,12,37
	.byte BOX,11,38,21,39
	.byte 16,22,18,26
	.byte HLIN,10,21,40
	.byte HLIN_ADD_RSAME,9	; 9 21 41
	.byte HLIN,16,17,21
	.byte VLIN,19,20,17
	.byte SET_COLOR | GREY1
	.byte BOX,24,33,30,34
	.byte 12,6,16,9
	.byte HLIN,24,27,21
	.byte HLIN_ADD_RSAME,21	; 21 27 22
	.byte HLIN,19,26,23
	.byte HLIN_ADD_LSAME,21 ; 19, 21, 24
	.byte HLIN,25,27,26
	.byte HLIN_ADD_RSAME,21	; 21 27 27
	.byte HLIN,20,28,28
	.byte HLIN_ADD_LSAME,29 ; 20, 29, 29
	.byte HLIN,21,30,30
	.byte HLIN_ADD_RSAME,22	; 22 30 31
	.byte 23	; 23 30 32
	.byte HLIN,25,30,35
	.byte HLIN_ADD_RSAME,26	; 26 30 36
	.byte 27	; 27 30 37
	.byte HLIN,28,31,38
	.byte HLIN_ADD_LSAME,32 ; 28, 32, 39
	.byte HLIN,29,33,40
	.byte HLIN_ADD,30,34	; 41
	.byte HLIN,26,27,20
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,9,7,16,8
	.byte 13,10,16,13
	.byte HLIN,13,16,6
	.byte 12,16,9
	.byte 14,16,14
	.byte VLIN,6,13,4
	.byte PLOT,14,15
	.byte 16,15
	.byte SET_COLOR | PINK
	.byte BOX,9,6,10,10
	.byte SET_COLOR | LIGHT_BLUE
	.byte 11,7,12,8
	.byte VLIN,6,7,11
	.byte PLOT,12,9
	.byte SET_COLOR | RED
	.byte 11,7
	.byte 12,8
	.byte SET_COLOR | ORANGE
	.byte 10,6
	.byte END
; total size = 194
