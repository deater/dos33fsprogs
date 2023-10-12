	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,17,17,27
	.byte BOX_ADD,6,16,30	; 28
	.byte BOX,4,14,5,16
	.byte SET_COLOR | PINK
	.byte 13,6,21,20
	.byte BOX_ADD_RSAME,18,25
	.byte 17,30	; 21 26
	.byte BOX,13,29,14,30
	.byte BOX_ADD_LSAME,21,41 ; 13, 31
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,22,6,35,41
	.byte 4,6,5,13
	.byte 7,12,12,19
	.byte 6,27,12,41
	.byte HLIN,7,9,11
	.byte 7,10,26
	.byte PLOT,7,25
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,22,6,29,12
	.byte BOX_ADD_LSAME,30,39 ; 22, 13
	.byte 31,41
	.byte SET_COLOR | GREY1
	.byte BOX,4,17,5,22
	.byte 12,19,16,20
	.byte BOX_ADD_RSAME,13,22
	.byte HLIN,12,15,18
	.byte HLIN_ADD,7,9	; 19
	.byte HLIN,7,8,22
	.byte HLIN_ADD_LSAME,11 ; 7, 11, 23
	.byte HLIN,14,16,23
	.byte 11,13,25
	.byte HLIN_ADD,13,15	; 26
	.byte VLIN,15,27,28
	.byte PLOT,4,16
	.byte 9,20
	.byte 10,21
	.byte SET_COLOR | BROWN
	.byte VLIN,12,27,41
	.byte VLIN_ADD,6,17	; 13
	.byte SET_COLOR | WHITE
	.byte VLIN,4,27,41
	.byte VLIN_ADD,6,14	; 5
	.byte SET_COLOR | YELLOW
	.byte HLIN,9,11,23
	.byte HLIN_ADD_LSAME,12 ; 9, 12, 24
	.byte HLIN,11,12,25
	.byte SET_COLOR | RED
	.byte BOX,4,21,5,22
	.byte PLOT,4,20
	.byte END
; total size = 156
