	.byte SET_COLOR | BROWN
	.byte BOX,10,6,35,36
	.byte BOX_ADD_RSAME,21,41
	.byte SET_COLOR | GREY1
	.byte BOX,12,26,16,28
	.byte 8,27,20,28
	.byte 9,30,13,31
	.byte 10,33,20,36
	.byte BOX_ADD_RSAME,11,39
	.byte BOX,12,40,21,41
	.byte HLIN,11,12,22
	.byte HLIN_ADD,6,14	; 23
	.byte HLIN,7,20,25
	.byte HLIN_ADD_LSAME,10 ; 7, 10, 26
	.byte HLIN,8,12,29
	.byte 9,14,32
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,6,9,22
	.byte 16,21,20,24
	.byte BOX_ADD_RSAME,17,26
	.byte 12,28	; 20 27
	.byte 16,32	; 20 29
	.byte HLIN,7,14,23
	.byte HLIN_ADD_RSAME,10	; 10 14 24
	.byte HLIN,10,12,25
	.byte HLIN_ADD,5,6	; 26
	.byte HLIN,16,18,33
	.byte 5,6,40
	.byte HLIN_ADD_RSAME,4	; 4 6 41
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,7,6,9,23
	.byte HLIN,11,12,24
	.byte PLOT,12,26
	.byte SET_COLOR | WHITE
	.byte BOX,17,15,19,17
	.byte BOX_ADD,16,20,20	; 18
	.byte HLIN,14,15,28
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,11,12,12,16
	.byte HLIN,11,12,6
	.byte 11,12,21
	.byte VLIN,14,10,15
	.byte 14,21,23
	.byte PLOT,11,7
	.byte 12,11
	.byte SET_COLOR | RED
	.byte HLIN,13,16,27
	.byte SET_COLOR | ORANGE
	.byte PLOT,12,25
	.byte END
; total size = 156
