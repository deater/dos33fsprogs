	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,15,35,41
	.byte SET_COLOR | GREEN
	.byte 4,6,35,14
	.byte HLIN,4,30,15
	.byte HLIN_ADD_LSAME,24 ; 4, 24, 16
	.byte 17
	.byte 11
	.byte PLOT,4,19
	.byte SET_COLOR | GREY2
	.byte BOX,6,6,13,10
	.byte 34,17,35,23
	.byte 23,18,26,22
	.byte 11,20,14,23
	.byte 23,23,25,37
	.byte 33,24,35,29
	.byte 12,24,14,28
	.byte BOX_ADD_LSAME,15,32 ; 12, 29
	.byte BOX,32,30,35,32
	.byte BOX_ADD,13,15,41	; 33
	.byte BOX,32,33,34,35
	.byte BOX_ADD_RSAME,31,38
	.byte BOX,31,39,33,41
	.byte 23,38,24,41
	.byte HLIN,6,12,11
	.byte SET_COLOR | BROWN
	.byte 25,26,17
	.byte HLIN_ADD,23,24	; 18
	.byte 13,14	; 19
	.byte 11,12	; 20
	.byte VLIN,17,23,34
	.byte 24,29,33
	.byte 30,35,32
	.byte 36,41,31
	.byte PLOT,35,16
	.byte SET_COLOR | WHITE
	.byte VLIN,6,10,13
	.byte END
; total size = 118
