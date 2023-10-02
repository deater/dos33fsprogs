	.byte SET_COLOR | GREY1
	.byte BOX,4,21,23,41
	.byte SET_COLOR | BROWN
	.byte 4,6,35,20
	.byte BOX_ADD_RSAME,21,23
	.byte 23,27	; 35 24
	.byte 24,41	; 35 28
	.byte BOX,4,21,13,29
	.byte HLIN,5,13,30
	.byte HLIN_ADD_RSAME,6	; 6 13 31
	.byte 7	; 7 13 32
	.byte 8	; 8 13 33
	.byte 9	; 9 13 34
	.byte 10	; 10 13 35
	.byte 11	; 11 13 36
	.byte 12	; 12 13 37
	.byte VLIN,38,39,13
	.byte SET_COLOR | WHITE
	.byte BOX,14,15,22,20
	.byte 15,12,21,13
	.byte HLIN,17,20,9
	.byte HLIN_ADD_RSAME,16	; 16 20 10
	.byte 15	; 15 20 11
	.byte HLIN,14,21,14
	.byte 19,20,8
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,10,6,11,13
	.byte VLIN,7,14,8
	.byte 22,29,11
	.byte 22,28,9
	.byte 11,16,6
	.byte 22,27,7
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
; total size = 110
