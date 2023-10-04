	.byte SET_COLOR | GREEN
	.byte BOX,4,6,35,41
	.byte SET_COLOR | PINK
	.byte 4,13,7,23
	.byte 9,25,15,28
	.byte 8,32,15,41
	.byte 5,8,8,9
	.byte HLIN,6,8,10
	.byte SET_COLOR | BROWN
	.byte BOX,5,6,8,7
	.byte 19,11,32,12
	.byte BOX_ADD,18,33,16	; 13
	.byte BOX_ADD_LSAME,34,21 ; 18, 17
	.byte 35,25
	.byte BOX,9,23,14,28
	.byte 18,26,34,27
	.byte BOX_ADD,19,33,29	; 28
	.byte BOX,9,29,15,31
	.byte BOX_ADD,22,32,33	; 32
	.byte BOX,8,32,15,38
	.byte 4,13,6,20
	.byte HLIN,23,28,7
	.byte HLIN_ADD,21,29	; 8
	.byte 20,30	; 9
	.byte HLIN_ADD_LSAME,31 ; 20, 31, 10
	.byte HLIN,11,14,22
	.byte 20,33,30
	.byte HLIN_ADD,21,32	; 31
	.byte HLIN,23,28,34
	.byte 8,13,39
	.byte 4,5,21
	.byte PLOT,8,40
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,20,14,31,16
	.byte BOX_ADD_LSAME,32,21 ; 20, 17
	.byte 33,23
	.byte 32,25
	.byte BOX,22,27,31,28
	.byte HLIN,22,28,10
	.byte HLIN_ADD_LSAME,29 ; 22, 29, 11
	.byte HLIN,21,30,12
	.byte HLIN_ADD_LSAME,31 ; 21, 31, 13
	.byte HLIN,21,31,26
	.byte 23,30,29
	.byte 25,27,9
	.byte 24,26,30
	.byte END
; total size = 155
