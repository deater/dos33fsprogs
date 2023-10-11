	.byte SET_COLOR | WHITE
	.byte BOX,4,6,35,37
	.byte BOX_ADD,25,27,40	; 38
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,25,18
	.byte BOX_ADD_RSAME,5,25
	.byte BOX,5,26,24,37
	.byte BOX_ADD_RSAME,17,40
	.byte VLIN,31,20,33
	.byte VLIN_ADD,6,19	; 32
	.byte SET_COLOR | GREY1
	.byte BOX,7,20,8,23
	.byte 7,21,9,23
	.byte 7,23,14,24
	.byte 31,34,35,35
	.byte HLIN,10,14,25
	.byte HLIN_ADD_RSAME,12	; 12 14 26
	.byte 13	; 13 14 27
	.byte HLIN,34,35,32
	.byte HLIN_ADD_RSAME,33	; 33 35 33
	.byte HLIN,4,7,35
	.byte HLIN_ADD_LSAME,10 ; 4, 10, 36
	.byte HLIN,30,35,36
	.byte HLIN_ADD,4,13	; 37
	.byte HLIN,29,35,37
	.byte HLIN_ADD,6,16	; 38
	.byte HLIN,28,35,38
	.byte HLIN_ADD,8,19	; 39
	.byte HLIN,27,35,39
	.byte HLIN_ADD,11,22	; 40
	.byte HLIN,26,34,40
	.byte HLIN_ADD,13,33	; 41
	.byte VLIN,4,31,34
	.byte PLOT,35,31
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,7,22,9,23
	.byte 13,23,14,25
	.byte HLIN,7,8,25
	.byte VLIN,14,26,27
	.byte PLOT,9,24
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,7,21,8,23
	.byte HLIN,12,13,22
	.byte VLIN,13,23,24
	.byte SET_COLOR | RED
	.byte HLIN,7,8,23
	.byte PLOT,7,22
	.byte SET_COLOR | ORANGE
	.byte 11,24
	.byte END
; total size = 160
