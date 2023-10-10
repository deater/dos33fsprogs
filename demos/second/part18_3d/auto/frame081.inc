	.byte SET_COLOR | GREY1
	.byte BOX,4,6,31,9
	.byte BOX_ADD,9,26,13	; 10
	.byte BOX_ADD_LSAME,25,16 ; 9, 14
	.byte 24,20
	.byte 23,24
	.byte 22,28
	.byte 21,32
	.byte 20,35
	.byte 19,39
	.byte 18,41
	.byte BOX,28,40,31,41
	.byte 29,32,31,39
	.byte PLOT,30,31
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,5,6,23,7
	.byte BOX_ADD_LSAME,22,9 ; 5, 8
	.byte BOX,4,11,20,12
	.byte 4,14,18,15
	.byte 4,18,17,20
	.byte BOX_ADD_LSAME,19,22 ; 4, 21
	.byte 14,24
	.byte 13,26
	.byte 12,28
	.byte 11,32
	.byte 10,36
	.byte 9,39
	.byte 8,41
	.byte HLIN,4,21,10
	.byte 4,19,13
	.byte 4,17,16
	.byte HLIN_ADD_LSAME,16 ; 4, 16, 17
	.byte SET_COLOR | BROWN
	.byte BOX,28,6,35,13
	.byte BOX_ADD_RSAME,29,21
	.byte 30,30	; 35 22
	.byte 31,38	; 35 31
	.byte 32,41	; 35 39
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,16,21,20,22
	.byte 16,20,18,23
	.byte VLIN,17,20,20
	.byte 23,24,20
	.byte PLOT,16,24
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,16,20,18,22
	.byte PLOT,18,23
	.byte SET_COLOR | WHITE
	.byte BOX,16,19,17,20
	.byte PLOT,17,18
	.byte 16,22
	.byte SET_COLOR | RED
	.byte 20,22
	.byte SET_COLOR | ORANGE
	.byte 17,23
	.byte END
; total size = 152
