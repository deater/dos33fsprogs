	.byte SET_COLOR | GREY1
	.byte BOX,4,21,35,38
	.byte HLIN,5,35,39
	.byte HLIN_ADD_RSAME,8	; 8 35 40
	.byte 10	; 10 35 41
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,35,20
	.byte BOX_ADD_RSAME,27,27
	.byte 4,30	; 35 28
	.byte 27,33	; 35 31
	.byte BOX,27,35,32,36
	.byte HLIN,27,34,34
	.byte 27,31,37
	.byte HLIN_ADD_LSAME,30 ; 27, 30, 38
	.byte 29
	.byte VLIN,27,40,41
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,26,17
	.byte BOX_ADD_RSAME,5,22
	.byte 9,25	; 26 23
	.byte 5,34	; 26 26
	.byte HLIN,6,26,35
	.byte HLIN_ADD_RSAME,9	; 9 26 36
	.byte 11	; 11 26 37
	.byte 14	; 14 26 38
	.byte 17	; 17 26 39
	.byte 20	; 20 26 40
	.byte 22	; 22 26 41
	.byte VLIN,33,23,34
	.byte VLIN_ADD,6,22	; 34
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,8,9,23
	.byte HLIN_ADD_LSAME,10 ; 8, 10, 24
	.byte HLIN,9,10,25
	.byte HLIN_ADD_RSAME,6	; 6 10 26
	.byte 8	; 8 10 27
	.byte VLIN,5,22,23
	.byte PLOT,9,28
	.byte SET_COLOR | ORANGE
	.byte HLIN,6,7,25
	.byte PLOT,6,24
	.byte SET_COLOR | DARK_BLUE
	.byte VLIN,8,23,24
	.byte SET_COLOR | RED
	.byte PLOT,10,26
	.byte END
; total size = 115
