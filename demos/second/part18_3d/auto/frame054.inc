	.byte SET_COLOR | BROWN
	.byte BOX,11,12,35,41
	.byte 18,6,35,10
	.byte HLIN,12,35,11
	.byte PLOT,12,10
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,31,6,32,9
	.byte 27,11,28,14
	.byte 13,13,17,18
	.byte 24,15,25,18
	.byte 32,16,34,19
	.byte 4,18,5,22
	.byte 14,20,18,41
	.byte 28,21,30,22
	.byte BOX_ADD,4,11,28	; 23
	.byte BOX,25,23,26,26
	.byte 34,26,35,30
	.byte 4,29,20,31
	.byte 30,29,31,33
	.byte 4,32,21,34
	.byte 26,32,27,36
	.byte 4,35,22,40
	.byte 31,40,32,41
	.byte HLIN,13,14,10
	.byte HLIN_ADD_LSAME,21 ; 13, 21, 11
	.byte 19
	.byte HLIN,33,34,15
	.byte 13,18,19
	.byte HLIN_ADD,28,29	; 20
	.byte HLIN,29,30,23
	.byte 4,21,41
	.byte VLIN,6,17,4
	.byte 39,41,35
	.byte PLOT,28,10
	.byte 31,10
	.byte 25,14
	.byte 27,15
	.byte 29,19
	.byte 33,20
	.byte 26,22
	.byte 35,25
	.byte 27,31
	.byte 34,31
	.byte 30,34
	.byte 28,41
	.byte SET_COLOR | GREEN
	.byte BOX,14,26,18,27
	.byte 7,29,18,41
	.byte HLIN,15,18,25
	.byte 13,18,28
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,19,28,20,29
	.byte BOX_ADD_RSAME,18,31
	.byte BOX,13,36,22,39
	.byte HLIN,17,21,32
	.byte HLIN_ADD_RSAME,16	; 16 21 33
	.byte 15	; 15 21 34
	.byte HLIN,14,22,35
	.byte 10,22,40
	.byte HLIN_ADD_LSAME,21 ; 10, 21, 41
	.byte VLIN,26,27,19
	.byte SET_COLOR | PINK
	.byte BOX,6,23,11,29
	.byte 7,31,9,32
	.byte BOX_ADD_LSAME,8,34 ; 7, 33
	.byte HLIN,7,10,30
	.byte PLOT,7,35
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,39,5,41
	.byte HLIN,7,8,41
	.byte VLIN,26,38,4
	.byte 39,40,7
	.byte SET_COLOR | GREY1
	.byte BOX,23,6,24,7
	.byte 18,9,24,10
	.byte HLIN,21,24,8
	.byte 18,19,8
	.byte 18,21,11
	.byte PLOT,19,7
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,24,25,9
	.byte 18,20,11
	.byte HLIN_ADD_LSAME,19 ; 18, 19, 12
	.byte VLIN,7,8,25
	.byte PLOT,24,6
	.byte 25,10
	.byte 24,11
	.byte 19,13
	.byte SET_COLOR | RED
	.byte HLIN,19,20,10
	.byte PLOT,18,11
	.byte SET_COLOR | ORANGE
	.byte HLIN,21,22,8
	.byte END
; total size = 292
