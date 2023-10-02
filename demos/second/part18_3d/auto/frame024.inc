	.byte SET_COLOR | GREY2
	.byte BOX,21,32,34,36
	.byte HLIN,24,32,37
	.byte HLIN_ADD_RSAME,27	; 27 32 38
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,35,31
	.byte BOX_ADD_LSAME,32,33 ; 4, 32
	.byte 10,37
	.byte HLIN,14,30,34
	.byte 4,16,38
	.byte HLIN_ADD_LSAME,18 ; 4, 18, 39
	.byte 21
	.byte 22
	.byte HLIN,17,28,35
	.byte SET_COLOR | BROWN
	.byte BOX,11,6,27,19
	.byte BOX_ADD_LSAME,28,24 ; 11, 20
	.byte 26,33
	.byte BOX,22,34,26,35
	.byte VLIN,16,32,33
	.byte 6,15,34
	.byte SET_COLOR | GREY1
	.byte BOX,20,18,22,20
	.byte 20,20,28,22
	.byte 26,22,28,23
	.byte HLIN,20,21,17
	.byte 26,27,19
	.byte 11,14,32
	.byte HLIN_ADD_LSAME,18 ; 11, 18, 33
	.byte HLIN,14,21,34
	.byte HLIN_ADD,17,24	; 35
	.byte 25,27	; 36
	.byte HLIN,19,20,36
	.byte HLIN_ADD,11,13	; 37
	.byte HLIN,22,23,37
	.byte 33,34,37
	.byte HLIN_ADD,11,16	; 38
	.byte HLIN_ADD_LSAME,18 ; 11, 18, 39
	.byte HLIN,28,31,39
	.byte HLIN_ADD,11,21	; 40
	.byte HLIN_ADD_LSAME,22 ; 11, 22, 41
	.byte HLIN,25,26,38
	.byte VLIN,32,35,35
	.byte PLOT,32,33
	.byte 29,35
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,20,22,20
	.byte 23,28,22
	.byte HLIN_ADD,20,22	; 23
	.byte 27,28	; 24
	.byte VLIN,20,23,28
	.byte 22,23,26
	.byte PLOT,22,19
	.byte 27,19
	.byte 22,21
	.byte SET_COLOR | RED
	.byte HLIN_ADD,26,28	; 22
	.byte HLIN,20,21,20
	.byte SET_COLOR | DARK_BLUE
	.byte 26,27,22
	.byte SET_COLOR | ORANGE
	.byte PLOT,24,21
	.byte END
; total size = 181
