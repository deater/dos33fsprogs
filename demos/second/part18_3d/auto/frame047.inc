	.byte SET_COLOR | BROWN
	.byte BOX,20,6,30,23
	.byte 21,25,26,26
	.byte HLIN,21,28,24
	.byte 21,23,27
	.byte PLOT,21,28
	.byte SET_COLOR | GREEN
	.byte BOX,21,12,25,17
	.byte 25,26,33,27
	.byte 23,9,24,10
	.byte HLIN,22,25,11
	.byte 30,33,24
	.byte HLIN_ADD_RSAME,28	; 28 33 25
	.byte HLIN,23,34,28
	.byte HLIN_ADD,22,33	; 29
	.byte 21,31	; 30
	.byte HLIN_ADD_LSAME,29 ; 21, 29, 31
	.byte 27
	.byte 26
	.byte HLIN,22,24,34
	.byte 32,33,23
	.byte PLOT,22,35
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,23,20,31
	.byte BOX_ADD_LSAME,21,38 ; 4, 32
	.byte 28,41
	.byte BOX,14,6,19,21
	.byte HLIN,4,21,22
	.byte 26,28,6
	.byte PLOT,26,7
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,21,10
	.byte BOX_ADD_LSAME,20,15 ; 4, 11
	.byte 19,18
	.byte HLIN,4,18,19
	.byte HLIN_ADD_LSAME,15 ; 4, 15, 20
	.byte 13
	.byte 10
	.byte 7
	.byte 5
	.byte PLOT,27,7
	.byte SET_COLOR | GREY1
	.byte BOX,23,39,35,41
	.byte HLIN,33,35,33
	.byte HLIN_ADD_RSAME,31	; 31 35 34
	.byte 29	; 29 35 35
	.byte 28	; 28 35 36
	.byte 26	; 26 35 37
	.byte 24	; 24 35 38
	.byte HLIN,25,26,6
	.byte PLOT,35,32
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,29,6,35,11
	.byte BOX_ADD_RSAME,30,17
	.byte BOX,31,19,32,21
	.byte HLIN,31,33,18
	.byte PLOT,31,22
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,22,13,25,17
	.byte HLIN,22,24,18
	.byte 24,25,12
	.byte PLOT,22,19
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,34,7,35,12
	.byte HLIN,33,35,6
	.byte VLIN,13,16,35
	.byte SET_COLOR | PINK
	.byte 17,22,21
	.byte 23,27,22
	.byte SET_COLOR | ORANGE
	.byte 22,26,25
	.byte 19,21,24
	.byte END
; total size = 205
