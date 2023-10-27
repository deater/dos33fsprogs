	.byte SET_COLOR | GREY1
	.byte BOX,17,23,20,26
	.byte BOX_ADD,18,19,28	; 27
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,21,22,22,23
	.byte 15,23,16,25
	.byte 15,27,16,28
	.byte HLIN,15,17,29
	.byte HLIN_ADD_RSAME,16	; 16 17 30
	.byte HLIN,9,10,33
	.byte HLIN_ADD_LSAME,12 ; 9, 12, 34
	.byte 13
	.byte HLIN,8,15,36
	.byte HLIN_ADD_LSAME,16 ; 8, 16, 37
	.byte 18
	.byte 19
	.byte 21
	.byte HLIN,7,23,41
	.byte VLIN,20,18,19
	.byte VLIN_ADD,20,21	; 21
	.byte 24,29	; 22
	.byte PLOT,15,26
	.byte 17,31
	.byte 9,32
	.byte SET_COLOR | RED
	.byte VLIN,15,23,24
	.byte PLOT,21,21
	.byte 22,22
	.byte SET_COLOR | ORANGE
	.byte HLIN,18,19,22
	.byte END
; total size = 82
