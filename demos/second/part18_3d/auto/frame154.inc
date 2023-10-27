	.byte SET_COLOR | GREY1
	.byte BOX,16,19,19,22
	.byte HLIN,17,19,23
	.byte 17,18,18
	.byte 17,18,24
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,20,18,21,20
	.byte BOX_ADD,14,15,23	; 21
	.byte HLIN,14,16,24
	.byte HLIN_ADD_RSAME,15	; 15 16 25
	.byte HLIN,4,5,35
	.byte HLIN_ADD_LSAME,7 ; 4, 7, 36
	.byte 10
	.byte 12
	.byte 14
	.byte 16
	.byte 19
	.byte VLIN,14,16,20
	.byte 16,26,27
	.byte 20,16,17
	.byte VLIN_ADD,21,26	; 21
	.byte SET_COLOR | RED
	.byte PLOT,20,17
	.byte 21,18
	.byte SET_COLOR | ORANGE
	.byte VLIN,17,18,19
	.byte END
; total size = 68
