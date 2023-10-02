	.byte SET_COLOR | GREY2
	.byte BOX,4,30,35,34
	.byte BOX_ADD_LSAME,34,36 ; 4, 35
	.byte HLIN,4,35,28
	.byte 6,33,37
	.byte HLIN_ADD,9,32	; 38
	.byte HLIN_ADD_RSAME,12	; 12 32 39
	.byte HLIN,16,31,40
	.byte HLIN_ADD_RSAME,18	; 18 31 41
	.byte PLOT,4,41
	.byte SET_COLOR | BROWN
	.byte BOX,4,6,30,30
	.byte BOX_ADD_RSAME,5,33
	.byte HLIN,8,24,34
	.byte HLIN_ADD_RSAME,11	; 11 24 35
	.byte 15	; 15 24 36
	.byte 18	; 18 24 37
	.byte 21	; 21 24 38
	.byte PLOT,24,39
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,31,6,35,27
	.byte 15,21,17,23
	.byte SET_COLOR | WHITE
	.byte 25,6,29,34
	.byte 31,6,34,30
	.byte HLIN,31,32,31
	.byte 25,28,35
	.byte HLIN_ADD_LSAME,27 ; 25, 27, 36
	.byte 26
	.byte VLIN,19,30,4
	.byte PLOT,31,32
	.byte 25,38
	.byte SET_COLOR | GREY1
	.byte BOX,10,23,16,24
	.byte 10,20,13,21
	.byte HLIN,11,13,19
	.byte 10,15,22
	.byte 10,18,24
	.byte HLIN_ADD_RSAME,15	; 15 18 25
	.byte HLIN,16,17,26
	.byte VLIN,22,23,18
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,10,22,12,23
	.byte 14,22,15,23
	.byte HLIN,14,16,23
	.byte HLIN_ADD,10,17	; 24
	.byte 11,12	; 25
	.byte SET_COLOR | RED
	.byte HLIN,10,12,22
	.byte SET_COLOR | ORANGE
	.byte HLIN_ADD,14,15	; 23
	.byte END
; total size = 148
