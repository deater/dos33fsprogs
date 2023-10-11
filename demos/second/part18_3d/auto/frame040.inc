	.byte SET_COLOR | BROWN
	.byte BOX,4,6,35,41
	.byte SET_COLOR | GREY1
	.byte 14,21,22,27
	.byte BOX_ADD_LSAME,23,39 ; 14, 28
	.byte BOX,4,38,12,39
	.byte BOX_ADD_LSAME,23,41 ; 4, 40
	.byte HLIN,4,5,31
	.byte HLIN_ADD_LSAME,6 ; 4, 6, 32
	.byte 7
	.byte 8
	.byte 9
	.byte 10
	.byte 11
	.byte PLOT,4,30
	.byte SET_COLOR | WHITE
	.byte BOX,15,12,21,13
	.byte 14,15,22,20
	.byte HLIN,19,20,8
	.byte HLIN_ADD_RSAME,17	; 17 20 9
	.byte 16	; 16 20 10
	.byte 15	; 15 20 11
	.byte HLIN,14,21,14
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,10,6,11,13
	.byte VLIN,11,16,6
	.byte VLIN_ADD,22,27	; 7
	.byte 7,14	; 8
	.byte 22,28	; 9
	.byte VLIN,22,29,11
	.byte PLOT,10,14
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,21,19,22,23
	.byte SET_COLOR | DARK_BLUE
	.byte HLIN,21,22,21
	.byte VLIN,19,20,21
	.byte PLOT,22,18
	.byte SET_COLOR | RED
	.byte 22,21
	.byte END
; total size = 104
