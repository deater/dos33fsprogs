	.byte SET_COLOR | BROWN
	.byte BOX,10,6,35,8
	.byte BOX_ADD_RSAME,11,13
	.byte 18,19	; 35 14
	.byte 32,30	; 35 20
	.byte SET_COLOR | GREEN
	.byte BOX,4,11,8,15
	.byte BOX_ADD_LSAME,11,21 ; 4, 16
	.byte 12,23
	.byte 13,33
	.byte 15,36
	.byte 16,38
	.byte 17,41
	.byte SET_COLOR | GREY1
	.byte BOX,21,6,31,19
	.byte 13,10,17,12
	.byte 12,14,17,15
	.byte BOX_ADD_RSAME,13,17
	.byte BOX,24,33,35,34
	.byte 26,36,35,37
	.byte BOX_ADD_RSAME,27,39
	.byte HLIN,12,17,6
	.byte 9,10,10
	.byte 10,11,12
	.byte HLIN_ADD,11,17	; 13
	.byte HLIN,14,18,18
	.byte HLIN_ADD,15,19	; 19
	.byte 16,30	; 20
	.byte HLIN_ADD_LSAME,28 ; 16, 28, 21
	.byte HLIN,17,26,22
	.byte HLIN_ADD_LSAME,23 ; 17, 23, 23
	.byte HLIN,18,21,24
	.byte HLIN_ADD,30,31	; 25
	.byte HLIN_ADD_RSAME,28	; 28 31 26
	.byte 26	; 26 31 27
	.byte HLIN,24,32,28
	.byte HLIN_ADD,21,33	; 29
	.byte 22,34	; 30
	.byte HLIN_ADD_LSAME,35 ; 22, 35, 31
	.byte HLIN,23,35,32
	.byte 25,35,35
	.byte 28,35,40
	.byte HLIN_ADD_RSAME,29	; 29 35 41
	.byte PLOT,10,11
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,21,6,31,14
	.byte 4,6,9,9
	.byte HLIN,4,7,10
	.byte HLIN_ADD_LSAME,6 ; 4, 6, 11
	.byte 5
	.byte HLIN,21,29,15
	.byte HLIN_ADD_LSAME,28 ; 21, 28, 16
	.byte 26
	.byte 24
	.byte 22
	.byte PLOT,4,13
	.byte 21,20
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,10,17,11,18
	.byte 8,33,14,34
	.byte BOX_ADD_RSAME,7,36
	.byte BOX,4,39,15,41
	.byte HLIN,8,10,14
	.byte HLIN_ADD_RSAME,7	; 7 10 15
	.byte HLIN,9,11,16
	.byte 12,13,28
	.byte HLIN_ADD_RSAME,11	; 11 13 29
	.byte HLIN,11,14,30
	.byte HLIN_ADD_RSAME,10	; 10 14 31
	.byte 9	; 9 14 32
	.byte HLIN,6,15,37
	.byte HLIN_ADD_RSAME,5	; 5 15 38
	.byte VLIN,11,19,20
	.byte PLOT,9,13
	.byte 13,27
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,13,8,17,11
	.byte HLIN,12,15,6
	.byte HLIN_ADD_RSAME,13	; 13 15 7
	.byte HLIN,13,15,12
	.byte SET_COLOR | PINK
	.byte BOX,8,6,9,9
	.byte SET_COLOR | LIGHT_BLUE
	.byte 17,8,19,9
	.byte 17,9,18,10
	.byte PLOT,15,6
	.byte 17,6
	.byte SET_COLOR | RED
	.byte HLIN,17,19,9
	.byte SET_COLOR | ORANGE
	.byte PLOT,16,7
	.byte END
; total size = 259
