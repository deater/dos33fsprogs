	.byte SET_COLOR | GREEN
	.byte BOX,4,6,35,41
	.byte SET_COLOR | BROWN
	.byte 5,6,8,9
	.byte 19,11,32,12
	.byte BOX_ADD,18,33,16	; 13
	.byte BOX,4,13,7,22
	.byte 18,17,34,21
	.byte BOX_ADD_LSAME,35,25 ; 18, 22
	.byte BOX,9,23,14,24
	.byte BOX_ADD_LSAME,15,31 ; 9, 25
	.byte BOX,18,26,34,27
	.byte BOX_ADD,19,33,29	; 28
	.byte BOX,22,32,32,33
	.byte 8,32,15,40
	.byte HLIN,23,28,7
	.byte HLIN_ADD,21,29	; 8
	.byte 20,30	; 9
	.byte HLIN_ADD_LSAME,31 ; 20, 31, 10
	.byte HLIN,11,14,22
	.byte 20,33,30
	.byte HLIN_ADD,21,32	; 31
	.byte HLIN,23,28,34
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,20,14,31,16
	.byte BOX_ADD_LSAME,32,21 ; 20, 17
	.byte 33,23
	.byte 32,25
	.byte BOX,22,27,31,28
	.byte HLIN,25,27,9
	.byte HLIN_ADD,22,28	; 10
	.byte HLIN_ADD_LSAME,29 ; 22, 29, 11
	.byte HLIN,21,30,12
	.byte HLIN_ADD_LSAME,31 ; 21, 31, 13
	.byte HLIN,21,31,26
	.byte 23,30,29
	.byte HLIN_ADD,24,26	; 30
	.byte SET_COLOR | PINK
	.byte BOX,5,8,8,9
	.byte 4,22,7,23
	.byte HLIN,6,8,10
	.byte 6,7,21
	.byte 14,15,39
	.byte HLIN_ADD_RSAME,9	; 9 15 40
	.byte 8	; 8 15 41
	.byte VLIN,13,20,7
	.byte 25,28,15
	.byte END
; total size = 156
