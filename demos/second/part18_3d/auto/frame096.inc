	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,35,23
	.byte BOX_ADD,5,34,31	; 24
	.byte BOX_ADD_LSAME,33,41 ; 5, 32
	.byte SET_COLOR | BROWN
	.byte BOX,5,6,6,23
	.byte 32,9,33,26
	.byte 12,16,26,17
	.byte BOX_ADD,11,27,25	; 18
	.byte BOX,13,20,15,41
	.byte 23,20,25,41
	.byte 6,24,7,41
	.byte 31,27,32,41
	.byte 33,6,34,8
	.byte HLIN,17,21,41
	.byte SET_COLOR | GREY1
	.byte BOX,14,6,15,15
	.byte 19,6,20,15
	.byte 24,6,25,15
	.byte 10,20,28,21
	.byte BOX_ADD,11,27,25	; 22
	.byte BOX,18,32,20,40
	.byte 34,40,35,41
	.byte VLIN,26,41,15
	.byte 26,41,25
	.byte 27,31,34
	.byte 36,39,34
	.byte 38,41,4
	.byte PLOT,35,23
	.byte 4,24
	.byte 35,26
	.byte END
; total size = 111
