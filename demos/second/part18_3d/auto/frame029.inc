	.byte SET_COLOR | GREY1
	.byte BOX,4,21,35,38
	.byte HLIN,5,35,39
	.byte HLIN_ADD_RSAME,8	; 8 35 40
	.byte 10	; 10 35 41
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,34,20
	.byte BOX_ADD_RSAME,5,22
	.byte BOX,5,26,34,34
	.byte 9,23,33,25
	.byte HLIN,6,32,35
	.byte HLIN_ADD,9,26	; 36
	.byte HLIN_ADD_RSAME,11	; 11 26 37
	.byte 14	; 14 26 38
	.byte 17	; 17 26 39
	.byte 20	; 20 26 40
	.byte 22	; 22 26 41
	.byte SET_COLOR | WHITE
	.byte BOX,27,6,33,22
	.byte BOX_ADD_LSAME,32,36 ; 27, 23
	.byte BOX,34,23,35,33
	.byte HLIN,27,31,37
	.byte HLIN_ADD_LSAME,30 ; 27, 30, 38
	.byte 29
	.byte VLIN,6,22,35
	.byte 18,20,4
	.byte 28,30,4
	.byte 40,41,27
	.byte PLOT,34,34
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,8,9,23
	.byte HLIN_ADD_LSAME,10 ; 8, 10, 24
	.byte HLIN,6,10,26
	.byte HLIN_ADD_RSAME,8	; 8 10 27
	.byte HLIN,9,10,25
	.byte VLIN,22,23,5
	.byte PLOT,9,28
	.byte SET_COLOR | ORANGE
	.byte HLIN,6,7,25
	.byte PLOT,6,24
	.byte SET_COLOR | DARK_BLUE
	.byte VLIN,23,24,8
	.byte SET_COLOR | RED
	.byte PLOT,10,26
	.byte END
; total size = 123
