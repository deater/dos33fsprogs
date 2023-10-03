	.byte SET_COLOR | BROWN
	.byte BOX,11,6,35,23
	.byte BOX_ADD_RSAME,28,38
	.byte 34,40	; 35 39
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,8,24,20,25
	.byte BOX_ADD_LSAME,19,28 ; 8, 26
	.byte 20,33
	.byte 21,36
	.byte BOX,8,40,20,41
	.byte 8,38,19,39
	.byte HLIN,8,20,37
	.byte VLIN,18,23,17
	.byte SET_COLOR | GREEN
	.byte BOX,4,13,17,17
	.byte BOX_ADD_LSAME,16,23 ; 4, 18
	.byte 15,27
	.byte 14,29
	.byte 13,32
	.byte BOX,4,34,11,35
	.byte 4,39,7,41
	.byte 19,24,21,25
	.byte HLIN,4,11,12
	.byte 4,12,33
	.byte 4,10,36
	.byte HLIN_ADD_LSAME,9 ; 4, 9, 37
	.byte 8
	.byte HLIN,19,21,41
	.byte 19,20,40
	.byte VLIN,19,23,18
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,20,6,26,16
	.byte 5,7,16,9
	.byte 20,17,27,23
	.byte 5,10,8,11
	.byte HLIN,5,7,6
	.byte 6,7,12
	.byte PLOT,6,13
	.byte SET_COLOR | GREY1
	.byte BOX,10,7,16,9
	.byte 24,33,30,34
	.byte HLIN,24,27,22
	.byte HLIN_ADD_RSAME,21	; 21 27 23
	.byte HLIN,19,26,24
	.byte HLIN_ADD,20,22	; 25
	.byte HLIN,21,27,28
	.byte HLIN_ADD_LSAME,28 ; 21, 28, 29
	.byte 30
	.byte HLIN,22,30,31
	.byte HLIN_ADD_RSAME,23	; 23 30 32
	.byte HLIN,25,30,35
	.byte HLIN_ADD_RSAME,26	; 26 30 36
	.byte HLIN,27,31,37
	.byte HLIN_ADD,28,32	; 38
	.byte 29,33	; 39
	.byte 30,34	; 40
	.byte 31,35	; 41
	.byte HLIN,25,27,27
	.byte PLOT,10,6
	.byte 27,21
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,11,7,16,8
	.byte 13,11,17,13
	.byte 4,9,5,14
	.byte HLIN,13,16,6
	.byte 9,16,9
	.byte HLIN_ADD_RSAME,13	; 13 16 10
	.byte VLIN,21,26,4
	.byte 15,18,4
	.byte 6,8,4
	.byte 14,16,17
	.byte 14,15,14
	.byte SET_COLOR | PINK
	.byte BOX,9,9,10,11
	.byte PLOT,9,8
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,11,7,12,9
	.byte HLIN,8,9,6
	.byte PLOT,9,7
	.byte SET_COLOR | RED
	.byte 11,8
	.byte 12,9
	.byte SET_COLOR | ORANGE
	.byte 9,6
	.byte END
; total size = 255
