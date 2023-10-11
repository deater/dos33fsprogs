	.byte SET_COLOR | BROWN
	.byte BOX,11,6,34,33
	.byte BOX_ADD,22,26,35	; 34
	.byte SET_COLOR | GREY1
	.byte BOX,34,17,35,32
	.byte 20,18,22,20
	.byte 20,20,32,22
	.byte 26,22,32,23
	.byte 27,33,35,35
	.byte HLIN,20,21,17
	.byte 26,32,19
	.byte 11,14,32
	.byte HLIN_ADD_LSAME,18 ; 11, 18, 33
	.byte HLIN,14,21,34
	.byte HLIN_ADD,17,24	; 35
	.byte 19,34	; 36
	.byte HLIN_ADD_RSAME,22	; 22 34 37
	.byte HLIN,11,13,37
	.byte HLIN_ADD,25,32	; 38
	.byte HLIN,11,16,38
	.byte HLIN_ADD_LSAME,18 ; 11, 18, 39
	.byte HLIN,28,31,39
	.byte HLIN_ADD,11,21	; 40
	.byte HLIN_ADD_LSAME,22 ; 11, 22, 41
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,27,28,19
	.byte HLIN_ADD,20,22	; 20
	.byte HLIN,23,28,22
	.byte HLIN_ADD,20,22	; 23
	.byte 27,28	; 24
	.byte VLIN,22,23,26
	.byte 19,23,28
	.byte PLOT,22,19
	.byte 22,21
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,10,41
	.byte 28,6,33,15
	.byte BOX_ADD_LSAME,32,19 ; 28, 16
	.byte BOX,34,16,35,31
	.byte 29,20,32,21
	.byte 29,23,32,24
	.byte BOX_ADD_RSAME,27,32
	.byte HLIN,27,32,22
	.byte 27,31,33
	.byte HLIN_ADD_LSAME,30 ; 27, 30, 34
	.byte 28
	.byte VLIN,6,15,35
	.byte SET_COLOR | RED
	.byte HLIN,20,21,20
	.byte 26,28,22
	.byte SET_COLOR | DARK_BLUE
	.byte 26,27,22
	.byte SET_COLOR | ORANGE
	.byte PLOT,24,21
	.byte END
; total size = 166
