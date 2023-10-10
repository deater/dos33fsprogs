	.byte SET_COLOR | GREEN
	.byte BOX,25,6,35,30
	.byte BOX_ADD_RSAME,32,41
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,14,6,24,22
	.byte 28,6,30,25
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 4,6,13,41
	.byte SET_COLOR | GREY1
	.byte 15,7,23,9
	.byte 14,24,19,26
	.byte BOX_ADD_LSAME,18,34 ; 14, 27
	.byte BOX,24,28,31,30
	.byte 25,34,31,38
	.byte 13,35,18,36
	.byte 10,39,17,40
	.byte 26,40,32,41
	.byte 21,10,22,21
	.byte HLIN,19,20,6
	.byte 14,24,22
	.byte 23,26,25
	.byte HLIN_ADD_LSAME,30 ; 23, 30, 26
	.byte HLIN,24,30,27
	.byte 12,18,37
	.byte HLIN_ADD_RSAME,11	; 11 18 38
	.byte HLIN,25,32,39
	.byte 9,17,41
	.byte 23,24,24
	.byte VLIN,10,21,17
	.byte 16,22,19
	.byte PLOT,17,6
	.byte 22,6
	.byte 30,25
	.byte SET_COLOR | BROWN
	.byte VLIN,10,22,16
	.byte 10,22,21
	.byte PLOT,19,19
	.byte 19,22
	.byte END
; total size = 120
