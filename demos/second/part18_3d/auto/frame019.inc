	.byte SET_COLOR | BROWN
	.byte BOX,13,6,35,40
	.byte SET_COLOR | WHITE
	.byte 4,6,12,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 25,11,28,18
	.byte 33,11,35,18
	.byte 33,21,35,33
	.byte 25,26,35,27
	.byte BOX_ADD_LSAME,28,32 ; 25, 28
	.byte SET_COLOR | GREY1
	.byte BOX,28,21,35,26
	.byte HLIN,29,34,20
	.byte 13,18,38
	.byte HLIN_ADD_LSAME,25 ; 13, 25, 39
	.byte 33
	.byte 35
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,28,25,35,26
	.byte HLIN,29,35,27
	.byte HLIN_ADD_RSAME,30	; 30 35 28
	.byte VLIN,21,24,28
	.byte SET_COLOR | RED
	.byte HLIN,29,35,25
	.byte END
; total size = 70
