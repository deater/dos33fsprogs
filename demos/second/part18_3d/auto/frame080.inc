	.byte SET_COLOR | GREY1
	.byte BOX,10,6,32,13
	.byte BOX_ADD_LSAME,29,15 ; 10, 14
	.byte 28,17
	.byte 27,20
	.byte 26,22
	.byte 25,25
	.byte 24,27
	.byte 23,30
	.byte 22,32
	.byte 21,35
	.byte 20,37
	.byte 19,40
	.byte BOX,29,40,32,41
	.byte 30,36,32,39
	.byte 31,33,32,35
	.byte HLIN,10,18,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,7,24,8
	.byte 4,10,22,11
	.byte BOX_ADD_LSAME,21,13 ; 4, 12
	.byte 16,15
	.byte 17,20
	.byte 16,23
	.byte 15,26
	.byte 14,29
	.byte 13,31
	.byte 12,34
	.byte 11,37
	.byte 10,40
	.byte HLIN,4,25,6
	.byte 4,23,9
	.byte 4,9,41
	.byte SET_COLOR | BROWN
	.byte BOX,30,6,35,13
	.byte BOX_ADD_RSAME,31,23
	.byte 32,33	; 35 24
	.byte 33,41	; 35 34
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,20,18,21,19
	.byte HLIN,18,19,12
	.byte HLIN_ADD_RSAME,17	; 17 19 13
	.byte HLIN,17,18,14
	.byte 20,22,16
	.byte HLIN_ADD_RSAME,17	; 17 22 17
	.byte HLIN,17,18,18
	.byte VLIN,13,16,22
	.byte 14,15,20
	.byte 19,20,20
	.byte PLOT,17,16
	.byte SET_COLOR | RED
	.byte VLIN,15,16,22
	.byte 17,18,21
	.byte PLOT,20,19
	.byte SET_COLOR | WHITE
	.byte 19,13
	.byte 18,15
	.byte SET_COLOR | ORANGE
	.byte 19,17
	.byte END
; total size = 158
