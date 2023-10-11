	.byte SET_COLOR | BROWN
	.byte BOX,7,12,35,41
	.byte 14,6,35,7
	.byte BOX_ADD_RSAME,15,11
	.byte BOX,8,10,9,11
	.byte SET_COLOR | LIGHT_GREEN
	.byte 12,27,22,34
	.byte BOX_ADD_LSAME,21,36 ; 12, 35
	.byte 20,41
	.byte SET_COLOR | GREEN
	.byte BOX,11,25,23,26
	.byte 34,25,35,26
	.byte BOX_ADD,11,20,28	; 27
	.byte BOX,10,33,14,34
	.byte 10,38,12,39
	.byte HLIN,17,19,23
	.byte HLIN_ADD,11,20	; 24
	.byte HLIN,11,18,29
	.byte HLIN_ADD_LSAME,17 ; 11, 17, 30
	.byte 16
	.byte 15
	.byte HLIN,11,13,35
	.byte HLIN_ADD_LSAME,12 ; 11, 12, 36
	.byte HLIN,8,12,40
	.byte HLIN_ADD_LSAME,11 ; 8, 11, 41
	.byte VLIN,35,39,8
	.byte 20,24,35
	.byte 27,28,35
	.byte PLOT,22,27
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,20,7,29,8
	.byte BOX_ADD_RSAME,28,10
	.byte BOX,10,12,14,16
	.byte 34,12,35,16
	.byte 24,12,25,14
	.byte BOX_ADD,21,22,17	; 15
	.byte BOX,30,16,31,20
	.byte 10,17,15,21
	.byte 26,20,27,23
	.byte 11,22,15,24
	.byte 22,23,23,25
	.byte BOX_ADD,11,13,27	; 26
	.byte BOX,31,27,32,31
	.byte 27,31,28,34
	.byte 23,32,24,33
	.byte 32,37,34,41
	.byte 28,39,29,41
	.byte HLIN,32,33,6
	.byte 20,25,9
	.byte 10,12,11
	.byte 11,14,25
	.byte 11,12,28
	.byte 24,25,41
	.byte VLIN,34,35,24
	.byte PLOT,32,7
	.byte 10,10
	.byte 25,11
	.byte 29,11
	.byte 35,11
	.byte 25,15
	.byte 34,17
	.byte 22,18
	.byte 30,21
	.byte 26,24
	.byte 23,26
	.byte 32,26
	.byte 11,29
	.byte 27,30
	.byte SET_COLOR | PINK
	.byte BOX,4,24,7,34
	.byte BOX_ADD_LSAME,8,38 ; 4, 35
	.byte HLIN,4,6,23
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,39,7,41
	.byte HLIN,7,8,38
	.byte SET_COLOR | GREY1
	.byte BOX,23,7,26,8
	.byte HLIN,21,27,6
	.byte 24,25,9
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,21,9,23,10
	.byte HLIN,23,25,6
	.byte 28,29,6
	.byte HLIN_ADD_RSAME,27	; 27 29 7
	.byte PLOT,27,8
	.byte 22,11
	.byte SET_COLOR | RED
	.byte BOX,21,8,22,9
	.byte HLIN,22,23,7
	.byte SET_COLOR | ORANGE
	.byte PLOT,25,6
	.byte END
; total size = 286
