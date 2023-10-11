	.byte SET_COLOR | BROWN
	.byte BOX,12,6,35,38
	.byte BOX_ADD_RSAME,23,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,6,11,22
	.byte 14,22,20,25
	.byte HLIN,7,12,25
	.byte 17,19,27
	.byte HLIN_ADD_RSAME,18	; 18 19 28
	.byte HLIN,11,22,33
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,9,6,11,23
	.byte HLIN,15,16,23
	.byte HLIN_ADD,16,19	; 24
	.byte PLOT,17,25
	.byte SET_COLOR | GREY1
	.byte BOX,18,21,22,22
	.byte 9,25,12,26
	.byte 4,25,5,27
	.byte 20,27,22,28
	.byte 10,28,14,29
	.byte 18,29,22,32
	.byte 4,29,5,30
	.byte 12,35,22,38
	.byte BOX_ADD_RSAME,13,41
	.byte HLIN,14,16,21
	.byte 19,22,23
	.byte 4,6,23
	.byte HLIN_ADD,20,22	; 24
	.byte HLIN_ADD_RSAME,21	; 21 22 25
	.byte 16	; 16 22 26
	.byte HLIN,10,13,27
	.byte 10,15,30
	.byte HLIN_ADD_RSAME,11	; 11 15 31
	.byte HLIN,11,16,32
	.byte HLIN_ADD_LSAME,17 ; 11, 17, 33
	.byte 22
	.byte VLIN,31,37,4
	.byte 25,26,18
	.byte PLOT,9,23
	.byte 16,27
	.byte SET_COLOR | WHITE
	.byte BOX,19,14,21,17
	.byte 18,19,22,20
	.byte HLIN,18,21,18
	.byte VLIN,26,27,20
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,13,12,14,15
	.byte HLIN,13,14,6
	.byte VLIN,9,14,16
	.byte PLOT,14,11
	.byte 14,21
	.byte 16,21
	.byte SET_COLOR | RED
	.byte HLIN,17,19,26
	.byte SET_COLOR | ORANGE
	.byte VLIN,24,25,16
	.byte END
; total size = 179
