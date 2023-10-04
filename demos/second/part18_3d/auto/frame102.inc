	.byte SET_COLOR | GREEN
	.byte BOX,4,28,35,41
	.byte 10,22,35,27
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 5,6,35,15
	.byte BOX_ADD_RSAME,6,17
	.byte 7,21	; 35 18
	.byte HLIN,7,32,22
	.byte HLIN_ADD,8,27	; 23
	.byte HLIN_ADD_LSAME,22 ; 8, 22, 24
	.byte 18
	.byte 14
	.byte 9
	.byte SET_COLOR | BROWN
	.byte BOX,28,25,32,28
	.byte 22,26,26,31
	.byte 28,29,35,31
	.byte 22,33,27,34
	.byte 16,33,20,36
	.byte BOX_ADD,9,11,41	; 37
	.byte HLIN,31,32,24
	.byte 22,33,32
	.byte 18,20,32
	.byte 28,31,41
	.byte 34,35,28
	.byte PLOT,26,25
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,19,6,22,9
	.byte 13,7,15,11
	.byte 26,13,28,17
	.byte 31,13,33,16
	.byte 19,15,22,18
	.byte 14,16,16,19
	.byte 26,6,28,8
	.byte HLIN,32,34,6
	.byte 14,15,6
	.byte HLIN_ADD,32,33	; 7
	.byte HLIN,19,21,10
	.byte 32,33,12
	.byte 14,15,20
	.byte SET_COLOR | PINK
	.byte 30,32,27
	.byte HLIN_ADD_RSAME,28	; 28 32 28
	.byte HLIN,23,26,29
	.byte HLIN_ADD,22,24	; 30
	.byte HLIN,31,33,32
	.byte HLIN_ADD_RSAME,29	; 29 33 33
	.byte HLIN,23,27,34
	.byte HLIN_ADD,22,25	; 35
	.byte HLIN,19,20,35
	.byte HLIN_ADD_RSAME,16	; 16 20 36
	.byte HLIN,16,17,37
	.byte VLIN,31,32,35
	.byte PLOT,26,28
	.byte 28,29
	.byte 27,33
	.byte 29,34
	.byte SET_COLOR | GREY1
	.byte BOX,4,21,5,28
	.byte 4,11,5,15
	.byte VLIN,6,10,4
	.byte SET_COLOR | GREY2
	.byte PLOT,5,28
	.byte END
; total size = 195
