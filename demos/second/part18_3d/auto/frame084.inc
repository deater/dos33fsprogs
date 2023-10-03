	.byte SET_COLOR | GREEN
	.byte BOX,24,6,31,14
	.byte BOX_ADD_RSAME,29,24
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,14,6,23,9
	.byte 30,6,35,8
	.byte BOX_ADD_RSAME,31,15
	.byte 32,24	; 35 16
	.byte BOX,15,23,22,25
	.byte 26,7,27,10
	.byte HLIN,15,22,10
	.byte HLIN_ADD_LSAME,18 ; 15, 18, 11
	.byte 20
	.byte HLIN,15,20,22
	.byte 25,35,25
	.byte 15,18,13
	.byte PLOT,26,6
	.byte SET_COLOR | GREY2
	.byte BOX,23,12,27,14
	.byte 15,16,19,22
	.byte 24,19,29,20
	.byte BOX_ADD,25,30,24	; 21
	.byte BOX,9,26,21,27
	.byte 26,27,35,29
	.byte 9,28,19,41
	.byte 15,23,17,24
	.byte HLIN,17,18,11
	.byte 20,21,11
	.byte 23,24,11
	.byte 26,27,11
	.byte HLIN_ADD,18,20	; 12
	.byte HLIN,15,17,14
	.byte HLIN_ADD,23,26	; 15
	.byte HLIN,18,19,15
	.byte 26,28,17
	.byte HLIN_ADD_RSAME,25	; 25 28 18
	.byte HLIN,9,20,25
	.byte 25,31,25
	.byte 34,35,25
	.byte HLIN_ADD_RSAME,25	; 25 35 26
	.byte HLIN,26,34,30
	.byte HLIN_ADD_LSAME,33 ; 26, 33, 31
	.byte HLIN,27,31,32
	.byte HLIN_ADD_LSAME,30 ; 27, 30, 33
	.byte 28
	.byte HLIN,32,35,41
	.byte 34,35,40
	.byte VLIN,6,10,17
	.byte 6,10,21
	.byte 7,10,19
	.byte PLOT,27,10
	.byte 18,13
	.byte 19,14
	.byte 24,16
	.byte 28,16
	.byte 35,24
	.byte 27,35
	.byte 35,39
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,13,8
	.byte BOX_ADD_LSAME,14,14 ; 4, 9
	.byte 15,19
	.byte 16,23
	.byte 15,26
	.byte 14,28
	.byte 13,30
	.byte 12,32
	.byte 11,34
	.byte 10,36
	.byte 9,39
	.byte 8,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte VLIN,21,25,22
	.byte 21,22,18
	.byte PLOT,19,24
	.byte 18,25
	.byte SET_COLOR | BROWN
	.byte VLIN,6,13,35
	.byte SET_COLOR | WHITE
	.byte BOX,20,26,21,27
	.byte SET_COLOR | RED
	.byte PLOT,22,24
	.byte SET_COLOR | GREY1
	.byte 23,15
	.byte SET_COLOR | ORANGE
	.byte 20,25
	.byte END
; total size = 243
