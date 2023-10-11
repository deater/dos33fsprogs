	.byte SET_COLOR | BROWN
	.byte BOX,4,6,35,33
	.byte BOX_ADD_RSAME,16,41
	.byte SET_COLOR | GREY1
	.byte BOX,4,29,7,30
	.byte 4,32,15,33
	.byte BOX_ADD_RSAME,5,35
	.byte 6,37	; 15 36
	.byte HLIN,4,8,28
	.byte 4,8,31
	.byte 7,15,38
	.byte HLIN_ADD_LSAME,16 ; 7, 16, 39
	.byte HLIN,8,17,40
	.byte HLIN_ADD,9,18	; 41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,10,22,15,32
	.byte 4,24,5,25
	.byte BOX_ADD_LSAME,8,27 ; 4, 26
	.byte BOX,5,27,7,29
	.byte VLIN,4,39,41
	.byte PLOT,4,23
	.byte SET_COLOR | WHITE
	.byte BOX,11,16,14,19
	.byte BOX_ADD,10,15,21	; 20
	.byte HLIN,6,8,28
	.byte SET_COLOR | MEDIUM_BLUE
	.byte VLIN,4,13,16
	.byte 4,21,22
	.byte VLIN_ADD,6,7	; 5
	.byte 12,16	; 6
	.byte VLIN,6,21,25
	.byte 8,11,16
	.byte 8,22,25
	.byte PLOT,7,6
	.byte SET_COLOR | RED
	.byte HLIN,5,8,27
	.byte SET_COLOR | DARK_BLUE
	.byte VLIN,4,25,27
	.byte SET_COLOR | ORANGE
	.byte PLOT,4,26
	.byte END
; total size = 123
