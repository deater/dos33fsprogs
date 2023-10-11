	.byte SET_COLOR | BROWN
	.byte BOX,11,6,35,23
	.byte BOX_ADD_RSAME,28,38
	.byte 34,40	; 35 39
	.byte SET_COLOR | GREEN
	.byte BOX,4,13,17,18
	.byte BOX_ADD_LSAME,18,23 ; 4, 19
	.byte 21,25
	.byte 15,28
	.byte 21,30
	.byte 20,33
	.byte 21,36
	.byte BOX,4,38,11,39
	.byte HLIN,8,11,12
	.byte 4,20,37
	.byte 4,20,40
	.byte HLIN_ADD_LSAME,21 ; 4, 21, 41
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,16,24,18,25
	.byte BOX_ADD_LSAME,19,27 ; 16, 26
	.byte BOX,14,30,20,32
	.byte 12,34,21,35
	.byte 8,40,18,41
	.byte HLIN,15,19,28
	.byte HLIN_ADD_LSAME,20 ; 15, 20, 29
	.byte HLIN,13,20,33
	.byte 11,21,36
	.byte HLIN_ADD,10,20	; 37
	.byte 9,19	; 38
	.byte HLIN_ADD_RSAME,8	; 8 19 39
	.byte VLIN,17,18,23
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,20,6,26,16
	.byte 5,7,16,9
	.byte BOX_ADD_LSAME,8,11 ; 5, 10
	.byte BOX,20,17,27,23
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
	.byte HLIN,25,27,27
	.byte HLIN_ADD_RSAME,21	; 21 27 28
	.byte HLIN,21,28,29
	.byte HLIN_ADD_LSAME,30 ; 21, 30, 30
	.byte HLIN,22,30,31
	.byte HLIN_ADD_RSAME,23	; 23 30 32
	.byte HLIN,25,30,35
	.byte HLIN_ADD_RSAME,26	; 26 30 36
	.byte HLIN,27,31,37
	.byte HLIN_ADD,28,32	; 38
	.byte 29,33	; 39
	.byte 30,34	; 40
	.byte 31,35	; 41
	.byte PLOT,10,6
	.byte 27,21
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,11,7,16,8
	.byte BOX_ADD,4,5,14	; 9
	.byte BOX,13,11,17,13
	.byte HLIN,13,16,6
	.byte 9,16,9
	.byte HLIN_ADD_RSAME,13	; 13 16 10
	.byte VLIN,4,21,26
	.byte 4,15,18
	.byte 4,6,8
	.byte 14,14,15
	.byte 17,14,16
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
; total size = 257
