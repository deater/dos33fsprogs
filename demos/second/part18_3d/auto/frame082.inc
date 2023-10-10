	.byte SET_COLOR | GREY1
	.byte BOX,8,10,25,11
	.byte 8,7,23,9
	.byte 8,13,22,19
	.byte BOX_ADD_LSAME,21,28 ; 8, 20
	.byte 20,32
	.byte 19,39
	.byte 18,41
	.byte BOX,28,9,33,21
	.byte 28,29,33,41
	.byte HLIN,8,23,12
	.byte 29,32,8
	.byte 21,23,6
	.byte 30,32,28
	.byte 28,29,22
	.byte PLOT,28,6
	.byte 31,27
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,19,14
	.byte BOX_ADD_LSAME,18,16 ; 4, 15
	.byte BOX,4,18,16,19
	.byte BOX_ADD_LSAME,15,21 ; 4, 20
	.byte 14,23
	.byte 13,25
	.byte 12,28
	.byte 11,30
	.byte 10,33
	.byte 9,36
	.byte 8,39
	.byte 7,41
	.byte HLIN,4,17,17
	.byte SET_COLOR | BROWN
	.byte BOX,30,6,35,10
	.byte BOX_ADD_RSAME,31,18
	.byte 32,27	; 35 19
	.byte 33,34	; 35 28
	.byte 34,41	; 35 35
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,16,25,19,26
	.byte BOX_ADD,20,21,28	; 27
	.byte HLIN,16,21,26
	.byte 17,19,24
	.byte VLIN,25,28,16
	.byte 22,23,17
	.byte 24,25,21
	.byte PLOT,20,29
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,18,24,19,25
	.byte HLIN,16,20,26
	.byte PLOT,16,25
	.byte SET_COLOR | WHITE
	.byte BOX,24,10,25,11
	.byte PLOT,25,9
	.byte SET_COLOR | RED
	.byte 21,27
	.byte 20,28
	.byte SET_COLOR | ORANGE
	.byte 18,27
	.byte END
; total size = 166
