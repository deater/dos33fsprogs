	.byte SET_COLOR | GREEN
	.byte BOX,25,6,35,27
	.byte BOX_ADD_RSAME,31,41
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,14,6,24,19
	.byte 27,6,29,22
	.byte SET_COLOR | GREY1
	.byte 16,6,22,8
	.byte 8,22,19,26
	.byte 23,23,29,24
	.byte BOX_ADD,24,30,27	; 25
	.byte BOX,8,27,18,41
	.byte 25,31,30,33
	.byte BOX_ADD_LSAME,31,36 ; 25, 34
	.byte BOX,26,37,32,39
	.byte BOX_ADD_LSAME,33,41 ; 26, 40
	.byte HLIN,21,24,19
	.byte HLIN_ADD,8,21	; 20
	.byte 23,24	; 21
	.byte HLIN_ADD_LSAME,25 ; 23, 25, 22
	.byte HLIN,24,30,30
	.byte VLIN,9,19,17
	.byte 14,20,19
	.byte 9,18,21
	.byte PLOT,29,22
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,13,9
	.byte BOX_ADD_LSAME,14,31 ; 4, 10
	.byte 13,33
	.byte BOX,4,35,11,36
	.byte 4,38,9,39
	.byte HLIN,4,12,34
	.byte 4,10,37
	.byte 4,8,40
	.byte HLIN_ADD_LSAME,7 ; 4, 7, 41
	.byte SET_COLOR | BROWN
	.byte PLOT,19,18
	.byte 19,20
	.byte END
; total size = 123
