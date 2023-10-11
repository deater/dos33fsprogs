	.byte SET_COLOR | BROWN
	.byte BOX,10,6,35,18
	.byte BOX_ADD_RSAME,19,20
	.byte 29,41	; 35 21
	.byte SET_COLOR | GREY1
	.byte BOX,20,6,28,19
	.byte 12,6,16,12
	.byte BOX_ADD_RSAME,10,17
	.byte BOX,25,35,33,36
	.byte 27,38,33,39
	.byte HLIN,10,17,18
	.byte HLIN_ADD,14,18	; 19
	.byte 15,28	; 20
	.byte HLIN_ADD_LSAME,26 ; 15, 26, 21
	.byte HLIN,16,24,22
	.byte HLIN_ADD,17,21	; 23
	.byte HLIN_ADD_LSAME,18 ; 17, 18, 24
	.byte HLIN,26,28,25
	.byte HLIN_ADD_RSAME,23	; 23 28 26
	.byte HLIN,20,29,27
	.byte HLIN_ADD_LSAME,30 ; 20, 30, 28
	.byte HLIN,21,31,29
	.byte HLIN_ADD_LSAME,32 ; 21, 32, 30
	.byte HLIN,22,33,31
	.byte HLIN_ADD,23,34	; 32
	.byte HLIN_ADD_LSAME,33 ; 23, 33, 33
	.byte HLIN,24,33,34
	.byte 26,33,37
	.byte 28,33,40
	.byte HLIN_ADD_RSAME,29	; 29 33 41
	.byte VLIN,12,24,10
	.byte PLOT,28,24
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,20,6,28,16
	.byte 4,6,9,10
	.byte HLIN,20,26,17
	.byte HLIN_ADD_LSAME,24 ; 20, 24, 18
	.byte 22
	.byte PLOT,20,20
	.byte SET_COLOR | GREEN
	.byte BOX,4,13,10,14
	.byte BOX_ADD_LSAME,11,16 ; 4, 15
	.byte 12,30
	.byte 14,33
	.byte 15,35
	.byte 16,37
	.byte 17,40
	.byte HLIN,7,8,10
	.byte HLIN_ADD_RSAME,4	; 4 8 11
	.byte HLIN,4,9,12
	.byte 4,18,41
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,12,24,13,25
	.byte BOX_ADD_RSAME,9,27
	.byte BOX,6,30,13,31
	.byte 4,33,12,35
	.byte HLIN,8,13,28
	.byte HLIN_ADD_RSAME,7	; 7 13 29
	.byte HLIN,5,12,32
	.byte 4,11,36
	.byte HLIN_ADD,7,9	; 37
	.byte PLOT,4,37
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,12,7,16,12
	.byte HLIN,14,16,6
	.byte 12,14,13
	.byte SET_COLOR | PINK
	.byte BOX,8,6,9,9
	.byte PLOT,9,10
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,13,7,15,8
	.byte PLOT,14,9
	.byte SET_COLOR | RED
	.byte HLIN,14,15,8
	.byte SET_COLOR | ORANGE
	.byte PLOT,12,6
	.byte 7,37
	.byte END
; total size = 231
