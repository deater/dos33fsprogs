	.byte SET_COLOR | BROWN
	.byte BOX,10,6,35,21
	.byte BOX_ADD_RSAME,28,40
	.byte HLIN,34,35,41
	.byte SET_COLOR | GREY1
	.byte BOX,19,16,27,20
	.byte 13,16,16,19
	.byte 23,32,30,33
	.byte 25,35,30,36
	.byte HLIN,13,17,20
	.byte HLIN_ADD_LSAME,27 ; 13, 27, 21
	.byte 26
	.byte 22
	.byte 18
	.byte HLIN,26,27,25
	.byte HLIN_ADD_RSAME,22	; 22 27 26
	.byte 13	; 13 27 27
	.byte HLIN,20,28,28
	.byte HLIN_ADD_LSAME,29 ; 20, 29, 29
	.byte HLIN,21,30,30
	.byte HLIN_ADD_RSAME,22	; 22 30 31
	.byte HLIN,24,30,34
	.byte 26,30,37
	.byte HLIN_ADD,27,31	; 38
	.byte HLIN_ADD_RSAME,28	; 28 31 39
	.byte HLIN,28,32,40
	.byte HLIN_ADD,29,33	; 41
	.byte SET_COLOR | GREEN
	.byte BOX,4,11,10,12
	.byte BOX_ADD_LSAME,14,15 ; 4, 13
	.byte 12,18
	.byte 14,38
	.byte 19,41
	.byte HLIN,5,9,10
	.byte PLOT,14,18
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,14,21,15,22
	.byte 13,25,17,26
	.byte 12,28,18,29
	.byte BOX_ADD_RSAME,11,32
	.byte 10,34	; 18 33
	.byte 9,38	; 18 35
	.byte 8,41	; 18 39
	.byte HLIN,11,12,18
	.byte HLIN_ADD_RSAME,10	; 10 12 19
	.byte HLIN,9,11,20
	.byte HLIN_ADD,7,9	; 21
	.byte 6,7	; 22
	.byte HLIN_ADD_RSAME,5	; 5 7 23
	.byte HLIN,14,16,23
	.byte HLIN_ADD_RSAME,13	; 13 16 24
	.byte HLIN,13,18,27
	.byte PLOT,12,17
	.byte 15,20
	.byte 6,24
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,19,6,27,18
	.byte 4,7,9,9
	.byte HLIN,4,15,6
	.byte 19,24,19
	.byte HLIN_ADD_LSAME,22 ; 19, 22, 20
	.byte PLOT,4,10
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,13,6,15,7
	.byte BOX_ADD,12,16,13	; 8
	.byte BOX_ADD_RSAME,13,15
	.byte SET_COLOR | PINK
	.byte BOX,8,6,9,9
	.byte PLOT,9,10
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,11,7,13,8
	.byte HLIN,11,12,6
	.byte SET_COLOR | RED
	.byte PLOT,12,7
	.byte 13,8
	.byte SET_COLOR | ORANGE
	.byte 10,6
	.byte END
; total size = 221
