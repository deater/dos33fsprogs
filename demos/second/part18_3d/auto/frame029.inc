	.byte SET_COLOR | WHITE
	.byte BOX,4,6,35,38
	.byte BOX_ADD,27,29,41	; 39
	.byte SET_COLOR | GREY2
	.byte BOX,4,21,26,27
	.byte 4,31,26,38
	.byte BOX_ADD,30,34,40	; 39
	.byte BOX,32,37,34,38
	.byte HLIN,5,26,39
	.byte HLIN_ADD_RSAME,8	; 8 26 40
	.byte 10	; 10 26 41
	.byte HLIN,33,34,36
	.byte SET_COLOR | GREY1
	.byte 33,35,35
	.byte 28,35,41
	.byte 28,29,40
	.byte VLIN,36,40,35
	.byte PLOT,35,34
	.byte 31,38
	.byte 30,39
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,26,17
	.byte BOX_ADD_RSAME,5,22
	.byte BOX,5,26,26,34
	.byte 9,23,26,25
	.byte HLIN,6,26,35
	.byte HLIN_ADD_RSAME,9	; 9 26 36
	.byte 11	; 11 26 37
	.byte 14	; 14 26 38
	.byte 17	; 17 26 39
	.byte 20	; 20 26 40
	.byte 22	; 22 26 41
	.byte VLIN,6,22,34
	.byte 23,34,33
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
; total size = 139
