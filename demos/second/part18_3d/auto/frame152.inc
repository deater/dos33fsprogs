	.byte SET_COLOR | DARK_BLUE
	.byte BOX,11,38,12,40
	.byte HLIN,10,12,41
	.byte VLIN,12,36,37
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,15,28,20,29
	.byte HLIN,18,22,25
	.byte HLIN_ADD_RSAME,17	; 17 22 26
	.byte HLIN,17,20,27
	.byte 18,20,30
	.byte 15,16,30
	.byte HLIN_ADD,18,19	; 31
	.byte 16,17	; 32
	.byte HLIN,13,14,36
	.byte HLIN_ADD_LSAME,15 ; 13, 15, 37
	.byte 16
	.byte HLIN,12,17,39
	.byte HLIN_ADD_LSAME,18 ; 12, 18, 40
	.byte 19
	.byte VLIN,17,33,34
	.byte 22,27,32
	.byte PLOT,16,31
	.byte 13,35
	.byte SET_COLOR | GREY1
	.byte BOX,17,27,19,28
	.byte HLIN,21,22,24
	.byte HLIN_ADD,18,20	; 25
	.byte HLIN_ADD_RSAME,17	; 17 20 26
	.byte HLIN,17,18,29
	.byte VLIN,15,24,25
	.byte 21,23,24
	.byte SET_COLOR | RED
	.byte 15,26,27
	.byte PLOT,21,24
	.byte 22,25
	.byte SET_COLOR | ORANGE
	.byte HLIN,18,19,25
	.byte END
; total size = 108
