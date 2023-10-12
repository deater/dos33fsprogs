	.byte SET_COLOR | DARK_BLUE
	.byte BOX,24,19,34,41
	.byte 25,14,33,18
	.byte 26,11,32,13
	.byte 27,8,32,10
	.byte 28,6,32,7
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 4,6,7,22
	.byte 33,6,35,14
	.byte BOX_ADD_RSAME,34,29
	.byte BOX,4,23,6,34
	.byte 8,27,23,37
	.byte 7,32,23,41
	.byte VLIN,35,30,41
	.byte SET_COLOR | PINK
	.byte BOX,15,6,23,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte 4,26,6,31
	.byte BOX_ADD_LSAME,15,34 ; 4, 32
	.byte BOX,7,35,15,36
	.byte 4,35,5,40
	.byte 10,36,11,38
	.byte 14,38,15,39
	.byte HLIN,8,9,30
	.byte HLIN_ADD_LSAME,10 ; 8, 10, 31
	.byte HLIN,8,15,37
	.byte PLOT,4,25
	.byte SET_COLOR | WHITE
	.byte BOX,6,15,7,22
	.byte 5,26,6,28
	.byte HLIN,4,5,41
	.byte VLIN,4,39,40
	.byte 6,29,32
	.byte 6,23,25
	.byte VLIN_ADD,6,14	; 7
	.byte SET_COLOR | GREY1
	.byte BOX,12,27,14,29
	.byte BOX_ADD_LSAME,15,31 ; 12, 30
	.byte HLIN,13,15,32
	.byte 9,10,32
	.byte HLIN_ADD,8,11	; 33
	.byte HLIN,13,14,33
	.byte HLIN_ADD,7,11	; 34
	.byte 8,10	; 35
	.byte HLIN_ADD_LSAME,11 ; 8, 11, 36
	.byte VLIN,13,34,36
	.byte PLOT,12,26
	.byte 9,31
	.byte SET_COLOR | BROWN
	.byte VLIN,14,23,28
	.byte 14,39,41
	.byte VLIN_ADD,6,22	; 15
	.byte SET_COLOR | YELLOW
	.byte BOX,9,36,11,37
	.byte HLIN,9,10,35
	.byte PLOT,10,38
	.byte SET_COLOR | RED
	.byte HLIN,4,5,35
	.byte VLIN,15,37,38
	.byte PLOT,4,34
	.byte 5,36
	.byte END
; total size = 200
